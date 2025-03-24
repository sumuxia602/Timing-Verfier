import warnings
from enum import Enum, auto
from typing import Tuple, Optional


class InstType(Enum):
    SINGLE_CYCLE = auto()
    SINGLE_MULTI = auto()  # 16 * 16 Single Multiply / .M Unit Non-multiply.
    MULTI_EXT = auto()  # Multiply Extensions.
    BRANCH = auto()
    DP_CYCLE1 = auto()  # 1-Cycle DP.
    CYCLE3 = auto()
    CYCLE4 = auto()
    DP_CMP = auto()  # DP Compare
    LOAD = auto()
    STORE = auto()
    SP_LOOP = auto()
    FP_HEAD = auto()
    ADDDP_SUBDP = auto()
    INTDP = auto()
    MPYI = auto()
    MPYID = auto()
    MPYDP = auto()
    MPYSPDP = auto()
    MPYSP2DP = auto()

    """ Unhandled, unknown or skipped instructions. """
    EXC_UNHANDLED = auto()
    UNKNOWN = auto()


class SPInstType(Enum):
    SPLoopHead = auto()
    SPLoopTail = auto()
    SPCtrl = auto()
    SPUnhandled = auto()


class ISASPLoopType:

    _inst_ty = {
        SPInstType.SPLoopHead: {'SPLOOP', 'SPLOOPD', 'SPLOOPW'},
        SPInstType.SPLoopTail: {'SPKERNEL'},
        SPInstType.SPCtrl: {'SPMASK'},
        SPInstType.SPUnhandled: {'SPKERNELR', 'SPMASKR'}
    }

    @classmethod
    def sp_inst_matching(cls, name: str) -> Optional[SPInstType]:
        for i_ty, i_set in cls._inst_ty.items():
            if name in i_set:
                return i_ty
        return None


class ISAType:

    _Strict = False  # When True, if unknown or unhandled instructions found, raise an exception.

    _inst_ty = {
        InstType.SINGLE_CYCLE:
            {
                'ABS', 'ABS2', 'ABSSP', 'ADD', 'ADD2', 'ADD4', 'ADDAB', 'ADDAD', 'ADDAH', 'ADDAW', 'ADDK', 'ADDKPC', 'ADDSUB',
                'ADDSUB2', 'ADDU', 'AND', 'ANDN', 'CLR', 'CMPEQ', 'CMPEQ2', 'CMPEQ4', 'CMPEQSP', 'CMPGT', 'CMPGT2', 'CMPGTSP',
                'CMPGTU', 'CMPGTU4', 'CMPLT', 'CMPLT2', 'CMPLTSP', 'CMPLTU', 'CMPLTU4', 'CROT270', 'CROT90', 'DADD', 'DADD2', 'DAPYS2',
                'DCMPEQ2', 'DCMPEQ4', 'DCMPGT2', 'DCMPGTU4', 'DCROT270', 'DCROT90', 'DMAX2', 'DMAXU4', 'DMIN2', 'DMINU4', 'DMV',
                'DPACK2', 'DPACKH2', 'DPACKH4', 'DPACKHL2', 'DPACKL2', 'DPACKL4', 'DPACKLH2', 'DPACKLH4', 'DPACKX2', 'DSADD', 'DSADD2',
                'DSHL', 'DSHL2', 'DSHR', 'DSHR2', 'DSHRU', 'DSHRU2', 'DSPACKU4', 'DSSUB', 'DSSUB2', 'DSUB', 'DSUB2', 'EXT', 'EXTU',
                'LAND', 'LANDN', 'LMBD', 'LOR', 'MAX2', 'MAXU4', 'MIN2', 'MINU4', 'MV', 'MVC', 'MVK', 'MVKH', 'MVKL', 'MVKLH',
                'NEG', 'NOP', 'NORM', 'NOT', 'OR', 'PACK2', 'PACKH2', 'PACKH4', 'PACKHL2', 'PACKL4', 'PACKLH2', 'RCPSP', 'RPACK2',
                'RSQRSP', 'SADD', 'SADD2', 'SADDSU2', 'SADDSUB', 'SADDSUB2', 'SADDU4', 'SADDUS2', 'SAT', 'SET', 'SHFL3', 'SHL',
                'SHL2', 'SHLMB', 'SHR', 'SHR2', 'SHRMB', 'SHRU', 'SHRU2', 'SPACK2', 'SPACKU4', 'SSHL', 'SSUB', 'SSUB2', 'SUB',
                'SUB2', 'SUB4', 'SUBAB', 'SUBABS4', 'SUBAH', 'SUBAW', 'SUBC', 'SUBU', 'SWAP2', 'SWAP4', 'UNPKBU4', 'UNPKH2', 'UNPKHU2',
                'UNPKHU4', 'UNPKLU4', 'XOR', 'ZERO'
            },
        
        InstType.SINGLE_MULTI:
            {
                'AVG2', 'AVGU4', 'BITC4', 'BITR', 'DAVG2', 'DAVGNR2', 'DAVGNRU4', 'DAVGU4', 'DEAL', 'DXPND2', 'DXPND4', 'MPY',
                'MPYH', 'MPYHL', 'MPYHLU', 'MPYHSLU', 'MPYHSU', 'MPYHU', 'MPYHULS', 'MPYHUS', 'MPYLH', 'MPYLHU', 'MPYLSHU', 'MPYLUHS',
                'MPYSU', 'MPYU', 'MPYUS', 'ROTL', 'SHFL', 'SMPY', 'SMPYH', 'SMPYHL', 'SMPYLH', 'SSHVL', 'SSHVR', 'XPND2', 'XPND4'
            },
        
        InstType.MULTI_EXT:
            {
                'CCMATMPY', 'CCMATMPYR1', 'CCMPY32R1', 'CMATMPY', 'CMATMPYR1', 'CMPY', 'CMPY32R1', 'CMPYR', 'CMPYR1', 'CMPYSP',
                'DCCMPY', 'DCCMPYR1', 'DCMPY', 'DCMPYR1', 'DDOTP4', 'DDOTP4H', 'DDOTPH2', 'DDOTPH2R', 'DDOTPL2', 'DDOTPL2R', 'DDOTPSU4H',
                'DMPY2', 'DMPYSP', 'DMPYSU4', 'DMPYU2', 'DMPYU4', 'DOTP2', 'DOTP4H', 'DOTPN2', 'DOTPNRSU2', 'DOTPNRUS2', 'DOTPRSU2',
                'DOTPRUS2', 'DOTPSU4', 'DOTPSU4H', 'DOTPU4', 'DOTPUS4', 'DSMPY2', 'FMPYDP', 'GMPY', 'GMPY4', 'MPY2', 'MPY2IR',
                'MPY32', 'MPY32SU', 'MPY32U', 'MPY32US', 'MPYHI', 'MPYHIR', 'MPYIH', 'MPYIHR', 'MPYIL', 'MPYILR', 'MPYLI', 'MPYLIR',
                'MPYSU4', 'MPYU2', 'MPYU4', 'MPYUS4', 'QMPY32', 'QMPYSP', 'QSMPY32R1', 'SMPY2', 'SMPY32', 'XORMPY',
            },
        
        InstType.BRANCH: {"B", "BDEC", "BPOS", "CALLP", "BNOP"},
        InstType.DP_CYCLE1: {"SPDP", "RCPDP", "ABSDP", "RSQRDP"},
        InstType.CYCLE3: {"FADDSP", "FSUBDP", "FADDDP", "DSPINTH", "DSUBSP", "FSUBSP", "DINTSPU", "DINTHSPU", "DADDSP", "DSPINT", "DINTHSP"},
        InstType.CYCLE4: {"SUBSP", "SPINT", "INTSP", "ADDSP", "DPTRUNC", "DPSP", "SPTRUNC", "DPINT", "MPYSP", "MVD", "INTSPU", "DMVD"},
        InstType.DP_CMP: {"CMPEQDP", "CMPLTDP", "CMPGTDP"},
        InstType.LOAD: {"LDNW", "LDDW", "LDNDW", "LDW", "LDB", "LDBU", "LDH", "LDHU"},
        InstType.STORE: {"STH", "STB", "STW", "STNDW", "STDW", "STNW"},

        InstType.SP_LOOP: {'SPKERNEL', 'SPKERNELR', 'SPLOOP', 'SPLOOPD', 'SPLOOPW', 'SPMASK', 'SPMASKR'},
        InstType.FP_HEAD: {'.fphead'},

        InstType.ADDDP_SUBDP: {'ADDDP', 'SUBDP'},
        InstType.INTDP: {"INTDPU", "INTDP"},
        InstType.MPYI: {'MPYI'},
        InstType.MPYID: {'MPYID'},
        InstType.MPYDP: {'MPYDP'},
        InstType.MPYSPDP: {'MPYSPDP'},
        InstType.MPYSP2DP: {'MPYSP2DP'},

        InstType.EXC_UNHANDLED:
            {
                'SWE',  # Software exception.
                'SWENR',  # Software Exception — No return.
                'IDLE',  # Multicycle NOP With No Termination Until Interrupt.
                'MFENCE',  # Stall the instruction fetch pipeline until the memory system busy flag goes low.
                'DINT',  # Disable interrupts and save previous enable state.
                'RINT'  # Restore previous enable state.
            },
        
    }

    _inst_cycle = {
        InstType.SINGLE_CYCLE: 1, InstType.SINGLE_MULTI: 2, InstType.MULTI_EXT: 4, InstType.BRANCH: 1,
        InstType.DP_CYCLE1: 2, InstType.CYCLE3: 3, InstType.CYCLE4: 4, InstType.DP_CMP: 2,
        InstType.LOAD: 5, InstType.STORE: 3,
        InstType.ADDDP_SUBDP: 7, InstType.INTDP: 5, InstType.MPYI: 9, InstType.MPYID: 10,
        InstType.MPYDP: 10, InstType.MPYSPDP: 7, InstType.MPYSP2DP: 5,

        # Instructions without execution.
        InstType.EXC_UNHANDLED: 0, InstType.SP_LOOP: 0, InstType.FP_HEAD: 0
    }

    _inst_delay_slot = {
        InstType.SINGLE_CYCLE: 0, InstType.SINGLE_MULTI: 1, InstType.MULTI_EXT: 3, InstType.BRANCH: 5,
        InstType.DP_CYCLE1: 1, InstType.CYCLE3: 2, InstType.CYCLE4: 3, InstType.DP_CMP: 1,
        InstType.LOAD: 4, InstType.STORE: 0,
        InstType.ADDDP_SUBDP: 6, InstType.INTDP: 4, InstType.MPYI: 8, InstType.MPYID: 9,
        InstType.MPYDP: 9, InstType.MPYSPDP: 6, InstType.MPYSP2DP: 4,

        # Instructions without execution.
        InstType.EXC_UNHANDLED: 0, InstType.SP_LOOP: 0, InstType.FP_HEAD: 0
    }

    _inst_unit_latency = {
        InstType.SINGLE_CYCLE: 1, InstType.SINGLE_MULTI: 1, InstType.MULTI_EXT: 1, InstType.BRANCH: 1,
        InstType.DP_CYCLE1: 1, InstType.CYCLE3: 1, InstType.CYCLE4: 1, InstType.DP_CMP: 1,
        InstType.LOAD: 1, InstType.STORE: 1,
        InstType.ADDDP_SUBDP: 2, InstType.INTDP: 1, InstType.MPYI: 4, InstType.MPYID: 4,
        InstType.MPYDP: 4, InstType.MPYSPDP: 3, InstType.MPYSP2DP: 2,

        # Instructions without execution.
        InstType.EXC_UNHANDLED: 0, InstType.SP_LOOP: 0, InstType.FP_HEAD: 0
    }

    @classmethod
    def inst_matching(cls, name: str) -> Tuple[InstType, int, int, int]:

        for i_ty, i_set in cls._inst_ty.items():
            if name in i_set:
                ty = i_ty
                if ty == InstType.EXC_UNHANDLED:
                    if cls._Strict:
                        raise RuntimeError("Unhandled instruction {}.".format(name))
                    else:
                        warnings.warn("Unhandled instruction {}.".format(name))
                break
        else:
            if cls._Strict:
                raise RuntimeError("Unknown type for instruction {}.".format(name))
            else:
                warnings.warn("Unknown instruction {}.".format(name))
                return InstType.UNKNOWN, 10, 0, 0
        return ty, cls._inst_cycle[ty], cls._inst_delay_slot[ty], cls._inst_unit_latency[ty]
