import warnings
from copy import deepcopy
from typing import Set, Union, Dict, List, Optional
import numpy as np
from tabulate import tabulate

from sample.cache.cache_config import CacheConfig
from sample.cache.constants import CacheAnalysisMethod
from sample.cache.memory_block import *

ScopeAwareAnalysisContext = Dict[str, Union[set, int]]

"""
在进行 scope aware 分析时，除了要记录每个 reference 的 relative age 外，还需要记录他们的 younger set。
ScopeAwareAnalysisContext 表示了这样一个内容的类型抽象。 例如，一个典型的进行 scope aware 分析时为 reference 记录的内容为：
>>> {"younger_set": {M1, M2, M3}, "relative age": 3}
"""

SetAbsState = Dict[Union[int, MemoryBlockWithScopeIdent], Union[int, ScopeAwareAnalysisContext]]

class SetState:
    """
    Abstract Set State.
        支持三种Abstract Set State：
        * Must/May sim: 见论文 `Applying Compiler Techniques to Cache Behavior Prediction`
        * Persistent sim: 见论文 `On Predicting Data Cache Behavior for Real-Time Systems.`
        * Scope-aware sim: 见论文 `Scope-aware Data Cache Analysis for WCET Estimation`
    """

    @staticmethod
    def __overlap_by_ident(ident1: MemoryBlockWithScopeIdent, ident2: MemoryBlockWithScopeIdent,
                           loop_level: int = -1) -> bool:
        """
        判断两个 ``MemoryBlockWithScopeIdent`` 的实例对应的 ``MemoryBlockWithScope`` 是否发生overlap。 参考 ``overlap()`` 方法。
        """
        if ident1[0] == ident2[0]:
            return False
        scope1, scope2 = ident1[1], ident2[1]
        loop_level = max(len(scope1), len(scope2)) + 1 if loop_level == -1 else loop_level
        for r1, r2 in zip(scope1[: loop_level], scope2[: loop_level]):
            if r2[0] <= r1[0] <= r2[1] or r2[0] <= r1[1] <= r2[1]:
                continue
            return False
        return True

    def __init__(self, analysis_type: CacheAnalysisMethod, associativity: int, set_index: Optional[int] = 0,
                 init_state: Optional[SetAbsState] = None):
        """
        初始化 ``SetState`` 实例。

        该函数的参数 ``init_state`` 用于提供 ``SetState`` 的初始状态。 代码默认 ``init_state`` 内容的合法性，并且不会对他们做任何
        检查。因此通常不应该使用他们。

        Args:
            analysis_type: Abstract Set State的类型，CacheAnalysisMethod 的其中一个。
            associativity: 集合的组相连度。
            set_index: 该集合在整个Cache中对应的下标，默认为 0。
            init_state: 初始状态，默认为 None。
        """
        self.__analysis_type = analysis_type
        self.__abstract_state = dict() if init_state is None else deepcopy(init_state)
        self.__set_index = set_index
        self.__associativity = associativity

    @property
    def set_index(self) -> int:
        return self.__set_index

    @property
    def associativity(self) -> int:
        return self.__associativity

    @property
    def analysis_type(self) -> CacheAnalysisMethod:
        return self.__analysis_type

    @property
    def runtime_ident(self) -> Tuple[Tuple[int, int], ...]:
        """
        方法在【运行时】将当前的abstract state转化为一个元组并返回。返回的元组类型总是 ``Tuple[Tuple[int, int], ...]`` 其中第一项表示
        内存块（对应的哈希值），第二项表示其在分析时的context（对应的哈希值）,并且返回的元组总是按照第一项（即内存块（对应的哈希值））排好序的。

        我们认为如果两个元组不同，那么返回的结果调用 ``__hash__()`` 得到的值一定是不同的，或者也可以直接用 ``==`` 运算直接比较。
        这使得我们可以判断任意两个abstract state是否相同。另外，用户可以进一步地比较究竟时哪些内存块的context发生了变化。

        注意：返回的元组不包括analysis type、组相连度和set index。对他们的控制由上层的 ``CacheState`` 完成，或者我们认为用户清楚他们
        在做什么。
        """

        if self.__analysis_type == CacheAnalysisMethod.SCOPE_AWARE:
            """
            对于scope_aware analysis来说，abstract state的类型是Dict[MemoryBlockWithScopeIdent, ScopeAwareAnalysisContext]。
            * MemoryBlockWithScopeIdent的类型为Tuple[int, ScopeTy]，其中ScopeTy = Tuple[Tuple[int, int], ...]
              由于int和ScopeTy都是常量，并且MemoryBlockWithScopeIdent是一个元组，那么他们整体就是一个可哈希的Tuple。
              我们认为，如果两个内存块拥有不同的`tag`或者temporal scope，那么他们对应的哈希值一定是不同的，反之一定是相同的，因此，我们取
              元组整体的哈希值。
            * ScopeAwareAnalysisContext的类型是一个字典，一个典型的形式为{"younger_set": {M1, M2, M3}, "relative age": 3}
              其中“relative age”是一个int类型常量，而“younger_set”是一个元素类型为int的集合。我们将该集合转换为排序后的元组。
              将ScopeAwareAnalysisContext转换为Tuple[int, Tuple[int, ...]]类型后，与前述相同的假设，我们取该元组整体的哈希值。
            最后，abstract state转换后的类型是Tuple[Tuple[int, int], ...]，按照每个元素的第一个int，即ident元组整体的哈希值进行排序。
            """
            return tuple(sorted([
                (
                    ident.__hash__(), (context["relative_age"],
                                       tuple(sorted(list(context["younger_set"])))
                                       ).__hash__()
                ) for ident, context in self.__abstract_state.items()
            ], key=lambda x: x[0]))
        else:
            """
            对于 must/may/persistent sim 来说，abstract state的类型是Dict[int, int]。其中第一个 int 表示内存访问块的 
            identity，即`tag`；第二个 int 表示 relative age。
            由于内存访问块的identity不会重复，因此代码将abstract state转换为Tuple[Tuple[int, int], ...]的形式，
            并按照 `tag` 为键进行排序。
            """
            return tuple(
                sorted(
                    [(tag, relative_age) for tag, relative_age in self.__abstract_state.items()],
                    key=lambda x: x[0])
            )

    @property
    def abstract_state(self) -> SetAbsState:
        """ 该函数返回一个当前状态的深拷贝。通常不应该使用这个函数，因为这会带来较大的复制开销，并且返回的内容不具有可读性。 """
        return deepcopy(self.__abstract_state)

    def get_set_lines(self, do_sort: bool = True) -> List[List[MemoryBlock]]:
        """
        按照年龄顺序排列所有的内存块。拥有相同年龄的内存块在同一个 ``list`` 中。返回的结果会将 ``ident`` 转换为对应的 ``MemoryBlock``
        或者 ``MemoryBlockWithScope`` 。

        Args:
            do_sort: 对于年龄相同的位于同一个 list 中的内存块，是否需要按照他们的 tag 从小到大排列。
        """

        if self.__analysis_type == CacheAnalysisMethod.SCOPE_AWARE:
            rtn_list: List[List[MemoryBlock]] = [list() for _ in range(self.associativity + 1)]
            """ 对于每一个内存块，根据他们的relative age将其放入rtn_list对应下标的list中。 """
            for block_ident, context in self.__abstract_state.items():
                rtn_list[context["relative_age"] - 1].append(
                    MemoryBlockWithScope(block_ident[0], self.set_index, block_ident[1]))
        else:
            if self.__analysis_type == CacheAnalysisMethod.PERSISTENT:
                rtn_list = [list() for _ in range(self.__associativity + 1)]
            else:
                rtn_list = [list() for _ in range(self.__associativity)]
            for block_ident, age in self.__abstract_state.items():
                rtn_list[age - 1].append(MemoryBlock(block_ident, self.set_index))

        if do_sort:
            rtn_list = [sorted(item, key=lambda x: x.tag) for item in rtn_list]
            
        return rtn_list

    def format_set_lines(self, title: Optional[str] = None, style="psql", simple: bool = False):
        """
        与 ``get_set_lines()`` 类似，但返回表格形式的，格式化后的，用于输出的字符串，拥有更好的可读性。

        Args:
            title: 表格的标题。
            style: 表格的风格。 传入"latex"、"html"和"markdown"以生成支持Latex、HTML和Markdown格式的表格字符串。
            simple: 如果该参数为True，那么将使用`ident`来标识每个内存块。这会使输出的表格更简洁，但降低可读性。
        """

        """ 列表的每行表示一个relative age。每行的标签即为当前行的年龄大小。 """
        row_index = ["l_{}".format(age) for age in range(1, self.__associativity + 1)]
        """ 对于scope_aware和persistent来说，还需要加上一个驱逐行（在论文中表示为l_T）。 """
        if self.__analysis_type in ("scope_aware", "persistent"):
            row_index.append("Evicted")
        """
        values是一个size为SetState.associativity + 1(/2)的数组，数组中的每个元素是一个list，包含了所有对应于该下标年龄的内存块。
        首先调用self.get_set_lines(do_sort=True)方法。 之后，对于每一个内存块，根据simple和内存块的类型将其转换为对应的字符串表示。
        """
        values = self.get_set_lines(do_sort=True)
        values = [[block.__str__() if not simple else
                   "<{}, {}>".format(hex(block.tag), list(block.scope)) if isinstance(block, MemoryBlockWithScope) else
                   hex(block.ident)
                   for block in block_list] for block_list in values]
        """ 第一列表示的是集合中的不同年龄的行标签，随后是数字,[0, L)，按顺序计数，其中L是values中最长的元素对应的长度。 """
        headers = ["Cache Line"] + list(range(max([len(x) for x in values])))
        """ 返回结果。如果title不为None，将标题添加在结果的最前面，用'\n'分隔。 """
        if title is None:
            return tabulate(values, headers=headers, showindex=row_index, tablefmt=style)
        else:
            return "\n".join([title, tabulate(values, headers=headers, showindex=row_index, tablefmt=style)])

    def get_younger_set(self) -> Dict[MemoryBlockWithScope, Set[MemoryBlock]]:
        """
        返回所有内存引用的 younger set。返回的结果会将所有的 ``ident`` 转换为对应的 ``MemoryBlock`` 或
        者 ``MemoryBlockWithScope``。该方法只有在 ``analysis_type == 'scope_aware'`` 时才有意义。
        """

        """ 
        根据ident和self.set_index获得对应的MemoryBlock，并作为键；
        根据context中的younger_set中的tag和self.set_index获得对应的MemoryBlock，将所有的MemoryBlock合并为一个list，作为值。
        """
        if len(self.__abstract_state) == 0:
            return dict()
        else:
            return {
                MemoryBlockWithScope(ident[0], self.set_index, ident[1]): set(
                    [MemoryBlock(tag, self.__set_index) for tag in context["younger_set"]]
                ) for ident, context in self.__abstract_state.items()
            }

    def format_younger_set(self, title: Optional[str] = None, style="psql", simple: bool = False) -> str:
        """
        与 ``get_younger_set()`` 类似，但返回表格形式的，格式化后的，用于输出的字符串，拥有更好的可读性。

        Args:
            title: 表格的标题。
            style: 表格的风格。 传入"latex"、"html"和"markdown"以生成支持Latex、HTML和Markdown格式的表格字符串。
            simple: 如果该参数为True，那么将使用`ident`来标识每个内存块。这会使输出的表格更简洁，但降低可读性。
        """

        """ 首先调用self.get_younger_set()方法获得所有内存块对应的younger set。 """
        ys: Dict[MemoryBlockWithScope, Set[MemoryBlock]] = self.get_younger_set()
        if len(ys) == 0:
            return "Empty" if title is None else "{} -> Empty\n".format(title)
        """
        表格的每一行的第一列(index)是当前的内存块，后续的若干个项（分布在每一列）都包含了当前内存块的younger set中的一个内存块。
        values是一个size为所有内存块数量的数组，每一个元素又是一个list，包含了younger_set的所有内存块的字符串表示。
        row_index与values对应，每个元素是内存块的字符串表示。
        字符串表示由MemoryBlock根据simple进行相应的转换。
        """
        values = [
            [str(item) if not simple else hex(item.ident) for item in block_list]
            for _, block_list in ys.items()
        ]
        row_index = [str(key) if not simple else "<{}, {}>".format(hex(key.tag), list(key.scope)) for key, _ in ys.items()]
        """ headers的第一列表示的是各个内存块，随后是数字,[0, L)，按顺序计数，其中L是values中最长的元素对应的长度。 """
        headers = ["Memory Blocks"] + list(range(max([len(x) for x in values])))
        """ 返回结果。如果title不为None，将标题添加在结果的最前面，用'\n'分隔。 """
        if title is None:
            return tabulate(values, headers=headers, showindex=row_index, tablefmt=style)
        else:
            return "\n".join([title, tabulate(values, headers=headers, showindex=row_index, tablefmt=style)])

    def __add_relative_age_less(self, cmp_rel_age: int, remove_evicted: bool = False) -> None:
        """
        私有方法。该方法用于 must/persistent-sim 。

        根据 ``cmp_rel_age`` 将当前状态中所有 relative age【小于】 ``cmp_rel_age`` 的内存块的relative age加1.
        如果 ``remove_evicted == True``，那么方法最后会调用 ``__remove_evicted()`` 方法检查所有的内存块，并将被驱逐的内存块删除。
        """

        for mem_block, rel_age in self.__abstract_state.items():
            if rel_age >= cmp_rel_age:
                continue
            """ 内存块的年龄最大不会超过 SetState.associativity+1，当等于时，说明该内存块被驱逐。 """
            self.__abstract_state[mem_block] = min(self.__associativity, rel_age) + 1
        if remove_evicted:
            self.__remove_evicted()

    def __add_relative_age_leq(self, cmp_rel_age: int, remove_evicted: bool = False) -> None:
        """
        私有方法。该方法用于 may-sim 。

        根据 ``cmp_rel_age`` 将当前状态中所有 relative age【小于或等于】 ``cmp_rel_age`` 的内存块的relative age加1.
        如果 ``remove_evicted == True``，那么方法最后会调用 ``__remove_evicted()`` 方法检查所有的内存块，并将被驱逐的内存块删除。
        """

        for mem_block, rel_age in self.__abstract_state.items():
            if rel_age > cmp_rel_age:
                continue
            """ 内存块的年龄最大不会超过 SetState.associativity+1，当等于时，说明该内存块被驱逐。 """
            self.__abstract_state[mem_block] = min(self.__associativity, rel_age) + 1
        if remove_evicted:
            self.__remove_evicted()

    def __remove_evicted(self) -> None:
        """ 私有方法。该方法检查所有的内存块，并将被驱逐的内存块删除。 """
        for mem_block, rel_age in tuple(self.__abstract_state.items()):
            if rel_age > self.associativity:
                self.__abstract_state.pop(mem_block)

    def update(self, mem_blocks: Sequence[Union[int, MemoryBlockWithScopeIdent]], loop_level: int = -1) -> None:
        """
        Set Abstract State 的 Update 方法，根据可能访问的内存块更新状态。

        Args:
            mem_blocks: 可能访问的内存块列表（元组）。列表（元组）中的元素应该被提前转换为 ident 。
            loop_level: 用于Scope-aware analysis的最深循环等级。对于must/may/persistent analysis来说，该参数被忽略。

        """
        if self.__analysis_type == CacheAnalysisMethod.MUST:
            """ Must-sim:
            To determine if a memory block is definitely in the __cache we use abstract __cache states where the positions
            of the memory blocks in the abstract __cache state are upper bounds of the ages of the memory blocks.
            * 如果一个内存块m之前不在 Set State 中，那么访问会导致 State 中所有内存块的最大年龄加1.
            * 如果一个内存块m之前存在 Set State 中，假设它的最大相对年龄是h，那么最大年龄小于h的内存块有可能在m之前，因此最大年龄需要加1；
              最大年龄大于等于h的内存块有两种情况，在m前，那么向后移动，但年龄依然不超过m，在m之后，不会发生冲突，因此不需要增加最大年龄。
            """
            for block_ident in mem_blocks:
                """ 如果内存块m不在 Set State 中，那么将年龄设置为 SetState.associativity + 1，这样所有的内存块年龄都小于m """
                rel_age = self.__abstract_state.get(block_ident, self.__associativity + 1)
                self.__add_relative_age_less(rel_age, remove_evicted=True)
                self.__abstract_state[block_ident] = 1
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
            for block_ident in mem_blocks:
                """ 如果内存块m不在 Set State 中，那么将年龄设置为 SetState.associativity + 1，这样所有的内存块年龄都小于等于m """
                rel_age = self.__abstract_state.get(block_ident, self.__associativity + 1)
                self.__add_relative_age_leq(rel_age, remove_evicted=True)
                self.__abstract_state[block_ident] = 1
        elif self.__analysis_type == CacheAnalysisMethod.PERSISTENT:
            """
            Persistent sim is to determine the persistence of a memory block, i.e., the absence of the possibility 
            that a memory block m is removed from the __cache. If there is no possibility to remove m from the __cache, then
            the first reference to m may result in a __cache miss, but all further references to m cannot result in __cache
            misses.
            Persistent analysis的update方法与must-analysis的update方法基本相同。区别在于当内存块的年龄大于SetState.associativity
            时，不会将其直接移出Set State，而是将其放入表示Evicted的行(l_h)。
            """
            for block_ident in mem_blocks:
                rel_age = self.__abstract_state.get(block_ident, self.__associativity + 1)
                self.__add_relative_age_less(rel_age, remove_evicted=False)
                self.__abstract_state[block_ident] = 1
        elif self.__analysis_type == CacheAnalysisMethod.SCOPE_AWARE:
            """
            该方法的实现遵守论文 `Scope-aware Data Cache Analysis for WCET Estimation`。
            """
            """ block_ident_passed 是新传入的内存块组成的集合，即论文中的TS^D或者X_{f_i}。 """
            blocks_ident_passed: Set[MemoryBlockWithScopeIdent] = set(mem_blocks)
            """ block_ident_in 是当前存在于Set State中的内存块组成的集合，即论文中的s^in。 """
            blocks_ident_in: Set[MemoryBlockWithScopeIdent] = set(self.__abstract_state.keys())
            blocks_ident_together: Set[MemoryBlockWithScopeIdent] = blocks_ident_passed | blocks_ident_in
            for block_ident in blocks_ident_together:
                """ Situation 1
                如果内存块当前不在Set State中，俺么它的younger set被设置为空集，相对年龄为1.
                """
                if block_ident not in blocks_ident_in:
                    self.__abstract_state[block_ident] = {"younger_set": set(), "relative_age": 1}
                else:
                    """
                    overlap_with_passed 记录了新传入的内存块中，和当前考察的内存块（在loop_level层循环内）发生冲突的内存块。
                    overlap_with_passed 仅记录冲突内存块的tag，而不记录scope。这和论文是一致的。
                    """
                    overlap_with_passed = set(
                        [cmp_ident[0] for cmp_ident in blocks_ident_passed
                         if SetState.__overlap_by_ident(cmp_ident, block_ident, loop_level=loop_level)]
                    )
                    """ Situation 2
                    如果内存块在Set State中，是新传入的内存块（即在blocks_ident_passed中），并且在新传入的内存块中没有任何一个内存块
                    与当前考察的内存块案发生冲突（即 len(overlap_with_passed) == 0），那么它的younger set被设置为空集，相对年龄为1.
                    """
                    if block_ident in blocks_ident_passed and len(overlap_with_passed) == 0:
                        self.__abstract_state[block_ident]["younger_set"] = set()
                        self.__abstract_state[block_ident]["relative_age"] = 1
                    else:
                        """ Situation 3
                        如果不满足前面的两种情况，那么它的younger set被设置为其本身的younger set与新传入内存块中与其发生冲突的所有
                        内存块的并集（即overlap_with_passed）。它的相对年龄即新的younger set的大小+1。
                        """
                        self.__abstract_state[block_ident]["younger_set"] |= overlap_with_passed
                        self.__abstract_state[block_ident]["relative_age"] = \
                            min(len(self.__abstract_state[block_ident]["younger_set"]), self.__associativity) + 1
        return

    def __add__(self, other):
        """
        Set Abstract State 的 Join 方法，重载到加号(+)运算符。合并两个Set State。 ``other`` 应该是另一个 ``SetState`` 的实例，并且
        与 ``self`` 拥有相同的分析类型。

        该方法返回一个新的 ``SetState`` 的实例，而不会修改传入的其中任何一个实例。
        """

        blocks_ident1 = set(self.__abstract_state.keys())
        blocks_ident2 = set(other.__abstract_state.keys())
        # 这里默认认为other应该和self有相同的分析类型、组相连度和集合下标。
        new_set_state = \
            SetState(analysis_type=self.__analysis_type, associativity=self.__associativity, set_index=self.__set_index)
        if self.__analysis_type == CacheAnalysisMethod.MUST:
            """ Must-sim
            Must sim 只取同时存在于两个Set State中的内存块，并且新的相对年龄是该内存块在两个Set State中的相对年龄的较大值。
            """
            blocks_ident_both = blocks_ident1 & blocks_ident2
            new_set_state.__abstract_state = \
                {ident: max(self.__abstract_state[ident], other.__abstract_state[ident]) for ident in blocks_ident_both}
        elif self.__analysis_type == CacheAnalysisMethod.MAY:
            """ May-sim
            May sim 考察所有存在于Set State中的内存块，如果它在两个Set State中都存在，取【较小】的相对年龄作为新的相对年龄。
            """
            blocks_ident_union = blocks_ident1 | blocks_ident2
            new_set_state.__abstract_state = \
                {ident: min(self.__abstract_state.get(ident, self.__associativity + 1),
                            other.__abstract_state.get(ident, self.__associativity + 1))
                 for ident in blocks_ident_union}
        elif self.__analysis_type == CacheAnalysisMethod.PERSISTENT:
            """ Persistent-sim
            Persistent sim 考察所有存在于Set State中的内存块，入宫它在两个Set State中都存在，取【较大】的相对年龄作为新的相对年龄。
            """
            blocks_ident_union = blocks_ident1 | blocks_ident2
            new_set_state.__abstract_state = \
                {ident: max(self.__abstract_state.get(ident, 0), other.__abstract_state.get(ident, 0))
                 for ident in blocks_ident_union}
        elif self.__analysis_type == CacheAnalysisMethod.SCOPE_AWARE:
            """ Scope-aware-sim
            Scope-aware sim 考察所有存在于Set State中的内存块。首先计算它的younger set。如果它同时存在于两个Set State中，那么
            新的younger set就是他们的并集；否则，新的younger set就是其原本的younger set。接着计算它的relative age，其值为younger 
            set的大小+1（但不超过SetState.associativity+1）。
            """
            blocks_ident_union = blocks_ident1 | blocks_ident2
            for ident in blocks_ident_union:
                younger_set1 = self.__abstract_state[ident]["younger_set"] if ident in blocks_ident1 else set()
                younger_set2 = other.__abstract_state[ident]["younger_set"] if ident in blocks_ident2 else set()
                new_younger_set = younger_set1 | younger_set2
                new_set_state.__abstract_state[ident] = \
                    {"younger_set": new_younger_set,
                     "relative_age": min(len(new_younger_set), self.__associativity) + 1}
        return new_set_state

    def __radd__(self, other):
        return self.__add__(other)


class CacheState:
    """
    Abstract Cache State.
    ``CacheState`` 完成对 ``SetState`` 的封装，提供面向对象的特性，并引入类型和参数的检查。
    """

    def __init__(self, cache_config: CacheConfig, analysis_type: CacheAnalysisMethod):
        self.__cache_config = cache_config
        if analysis_type not in {CacheAnalysisMethod.MUST, CacheAnalysisMethod.MAY, CacheAnalysisMethod.PERSISTENT, CacheAnalysisMethod.SCOPE_AWARE}:
            raise ValueError("Unsupported sim type {}.".format(analysis_type))
        self.__analysis_type = analysis_type
        self.__states = [
            SetState(analysis_type=analysis_type, associativity=cache_config.associativity, set_index=i)
            for i in range(cache_config.set_number)
        ]

    @property
    def cache_config(self) -> CacheConfig:
        return self.__cache_config

    @property
    def analysis_type(self) -> CacheAnalysisMethod:
        return self.__analysis_type

    @property
    def runtime_ident(self) -> Tuple[int, ...]:
        """
        方法在运行时将当前的abstract __cache state转化为一个元组并返回。返回的元组类型是 ``Tuple[int, ...]`` 。

        该方法针对每一个set调用 ``SetState.runtime_ident`` 方法， 并对返回的元组调用 ``__hash__()`` 方法。这样，用户既可以比较两个
        Cache State是否相同，也可以进一步地比较哪一个set发生了变化。
        """
        return tuple([state.runtime_ident.__hash__() for state in self.__states])

    def update(self, mem_blocks: Sequence[MemoryBlock], loop_level: int = -1):
        if self.__analysis_type == CacheAnalysisMethod.SCOPE_AWARE:
            if not all([isinstance(o, MemoryBlockWithScope) for o in mem_blocks]):
                raise TypeError("All elements in mem_blocks must be instances of class:MemoryBlockWithScope.")
        else:
            if not all([isinstance(o, MemoryBlock) for o in mem_blocks]):
                raise TypeError("All elements in mem_blocks must be instances of class:MemoryBlock.")
            if any([isinstance(o, MemoryBlockWithScope) for o in mem_blocks]):
                warnings.warn("For sim type {}, all instances of class:MemoryBlockWithScope will be converted "
                              "to instances of class:MemoryBlock, which means all temporal scopes are ignored."
                              .format(self.__analysis_type), RuntimeWarning)

        if self.__analysis_type == CacheAnalysisMethod.SCOPE_AWARE:
            distribute: List[List[Union[int, MemoryBlockWithScopeIdent]]] = [
                [o.ident for o in mem_blocks if o.set_index == set_index]
                for set_index in range(self.__cache_config.set_number)]
        else:
            """ 使用o.tag而不是o.ident，隐式地将所有MemoryBlockWithScope类型转换为MemoryBlock。 """
            distribute: List[List[Union[int, MemoryBlockWithScopeIdent]]] = [
                [o.tag for o in mem_blocks if o.set_index == set_index]
                for set_index in range(self.__cache_config.set_number)]

        for set_index, idents in zip(range(self.__cache_config.set_number), distribute):
            self.__states[set_index].update(mem_blocks=idents, loop_level=loop_level)

    def __add__(self, other):

        if not isinstance(other, CacheState):
            raise TypeError("Operands must be instances of class:CacheState.")
        if not all([self.__analysis_type == other.__analysis_type,
                    self.__cache_config.ident == other.__cache_config.ident]):
            raise TypeError("Two operands must have the same sim type and __cache configuration.")

        new_state = CacheState(cache_config=self.__cache_config, analysis_type=self.__analysis_type)

        for set_index in range(self.__cache_config.set_number):
            new_state.__states[set_index] = self.__states[set_index] + other.__states[set_index]

        return new_state

    def __radd__(self, other):
        return self.__add__(other)

    def get_all_set_lines(self, do_sort=True) -> List[List[List[MemoryBlock]]]:
        """
        返回的结果是一个三层的数组：
         - 第一层：``set_index``，表示不同的Cache Set，长度为 ``self.cache_config.set_number``；
         - 第二层：``age``，表示一个Cache Set中的不同的年龄，长度为 ``self.cache_config.associativity``
         或者对于scope aware和persistent来说，需要在其基础上加1。
         - 第三层是一个 ``List[MemoryBlock]`` 列表，包含了下标为 ``set_index`` 的Cache State中年龄为 ``age`` 的所有内存块。
        """
        return [state.get_set_lines(do_sort=do_sort) for state in self.__states]

    def format_all_set_lines(self, title: Optional[str] = None, style="grid", simple=False):
        """"""
        """ 列表的每一行表示一个cache set """
        row_index = list(range(self.__cache_config.set_number))
        """ 列表的每一列表示一个relative age，每行的标签即为当前行的年龄大小。对于scope aware和persistent来说，还需要加上一个驱逐行 """
        headers = [""] + ["l_{}".format(age) for age in range(1, self.__cache_config.associativity + 1)]
        if self.__analysis_type in ("scope_aware", "persistent"):
            headers.append("Evicted")

        """
        values是一个size为len(row_index)的数组，数组的每个元素是一个list，包含了所在行的cache set的年龄为所在列的所有的内存块。
        """
        values = list()
        for set_index in range(self.__cache_config.set_number):
            values.append(["\n".join([str(b) if not simple else str(b.tag) for b in item])
                           for item in self.__states[set_index].get_set_lines()])

        if title is None:
            return tabulate(values, headers=headers, showindex=row_index, tablefmt=style)
        else:
            return "\n".join([title, tabulate(values, headers=headers, showindex=row_index, tablefmt=style)])
