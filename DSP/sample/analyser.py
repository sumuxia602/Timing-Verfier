import warnings
from typing import Optional, List, Set, Dict, Hashable, Tuple

from sample.cache.abstract_state import CacheState
from sample.cache.cache_cfg import CacheCFG
from sample.cache.cache_config import CacheConfig
from sample.cache.constants import CacheAnalysisMethod, MemoryModel
from sample.cache.fixpoint import Fixpoint, FixpointState
from sample.cache.memory_block import MemoryBlock
from sample.cache.memory_ref import InstMemoryRef, DataMemoryRef
from sample.frontend.cfg import TCFGNode, Prog, TCFGEdgeKind, SimpProg
from sample.frontend.isa import Addr
from sample.frontend.loops import LoopHrchy
from sample.ilp.ilp import ILPModel, LPSolve
from sample.pipeline.abstract_interpretation import EPInPipeline, FPInPipeline, tcfg_node_to_eps_in_pipeline, eps_in_pipeline_to_fps_in_pipeline, \
    fps_in_pipeline_to_cache_line
from sample.pipeline.simulator import do_pipeline_simulation_in_block
from sample.pipeline.sploop import SPLoopType, sp_loop_scan
from sample.pipeline.tracer import PipelineTracer
from sample.isa.isa_syntax import Instruction
from sample.isa.stream_proc import ASMFileReader
from sample.cache.address import Address_analyser


class WCETAnalyser:
    behavior_record: bool = True
    append_status_after_each_iteration: bool = False

    def __init__(self,
                 analysis_file: str, inst_cache_config: CacheConfig, 
                 data_cache_config: CacheConfig, memory_model: MemoryModel = MemoryModel.SMALL_MEMORY_MODEL,
                 jump_table_dir: Optional[str] = None, cons_dir: Optional[str] = None, 
                 dline_dir: Optional[str] = None, slist_dir: Optional[str] = None,
                 i_must: bool = True, i_persistent: bool = True,
                 d_must: bool = True, d_persistent: bool = True,
                 start_name: str = "main", finish_addr: Optional[Addr] = None):
        """"""

        """  --------------
        User-supplied.
        --------------  """

        self.__analysis_file_dir = analysis_file
        self.__inst_cache_config = inst_cache_config
        self.__data_cache_config = data_cache_config
        # User supplied files.
        self.__jump_table_dir = jump_table_dir
        self.__cons_dir = cons_dir
        self.__dline_dir = dline_dir
        self.__slist_dir = slist_dir
        self.__memory_model = memory_model
        # If cache analysis method applied.
        self.__i_must = i_must
        self.__i_persistent = i_persistent
        self.__d_must = d_must
        self.__d_persistent = d_persistent
        # TODO.
        self.__start_name = start_name
        self.__finish_addr = finish_addr

        """  --------------------
        For global analysis.
        --------------------  """

        # Front end.
        self.__prog: Optional[Prog] = None
        self.__lphr: Optional[LoopHrchy] = None
        self.__blocks: List[TCFGNode] = list()
        # Instruction cache analysis.
        self.__inst_mem_ref: Optional[InstMemoryRef] = None
        self.__inst_must_states: Optional[Dict[Hashable, FixpointState]] = None
        self.__inst_persistent_states: Optional[Dict[Hashable, Dict[Hashable,FixpointState]]] = dict()
        # SPLoops.
        self.__sp_loops: Optional[List[Tuple]] = None
        # Data cache analysis
        reader = ASMFileReader(analysis_file)
        self.__instructions: List[Instruction] = sorted([Instruction(inst) for inst in reader.instructions],
                                                        key=lambda x: x.address)
        self.__cache_cfg: Optional[CacheCFG] = None
        self.__data_mem_ref: Optional[DataMemoryRef] = None
        self.__data_must_states: Optional[Dict[Hashable, FixpointState]] = None
        self.__data_persistent_states: Optional[Dict[Hashable, Dict[Hashable,FixpointState]]] = dict()


        """   -------------------------
        For a single basic block.
        -------------------------   """

        # A program may contain multiple blocks, and this variable represents the ID of the block currently being analyzed.
        self.__current_bock_id: Optional[int] = None

        # Used to document the behavior and details of pipeline simulations. If InBlockWCETAnalyser is False, no behavior is logged.
        self.__behaviors: List[PipelineTracer] = list()
        # All must-hit instruction memory blocks for current basic blocks.
        self.__inst_must_blocks: Optional[Set[MemoryBlock]] = None
        # All persistent instruction memory blocks for current basic blocks.
        self.__inst_persistent_blocks: Optional[Set[MemoryBlock]] = None
        # All must-hit data reference for current basic blocks.
        self.__data_must_refer: Optional[Set[Instruction]] = None
        # All persistent data reference for current basic blocks.
        self.__data_persistent_refer: Optional[Set[Instruction]] = None
        
        # For pipeline simulation.
        self.__cycle: List[int] = list()  # Total cycles by WCET analysis.
        self.__fps_is_line_head: Optional[List[bool]] = None  # Whether an FP is the head of cache line.
        self.__fps_line_addr: Optional[List[MemoryBlock]] = None  # The start address of each FP.
        self.__fetch_packets: Optional[List[FPInPipeline]] = None  # Abstract interpretation of fetch packets.
        self.__execute_packets: Optional[List[EPInPipeline]] = None  # Abstract interpretation of execute packets.
        # SPLoop.
        self.__is_in_sp_loop: Optional[bool] = None  # Flag. If current basic block contains an SPLoop body.
        self.__ii: Optional[int] = None  # Iteration interval.
        self.__sp_loop_type: Optional[SPLoopType] = None  # SPLoop type.
        self.__max_iter: Optional[int] = None  # Maximum iteration of SPLoop body.

        """   -------------------------
        For inter-block.
        -------------------------   """

        self.__overlap_cycles: List[int]= list()

        """  --------------------------------
        For ILP and final WCET analysis.
        --------------------------------  """

        self.__cycle_cons: Dict[int, List[int]] = dict()
        self.__ilp_model: Optional[ILPModel] = None
        self.__ilp_str: Optional[str] = None
        self.__lp_solver: Optional[LPSolve] = None
        #  for inst cache constrains   Dict[node_id, Dict[MemoryBlock, persistent loop_level]]
        self.__inst_cache_cons: Optional[Dict[Hashable, Dict[MemoryBlock, Hashable]]] = dict() 
        #  for data cache constrains   Dict[node_id, Dict[Data reference, persistent loop_level]]
        self.__data_cache_cons: Optional[Dict[Hashable, Dict[Instruction, Hashable]]] = dict()

    @property
    def inst_cache_config(self):
        return self.__inst_cache_config

    @property
    def data_cache_config(self):
        return self.__data_cache_config

    @property
    def analysis_file_dir(self):
        return self.__analysis_file_dir

    @property
    def jump_table_dir(self):
        return self.__jump_table_dir

    @property
    def loop_constrain_dir(self):
        return self.__cons_dir

    @property
    def overlap_cycle(self):
        return self.__overlap_cycles

    def frontend_analysis(self):
        """ The program instance generated by the frontend. """
        self.__prog = Prog(self.__analysis_file_dir, self.__jump_table_dir)
        self.__prog.build_cfgs()
        self.__prog.build_tcfg(start=self.__start_name, end_addr=self.__finish_addr)

        """ Program loop sim. """
        self.__lphr = LoopHrchy(self.__prog.tcfg_nodes)
        self.__lphr.loop_process()

        """ All blocks to be analyzed. """
        self.__blocks.extend(self.__prog.tcfg_nodes)
    
    def frontend_analysis_cc(self, nodes):
        self.__prog = SimpProg(nodes)

        """ Program loop sim. """
        self.__lphr = LoopHrchy(self.__prog.tcfg_nodes)
        self.__lphr.loop_process()

        """ All blocks to be analyzed. """
        self.__blocks.extend(self.__prog.tcfg_nodes)

    @property
    def prog(self):
        return self.__prog

    @property
    def loop_hierarchy(self):
        return self.__lphr

    @property
    def blocks(self):
        return self.__blocks

    def inst_cache_analysis_global(self):
        """"""
        if not self.__cache_cfg:
            self.__cache_cfg = CacheCFG(self.__instructions) 
            self.__cache_cfg.read_from_front_end(self.__prog, self.__lphr)
        """ MUST analysis results of instruction memory accesses to the program. """
        self.__inst_mem_ref = InstMemoryRef(self.__prog, self.__inst_cache_config)
        fixpoint = Fixpoint(self.__cache_cfg, self.__inst_cache_config)
        if self.__i_must:
            self.__inst_must_states = fixpoint.do_analysis_inst(analysis_type=CacheAnalysisMethod.MUST, inst_refs=self.__inst_mem_ref)
        if self.__i_persistent:
            self.__inst_persistent_states = {loop_level : fixpoint.do_analysis_inst(analysis_type=CacheAnalysisMethod.PERSISTENT, 
                                                                                 inst_refs=self.__inst_mem_ref,
                                                                                level = loop_level)
                                                for loop_level in self.__lphr.loops.keys() if loop_level}
    
    def data_cache_analysis_global(self):
        if not self.__cache_cfg:
            self.__cache_cfg = CacheCFG(self.__instructions) 
            self.__cache_cfg.read_from_front_end(self.__prog, self.__lphr)

        address_analyser = Address_analyser(self.__analysis_file_dir, self.__slist_dir, 
                                            self.__prog ,self.__data_cache_config, 
                                            self.__cache_cfg, self.__memory_model)
        
        self.__data_mem_ref = DataMemoryRef(address_analyser.do_address_analysis())

        fixpoint = Fixpoint(self.__cache_cfg, self.__data_cache_config)
        if self.__d_must:
            self.__data_must_states = fixpoint.do_analysis_data(analysis_type=CacheAnalysisMethod.MUST, data_refs=self.__data_mem_ref)
        if self.__d_persistent:
            self.__data_persistent_states = {loop_level : fixpoint.do_analysis_data(analysis_type=CacheAnalysisMethod.PERSISTENT, 
                                                                                 data_refs=self.__data_mem_ref,
                                                                                level = loop_level)
                                                for loop_level in self.__lphr.loops.keys() if loop_level}

    @property
    def inst_mem_ref(self):
        return self.__inst_mem_ref

    @property
    def inst_must_states(self):
        return self.__inst_must_states

    @property
    def inst_persistent_states(self):
        return self.__inst_persistent_states

    def sp_loop_analysis_global(self):
        """ All SPLoop bodies. """
        self.__sp_loops = sp_loop_scan(self.__prog, default_max_iter=1000)

    @property
    def sp_loops(self):
        return self.__sp_loops

    def move_block_cursor_to(self, block_id):
        self.__current_bock_id = block_id

    @property
    def current_block_id(self):
        return self.__current_bock_id

    def abstract_interpretation_gen(self):
        """ Abstract Interpretation. """
        self.__execute_packets = tcfg_node_to_eps_in_pipeline(self.__prog.tcfg_nodes[self.__current_bock_id])
        self.__fetch_packets = eps_in_pipeline_to_fps_in_pipeline(self.__execute_packets)
        self.__fps_line_addr, self.__fps_is_line_head = fps_in_pipeline_to_cache_line(self.__fetch_packets, self.__inst_cache_config)

    @property
    def fps_is_line_head(self):
        """ Returns a list indicating whether each fetch packet is the start of a cache line. """
        return self.__fps_is_line_head

    @property
    def fps_line_addr(self):
        """ Returns a list representing the starting address of each fetch packet. """
        return self.__fps_line_addr

    @property
    def fetch_packets(self):
        """ Returns a list of all fetch packets. Instances of FPInPipeline. """
        return self.__fetch_packets

    @property
    def execute_packets(self):
        """ Returns a list of all execute packets. Instances of EPInPipeline. """
        return self.__execute_packets

    def sp_loop_analysis_bb(self):
        """ SPLoop related. """
        in_sp_loop = [o for o in self.__sp_loops if o[0] == self.__current_bock_id]
        if len(in_sp_loop) > 1:
            raise RuntimeError("Unexpected error: More than one record of SPLoop of block {}.".format(self.__current_bock_id))
        self.__is_in_sp_loop = len(in_sp_loop) == 1
        if self.__is_in_sp_loop:
            _, self.__sp_loop_type, self.__ii, self.__max_iter = in_sp_loop[0]
        else:
            self.__sp_loop_type, self.__ii, self.__max_iter = None, None, None

    @property
    def is_sp_loop_body(self):
        return self.__is_in_sp_loop

    @property
    def sp_loop_ii(self):
        return self.__ii

    @property
    def sp_loop_type(self):
        return self.__sp_loop_type

    @property
    def sp_loop_max_iter(self):
        return self.__max_iter

    def inst_cache_analysis_bb(self):
        """ Must cache analysis. """
        try:
            in_state: CacheState = self.__inst_must_states[self.__current_bock_id].in_state
        except KeyError:
            """ Situation 1: Fixpoint sim ignores blocks that can never be accessed, but in-block sim does not. """
            """ Situation 2: Must cache analysis is disabled. """
            self.__inst_must_blocks = set()
            # warnings.warn("Do not find must analysis in_state for node {}".format(self.__current_bock_id))
        else:
            self.__inst_must_blocks = set([mem_block
                                           for cache_set in in_state.get_all_set_lines(do_sort=False)  # All set in cache.
                                           for age_list in cache_set  # Abstract age line of memory block with the same age in a set.
                                           for mem_block in age_list])  # All memory block in abstract age line.

        """ Persistent cache analysis. """
        try:
            loops = self.__cache_cfg.get_node_map_loop(self.__current_bock_id)
        except KeyError:
            self.__inst_persistent_blocks = set()
            # warnings.warn("Do not find persistent analysis in_state for node {}".format(self.__current_bock_id))
        else:
            if loops:
                in_states: Dict[Hashable,CacheState] = {loop.ident : self.__inst_persistent_states[loop.ident][self.current_block_id].in_state 
                                                            for loop in loops}
                
                inst_persistent_multi_level_blocks = {ident:[mem_block
                                                    for cache_set in in_state.get_all_set_lines(do_sort=False)  # All set in cache.
                                                    for age_list in cache_set[: -1]  # Abstract age line of memory block with the same age in a set.
                                                                                    # Remove the evicted line.
                                                    for mem_block in age_list] for ident,in_state in in_states.items()}  # All memory block in abstract age line.
                
                self.__inst_persistent_blocks = set([block for blocks in inst_persistent_multi_level_blocks.values() for block in blocks])

                persistent_blocks: Dict[MemoryBlock, int] = dict()
                for block in self.__fps_line_addr:
                    for loop in loops:
                        if block in inst_persistent_multi_level_blocks[loop.ident]:
                            persistent_blocks[block] = loop.ident
                            break

                    # try :
                    #     loop_current_node = self.__lphr.loop_map[self.current_block_id].lid
                    # except KeyError:
                    #     """ Situation : Fixpoint sim ignores blocks that can never be accessed, but in-block sim does not. """
                    #     continue
                    # else:
                    #     if loop_current_node and block in inst_persistent_multi_level_blocks[loop_current_node]:
                    #         while  self.__lphr.loops[loop_current_node].parent.lid and block in inst_persistent_multi_level_blocks[self.__lphr.loops[loop_current_node].parent.lid]:
                    #                 loop_current_node = self.__lphr.loops[loop_current_node].parent.lid
                    #         persistent_blocks[block] = loop_current_node
                            
                # self.__inst_cache_cons[self.current_block_id] = persistent_blocks
                self.__inst_cache_cons[self.current_block_id] = {block : loop_level for block, loop_level in persistent_blocks.items()
                                                                 if block not in self.__inst_must_blocks}
                """ 
                Validation: if a memory block is in must blocks, in persistent blocks.
                """
                if self.current_block_id in self.__lphr.loop_map.keys() and self.__lphr.loop_map[self.current_block_id].lid:
                    if len([b for b in self.__inst_must_blocks if b not in self.__inst_persistent_blocks]) > 0:
                        raise RuntimeError("Memory blocks in node {} is a must block but not a persistent block. "
                                        "Must blocks: {}. "
                                        "Persistent blocks: {}".format(self.__current_bock_id, self.__inst_must_blocks, self.__inst_persistent_blocks))
            else:
                self.__inst_persistent_blocks = set()
                
    def data_cache_analysis_bb(self):
        """ Must cache analysis. """
        try:
            in_state: CacheState = self.__data_must_states[self.__current_bock_id].in_state
        except KeyError:
            """ Situation 1: Fixpoint sim ignores blocks that can never be accessed, but in-block sim does not. """
            """ Situation 2: Must cache analysis is disabled. """
            self.__data_must_refer = set()
            # warnings.warn("Do not find must analysis in_state for node {}".format(self.__current_bock_id))
        else:
            self.__data_must_refer = set()
            data_must_blocks = set([mem_block
                                           for cache_set in in_state.get_all_set_lines(do_sort=False)  # All set in cache.
                                           for age_list in cache_set  # Abstract age line of memory block with the same age in a set.
                                           for mem_block in age_list])  # All memory block in abstract age line.
            
            for inst in self.__data_mem_ref.get_data_reference(self.__current_bock_id):
                potentialMemoryBlock = self.__data_mem_ref.get_inst_block(self.__current_bock_id, inst)
                if not potentialMemoryBlock:  # Unknown data reference
                    continue
                if potentialMemoryBlock.issubset(data_must_blocks):
                    self.__data_must_refer.add(inst)

        """ Persistent cache analysis. considering the node in loop"""
        try:
            loops = self.__cache_cfg.get_node_map_loop(self.__current_bock_id)
        except KeyError:
            """ Situation 1: Fixpoint sim ignores blocks that can never be accessed, but in-block sim does not. """
            self.__data_persistent_refer = set()
        else:
            if loops:
                in_states: Dict[Hashable,CacheState] = {loop.ident : self.__data_persistent_states[loop.ident][self.current_block_id].in_state 
                                                            for loop in loops}
            
                data_persistent_multi_level_blocks = {ident:[mem_block
                                                        for cache_set in in_state.get_all_set_lines(do_sort=False)  # All set in cache.
                                                        for age_list in cache_set[: -1]  # Abstract age line of memory block with the same age in a set.
                                                                                        # Remove the evicted line.
                                                        for mem_block in age_list] for ident,in_state in in_states.items()}  # All memory block in abstract age line.
                    
                data_persistent_blocks = set([block for blocks in data_persistent_multi_level_blocks.values() for block in blocks])

                persistent_data_refer: Dict[Instruction, int] = dict()

                for inst in self.__data_mem_ref.get_data_reference(self.__current_bock_id):

                    potentialMemoryBlock = self.__data_mem_ref.get_inst_block(self.__current_bock_id, inst)
                    if not potentialMemoryBlock:  # Unknown data reference
                        continue

                    for loop in loops:
                        if potentialMemoryBlock.issubset(data_persistent_multi_level_blocks[loop.ident]):
                            persistent_data_refer[inst] = loop.ident
                            break

                
                self.__data_persistent_refer = set(persistent_data_refer.keys())
                
                self.__data_cache_cons[self.current_block_id] = {inst : loop_level for inst, loop_level in persistent_data_refer.items()
                                                                 if inst not in self.__data_must_refer}


                """ Validation:  
                    if a memory block is in must blocks, in persistent blocks.
                    """
                if len([b for b in data_must_blocks if b not in data_persistent_blocks]) > 0:
                    raise RuntimeError("Memory blocks in node {} is a must block but not a persistent block. "
                                        "Must blocks: {}. "
                                        "Persistent blocks: {}".format(self.__current_bock_id, self.__data_must_refer, self.__data_persistent_refer))
            else:
                self.__data_persistent_refer = set()
    @property
    def inst_must_blocks(self):
        """ Returns a collection that contains all memory blocks whose hit status is MUST after Cache sim.
            Instances of MemoryBlock. """
        return self.__inst_must_blocks

    @property
    def inst_persistent_blocks(self):
        return self.__inst_persistent_blocks

    def in_block_wcet_analysis(self, log: Optional[bool] = None, status_log: Optional[bool] = None):
        """"""
        debug = False
        log = log if log is not None else self.behavior_record
        status_log = status_log if status_log is not None else self.append_status_after_each_iteration

        """ Clear the list. """
        self.__cycle.clear()
        self.__behaviors.clear()

        hit_blocks = self.inst_must_blocks.union(self.__inst_persistent_blocks)
        hit_data_reference = set([inst.address for inst in list(self.__data_must_refer.union(self.__data_persistent_refer))])

        if debug:
            hit_data = list(self.__data_must_refer.union(self.__data_persistent_refer))
            print("Basic block: %d"%self.__current_bock_id)
            print("  MUST HIT data reference:")
            for must_inst in list(self.__data_must_refer):
                print("    ",must_inst)
            if self.__cache_cfg.get_node_map_loop(self.current_block_id):
                print("  Persistent  data reference:")
                for per_inst in list(self.__data_persistent_refer):
                    print("    ",per_inst)
            print("  Miss data reference:")
            for _inst in self.__cache_cfg.get_node(self.__current_bock_id).insts:
                if _inst.is_memory_access and (_inst not in hit_data):
                    print("    ",_inst)
            print("")

        """ Analysis under must hit blocks. """
        cycles, overlap_cycle, behaviors = \
            do_pipeline_simulation_in_block(self.__current_bock_id, self.__fetch_packets, self.__fps_is_line_head,
                                            self.__fps_line_addr, hit_blocks, hit_data_reference,
                                            self.__inst_cache_config, self.__data_cache_config,
                                            self.__is_in_sp_loop, self.__sp_loop_type, self.__ii, self.__max_iter,
                                            log=log, status_log=status_log)
        self.__cycle.append(cycles)
        self.__behaviors.append(behaviors)
        self.__overlap_cycles.append(overlap_cycle)

        # """ Analysis under persistent hit blocks. """
        # cycles, behaviors = \
        #     do_pipeline_simulation_in_block(self.__current_bock_id, self.__fetch_packets, self.__fps_is_line_head,
        #                                     self.__fps_line_addr, self.__inst_persistent_blocks,
        #                                     self.__inst_cache_config, self.__data_cache_config,
        #                                     self.__is_in_sp_loop, self.__sp_loop_type, self.__ii, self.__max_iter,
        #                                     log=log, status_log=status_log)
        # self.__cycle.append(cycles)
        # self.__behaviors.append(behaviors)

    @property
    def cycle_must(self):
        return self.__cycle[0]

    @property
    def cycle_persistent(self):
        return self.__cycle[1]

    @property
    def cycle(self):
        return self.__cycle

    @property
    def behaviors_must(self):
        return self.__behaviors[0]

    @property
    def behaviors_persistent(self):
        return self.__behaviors[1]

    @property
    def behaviors(self):
        return self.__behaviors

    def block_cycle_cons_gen(self, cons: Optional[Dict[int, List[int]]] = None):
        """ """
        self.__cycle_cons: Dict[int, List[int]] = dict()
        if cons is not None:
            self.__cycle_cons.update(cons)
        else:
            for idx in range(len(self.__blocks)):
                self.move_block_cursor_to(idx)
                self.abstract_interpretation_gen()
                self.sp_loop_analysis_bb()
                self.inst_cache_analysis_bb()
                self.data_cache_analysis_bb()
                self.in_block_wcet_analysis(log=False)
                self.__cycle_cons[idx] = self.__cycle  # The first is under must and the second is under persistent.
            self.inter_block_analysis()

    def inter_block_analysis(self):
        for idx in range(1,len(self.__blocks)):
            block_duplicate=[self.__cycle_cons[idx][0] -self.__overlap_cycles[edge.src.nid] 
                                for edge in self.__blocks[idx].in_edges
                                    if edge.edge_kind != TCFGEdgeKind.NEVER_TAKEN]
            self.__cycle_cons[idx]=block_duplicate

    @property
    def cycle_constrain(self):
        return self.__cycle_cons

    def ilp_gen(self):
        """"""

        self.__ilp_model = ILPModel(lp_hrchy=self.__lphr,
                                    dline_file=self.__dline_dir, 
                                    inst_cache_cons=self.__inst_cache_cons,
                                    data_cache_cons=self.__data_cache_cons,
                                    inst_cache_config=self.__inst_cache_config,
                                    data_cache_config=self.__data_cache_config,
                                    loop_cons_file=self.__cons_dir, pred_cycle=self.__cycle_cons)
        self.__ilp_str = self.__ilp_model.gen_ilp_model()

    @property
    def ilp_model(self):
        return self.__ilp_model

    @property
    def ilp_str(self):
        return self.__ilp_str
    
    @property
    def inst_cache_cons(self):
        return self.__inst_cache_cons
    
    @property
    def data_cache_cons(self):
        return self.__data_cache_cons
