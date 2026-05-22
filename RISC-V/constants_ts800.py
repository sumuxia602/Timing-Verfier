from enum import Enum, auto


class InstType(Enum):
    """ riscv G64 指令集类型 """

    # Basic types.
    INTEGER = auto()
    JUMP = auto()
    BRANCH = auto()
    MEMORY = auto()
    MULTIPLY = auto()
    DIVISION = auto()
    SINGLE_FLOAT = auto()
    DOUBLE_FLOAT = auto()
    ATOMIC = auto()
    VECTOR = auto()

    # Unknown or unhandled instructions.
    UNKNOWN = auto()
    UNHANDLED = auto()


class InstLookUpTable:
    """ riscv 指令名称与执行周期查表

    ts800：先不把 LSU 和算术指令分开，统一放进 I 流水线考虑；
    手册中 E2/E3 为辅助执行级，多周期指令在这两级运算，单周期指令只做数据传递，
    因此每条指令在执行段的占用最多 4 个周期。
    """

    inst = {
        InstType.INTEGER: {
            "LUI", "AUIPC",
            "ADDI", "SLTI", "SLTIU", "XORI", "ORI", "ANDI",
            "SLLI", "SRLI", "SRAI",
            "ADD", "SUB", "SLL", "SLT", "SLTU",
            "XOR", "SRL", "SRA", "OR", "AND",
            "FENCE", "ECALL", "EBREAK",
            "LWU",
            "ADDIW", "SLLIW", "SRLIW", "SRAIW",
            "ADDW", "SUBW", "SLLW", "SRLW", "SRAW",
        },
        InstType.JUMP: {
            "JAL", "JALR",
        },
        InstType.BRANCH: {
            "BEQ", "BNE", "BLT", "BGE", "BLTU", "BGEU",
        },
        InstType.MEMORY: {
            "LB", "LH", "LW", "LD",
            "LBU", "LHU",
            "SB", "SH", "SW", "SD",
            "FLW", "FSW", "FLD", "FSD",
        },
        InstType.MULTIPLY: {
            "MUL", "MULH", "MULHSU", "MULHU", "MULW",
        },
        InstType.DIVISION: {
            "DIV", "DIVU", "REM", "REMU",
            "DIVW", "DIVUW", "REMW", "REMUW",
        },
        InstType.SINGLE_FLOAT: {
            "FMADD.S", "FMSUB.S", "FNMSUB.S", "FNMADD.S",
            "FADD.S", "FSUB.S", "FMUL.S", "FDIV.S", "FSQRT.S",
            "FSGNJ.S", "FSGNJN.S", "FSGNJX.S",
            "FMIN.S", "FMAX.S",
            "FCVT.W.S", "FCVT.WU.S", "FMV.X.W",
            "FEQ.S", "FLT.S", "FLE.S", "FCLASS.S",
            "FCVT.S.W", "FCVT.S.WU", "FMV.W.X",
            "FCVT.L.S", "FCVT.LU.S", "FCVT.S.L", "FCVT.S.LU",
        },
        InstType.DOUBLE_FLOAT: {
            "FMADD.D", "FMSUB.D", "FNMSUB.D", "FNMADD.D",
            "FADD.D", "FSUB.D", "FMUL.D", "FDIV.D", "FSQRT.D",
            "FSGNJ.D", "FSGNJN.D", "FSGNJX.D",
            "FMIN.D", "FMAX.D",
            "FCVT.S.D", "FCVT.D.S",
            "FEQ.D", "FLT.D", "FLE.D", "FCLASS.D",
            "FCVT.W.D", "FCVT.WU.D", "FCVT.D.W", "FCVT.D.WU",
            "FCVT.L.D", "FCVT.LU.D", "FMV.X.D",
            "FCVT.D.L", "FCVT.D.LU", "FMV.D.X",
        },
        InstType.ATOMIC: {
            "LR.W", "SC.W",
            "AMOSWAP.W", "AMOADD.W", "AMOXOR.W", "AMOAND.W", "AMOOR.W",
            "AMOMIN.W", "AMOMAX.W", "AMOMINU.W", "AMOMAXU.W",
            "LR.D", "SC.D",
            "AMOSWAP.D", "AMOADD.D", "AMOXOR.D", "AMOAND.D", "AMOOR.D",
            "AMOMIN.D", "AMOMAX.D", "AMOMINU.D", "AMOMAXU.D",
        },
        # Vector 指令集：ts800 上的具体表暂留接口，待补
        InstType.VECTOR: set(),
        InstType.UNHANDLED: {
            'SWE',    # Software exception.
            'SWENR',  # Software exception — no return.
            'IDLE',   # Multicycle NOP with no termination until interrupt.
        },
    }

    cycle = {
        InstType.INTEGER: 1,
        InstType.JUMP: 1,
        InstType.BRANCH: 2,
        InstType.MEMORY: 2,
        InstType.MULTIPLY: 2,
        InstType.DIVISION: 3,
        InstType.SINGLE_FLOAT: 4,
        InstType.DOUBLE_FLOAT: 4,
        InstType.ATOMIC: 4,
        InstType.VECTOR: 4,
        InstType.UNKNOWN: 10,
        InstType.UNHANDLED: 0,
    }

    # ts800 暂不模拟 SPLOOP（VLIW 软件流水）相关，保留接口
    SPUnhandled: set = set()
