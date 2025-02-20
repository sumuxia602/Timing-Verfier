import re
from enum import auto, Enum
from typing import Tuple, Optional, Union


class OperandTyEnum(Enum):
    Register = auto()
    CtrlRegister = auto()
    RegisterPair = auto()
    RegisterQuadruplet = auto()
    FunctionalUnit = auto()
    BranchTarget = auto()
    Immediate = auto()
    IndirectAddressing = auto()
    FPHeadCtrl = auto()
    Unknown = auto()


class OperandObject:
    def __init__(self, ty: OperandTyEnum, tokens: tuple):
        self._ty = ty
        self._tokens = tokens

    def __hash__(self):
        return self._ty, self._tokens

    def __eq__(self, other):
        if not isinstance(other, OperandObject):
            return False
        return other.__hash__() == self.__hash__()

    def __str__(self):
        return "<{} {}>".format(self._ty.name, self._tokens)

    def __repr__(self):
        return "<Operand: {} {} {}>".format(id(self), self._ty.name, self._tokens)

    @property
    def ty(self):
        return self._ty

    @property
    def tokens(self):
        return self._tokens


class RegOperand(OperandObject):
    def __init__(self, ty: OperandTyEnum, tokens: tuple):
        super(RegOperand, self).__init__(ty, tokens)
        self.__reg = self._tokens[0]

    def __hash__(self):
        return self.__reg

    def __eq__(self, other):
        if not isinstance(other, RegOperand):
            return False
        return other.__hash__() == self.__hash__()

    def __str__(self):
        return "<Reg {}>".format(self.__reg)

    @property
    def reg(self) -> str:
        return self.__reg


class RegPairOperand(OperandObject):
    def __init__(self, ty: OperandTyEnum, tokens: tuple):
        super(RegPairOperand, self).__init__(ty, tokens)
        self.__reg_h, self.__reg_l = self._tokens[0], self._tokens[1]

    def __str__(self):
        return "<RegPair {}:{}>".format(self.__reg_h, self.__reg_l)

    def __hash__(self):
        return self.__reg_h, self.__reg_l

    def __eq__(self, other):
        if not isinstance(other, RegPairOperand):
            return False
        return other.__hash__() == self.__hash__()

    @property
    def reg_h(self) -> str:
        return self.__reg_h

    @property
    def reg_l(self) -> str:
        return self.__reg_l

    @property
    def reg_pair(self) -> Tuple[str, str]:
        return self.__reg_h, self.__reg_l


class RegQuadrupletOperand(OperandObject):
    def __init__(self, ty: OperandTyEnum, tokens: tuple):
        super(RegQuadrupletOperand, self).__init__(ty, tokens)
        self.__reg3, self.__reg2, self.__reg1, self.__reg0 = tokens

    def __str__(self):
        return "<RegQuadruplet {}:{}:{}:{}>".format(self.__reg3, self.__reg2, self.__reg1, self.__reg0)

    def __hash__(self):
        return self.__reg3, self.__reg2, self.__reg1, self.__reg0

    def __eq__(self, other):
        if not isinstance(other, RegQuadrupletOperand):
            return False
        return other.__hash__() == self.__hash__()

    @property
    def reg3(self):
        return self.__reg3

    @property
    def reg2(self):
        return self.__reg2

    @property
    def reg1(self):
        return self.__reg1

    @property
    def reg0(self):
        return self.__reg0

    @property
    def reg_quadruplet(self):
        return self.__reg3, self.__reg2, self.__reg1, self.__reg0


class FuncUnitOperand(OperandObject):
    def __init__(self, ty: OperandTyEnum, tokens: tuple):
        super(FuncUnitOperand, self).__init__(ty, tokens)
        self.__func_unit = self._tokens[0]

    def __hash__(self):
        return self.__func_unit

    def __eq__(self, other):
        if not isinstance(other, FuncUnitOperand):
            return False
        return other.__hash__() == self.__hash__()

    def __str__(self):
        return "<FuncUnit {}>".format(self.__func_unit)

    @property
    def func_unit(self) -> str:
        return self.__func_unit


class BTargetOperand(OperandObject):
    def __init__(self, ty: OperandTyEnum, tokens: tuple):
        super(BTargetOperand, self).__init__(ty, tokens)
        self.__sym = self._tokens[0]
        self.__pc_offset = int(self._tokens[1])
        self.__addr_hex = self._tokens[2]
        self.__addr = int(self._tokens[2], 16)

    def __hash__(self):
        return self.__sym, self.__pc_offset, self.__addr

    def __eq__(self, other):
        if not isinstance(other, BTargetOperand):
            return False
        return other.__hash__() == self.__hash__()

    def __str__(self):
        return "<Target {} PC{:+}=0x{}>".format(self.__sym, self.__pc_offset, self.__addr_hex)

    @property
    def b_sym(self) -> str:
        return self.__sym

    @property
    def b_pc_offset(self) -> int:
        return self.__pc_offset

    @property
    def b_addr_hex(self) -> str:
        return self.__addr_hex

    @property
    def b_addr(self) -> int:
        return self.__addr


class ImmOperand(OperandObject):
    def __init__(self, ty: OperandTyEnum, tokens: tuple):
        super(ImmOperand, self).__init__(ty, tokens)
        imm_hex, imm_dec, imm_bin = tokens
        self.__imm = int(imm_hex, 16) if imm_hex is not None else int(imm_dec) if imm_dec is not None else int(imm_bin, 2)

    def __hash__(self):
        return self.__imm

    def __eq__(self, other):
        if not isinstance(other, ImmOperand):
            return False
        return other.__hash__() == self.__hash__()

    def __str__(self):
        return "<Imm {}>".format(self.__imm)

    @property
    def imm(self):
        return self.__imm


class IndAddrOperand(OperandObject):
    def __init__(self, ty: OperandTyEnum, tokens: tuple):
        super(IndAddrOperand, self).__init__(ty, tokens)
        self.__ind_pre, self.__ind_post = self._tokens[0], self._tokens[2]
        self.__base_reg = self._tokens[1]
        
        if self._tokens[4] is not None:
            try:
                offset = int(self._tokens[4], 10)
            except ValueError:
                self.__is_offset_reg, self.__offset = True, self._tokens[4]
            else:
                self.__is_offset_reg, self.__offset = False, offset
            self.__is_offset_extend = True if self._tokens[3] in  ('[','(') else False
            self.__is_scaled_offsets = False if self._tokens[3] == '(' else True
            
        else:
            self.__is_offset_reg = None
            self.__is_offset_extend = None
            self.__offset = None

    def __hash__(self):
        return self.__ind_pre, self.__base_reg, self.__ind_post, self.__offset, self.__is_offset_extend

    def __eq__(self, other):
        if not isinstance(other, IndAddrOperand):
            return False
        return other.__hash__() == self.__hash__()

    def __str__(self):
        if self.__offset is None:
            return "<IndAddr {}{}{}>".format(
                self.__ind_pre if self.__ind_pre is not None else "", self.__base_reg, self.__ind_post if self.__ind_post is not None else "", )
        else:
            return "<IndAddr {}{}{} off:{} ext:{}>".format(
                self.__ind_pre if self.__ind_pre is not None else "", self.__base_reg, self.__ind_post if self.__ind_post is not None else "",
                self.__offset, self.__is_offset_extend
            )

    @property
    def inda_pre(self) -> Optional[str]:
        return self.__ind_pre

    @property
    def inda_post(self) -> Optional[str]:
        return self.__ind_post

    @property
    def inda_base_reg(self) -> str:
        return self.__base_reg

    @property
    def inda_is_offset(self) -> bool:
        return self.__offset is not None

    @property
    def inda_is_offset_reg(self) -> Optional[bool]:
        return self.__is_offset_reg

    @property
    def inda_is_offset_imm(self) -> Optional[bool]:
        return not self.__is_offset_reg

    @property
    def inda_is_extend(self) -> Optional[bool]:
        return self.__is_offset_extend
    
    @property
    def inda_is_scaled_offsets(self) -> Optional[bool]:
        return self.__is_scaled_offsets

    @property
    def inda_offset(self) -> Optional[Union[int, str]]:
        return self.__offset


OperandHint = Union[RegOperand, RegPairOperand, RegQuadrupletOperand, FuncUnitOperand, BTargetOperand, ImmOperand, IndAddrOperand]


class OperandAutomation:
    function_unit_pat = r"^([LSMD]{1}[12]{1})$"
    register_pat = r"^[\s]*([AB]{1}(?:(?:[0-9]{1})|(?:[12]{1}[0-9]{1})|(?:3[01]{1})))[\s]*$"
    ctrl_register_pat = r"^[\s]*((?:AMR)|(?:CSR)|(?:GFPGFR)|(?:I[CEFS]R)|(?:IRP)|(?:ISTP)|(?:NRP)|(?:PCE1)|(?:DNUM)|(?:E[CF]R)|" \
                        r"(?:GPLY[AB])|(?:IERR)|(?:ILC)|(?:[IN]TSR)|(?:REP)|(?:RILC)|(?:SSR)|(?:TSC[HL])|(?:TSR)|(?:F(?:(?:AD)|(?:AU)|M)CR))[\s]*$"
    register_pair_pat = r"^[\s]*([AB]{1}(?:(?:[0-9]{1})|(?:[12]{1}[0-9]{1})|(?:3[01]{1})))\:" \
                        r"([AB]{1}(?:(?:[0-9]{1})|(?:[12]{1}[0-9]{1})|(?:3[01]{1})))[\s]*$"
    register_quadruplet_pat = r"^[\s]*([AB]{1}(?:(?:[0-9]{1})|(?:[12]{1}[0-9]{1})|(?:3[01]{1})))\:" \
                              r"([AB]{1}(?:(?:[0-9]{1})|(?:[12]{1}[0-9]{1})|(?:3[01]{1})))\:" \
                              r"([AB]{1}(?:(?:[0-9]{1})|(?:[12]{1}[0-9]{1})|(?:3[01]{1})))\:" \
                              r"([AB]{1}(?:(?:[0-9]{1})|(?:[12]{1}[0-9]{1})|(?:3[01]{1})))[\s]*$"
    branch_target_pat = r"^([^\s]+)[\s]+\(PC([\+\-]{1}[0-9]+)[\s]+\=[\s]+(0x[0-9a-f]+)\)$"
    immediate_pat = r"(?:^0x([0-9a-f]+)(?!b)$)|(?:^(?!0x)(-?[0-9]+)(?!b)$)|(?:^(?!0x)([01]+)b$)"
    indirect_addr_pat = r"^\*([+-]{1,2})?((?:[AB]{1}(?:(?:[0-9]{1})|(?:[12]{1}[0-9]{1})|(?:3[01]{1}))))([+-]{1,2})?" \
                        r"(?:([\[\(]{1})((?:(?:[AB]{1}(?:(?:[0-9]{1})|(?:[12]{1}[0-9]{1})|(?:3[01]{1}))))|(?:[0-9]+))[\]\)]{1})?$"

    register_cpat = re.compile(register_pat)
    register_pair_cpat = re.compile(register_pair_pat)
    register_quadruplet_cpat = re.compile(register_quadruplet_pat)
    ctrl_register_cpat = re.compile(ctrl_register_pat)
    function_unit_cpat = re.compile(function_unit_pat)
    branch_target_cpat = re.compile(branch_target_pat)
    immediate_cpat = re.compile(immediate_pat)
    indirect_addr_cpat = re.compile(indirect_addr_pat)

    @classmethod
    def get_operand(cls, op: str) -> Optional[OperandHint]:

        ty = {
            OperandTyEnum.Register: re.match(cls.register_cpat, op),
            OperandTyEnum.RegisterPair: re.match(cls.register_pair_cpat, op),
            OperandTyEnum.RegisterQuadruplet: re.match(cls.register_quadruplet_pat, op),
            OperandTyEnum.CtrlRegister: re.match(cls.ctrl_register_cpat, op),
            OperandTyEnum.FunctionalUnit: re.match(cls.function_unit_cpat, op),
            OperandTyEnum.BranchTarget: re.match(cls.branch_target_cpat, op),
            OperandTyEnum.Immediate: re.match(cls.immediate_cpat, op),
            OperandTyEnum.IndirectAddressing: re.match(cls.indirect_addr_cpat, op)
        }

        valid_ty = [(t, details) for t, details in ty.items() if details is not None]
        if len(valid_ty) > 1:
            raise RuntimeError("More than one possible valid operand matching.\n"
                               "Operand: {}\n"
                               "Possible matching: {}\n".format(op, [o[0] for o in valid_ty]))
        if len(valid_ty) == 0:
            return None

        t, details = valid_ty[0]
        details = details.groups()
        if t == OperandTyEnum.Register or t == OperandTyEnum.CtrlRegister:
            return RegOperand(t, details)
        elif t == OperandTyEnum.RegisterPair:
            return RegPairOperand(t, details)
        elif t == OperandTyEnum.RegisterQuadruplet:
            return RegQuadrupletOperand(t, details)
        elif t == OperandTyEnum.FunctionalUnit:
            return FuncUnitOperand(t, details)
        elif t == OperandTyEnum.BranchTarget:
            return BTargetOperand(t, details)
        elif t == OperandTyEnum.Immediate:
            return ImmOperand(t, details)
        elif t == OperandTyEnum.IndirectAddressing:
            return IndAddrOperand(t, details)
