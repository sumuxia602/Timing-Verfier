from enum import Enum, auto
from typing import Union


class InstType(Enum):
    """ Type of instructions follows Table 5-2 in TMS320C66x DSP CPU and Instruction Set. """

    """ Basic types. """
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
    FPHEAD = auto()

    """ Certain instructions are considered as a separate type. """
    ADDDP_SUBDP = auto()
    INSTDP = auto()
    MPYI = auto()
    MPYID = auto()
    MPYDP = auto()
    MPYSPDP = auto()
    MPYSP2DP = auto()

    """ Unknown or unhandled instructions. """
    UNKNOWN = auto()
    UNHANDLED = auto()


class InstLookUpTable:
    """ Type and execution cycle of instructions follow Table 5-2 in TMS320C66x DSP CPU and Instruction Set. """

    SPLoopHead = {'SPLOOP', 'SPLOOPD', 'SPLOOPW'}
    SPLoopTail = {'SPKERNEL'}
    SPCtrl = {'SPMASK'}
    SPUnhandled = {'SPKERNELR', 'SPMASKR'}

    inst = {
        InstType.SINGLE_CYCLE:
            {
                "NOP",
                "ADDSUB",
                "EXT",
                "SADDU4",
                "ADDSUB2",
                "DSADD2",
                "SHRU",
                "SUBAB",
                "CMPEQ",
                "DMAX2",
                "ADD4",
                "CROT270",
                "CMPGTSP",
                "SADDSU2",
                "SADD2",
                "CMPGTU4",
                "ADDAW",
                "DPACKLH4",
                "ADDKPC",
                "CMPGTU",
                "CMPEQ2",
                "SUBAH",
                "DCMPGT2",
                "SHR",
                "DADD",
                "ADDAH",
                "MVKH",
                "MVKLH",
                "ADD2",
                "SUBU",
                "CMPEQ4",
                "DSHR",
                "SHR2",
                "DCROT90",
                "SHLMB",
                "SPACK2",
                "SUBAW",
                "PACKL4",
                "ANDN",
                "ZERO",
                "DCMPEQ4",
                "CMPGT",
                "SUB",
                "DSADD",
                "DSHRU2",
                "ADDU",
                "PACK2",
                "CMPLTU",
                "DSHRU",
                "DCMPEQ2",
                "RCPSP",
                "NEG",
                "ADD",
                "DMV",
                "LMBD",
                "DAPYS2",
                "MINU4",
                "DSHL",
                "SADD",
                "DCMPGTU4",
                "ADDK",
                "ADDAB",
                "SWAP4",
                "SSUB2",
                "NOT",
                "SAT",
                "CMPGT2",
                "MAXU4",
                "DMAXU4",
                "CMPLT2",
                "SADDUS2",
                "SHRU2",
                "RSQRSP",
                "SADDSUB",
                "CMPLTSP",
                "SUBC",
                "CROT90",
                "SADDSUB2",
                "ABS2",
                "SUBABS4",
                "SPACKU4",
                "DSHR2",
                "DCROT270",
                "CLR",
                "DMINU4",
                "CMPLTU4",
                "MIN2",
                "CMPEQSP",
                "SHRMB",
                "DPACKL4",
                "PACKH4",
                "MAX2",
                "SWAP2",
                "PACKLH2",
                "CMPLT",
                "SHFL3",
                "MVC",
                "PACKH2",
                "EXTU",
                "AND",
                "DPACKH4",
                "ADDAD",
                "NORM",
                "RPACK2",
                "SSHL",
                "DSHL2",
                "ABSSP",
                "DPACKHL2",
                "DPACK2",
                "PACKHL2",
                "SSUB",
                "MV",
                "ABS",
                "SUB4",
                "DMIN2",
                "DADD2",
                "DPACKLH2",
                "DPACKL2",
                "SUB2",
                "DPACKX2",
                "SET",
                "DPACKH2",
                "SHL",
                "OR",
                "DSSUB2",
                "UNPKHU4",
                "DSUB2",
                "MVK",
                "XOR",
                "UNPKLU4",
                "MVKL",
                "DSUB",
                "SHL2",
                "UNPKHU2",
                "LAND",
                "DSSUB",
                "DSPACKU4",
                "UNPKBU4",
                "LANDN",
                "LOR",
                "UNPKH2"
            },
        
        InstType.SINGLE_MULTI:
            {
                "SMPYHL",
                "SMPYH",
                "SMPY",
                "SMPYLH",
                "MPYHL",
                "MPYHULS",
                "MPY",
                "MPYHSLU",
                "MPYLHU",
                "MPYLSHU",
                "MPYHUS",
                "MPYHLU",
                "MPYH",
                "MPYU",
                "MPYUS",
                "MPYHU",
                "MPYLH",
                "MPYLUHS",
                "MPYHSU",
                "MPYSU",
                "SSHVL",
                "AVG2",
                "BITC4",
                "XPND2",
                "BITR",
                "ROTL",
                "SHFL",
                "XPND4",
                "AVGU4",
                "DEAL",
                "SSHVR",
                "DXPND2",
                "DAVGU4",
                "DAVG2",
                "DXPND4",
                "DAVGNRU4",
                "DAVGNR2"
            },
        
        InstType.MULTI_EXT:
            {
                "QMPYSP",
                "DMPYU4",
                "DMPY2",
                "DCMPYR1",
                "CCMPY32R1",
                "QSMPY32R1",
                "DSMPY2",
                "CCMATMPYR1",
                "CMATMPY",
                "CMPYSP",
                "DCMPY",
                "CMPY32R1",
                "QMPY32",
                "FMPYDP",
                "DCCMPY",
                "DMPYU2",
                "CCMATMPY",
                "DMPYSP",
                "DMPYSU4",
                "CMATMPYR1",
                "DCCMPYR1",
                "SMPY2",
                "GMPY4",
                "MPYILR",
                "MPY32SU",
                "CMPYR",
                "MPY32",
                "MPY32US",
                "MPYLI",
                "MPYHI",
                "CMPY",
                "SMPY32",
                "MPYUS4",
                "XORMPY",
                "MPYLIR",
                "MPYSU4",
                "GMPY",
                "MPYIL",
                "CMPYR1",
                "MPYHIR",
                "MPY2IR",
                "MPYIHR",
                "MPYU4",
                "MPY32U",
                "MPY2",
                "MPYIH",
                "MPYU2",
                "DDOTPSU4H",
                "DOTP4H",
                "DDOTP4H",
                "DOTPSU4H",
                "DDOTPL2R",
                "DOTPU4",
                "DOTPNRUS2",
                "DDOTPH2",
                "DDOTP4",
                "DOTPNRSU2",
                "DDOTPH2R",
                "DOTPN2",
                "DOTPRUS2",
                "DOTPUS4",
                "DOTP2",
                "DOTPRSU2",
                "DDOTPL2",
                "DOTPSU4"
            },
        
        InstType.BRANCH: {"B", "BDEC", "BPOS", "CALLP", "BNOP"},
        InstType.DP_CYCLE1: {"SPDP", "RCPDP", "ABSDP", "RSQRDP"},
        InstType.CYCLE3: {"FADDSP", "FSUBDP", "FADDDP", "DSPINTH", "DSUBSP", "FSUBSP", "DINTSPU", "DINTHSPU", "DADDSP", "DSPINT", "DINTHSP"},
        InstType.CYCLE4: {"SUBSP", "SPINT", "INTSP", "ADDSP", "DPTRUNC", "DPSP", "SPTRUNC", "DPINT", "MPYSP", "MVD", "INTSPU", "DMVD"},
        InstType.DP_CMP: {"CMPEQDP", "CMPLTDP", "CMPGTDP"},
        InstType.LOAD: {"LDNW", "LDDW", "LDNDW", "LDW", "LDB", "LDBU", "LDH", "LDHU"},
        InstType.STORE: {"STH", "STB", "STW", "STNDW", "STDW", "STNW"},

        InstType.SP_LOOP: {'SPKERNEL', 'SPKERNELR', 'SPLOOP', 'SPLOOPD', 'SPLOOPW', 'SPMASK', 'SPMASKR'},
        InstType.FPHEAD: {'.fphead'},

        InstType.ADDDP_SUBDP: {'ADDDP', 'SUBDP'},
        InstType.INSTDP: {"INTDPU", "INTDP"},
        InstType.MPYI: {'MPYI'},
        InstType.MPYID: {'MPYID'},
        InstType.MPYDP: {'MPYDP'},
        InstType.MPYSPDP: {'MPYSPDP'},
        InstType.MPYSP2DP: {'MPYSP2DP'},

        InstType.UNHANDLED: {
            # 'MFENCE',  # Stall the instruction fetch pipeline until the memory system busy flag goes low.
            'SWE',  # Software exception.
            'SWENR',  # Software Exception — No return.
            'IDLE'  # Multicycle NOP With No Termination Until Interrupt
        }
    }

    cycle = {
        InstType.SINGLE_CYCLE: 1, InstType.SINGLE_MULTI: 2, InstType.MULTI_EXT: 4, InstType.BRANCH: 1,
        InstType.DP_CYCLE1: 2, InstType.CYCLE3: 3, InstType.CYCLE4: 4, InstType.DP_CMP: 2,
        InstType.LOAD: 5, InstType.STORE: 3,

        InstType.ADDDP_SUBDP: 7, InstType.INSTDP: 5, InstType.MPYI: 9, InstType.MPYID: 10,
        InstType.MPYDP: 10, InstType.MPYSPDP: 7, InstType.MPYSP2DP: 5,

        InstType.UNHANDLED: 0,
        InstType.SP_LOOP: 0,
        InstType.FPHEAD: 0
    }


class PipelineStage(Enum):
    """ """
    Fetch = auto()
    Decode = auto()
    Execute = auto()

    """ Details in Fetch. """
    PG = auto()
    PS = auto()
    PW = auto()
    PR = auto()

    """ Details in Decode. """
    DP = auto()
    DC = auto()

    def __str__(self):
        return self.name


def pipeline_stage_translation(s: PipelineStage, details: Union[PipelineStage, int]) -> str:
    if not isinstance(s, PipelineStage):
        raise TypeError("Unexpected stage type: {}".format(type(s)))
    if not (isinstance(details, PipelineStage) or isinstance(details, int)):
        raise TypeError("Unexpected detail type: {}".format(type(details)))

    return "{}-{}".format(str(s), str(details))


if __name__ == '__main__':
    all_inst = set()
    inst_char = set()
    inst_len = set()
    for _, inst_set in InstLookUpTable.inst.items():
        for inst in inst_set:
            chlst = list(inst)
            inst_char.update(chlst)
            inst_len.update([len(inst)])
    print("".join(sorted(inst_char)))
    print(inst_len)
