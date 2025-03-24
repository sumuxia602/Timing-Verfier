from typing import Union, Tuple, List, Sequence
from sample.frontend.cfg import EPacket, TCFGNode, CFGNode
from sample.frontend.isa import Instruction, Addr
from sample.cache.cache_config import CacheConfig
from sample.cache.memory_block import MemoryBlock
from sample.pipeline.constants import InstType, InstLookUpTable


class InstInPipeline:

    def __init__(self, f_inst: Instruction, ep_in: int):
        self.__backend_inst = f_inst
        self.__operand_num = len(self.__backend_inst.operands)
        self.__ep_in = ep_in

        """ Get the instruction type and execution cycle. """
        for t, inst_set in InstLookUpTable.inst.items():
            if self.__backend_inst.name in inst_set:
                self.__type, self.__execute_cycle = t, InstLookUpTable.cycle[t]
                break
        else:
            self.__type, self.__execute_cycle = InstType.UNKNOWN, 10

        """
        Two kinds of errors: unhandled interrupt/exception related instructions and unhandled (nested) SPLoop instructions.
        """
        if self.__type == InstType.UNHANDLED:
            raise RuntimeError("Instruction {} in memory address {} is unhandled. "
                               "This is because it involves interrupts, exceptions, pipeline blocking, or other behaviors "
                               "that cannot be handled by WCET sim.".format(self.__backend_inst.name, self.__backend_inst.addr))

        if self.__backend_inst.name in InstLookUpTable.SPUnhandled:
            raise RuntimeError("SPLOOP related instruction {} in memory address {} is unhandled. "
                               "This may because it involves nested SPLOOPs".format(self.__backend_inst.name, self.__backend_inst.addr))

        """ Check for multi_cycle NOPs stall """
        if self.__backend_inst.name == 'BNOP' and self.__operand_num > 0:
            self.__multi_cycle_nop_cycle = int(self.__backend_inst.operands[1])
        elif self.__backend_inst.name == 'NOP' and self.__operand_num == 1:
            self.__multi_cycle_nop_cycle = int(self.__backend_inst.operands[0]) - 1
        elif self.__backend_inst.name == 'ADDKPC':
            self.__multi_cycle_nop_cycle = int(self.__backend_inst.operands[2])
        elif self.__backend_inst.name == 'CALLP':
            self.__multi_cycle_nop_cycle = 5
        else:
            self.__multi_cycle_nop_cycle = 0

    @property
    def ep_in(self):
        return self.__ep_in

    @property
    def addr(self):
        return self.__backend_inst.addr.to_dec()

    @property
    def name(self):
        return self.__backend_inst.name

    @property
    def execute_cycle(self):
        return self.__execute_cycle

    @property
    def multi_cycle_nop_cycle(self):
        return self.__multi_cycle_nop_cycle

    @property
    def operands(self):
        return self.__backend_inst.operands

    @property
    def operand_num(self):
        return self.__backend_inst.operands.__len__()

    @property
    def type(self):
        return self.__type

    @property
    def is_sp_loop_head(self):
        return self.__backend_inst.name in InstLookUpTable.SPLoopHead

    @property
    def is_sp_loop_tail(self):
        return self.__backend_inst.name in InstLookUpTable.SPLoopTail


class EPInPipeline:
    
    def __init__(self, ep_id: Union[int, str], ep: EPacket):
        self.__ep_id = ep_id
        self.__ep = ep

        self.__inst = [InstInPipeline(o, self.__ep_id) for o in self.__ep.ists]
        self.__inst_num = len(self.__inst)

        self.__execute_cycle = max(self.__inst, key=lambda inst: inst.execute_cycle).execute_cycle

    @property
    def ep_id(self):
        return self.__ep_id

    def __len__(self):
        return self.__inst_num

    def __getitem__(self, idx) -> InstInPipeline:
        return self.__inst[idx]

    @property
    def execute_cycle(self):
        return self.__execute_cycle

    @property
    def start_addr(self):
        return self.__ep.start_addr.to_dec()

    @property
    def is_load_inst(self):
        """
        This is a temporary property designed to handle data hazards in the pipeline. It should NOT be used anywhere else!
        Check if any load instruction is in this EP.
        TODO: Optimize and delete it.
        """
        return any([inst.type == InstType.LOAD for inst in self.__inst])

    @property
    def is_over_4_cycle_nop(self):
        """
        This is a temporary property designed to handle data hazards in the pipeline. It should NOT be used anywhere else!
        Check if at least 4-cycle multi-nop is in this EP.
        TODO: Optimize and delete it.
        """
        return any([inst.name == 'NOP' and inst.multi_cycle_nop_cycle >= 3 for inst in self.__inst])

    @property
    def multi_cycle_nop(self):
        inst = [(i, o) for i, o in enumerate(self.__inst) if o.multi_cycle_nop_cycle != 0]
        if len(inst) == 0:
            return None, None, None
        elif len(inst) == 1:
            inst_id, inst = inst[0]
            return inst_id, inst, inst.multi_cycle_nop_cycle
        else:
            raise RuntimeError("Only one multi-cycle NOP instruction is allowed.")


"""
EP_WITH_SINGLE_NOP is a special execute package with only one single-NOP instruction.
For a execute packet with a multi-cycle-NOPs instruction, EP_WITH_SINGLE_NOP can occupied the subsequent stage.
"""
EP_WITH_SINGLE_NOP = EPInPipeline("nop", EPacket([Instruction("NOP", None, [], Addr(0), "Virtual")]))


def tcfg_node_to_eps_in_pipeline(node: TCFGNode) -> List[EPInPipeline]:
    bb: CFGNode = node.bb
    execute_packets: List[EPInPipeline] = [EPInPipeline(ei, ep) for ei, ep in enumerate(bb.eps)]
    return execute_packets


class FPInPipeline:
    
    def __init__(self, fp_id: int, eps: Tuple[EPInPipeline, ...]):
        self.__fp_id = fp_id
        self.__num_ep = len(eps)
        self.__eps = eps

    @property
    def fp_id(self):
        return self.__fp_id

    @property
    def eps(self):
        return self.__eps

    def __len__(self):
        return self.__num_ep

    def __getitem__(self, idx) -> EPInPipeline:
        return self.__eps[idx]


class FPDispatch(FPInPipeline):
    
    def __init__(self, *args, **kwargs):
        super(FPDispatch, self).__init__(*args, **kwargs)
        self.__next_ep_idx = 0

    def is_all_dispatched(self):
        return self.__next_ep_idx >= self.__len__()

    def dispatch(self) -> EPInPipeline:
        if self.__next_ep_idx >= self.__len__():
            raise RuntimeError("FP_{}: No more execute packet to dispatch.".format(self.fp_id))
        ep = self[self.__next_ep_idx]
        self.__next_ep_idx += 1
        return ep


def eps_in_pipeline_to_fps_in_pipeline(eps: Sequence[EPInPipeline]) -> List[FPInPipeline]:
    
    fetch_packets = list()
    """
    First get ranges of all fetch packets. Range is in form of [left, right), which means execute packets from eps[left] to eps[right-1] 
    consist of a fetch packet.
    """
    cur_fp_start, cur_fp_addr = 0, None
    for ep_in_pipeline in eps:
        # Fetch packet is 32-byte aligned, so its address should be shifted 5 bits to the right.
        fp_addr = ep_in_pipeline.start_addr >> 5
        if fp_addr != cur_fp_addr:
            if cur_fp_addr is not None:
                fetch_packets.append((cur_fp_start, ep_in_pipeline.ep_id))
            cur_fp_start = ep_in_pipeline.ep_id
            cur_fp_addr = fp_addr
            
    # The last one fetch packet.
    if cur_fp_addr is not None:
        fetch_packets.append((cur_fp_start, len(eps)))

    """
    Transfer FP range to instance of FPInPipeline
    """
    fetch_packets = [FPInPipeline(fp_id, tuple(eps[ep_start: ep_stop])) for fp_id, (ep_start, ep_stop) in enumerate(fetch_packets)]

    return fetch_packets


def fps_in_pipeline_to_cache_line(fps: Sequence[FPInPipeline], cache_config: CacheConfig) -> Tuple[List[MemoryBlock], List[bool]]:
    
    aligned_addr = [fp_in_pipeline[0].start_addr >> cache_config.line_bitlen for fp_in_pipeline in fps]
    set_index_mask = (1 << cache_config.set_bitlen) - 1
    fp_line_addr = [MemoryBlock(set_index=addr & set_index_mask, tag=addr >> cache_config.set_bitlen) for addr in aligned_addr]

    # The first FP is always the head of the cache line.
    """ This is an overestimation. """
    is_fp_line_head = [True, ]
    # If current cache-line-aligned address is different from the last one, it's the start of a new cache line.
    # For instruction access is always in sequence inside a block.
    is_fp_line_head.extend(
        [True if fp_line_addr[idx] != fp_line_addr[idx - 1] else False for idx in range(1, len(fps))]
    )

    return fp_line_addr, is_fp_line_head
