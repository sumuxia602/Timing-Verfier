from typing import Dict, Hashable, List, Tuple, Optional, Set

from sample.cache.cache_config import CacheConfig
from sample.cache.memory_block import MemoryBlock
from sample.frontend.cfg import Prog, CFGNode
from sample.isa.isa_syntax import Instruction


def inst_block_gen(start_addr: int, b_size: int, cache_config: CacheConfig) -> List[MemoryBlock]:
    blocks: List[MemoryBlock] = list()
    s_cache_addr = start_addr >> cache_config.line_bitlen
    
    e_cache_addr = (start_addr + b_size - 1) >> cache_config.line_bitlen
    for addr in range(s_cache_addr, e_cache_addr + 1):
        set_index = addr & ((1 << cache_config.set_bitlen) - 1)
        tag = addr >> cache_config.set_bitlen
        blocks.append(MemoryBlock(tag=tag, set_index=set_index))
        
    return blocks


class InstMemoryRef:
    def __init__(self, prog: Prog, cache_config: CacheConfig):
        self.__refs: Dict[Hashable, Tuple[int, int, Tuple[MemoryBlock, ...]]] = dict()

        for node in prog.tcfg_nodes:
            bb: CFGNode = node.bb
            bb_start_addr = bb.start_addr.to_dec()
            bb_size = bb.code[-1].addr.to_dec() + (len(bb.code[-1].opcode) // 2) - bb_start_addr
            bb_block: Tuple[MemoryBlock, ...] = tuple(inst_block_gen(bb_start_addr, bb_size, cache_config))
            self.__refs[node.nid] = (bb_start_addr, bb_size, bb_block)

    @property
    def node_idents(self):
        return list(self.__refs.keys())

    def get_start_addr(self, ident):
        return self.__refs[ident][0]

    def get_size(self, ident):
        return self.__refs[ident][1]

    def get_blocks(self, ident):
        return self.__refs[ident][2]

    def __getitem__(self, item: Hashable, t: Optional[str] = None) -> Tuple[int, int, Tuple[MemoryBlock, ...]]:
        return self.__refs[item]


class DataMemoryRef:
    def __init__(self, data_memory_ref: Dict[Hashable, Dict[Instruction, Set[MemoryBlock]]]):
        self.__refs: Dict[Hashable, Dict[Instruction, Set[MemoryBlock]]] = data_memory_ref

    @property
    def node_idents(self):
        return list(self.__refs.keys())

    def get_blocks(self, ident):
        node_blocks = set()
        return node_blocks.union(*self.__refs[ident].values())

    def get_data_reference(self, ident):
        return list(self.__refs[ident].keys())

    def get_inst_block(self, ident, inst):
        return self.__refs[ident][inst]

    def __getitem__(self, item: Hashable) -> Dict[Instruction, Set[MemoryBlock]]:
        return self.__refs[item]
        
