from typing import Dict

from src.cache.constants import RefType, CacheHierarchy
from src.cache.cache_config import CacheConfig, MultiLevelCacheConfig
from src.cache.memory_block import MemoryBlock


class Reference:
    def __init__(self, cache_address, ref_type: RefType, config: MultiLevelCacheConfig) -> None:
        # cache address : (tag||set index) --> address >> line_bitlen
        self.__cache_address = cache_address
        self.__ref_type = ref_type

        # if ref_type == RefType.INST:
        #     cache_levels = [CacheHierarchy.L1I, CacheHierarchy.L2, CacheHierarchy.L3]
        # else:
        #     cache_levels = [CacheHierarchy.L1D, CacheHierarchy.L2, CacheHierarchy.L3]

        if ref_type == RefType.INST:
            cache_levels = [CacheHierarchy.L1I, CacheHierarchy.L2]
        else:
            cache_levels = [CacheHierarchy.L1D, CacheHierarchy.L2]

        # 生成各cache level对应的Memory block
        self.__memory_block: Dict[CacheHierarchy, MemoryBlock] = {level: self.gen_block(config.get_cache_config(level))
                                                                  for level in cache_levels}

    def gen_block(self, cache_config: CacheConfig):
        return MemoryBlock(tag=self.__cache_address >> cache_config.set_bitlen,
                           set_index=self.__cache_address & ((1 << cache_config.set_bitlen) - 1),
                           cache_level=cache_config.cache_level)

    def get_block(self, cache_level: CacheHierarchy):
        return self.__memory_block.get(cache_level, None)

    @property
    def ref_type(self):
        return self.__ref_type

    @property
    def cache_address(self):
        return self.__cache_address

    def __eq__(self, other) -> bool:
        return self.cache_address == other.cache_address

    def __hash__(self) -> int:
        return self.__cache_address.__hash__()
