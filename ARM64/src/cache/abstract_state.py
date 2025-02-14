import copy
import warnings
from copy import deepcopy
from typing import Set, Union, Dict, List, Optional

from src.cache.cache_config import CacheConfig, MultiLevelCacheConfig
from src.cache.constants import CacheAnalysisMethod, CacheHierarchy, CAC, CHMC, RefType
from src.cache.memory_block import *
from src.cache.memory_ref import Reference

ScopeAwareAnalysisContext = Dict[str, Union[set, int]]
"""
在进行 scope aware 分析时，除了要记录每个 reference 的 relative age 外，还需要记录他们的 younger set。
ScopeAwareAnalysisContext 表示了这样一个内容的类型抽象。 例如，一个典型的进行 scope aware 分析时为 reference 记录的内容为：
>>> {"younger_set": {M1, M2, M3}, "relative age": 3}
"""

SetAbsState = Dict[Union[int, MemoryBlockWithScopeIdent], Union[int, ScopeAwareAnalysisContext]]
"""
Abstract Set State 的类型抽象。

* 在进行 Must/May/Persistent-sim 时，Abstract Set State的类型为： Dict[int, int]。
  其中第一个 int 表示内存访问块的 identity，即 ``tag``；第二个 int 表示 relative age。
* 在进行 Scope-aware-sim 时，Abstract Set State的类型为： Dict[MemoryBlockWithScopeIdent, ScopeAwareAnalysisContext]。
"""


class CacheState:

    def __init__(self, cache_config: CacheConfig, analysis_type: CacheAnalysisMethod):
        self.__cache_config = cache_config
        if analysis_type not in {CacheAnalysisMethod.MUST, CacheAnalysisMethod.MAY, CacheAnalysisMethod.PERSISTENT,
                                 CacheAnalysisMethod.SCOPE_AWARE}:
            raise ValueError("Unsupported sim type {}.".format(analysis_type))
        self.__analysis_type = analysis_type
        self.__states = [dict() for _ in range(cache_config.set_number)]
        self.__associativity = cache_config.associativity
        self.__cache_level = cache_config.cache_level

    def clear(self):
        """ Clears the state of the cache. This method resets all the states in the cache to an empty dictionary. """
        self.__states = [dict() for _ in range(self.__cache_config.set_number)]

    @property
    def cache_config(self) -> CacheConfig:
        return self.__cache_config

    @property
    def analysis_type(self) -> CacheAnalysisMethod:
        return self.__analysis_type

    @property
    def associativity(self):
        return self.__associativity

    @property
    def runtime_ident(self) -> Tuple[int, ...]:
        """
        方法在【运行时】将当前的abstract __cache state转化为一个元组并返回。返回的元组类型是 ``Tuple[int, ...]`` 。

        该方法针对每一个set调用 ``SetState.runtime_ident`` 方法， 并对返回的元组调用 ``__hash__()`` 方法。这样，用户既可以比较两个
        Cache State是否相同，也可以进一步地比较哪一个set发生了变化。
        """
        return tuple([state.__hash__() for state in self.__states])
        # return tuple([state.runtime_ident.__hash__() for state in self.__states])

    def get_evicted_line(self) -> Set[MemoryBlock]:
        if not self.analysis_type == CacheAnalysisMethod.PERSISTENT:
            raise TypeError("Only PERSISTENT analysis is supported")
        PO = set()
        for set_index, state in enumerate(self.__states):
            for tag, age in state.items():
                if age == self.associativity + 1:
                    PO.add(MemoryBlock(tag, set_index, self.__cache_level))
        return PO

    def in_cache(self, mb: MemoryBlock) -> bool:
        in_cache_blocks = [block for blocks in self.get_set_lines(mb.set_index)
                           for block in blocks]
        return True if mb in in_cache_blocks else False

    def remove_block(self, mb: MemoryBlock):
        self.__states[mb.set_index][mb.tag].pop(mb)

    def set_age(self, age, mb: MemoryBlock):
        """ 暂时只用于PERSISTENT中 """
        self.__states[mb.set_index][mb.tag] = age

    def get_age(self, mb: MemoryBlock):
        return self.__states[mb.set_index][mb.tag]

    def __add_relative_age_less(self, set_index: int, cmp_rel_age: int, remove_evicted: bool = False) -> None:
        """
        私有方法。该方法用于 must/persistent-sim 。

        根据 ``cmp_rel_age`` 将当前状态中所有 relative age【小于】 ``cmp_rel_age`` 的内存块的relative age加1.
        如果 ``remove_evicted == True``，那么方法最后会调用 ``__remove_evicted()`` 方法检查所有的内存块，并将被驱逐的内存块删除。
        """

        for mem_block, rel_age in self.__states[set_index].items():
            if rel_age >= cmp_rel_age:
                continue
            """ 内存块的年龄最大不会超过 SetState.associativity+1，当等于时，说明该内存块被驱逐。 """
            self.__states[set_index][mem_block] = min(self.__associativity, rel_age) + 1
        if remove_evicted:
            self.__remove_evicted(set_index)

    def __add_relative_age_leq(self, set_index: int, cmp_rel_age: int, remove_evicted: bool = False) -> None:
        """
        私有方法。该方法用于 may-sim 。

        根据 ``cmp_rel_age`` 将当前状态中所有 relative age【小于或等于】 ``cmp_rel_age`` 的内存块的relative age加1.
        如果 ``remove_evicted == True``，那么方法最后会调用 ``__remove_evicted()`` 方法检查所有的内存块，并将被驱逐的内存块删除。
        """

        for mem_block, rel_age in self.__states[set_index].items():
            if rel_age > cmp_rel_age:
                continue
            """ 内存块的年龄最大不会超过 SetState.associativity+1，当等于时，说明该内存块被驱逐。 """
            self.__states[set_index][mem_block] = min(self.__associativity, rel_age) + 1
        if remove_evicted:
            self.__remove_evicted(set_index)

    def __remove_evicted(self, set_index) -> None:
        """ 私有方法。该方法检查所有的内存块，并将被驱逐的内存块删除。 """
        for mem_block, rel_age in tuple(self.__states[set_index].items()):
            if rel_age > self.__associativity:
                self.__states[set_index].pop(mem_block)

    def update(self, mem_block: MemoryBlock, loop_level: int = -1, min_age: Optional[int] = None):
        if not isinstance(mem_block, MemoryBlock):
            raise TypeError("mem_block must be instances of class:MemoryBlock instead of ", type(mem_block))
        if min_age is not None and not self.analysis_type == CacheAnalysisMethod.MAY:
            warnings.warn("Min age only used in MAY analysis")

        set_index = mem_block.set_index
        block_ident = mem_block.tag
        if self.__analysis_type == CacheAnalysisMethod.MUST:
            """ Must-sim:
            To determine if a memory block is definitely in the __cache we use abstract __cache states where the positions
            of the memory blocks in the abstract __cache state are upper bounds of the ages of the memory blocks.
            * 如果一个内存块m之前不在 Set State 中，那么访问会导致 State 中所有内存块的最大年龄加1.
            * 如果一个内存块m之前存在 Set State 中，假设它的最大相对年龄是h，那么最大年龄小于h的内存块有可能在m之前，因此最大年龄需要加1；
              最大年龄大于等于h的内存块有两种情况，在m前，那么向后移动，但年龄依然不超过m，在m之后，不会发生冲突，因此不需要增加最大年龄。
            """

            """ 如果内存块m不在 Set State 中，那么将年龄设置为 SetState.associativity + 1，这样所有的内存块年龄都小于m """
            rel_age = self.__states[set_index].get(block_ident, self.associativity + 1)
            self.__add_relative_age_less(mem_block.set_index, rel_age, remove_evicted=True)
            self.__states[set_index][block_ident] = 1
        elif self.__analysis_type == CacheAnalysisMethod.MAY:
            """ May-sim:
            To determine, if a memory block is never in the __cache, we compute the set of all memory blocks that may be
            in the __cache. We use abstract __cache states where the positions of the memory blocks in the abstract __cache 
            state are lower bounds of the age of the memory blocks.
            * 如果一个内存块m之前不在 Set State 中，那么访问会导致 State 中所有内存块的最小年龄加1。
            * 如果一个内存块m之前存在 Set State 中：
              * 假设它的最小相对年龄是h，那么对于最小年龄小于h的内存块，假设它的年龄是a，如果它在l_a，那么它一定会被向后移动，
                因此最小年龄需要加1；
              * 对于最小年龄等于h的内存块，如果它的确位于l_h，那么其一定在m之前，这样访问m一定会导致x向后移动一位，因此最小年龄需要加1；
              * 对于最小年龄大于h的内存块，假设它的年龄是b，如果他在l_b，m是可能在l_b之前的，这就说明该内存块可能不会被向后移动，
                因此最小年龄仍然为b。
            """

            """ 如果内存块m不在 Set State 中，那么将年龄设置为 SetState.associativity + 1，这样所有的内存块年龄都小于等于m """
            rel_age = self.__states[set_index].get(block_ident, self.__associativity + 1)
            if min_age is None or rel_age <= min_age:
                self.__add_relative_age_leq(mem_block.set_index, rel_age, remove_evicted=True)
                self.__states[set_index][block_ident] = 1
            else:
                """ 根据 'Precise Multi-Level Inclusive Cache Analysis for WCET Estimation' 的safe MAY Update实现"""
                self.__add_relative_age_leq(mem_block.set_index, min_age, remove_evicted=True)
                self.__states[set_index][block_ident] = 1

        elif self.__analysis_type == CacheAnalysisMethod.PERSISTENT:
            """
            Persistent sim is to determine the persistence of a memory block, i.e., the absence of the possibility 
            that a memory block m is removed from the __cache. If there is no possibility to remove m from the __cache, then
            the first reference to m may result in a __cache miss, but all further references to m cannot result in __cache
            misses.
            Persistent analysis的update方法与must-analysis的update方法基本相同。区别在于当内存块的年龄大于SetState.associativity
            时，不会将其直接移出Set State，而是将其放入表示Evicted的行(l_h)。
            """

            rel_age = self.__states[set_index].get(block_ident, self.__associativity + 1)
            self.__add_relative_age_less(mem_block.set_index, rel_age, remove_evicted=False)
            self.__states[set_index][block_ident] = 1

    def updateU(self, mem_block: MemoryBlock, loop_level: int = -1, min_age: Optional[List[int]] = None):
        """
        CAC = U时的 Update：
        即 updateU = Join(cache state, Update(cache state, memory block))
        主要是为了避免 deepcopy 的开销
        """
        set_index = mem_block.set_index
        block_ident = mem_block.tag
        if self.__analysis_type == CacheAnalysisMethod.MUST:
            # L1 MISS，继而访问L2(更新Block) & L2 Hit，不访问L2(L2中一定含有L1的block)
            # 最差的情况就是更新block
            rel_age = self.__states[set_index].get(block_ident, self.__associativity + 1)
            self.__add_relative_age_less(set_index, rel_age, remove_evicted=True)
            self.__states[set_index][block_ident] = 1

        elif self.__analysis_type == CacheAnalysisMethod.MAY:
            self.__states[set_index][block_ident] = 1

        elif self.__analysis_type == CacheAnalysisMethod.PERSISTENT:
            rel_age = self.__states[set_index].get(block_ident, self.__associativity + 1)
            self.__add_relative_age_less(set_index, rel_age, remove_evicted=False)
            if rel_age == self.__associativity + 1:  # 之前没有放过内存块Block，令其age=1
                self.__states[set_index][block_ident] = 1
            for block_ident, rel_age in tuple(self.__states[set_index].items()):
                if rel_age > self.associativity:
                    self.__states[set_index][block_ident] = self.associativity

    def __add__(self, other):
        """ 不同分析方法的Join函数 """
        if not isinstance(other, CacheState):
            print(type(other))
            raise TypeError("Operands must be instances of class:CacheState.")
        if not all([self.__analysis_type == other.__analysis_type,
                    self.__cache_config.ident == other.__cache_config.ident]):
            raise TypeError("Two operands must have the same sim type and __cache configuration.")

        new_state = CacheState(cache_config=self.__cache_config, analysis_type=self.__analysis_type)

        set_number = self.__cache_config.set_number
        self_state = self.__states
        other_state = other.__states
        new_cachestate = new_state.__states

        if self.__analysis_type == CacheAnalysisMethod.MUST:
            for set_index in range(set_number):
                self_set_state = self_state[set_index]
                other_set_state = other_state[set_index]
                intersection_keys = self_set_state.keys() & other_set_state.keys()
                new_cachestate[set_index] = {
                    ident: self_set_state[ident] if self_set_state[ident] > other_set_state[ident]
                    else other_set_state[ident]
                    for ident in intersection_keys}

        elif self.__analysis_type == CacheAnalysisMethod.MAY:
            default_age = self.__associativity + 1
            for set_index in range(set_number):
                self_set_state = self_state[set_index]
                other_set_state = other_state[set_index]
                union_keys = self_set_state.keys() | other_set_state.keys()
                new_set_state = {}
                for ident in union_keys:
                    self_age = self_set_state.get(ident, default_age)
                    other_age = other_set_state.get(ident, default_age)
                    new_set_state[ident] = self_age if self_age < other_age else other_age
                new_cachestate[set_index] = new_set_state

        elif self.__analysis_type == CacheAnalysisMethod.PERSISTENT:
            for set_index in range(set_number):
                self_set_state = self_state[set_index]
                other_set_state = other_state[set_index]
                union_keys = self_set_state.keys() | other_set_state.keys()
                new_set_state = {}
                for ident in union_keys:
                    self_age = self_set_state.get(ident, 0)
                    other_age = other_set_state.get(ident, 0)
                    new_set_state[ident] = self_age if self_age > other_age else other_age
                new_cachestate[set_index] = new_set_state
        return new_state

    def __radd__(self, other):
        return self.__add__(other)

    def get_set_lines(self, set_index: int, do_sort: bool = True) -> List[List[MemoryBlock]]:
        """
        Args:
            do_sort: 对于年龄相同的位于同一个 list 中的内存块，是否需要按照他们的 tag 从小到大排列。
        """

        if self.__analysis_type == CacheAnalysisMethod.PERSISTENT:
            rtn_list = [list() for _ in range(self.__associativity + 1)]
        else:
            rtn_list = [list() for _ in range(self.__associativity)]
        for block_ident, age in self.__states[set_index].items():
            rtn_list[age - 1].append(MemoryBlock(block_ident, set_index, self.__cache_level))

        if do_sort:
            rtn_list = [sorted(item, key=lambda x: x.tag) for item in rtn_list]
        return rtn_list

    def get_all_set_lines(self, do_sort=True) -> List[List[List[MemoryBlock]]]:
        """
        返回的结果是一个三层的数组：
         - 第一层：``set_index``，表示不同的Cache Set，长度为 ``self.cache_config.set_number``；
         - 第二层：``age``，表示一个Cache Set中的不同的年龄，长度为 ``self.cache_config.associativity``
         或者对于scope aware和persistent来说，需要在其基础上加1。
         - 第三层是一个 ``List[MemoryBlock]`` 列表，包含了下标为 ``set_index`` 的Cache State中年龄为 ``age`` 的所有内存块。
        """
        return [self.get_set_lines(set_index=set_index, do_sort=do_sort) for set_index in range(len(self.__states))]

    def __eq__(self, other) -> bool:
        for self_state, other_state in zip(self.__states, other.__states):
            if self_state != other_state:
                return False
        return True

    def __deepcopy__(self, memo=None):
        if id(self) in memo:
            return memo[id(self)]

        new_state = CacheState(cache_config=self.__cache_config, analysis_type=self.__analysis_type)

        # Here we can use Shallow Copy because Immutable Attributes
        new_state.__states = [set_dict.copy() for set_dict in self.__states]

        memo[id(self)] = new_state
        return new_state


class CACLeastUpperBound:
    def __init__(self) -> None:
        self.__CAC_bound: Dict[Reference, Dict[CacheHierarchy, CAC]] = dict()

    def update(self, ref: Reference, cache_level: CacheHierarchy, cac: CAC):
        if ref not in self.__CAC_bound:
            self.__CAC_bound[ref] = {}
        current_cac = self.__CAC_bound[ref].get(cache_level, None)

        if current_cac is None:
            self.__CAC_bound[ref][cache_level] = cac
        else:
            if current_cac == CAC.U or cac == CAC.U:
                self.__CAC_bound[ref][cache_level] = CAC.U
            elif current_cac == CAC.A and cac == CAC.A:
                self.__CAC_bound[ref][cache_level] = CAC.A
            else:
                self.__CAC_bound[ref][cache_level] = CAC.N

    def get_CAC(self, ref, cache_level):
        return self.__CAC_bound[ref][cache_level]

    @property
    def CAC_bound(self):
        return self.__CAC_bound


def UpdateCAC(chmc, cac):
    """ From the CHMC and CAC of layer i,  get the CAC of layer i+1 : L1->L2 """
    if cac == CAC.A:  # L1 (CAC==A) -> L2
        if chmc == CHMC.AH:
            cac = CAC.A    # L2中可能不存在此内存块
        elif chmc == CHMC.AM:
            cac = CAC.A
        else:  # L1.chmc == PS/NC
            cac = CAC.U     # L2中可能不存在此内存块
    elif cac == CAC.U:      # L2 -> L3
        if chmc == CHMC.AH:
            cac = CAC.N
        else:
            cac = CAC.U
    else:              # L2 -> L3
        cac = CAC.N
    return cac


class MultiLevelCacheState:
    def __init__(self, multilevel_cache_config: MultiLevelCacheConfig) -> None:
        self.__cache_config = multilevel_cache_config

        self.__states = {
            CacheAnalysisMethod.MUST: {level: CacheState(config, CacheAnalysisMethod.MUST)
                                       for level, config in self.__cache_config.cache_configs().items()},
            CacheAnalysisMethod.MAY: {level: CacheState(config, CacheAnalysisMethod.MAY)
                                      for level, config in self.__cache_config.cache_configs().items()},
            CacheAnalysisMethod.PERSISTENT: {level: CacheState(config, CacheAnalysisMethod.PERSISTENT)
                                             for level, config in self.__cache_config.cache_configs().items()}
        }

        self.__CAC_bound = CACLeastUpperBound()

        " for MAY analysis"
        self.__min_age = {CacheHierarchy.L1I: [self.__cache_config[CacheHierarchy.L1I].associativity + 1
                                               for _ in range(self.__cache_config[CacheHierarchy.L1I].set_number)],
                          CacheHierarchy.L1D: [self.__cache_config[CacheHierarchy.L1D].associativity + 1
                                               for _ in range(self.__cache_config[CacheHierarchy.L1D].set_number)], }

    def clear(self):
        """ Clears the state of the MultiLevelCacheState, resetting all internal states. """

        # Clear all states in __states
        for analysis_method in self.__states:
            for level in self.__states[analysis_method]:
                self.__states[analysis_method][level].clear()

        # Reset CAC_bound
        self.__CAC_bound = CACLeastUpperBound()

        # Reset min_age values
        for cache_level in self.__min_age:
            self.__min_age[cache_level] = [self.__cache_config[cache_level].associativity + 1
                                           for _ in range(self.__cache_config[cache_level].set_number)]

    @property
    def must_state(self) -> Dict[CacheHierarchy, CacheState]:
        return self.__states[CacheAnalysisMethod.MUST]

    @property
    def may_state(self) -> Dict[CacheHierarchy, CacheState]:
        return self.__states[CacheAnalysisMethod.MAY]

    @property
    def persistent_state(self) -> Dict[CacheHierarchy, CacheState]:
        return self.__states[CacheAnalysisMethod.PERSISTENT]

    @property
    def CAC_bound(self):
        return self.__CAC_bound

    def get_state(self, analysis_method: CacheAnalysisMethod, cache_level: CacheHierarchy) -> CacheState:
        return self.__states[analysis_method][cache_level]

    def update(self, ref: Reference):
        """ 更新函数 """
        L1Block = ref.get_block(CacheHierarchy.L1I if ref.ref_type == RefType.INST else CacheHierarchy.L1D)
        L2Block = ref.get_block(CacheHierarchy.L2)

        " First Loop: from L1 to lower cache level "
        cac = CAC.A
        cache_level = CacheHierarchy.L1I if ref.ref_type == RefType.INST else CacheHierarchy.L1D
        self.__CAC_bound.update(ref, cache_level, cac)  # 设置L1下的cac
        chmc = self.Categorize(ref, cache_level)
        cac = UpdateCAC(chmc, cac)  # 通过该cache level下的cac及指令的chmc，获取下一级的cac
        " L2"
        cache_level = CacheHierarchy.L2
        self.__CAC_bound.update(ref, cache_level, cac)  # 设置L2下的cac
        chmc = self.Categorize(ref, cache_level)
        cac = UpdateCAC(chmc, cac)  # 获取下一级的cac

        " second Loop: from L2 to higher cache level "
        cac = self.__CAC_bound.get_CAC(ref, cache_level)
        if cac == CAC.A:
            self.__states[CacheAnalysisMethod.MUST][cache_level].update(L2Block)
            self.__states[CacheAnalysisMethod.MAY][cache_level].update(L2Block)
            self.__states[CacheAnalysisMethod.PERSISTENT][cache_level].update(L2Block)
        elif cac == CAC.U:  # L1中的指令为PS/NC
            self.__states[CacheAnalysisMethod.MUST][cache_level].updateU(L2Block)
            self.__states[CacheAnalysisMethod.MAY][cache_level].updateU(L2Block)
            self.__states[CacheAnalysisMethod.PERSISTENT][cache_level].updateU(L2Block)
        else:
            pass

        " Invalidate"
        # TODO optimize Invalidate function
        PO = self.__states[CacheAnalysisMethod.PERSISTENT][cache_level].get_evicted_line()

        for victim in PO:
            victim_l1i = MemblockConvert(victim, self.__cache_config.get_cache_config(CacheHierarchy.L2),
                                         self.__cache_config.get_cache_config(CacheHierarchy.L1I))
            victim_l1d = MemblockConvert(victim, self.__cache_config.get_cache_config(CacheHierarchy.L2),
                                         self.__cache_config.get_cache_config(CacheHierarchy.L1D))
            if self.__states[CacheAnalysisMethod.MUST][CacheHierarchy.L1I].in_cache(victim_l1i):
                self.__states[CacheAnalysisMethod.MUST][CacheHierarchy.L1I].remove_block(victim_l1i)
            if self.__states[CacheAnalysisMethod.MUST][CacheHierarchy.L1D].in_cache(victim_l1d):
                self.__states[CacheAnalysisMethod.MUST][CacheHierarchy.L1D].remove_block(victim_l1d)
            if self.__states[CacheAnalysisMethod.PERSISTENT][CacheHierarchy.L1I].in_cache(victim_l1i):
                self.__states[CacheAnalysisMethod.PERSISTENT][CacheHierarchy.L1I].set_age(
                    self.__cache_config[CacheHierarchy.L1I].associativity + 1, victim_l1i)
            if self.__states[CacheAnalysisMethod.PERSISTENT][CacheHierarchy.L1I].in_cache(victim):
                self.__states[CacheAnalysisMethod.PERSISTENT][CacheHierarchy.L1D].set_age(
                    self.__cache_config[CacheHierarchy.L1D].associativity + 1, victim_l1d)
            if self.__states[CacheAnalysisMethod.MAY][CacheHierarchy.L1I].in_cache(victim):
                self.__min_age[CacheHierarchy.L1I][victim.set_index] = min(self.__min_age[CacheHierarchy.L1I],
                                                                           self.__states[CacheAnalysisMethod.MAY][
                                                                               CacheHierarchy.L1I].get_age(victim_l1i))
            if self.__states[CacheAnalysisMethod.MAY][CacheHierarchy.L1D].in_cache(victim):
                self.__min_age[CacheHierarchy.L1D][victim.set_index] = min(self.__min_age[CacheHierarchy.L1D],
                                                                           self.__states[CacheAnalysisMethod.MAY][
                                                                               CacheHierarchy.L1D].get_age(victim_l1d))

        cache_level = CacheHierarchy.L1I if ref.ref_type == RefType.INST else CacheHierarchy.L1D
        cac = self.__CAC_bound.get_CAC(ref, cache_level)
        if cac == CAC.A:
            self.__states[CacheAnalysisMethod.MUST][cache_level].update(L1Block)
            self.__states[CacheAnalysisMethod.MAY][cache_level].update(L1Block, min_age=self.__min_age[cache_level][L1Block.set_index])
            self.__states[CacheAnalysisMethod.PERSISTENT][cache_level].update(L1Block)
        elif cac == CAC.U:
            self.__states[CacheAnalysisMethod.MUST][cache_level].updateU(L1Block)
            self.__states[CacheAnalysisMethod.MAY][cache_level].updateU(L1Block)
            self.__states[CacheAnalysisMethod.PERSISTENT][cache_level].updateU(L1Block)
        else:
            pass

    def Categorize(self, ref: Reference, cache_level: CacheHierarchy):

        mb = ref.get_block(cache_level)
        debug = True

        if debug:
            if self.must_state[cache_level].in_cache(mb) and not self.persistent_state[cache_level].in_cache(mb):
                raise SystemError("memory block in the must state must be in the persistent state.")

        if self.must_state[cache_level].in_cache(mb):
            return CHMC.AH

        # if self.persistent_state[cache_level].in_cache(mb):  # 对全局进行persistent，导致AM的指令无法识别，影响计算CAC，删掉
        #     return CHMC.PS

        if not self.may_state[cache_level].in_cache(mb):
            return CHMC.AM

        return CHMC.NC

    def __add__(self, other):
        """ Join函数，调用了不同分析方法的Join函数 """
        new_state = MultiLevelCacheState(multilevel_cache_config=self.__cache_config)
        for analysis_type, state in self.__states.items():
            for level in state.keys():
                new_state.__states[analysis_type][level] = self.__states[analysis_type][level] + \
                                                           other.__states[analysis_type][level]
        return new_state

    def __radd__(self, other):
        return self.__add__(other)

    def __eq__(self, other):

        for method, self_multi_state in self.__states.items():
            other_multi_state = other.__states[method]
            for cache_level, self_state in self_multi_state.items():
                if self_state != other_multi_state.get(cache_level):
                    return False
        return True
