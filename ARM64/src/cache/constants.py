from enum import Enum, auto


class CacheAnalysisMethod(Enum):
    MUST = auto()
    MAY = auto()
    PERSISTENT = auto()
    SCOPE_AWARE = auto()


class CHMC(Enum):
    AH = auto()
    AM = auto()
    PS = auto()
    NC = auto()


class CAC(Enum):
    A = auto()
    N = auto()
    U = auto()


class RefType(Enum):
    INST = auto()
    DATA = auto()


class CacheHierarchy(Enum):
    L1I = auto()
    L1D = auto()
    L2 = auto()
    L3 = auto()
