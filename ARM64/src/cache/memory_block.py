from typing import Sequence, Tuple

from src.cache.cache_config import CacheConfig
from src.cache.constants import CacheHierarchy

ScopeTy = Tuple[Tuple[int, int], ...]
""" Temporal scope, 每一个 Tuple[int, int] 都表示一个scope，即 [lw, up]。 """

MemBlockAddr = Tuple[int, int]
""" Address of Memory Block，第一个 int 表示标签 (tag)，第二个 int 表示所在集合 (set_index)。 """

MemoryBlockWithScopeIdent = Tuple[int, ScopeTy]
"""
只有在同一个Set中的MemoryBlock相互之间才会发生冲突。因此当标识一个set中的内存块时，所在集合 set_index 可以忽略。

* 标识一个 MemoryBlockWithScope 实例的 identity。由标签 (tag) 和 temporal scope 组成。
* 标识一个 MemoryBlock 实例的 identity 只包括一个 int 类型的标签 (tag)。
"""


class MemoryBlock:
    """
    Memory Block，Cache访问（即内存块）的抽象表示。每个 ``MemoryBlock`` 由其在Cache中所在的集合(``set_index``)以及
    其在集合中的索引(``tag``)唯一确定。即：
    ``address = tag||set_index||line_offset``
    这意味着即使对于同一个内存访问地址，不同的Cache参数也对应着不同的 ``MemoryBlock`` 实例。
    """

    def __init__(self, tag: int, set_index: int, cache_level: CacheHierarchy) -> None:
        """
        初始化 ``MemoryBlock`` 实例。

        Args:
            tag: 内存块在Cache中对应集合中的索引。
            set_index: 内存块在Cache中所在的集合下标。
        """
        self.__set_index = set_index
        self.__tag = tag
        self.__cache_level = cache_level
        self.__hashed = (tag, set_index).__hash__()
        self.__dump = "[MemoryBlock, tag={}, set_index={}]".format(hex(self.__tag), self.__set_index)

    def convert(self, cache_config: CacheConfig):
        if self.__cache_level == cache_config.cache_level:
            return self
        else:
            pass

    @property
    def set_index(self):
        return self.__set_index

    @property
    def tag(self):
        return self.__tag

    @property
    def cache_level(self):
        return self.__cache_level

    @property
    def block_addr(self):
        """ Returns: 内存块的块地址，由集合索引和集合下标组成。返回结果为 ``(tag, set_index)`` 形式的元组。 """
        return self.__tag, self.__set_index

    @property
    def ident(self):
        return self.__tag

    def __hash__(self) -> int:
        """ 实例的哈希值与元组 ``(tag, set_index)`` 的哈希值相同。 """
        return self.__hashed

    def __eq__(self, other) -> bool:
        """
        当 ``other`` 也是一个 ``MemoryBlock`` 实例，并且两者拥有相同的集合下标(``set_index``)和索引(``tag``)时。
        返回结果为 ``True``，否则返回结果为 ``False``。

        虽然作为 ``MemoryBlock`` 的继承，但是当 ``other`` 为 ``MemoryBlockWithScope`` 的实例时，
        返回结果仍然为 ``False``，即使他们有相同的 ``block_addr`` 。
        """
        if isinstance(other, MemoryBlock) and not isinstance(other, MemoryBlockWithScope):
            return True if self.block_addr == other.block_addr else False
        return False

    def __str__(self) -> str:
        return self.__dump

    def __repr__(self) -> str:
        return self.__dump


class MemoryBlockWithScope(MemoryBlock):
    """
    继承自 ``MemoryBlock``，在其基础上加入了temporal scope (``scope``)。

    与 ``MemoryBlock`` 一样，该类型的实例总是一个常量，这意味着实例的初始化一旦完成，其在整个生存周期内不会被改变。

    Temporal scope
    --------------

    A temporal scope for memory block `m` which is possibly accessed by a data reference `D` is defined as:

    m_bar = {L_i -> [lw, up] for every loop L_i reside in D}

    `scope` 的计算机表示包含若干个 ``Tuple[int, int]`` 组成。 其中每一个 ``Tuple[int, int]`` 都表示一层循环的scope，
    即 [lw, up]。这些scope按照从最外层（但不包括 ``main`` 循环）到最内层的顺序排列。例如：

    >>> scope = [(0, 0), (1, 3), (2, 4)]

    表示第一层循环的访问范围局限在下标 ``0`` 时，第二层循环的访问范围局限在下标从 ``1`` 到 ``3`` 时，第三层循环的访问范围局限在下标
    从 ``2`` 到 ``4`` 时。

    当从某层循环开始，对内存块的访问不再与更内层的循环有关，那么后续的scope可以省略。

    Temporal scope的定义与论文 `Scope-aware Data Cache Analysis for WCET Estimation` 一致。
    """

    def __init__(self, tag: int, set_index: int, scope: Sequence[Tuple[int, int]]) -> None:
        """
        初始化 ``MemoryBlockWithScope`` 实例。

        Args:
            tag: 内存块在Cache中对应集合中的索引。
            set_index: 内存块在Cache中所在的集合下标。
            scope: 内存访问的temporal scope。

        """
        super(MemoryBlockWithScope, self).__init__(tag=tag, set_index=set_index)
        self.__scope = tuple(scope)
        self.__hashed = (tag, set_index, self.__scope).__hash__()
        self.__dump = "<MemoryBlockWithScope, tag={}, set_index={}, scope={}>".format(
            hex(self.tag), self.set_index, self.__scope)

    @property
    def scope(self) -> ScopeTy:
        return self.__scope

    @property
    def ident(self) -> MemoryBlockWithScopeIdent:
        return self.tag, self.__scope

    def __hash__(self) -> int:
        """ 实例的哈希值与元组 ``(tag, set_index， scope)`` 的哈希值相同。 """
        return self.__hashed

    def __eq__(self, other) -> bool:
        """
        当 ``other`` 也是一个 ``MemoryBlockWithScope`` 实例，并且两者拥有相同的集合下标(``set_index``)、索引(``tag``)和
        temporal scope (``scope``)时。返回结果为 ``True``，否则返回结果为 ``False``。
        """
        if isinstance(other, MemoryBlockWithScope):
            return True if self.__hashed == other.__hashed else False
        return False

    def __str__(self) -> str:
        return self.__dump

    def __repr__(self) -> str:
        return self.__dump


def MemblockConvert(ori_mb: MemoryBlock, ori_cache_config: CacheConfig, tar_cache_config: CacheConfig):
    """ 默认cache line size相同 """
    cache_address = ori_mb.tag << ori_cache_config.set_bitlen | ori_mb.set_index

    return MemoryBlock(tag=cache_address >> tar_cache_config.set_bitlen,
                       set_index=cache_address & ((1 << tar_cache_config.set_bitlen) - 1),
                       cache_level=tar_cache_config.cache_level)


def memory_block_overlap(blck1: MemoryBlockWithScope, blck2: MemoryBlockWithScope, loop_level: int = -1) -> bool:
    """
    判断两个 ``MemoryBlockWithScope`` 类型的实例是否发生overlap。

    如果两个内存块拥有相同的块地址（即 ``block_addr``），那么认为他们不发生overlap，否则检查他们的temporal scope是否发生overlap。
    如果 ``loop_level`` 被指定（即不为 ``-1``），对overlap的判断最多进行到第 ``loop_level`` 层，否则对temporal scope
    的检查将进行到最内层。

    例如：

    >>> mem1 = MemoryBlockWithScope(0x10001, 1, scope=[(0, 2), (2, 3), (4, 5)])
    >>> mem2 = MemoryBlockWithScope(0x10001, 1, scope=[(1, 6), (2, 5), (8, 10)])
    >>> memory_block_overlap(mem1, mem2)
    False
    >>> memory_block_overlap(mem1, mem2, loop_level=2)
    True
    >>> memory_block_overlap(mem1, mem2, loop_level=3)
    False

    该方法的定义与论文 `Scope-aware Data Cache Analysis for WCET Estimation` 一致。

    Args:
        blck1: 待判断的内存块。
        blck2: 待判断的内存块。
        loop_level: 对temporal scope检查的最深循环等级。


    Returns: 如果他们发生overlap返回 ``True``，否则返回 ``False`` 。

    """
    if blck1.block_addr == blck2.block_addr:
        return False
    scope1, scope2 = blck1.scope, blck2.scope
    loop_level = max(len(scope1), len(scope2)) + 1 if loop_level == -1 else loop_level
    # 如果两个 scope 的长度不一致，那么我们就认为较短的内存块缺失的层始终与另一个内存块发生overlap。
    # 如果 len(scope1) != len(scope2)，那么 zip 将会首先截断较长的，再与较短的结合。
    for r1, r2 in zip(scope1[: loop_level], scope2[: loop_level]):
        if r2[0] <= r1[0] <= r2[1] or r2[0] <= r1[1] <= r2[1]:
            continue  # 当前这一层发生了overlap。继续检查下一个循环的scope。
        return False  # 只要有一层不发生overlap，那么最终两个内存块就不会发生overlap。
    return True  # 如果检查到最后一层仍然发生overlap，那么最终两个内存块就发生overlap。
