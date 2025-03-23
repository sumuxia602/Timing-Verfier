import json
from math import log2
from typing import Optional, Tuple


class CacheConfig:
    DEFAULT_PENALTY = 1000  # 当没有对实例指定penalty时，默认的发生cache miss时流水阻塞的周期数。

    def __init__(self, set_bitlen: Optional[int] = None, set_number: Optional[int] = None,
                 line_bitlen: Optional[int] = None, line_size: Optional[int] = None,
                 associativity: Optional[int] = None, capacity_size: Optional[int] = None,
                 penalty: int = DEFAULT_PENALTY):
        """
        Cache Config，一个 ``CacheConfig`` 实例可以唯一确定一个LRU Cache的参数，包括Cache的大小、组相连度等等。

        Args:
            set_bitlen: Cache的集合的个数对应的二进制比特长度。
            set_number: Cache的集合的个数。
            line_bitlen: Cache的行（块）大小对应的二进制比特长度。
            line_size: Cache的行（块）大小（单位为Byte）。
            associativity: Cache的组相联度。
            capacity_size: Cache的容量（单位为Byte）。
            penalty: 当发生Cache Miss时，流水阻塞的周期数。
        """

        self.__penalty = penalty

        """ 当set_number和set_bitlen指定一个时，集合大小以及其对应的比特长度确定 """
        self.__set_number = set_number if set_number is not None else int(2 ** set_bitlen) \
            if set_bitlen is not None else None
        self.__set_bitlen = set_bitlen if set_bitlen is not None else int(log2(set_number)) \
            if set_number is not None else None
        """ 当line_size和line_bitlen指定一个时，块大小以及其所对应的比特长度确定 """
        self.__line_size = line_size if line_size is not None else int(2 ** line_bitlen) \
            if line_bitlen is not None else None
        self.__line_bitlen = line_bitlen if line_bitlen is not None else int(log2(line_size)) \
            if line_size is not None else None
        self.__associativity = associativity if associativity is not None else None
        self.__capacity_size = capacity_size if capacity_size is not None else None

        """
        capacity_size = set_number * line_size * associativity
        当其中任意三个给定时，剩余的一个也可以计算出来。否则，抛出 ValueError 异常，表示没有足够的参数用来初始化。
        """
        vacant = sum(
            [self.__set_number is None, self.__line_size is None, self.__associativity is None,
             self.__capacity_size is None]
        )
        if vacant == 1:
            if self.__set_number is None:
                self.__set_number = self.__capacity_size // self.__line_size // self.__associativity
                self.__set_bitlen = int(log2(self.__set_number))
            elif self.__line_size is None:
                self.__line_size = self.__capacity_size // self.__set_number // self.__associativity
                self.__line_bitlen = int(log2(self.__line_size))
            elif self.__associativity is None:
                self.__associativity = self.__capacity_size // self.__set_number // self.__line_size
            else:
                self.__capacity_size = self.__set_number * self.__line_size * self.__associativity
        elif vacant >= 2:
            raise ValueError("No enough arguments for initialization.")

        """ 判断 set_number == 2 ^ set_bitlen, line_size == 2 ^ line_bitlen 是否成立 """
        if self.__set_number != int(2 ** self.__set_bitlen):
            raise ValueError("Initialization for set_number or set_bitlen failed.")
        if self.__line_size != int(2 ** self.__line_bitlen):
            raise ValueError("Initialization for line_size or line_bitlen failed.")

        """ 判断 capacity_size = set_number * line_size * associativity 是否成立  """
        if self.__capacity_size != self.__associativity * self.__set_number * self.__line_size:
            raise ValueError("Initialization for __cache config failed.")

        self.__ident = (self.__line_bitlen, self.__set_bitlen, self.__associativity, self.__penalty).__hash__()

    @property
    def ident(self) -> int:
        """
        如果两个 ``CacheConfig`` 实例拥有相同的 ``ident`` ，那么说明他们拥有完全相同的 Cache 参数，包括组相连度、大小、块大小等。
        """
        return self.__ident

    @property
    def set_number(self) -> int:
        return self.__set_number

    @property
    def set_bitlen(self) -> int:
        return self.__set_bitlen

    @property
    def line_size(self) -> int:
        return self.__line_size

    @property
    def line_bitlen(self) -> int:
        return self.__line_bitlen

    @property
    def associativity(self) -> int:
        return self.__associativity

    @property
    def capacity(self) -> int:
        return self.__capacity_size

    @property
    def penalty(self) -> int:
        return self.__penalty

    def dump(self):
        return "<L1Cache, Cap={}, Assoc={}, LnSz={}, Pln={}>".format(self.__capacity_size, self.__associativity, self.__line_size, self.__penalty)


def read_cache_config_from_json(f: str) -> Tuple[CacheConfig, CacheConfig]:
    """ """

    with open(f, 'r') as fstream:
        cache_config_dict = json.load(fstream)

    inst_cap = cache_config_dict['L1P']['capacity_size']
    inst_assoc = cache_config_dict['L1P']['associativity']
    inst_lnsz = cache_config_dict['L1P']['line_size']
    inst_pnlt = cache_config_dict['L1P']['penalty']
    inst_cache_config = CacheConfig(capacity_size=inst_cap, associativity=inst_assoc, line_size=inst_lnsz, penalty=inst_pnlt)

    data_cap = cache_config_dict['L1D']['capacity_size']
    data_assoc = cache_config_dict['L1D']['associativity']
    data_lnsz = cache_config_dict['L1D']['line_size']
    data_pnlt = cache_config_dict['L1D']['penalty']
    data_cache_config = CacheConfig(capacity_size=data_cap, associativity=data_assoc, line_size=data_lnsz, penalty=data_pnlt)

    return inst_cache_config, data_cache_config
