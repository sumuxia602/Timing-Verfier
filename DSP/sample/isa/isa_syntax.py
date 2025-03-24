import re
import warnings
from enum import Enum, auto
from typing import Optional, Sequence, Tuple, Union, List
from sample.isa.isa_type import ISAType, InstType, ISASPLoopType, SPInstType
from sample.isa.operand_syntax import OperandTyEnum, OperandObject, OperandAutomation, OperandHint, RegOperand, RegPairOperand, \
    RegQuadrupletOperand, IndAddrOperand, BTargetOperand, ImmOperand, FuncUnitOperand


Left_shift_bit = {
    "LDB" : 0,
    "LDBU" : 0,
    "LDDW"  : 3,
    "LDH"  : 1,
    "LDHU"  : 1,
    # "LDNDW"  : 3/0 based on sc field
    "LDNW"  : 2,
    "LDW"  : 2,
    "STB"  : 0,
    "STDW"  : 3,
    "STH"  : 1,
    # "STNDW"  : 3/0 based on sc field
    "STNW"  : 2,
    "STW"  : 2,
}

class ISASyntaxAutomation:
    cpu_bus_pat = r"^([LSMD]{1}[12]{1})(X)?(T[12]{1})?$"


class InstObject:
    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        self._tokens = tuple(tokens)
        self._address_hex: str = tokens[0]
        self._address: int = int(self._address_hex, 16)
        self._opcode: str = tokens[1]

    def __str__(self):
        paralleled = self._tokens[2] if self._tokens[2] is not None else ""
        masked = self._tokens[3] if self._tokens[3] is not None else ""
        cond = "[{:>3}]".format(self._tokens[4]) if self._tokens[4] is not None else ""
        inst = ".".join([self._tokens[5], self._tokens[6]] if self._tokens[6] is not None else [self._tokens[5]])
        return "{} {:>8}  {:2}{:1} {:5} {:<18} {}".format(self._address_hex, self._opcode, paralleled, masked, cond, inst, self._tokens[7])

    def __repr__(self):
        return "<Instruction in 0x{}, Opcode={}>".format(self._address_hex, self._opcode)

    def __hash__(self):
        return self._address

    def __eq__(self, other):
        if not isinstance(other, InstObject):
            return False
        return other._address == self._address

    @property
    def tokens(self):
        return self._tokens

    @property
    def address_hex(self):
        return self._address_hex

    @property
    def address(self):
        return self._address

    @property
    def opcode(self):
        return self._opcode


class InstStream(InstObject):
    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(InstStream, self).__init__(tokens, *args, **kwargs)
        self._fp_begin: bool = (self._address % 32) == 0
        self._paralleled: bool = self._tokens[2] is not None
        self._spmasked: bool = self._tokens[3] is not None
        self._cond: Optional[str] = self._tokens[4]

    @property
    def is_fp_begin(self):
        return self._fp_begin

    @property
    def is_ep_paralleled(self):
        return self._paralleled

    @property
    def is_ep_begin(self):
        return not self._paralleled

    @property
    def is_sp_masked(self):
        return self._spmasked

    @property
    def condition(self):
        return self._cond


class InstBody(InstObject):
    _cpu_bus_cpat = re.compile(ISASyntaxAutomation.cpu_bus_pat)

    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(InstBody, self).__init__(tokens, *args, **kwargs)

        self._name: str = self._tokens[5]
        if self._tokens[6] is not None:
            func_unit, cross_path, data_path = re.match(self._cpu_bus_cpat, self._tokens[6]).groups()
            self._func_unit: Optional[str] = func_unit
            self._cross_path: bool = cross_path is not None
            self._data_path: Optional[str] = data_path
        else:
            self._func_unit = None
            self._cross_path = False
            self._data_path = None

        self._ty, self._exe_cycle, self._delay_slot, self._func_unit_latency = ISAType.inst_matching(self._name)

    @property
    def name(self):
        return self._name

    @property
    def function_unit(self):
        return self._func_unit

    @property
    def is_cross_path(self):
        return self._cross_path

    @property
    def data_path(self):
        return self._data_path

    @property
    def ty(self):
        return self._ty

    @property
    def exe_cycle(self):
        return self._exe_cycle

    @property
    def delay_slot(self):
        return self._delay_slot

    @property
    def func_unit_latency(self):
        return self._func_unit_latency


class InstOperands(InstBody):
    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(InstOperands, self).__init__(tokens, *args, **kwargs)

        self._operands = list()
        operand_tokens = self._tokens[7]
        if self._name == ".fphead":
            self._operands.append(OperandObject(OperandTyEnum.FPHeadCtrl, (operand_tokens,)))
        elif operand_tokens is not None:
            operand_tokens = operand_tokens.split(",")
            self._operands.extend([OperandAutomation.get_operand(op.strip()) for op in operand_tokens])

        self._operands: Tuple[Union[OperandHint, OperandObject], ...] = tuple(self._operands)
        self._operand_num = len(self._operands)

    @property
    def operands(self):
        return self._operands

    @property
    def operand_num(self):
        return self._operand_num

    def operand(self, idx) -> Union[OperandHint, OperandObject]:
        return self._operands[idx]


class InstNopBehaviorError(Exception):
    def __init__(self, val: str, *args):
        super(InstNopBehaviorError, self).__init__(val, *args)


class InstNopBehavior(InstOperands):
    __multi_cycle_instructions = {'BNOP', 'NOP', 'ADDKPC', 'CALLP'}

    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(InstNopBehavior, self).__init__(tokens, *args, **kwargs)

        try:
            self._is_multi_cycle_nop = self._name in self.__multi_cycle_instructions
            self._multi_cycle_nop = 0
            if self._is_multi_cycle_nop:
                if self._name == 'BNOP':
                    self._multi_cycle_nop = self._operands[1].imm
                elif self._name == 'NOP' and self._operand_num > 0:
                    self._multi_cycle_nop = self._operands[0].imm - 1
                elif self._name == 'ADDKPC':
                    self._multi_cycle_nop = self._operands[2].imm
                elif self._name == 'CALLP':
                    self._multi_cycle_nop = 5

                if self._multi_cycle_nop < 0:
                    raise RuntimeError("Negative extra-nop-cycle is not allowed.")
                # If extra-nop-cycle is 0, then no multi-cycle-nop will be generated.
                if self._multi_cycle_nop == 0:
                    self._is_multi_cycle_nop = False

        except Exception as e:
            raise InstNopBehaviorError("{}\n"
                                       "Error type: {}\n"
                                       "Instruction type: {}\n"
                                       "Instruction: {}\n".format(e.__str__(), type(e), self._ty, self.__str__()))

    @property
    def is_multi_cycle_nop(self):
        return self._is_multi_cycle_nop

    @property
    def extra_nop_cycle(self):
        if not self._is_multi_cycle_nop:
            raise AttributeError("Non-multi-cycle-nop instruction does not have attribute extra_nop_cycle().")
        return self._multi_cycle_nop


class InstRegBehaviorError(Exception):
    def __init__(self, val: str, *args):
        super(InstRegBehaviorError, self).__init__(val, *args)


class InstRegBehavior(InstOperands):

    @staticmethod
    def __append_reg(op: Union[RegOperand, RegPairOperand, RegQuadrupletOperand], reg_c: int) -> List[Tuple[str, int]]:
        if isinstance(op, RegOperand):
            return [(op.reg, reg_c)]
        elif isinstance(op, RegPairOperand):
            return [(op.reg_h, reg_c), (op.reg_l, reg_c)]
        elif isinstance(op, RegQuadrupletOperand):
            return [(reg, reg_c) for reg in op.reg_quadruplet]
        else:
            return list()

    def __reg_read_write_check(self):

        self._reg_read: List[Tuple[str, int]] = list()
        self._reg_write: List[Tuple[str, int]] = list()

        if self._ty == InstType.SINGLE_CYCLE:
            if self._name == 'ADDKPC':
                src1, dst, src2 = self._operands
                if not (isinstance(src1, BTargetOperand) and isinstance(dst, RegOperand) and isinstance(src2, ImmOperand)):
                    raise RuntimeError("The instruction ADDKPC has a standard operand format: <BTarget> <Reg> <Imm>. "
                                       "Current: {} {} {}".format(*self._operands))
                self._reg_write.append((dst.reg, 1))
            elif self._name == 'NOP':
                pass
            else:
                # Read at E1 stage and write at E1 stage.
                for op in self._operands[: -1]:
                    self._reg_read.extend(self.__append_reg(op, 1))
                if not isinstance(self._operands[-1], (RegOperand, RegPairOperand, RegQuadrupletOperand)):
                    raise RuntimeError("The instruction needs to have writable lvalues (registers).")
                self._reg_write.extend(self.__append_reg(self._operands[-1], 1))

        elif self._ty == InstType.SINGLE_MULTI:
            # Read at E1 stage and write at E2 stage.
            for op in self._operands[: -1]:
                self._reg_read.extend(self.__append_reg(op, 1))
            if not isinstance(self._operands[-1], (RegOperand, RegPairOperand, RegQuadrupletOperand)):
                raise RuntimeError("The instruction needs to have writable lvalues (registers).")
            self._reg_write.extend(self.__append_reg(self._operands[-1], 2))

        elif self._ty == InstType.STORE:
            # Read src and baseR at E1 stage.
            self._reg_read.extend(self.__append_reg(self._operands[0], 1))
            inda_op = self._operands[1]
            if not isinstance(inda_op, IndAddrOperand):
                raise RuntimeError("The instruction needs a second indirect-addressing operand.")
            self._reg_read.append((inda_op.inda_base_reg, 1))
            # If register-offset, read offsetR at E1 stage.
            if inda_op.inda_is_offset and inda_op.inda_is_offset_reg:
                self._reg_read.append((inda_op.inda_offset, 1))
            # baseR is written if pre or post in/decreased.
            if inda_op.inda_pre in ('++', '--') or inda_op.inda_post in ('++', '--'):
                self._reg_write.append((inda_op.inda_base_reg, 1))

        elif self._ty == InstType.MULTI_EXT or self._ty == InstType.CYCLE4:
            # Read src at E1 stage and write dst at E4 stage.
            for op in self._operands[: -1]:
                self._reg_read.extend(self.__append_reg(op, 1))
            if not isinstance(self._operands[-1], (RegOperand, RegPairOperand, RegQuadrupletOperand)):
                raise RuntimeError("The instruction needs to have writable lvalues (registers).")
            self._reg_write.extend(self.__append_reg(self._operands[-1], 4))

        elif self._ty == InstType.LOAD:
            # Read baseR at E1 stage.
            inda_op = self._operands[0]
            if not isinstance(inda_op, IndAddrOperand):
                raise RuntimeError("The instruction needs a first indirect-addressing operand.")
            self._reg_read.append((inda_op.inda_base_reg, 1))
            # If register-offset, read offsetR at E1 stage.
            if inda_op.inda_is_offset and inda_op.inda_is_offset_reg:
                self._reg_read.append((inda_op.inda_offset, 1))
            # write dst at E5 stage.
            self._reg_write.extend(self.__append_reg(self._operands[1], 5))
            # baseR is written if pre or post in/decreased.
            if inda_op.inda_pre in ('++', '--') or inda_op.inda_post in ('++', '--'):
                self._reg_write.append((inda_op.inda_base_reg, 1))

        elif self._ty == InstType.BRANCH:
            # All branch-instructions need to read src at E1 stage.
            self._reg_read.extend(self.__append_reg(self._operands[0], 1))
            # For 'BDEC' and 'BPOS', write dst at E1 stage.
            if self._name == 'BDEC' or self._name == 'BPOS':
                self._reg_read.extend(self.__append_reg(self._operands[1], 1))
            # For 'BDEC' and 'CALLP', write dst at E1 stage.
            if self._name == 'BDEC' or self._name == 'CALLP':
                self._reg_write.extend(self.__append_reg(self._operands[1], 1))

        elif self._ty == InstType.DP_CYCLE1:
            # Read src at E1 stage.
            self._reg_read.extend(self.__append_reg(self._operands[0], 1))
            # Write dst_l at E1 stage and dst_h at E2 stage.
            dst_op = self._operands[1]
            if not isinstance(dst_op, RegPairOperand):
                raise RuntimeError("The instruction needs a second register-pair operand.")
            self._reg_write.extend([(dst_op.reg_l, 1), (dst_op.reg_h, 2)])

        elif self._ty == InstType.CYCLE3:
            # Read src at E1 stage and write dst at E4 stage.
            for op in self._operands[: -1]:
                self._reg_read.extend(self.__append_reg(op, 1))
            if not isinstance(self._operands[-1], (RegOperand, RegPairOperand, RegQuadrupletOperand)):
                raise RuntimeError("The instruction needs to have writable lvalues (registers).")
            self._reg_write.extend(self.__append_reg(self._operands[-1], 3))

        elif self._ty == InstType.DP_CMP:
            src1, src2, dst = self._operands
            if not (isinstance(src1, RegPairOperand) and isinstance(src2, RegPairOperand) and isinstance(dst, RegOperand)):
                raise RuntimeError("The DP-CMP instructions have a standard operand format: <RegPair> <RegPair> <Reg>. "
                                   "Current: {} {}".format(*self._operands))
            # Read src1_l, src2_l at E1 stage, src1_h, src_h at E2 stage.
            self._reg_read.extend([(src1.reg_l, 1), (src2.reg_l, 1)])
            self._reg_read.extend([(src1.reg_h, 2), (src2.reg_h, 2)])
            # Write dst at E2 stage.
            self._reg_write.extend([(dst.reg, 2), ])

        elif self._ty == InstType.INTDP:
            src2, dst = self._operands
            if not (isinstance(src2, RegOperand) and isinstance(dst, RegPairOperand)):
                raise RuntimeError("The INTDP instructions have a standard operand format: <Reg> <RegPair>. "
                                   "Current: {} {} {}".format(*self._operands))
            # Read src2 at E1 stage.
            self._reg_read.append((src2.reg, 1))
            # Write dst_l at E4 stage and dst_h at E5 stage.
            self._reg_write.extend([(dst.reg_l, 4), (dst.reg_h, 5)])

        elif self._ty == InstType.ADDDP_SUBDP:
            src1, src2, dst = self._operands
            if not (isinstance(src1, RegPairOperand) and isinstance(src2, RegPairOperand) and isinstance(dst, RegPairOperand)):
                raise RuntimeError("The ADDDP/SUBDP instructions have a standard operand format: <RegPair> <RegPair> <RegPair>. "
                                   "Current: {} {} {}".format(*self._operands))
            # Read src1_l, src2_l at E1 stage, src1_h, src2_h at E2 stage.
            self._reg_read.extend([(src1.reg_l, 1), (src2.reg_l, 1)])
            self._reg_read.extend([(src2.reg_h, 2), (src2.reg_h, 2)])
            # Write dst_l at E6 stage and dst_h at E7 stage.
            self._reg_write.extend([(dst.reg_l, 6), (dst.reg_h, 7)])

        elif self._ty == InstType.MPYI:
            src1, src2, dst = self._operands
            if not (isinstance(src1, RegOperand) and isinstance(src2, RegOperand) and isinstance(dst, RegOperand)):
                raise RuntimeError("The MPYI instruction has a standard operand format: <Reg> <Reg> <Reg>. "
                                   "Current: {} {} {}".format(*self._operands))
            # Read src1, src2 from E1 stage to E4 stage.
            self._reg_read.extend([(src1.reg, i) for i in range(1, 5)])
            self._reg_read.extend([(src2.reg, i) for i in range(1, 5)])
            # Write dst at E9 stage.
            self._reg_write.append((dst.reg, 9))

        elif self._ty == InstType.MPYID:
            src1, src2, dst = self._operands
            if not (isinstance(src1, RegOperand) and isinstance(src2, RegOperand) and isinstance(dst, RegPairOperand)):
                raise RuntimeError("The MPYID instruction has a standard operand format: <Reg> <Reg> <RegPair>. "
                                   "Current: {} {} {}".format(*self._operands))
            # Read src1, src2 from E1 stage to E4 stage.
            self._reg_read.extend([(src1.reg, i) for i in range(1, 5)])
            self._reg_read.extend([(src2.reg, i) for i in range(1, 5)])
            # Write dst_l at E9 stage and dst_h at E10 stage.
            self._reg_write.extend([(dst.reg_l, 9), (dst.reg_h, 10)])

        elif self._ty == InstType.MPYDP:
            src1, src2, dst = self._operands
            if not (isinstance(src1, RegPairOperand) and isinstance(src2, RegPairOperand) and isinstance(dst, RegPairOperand)):
                raise RuntimeError("The MPYDP instruction has a standard operand format: <RegPair> <RegPair> <RegPair>. "
                                   "Current: {} {} {}".format(*self._operands))
            # Read src1_l and src2_l at E1 stage.
            self._reg_read.extend([(src1.reg_l, 1), (src2.reg_l, 1)])
            # Read src1_l and src2_h at E2 stage.
            self._reg_read.extend([(src1.reg_l, 2), (src2.reg_h, 2)])
            # Read src1_h and src2_l at E3 stage.
            self._reg_read.extend([(src1.reg_h, 3), (src2.reg_l, 3)])
            # Read src1_h and src2_h at E4 stage.
            self._reg_read.extend([(src1.reg_h, 4), (src2.reg_h, 4)])
            # Write dst_l at E9 stage and dst_h at E10 stage.
            self._reg_write.extend([(dst.reg_l, 9), (dst.reg_h, 10)])

        elif self._ty == InstType.MPYSPDP:
            src1, src2, dst = self._operands
            if not (isinstance(src1, RegOperand) and isinstance(src2, RegPairOperand) and isinstance(dst, RegPairOperand)):
                raise RuntimeError("The MPYSPDP instruction has a standard operand format: <Reg> <RegPair> <RegPair>. "
                                   "Current: {} {} {}".format(*self._operands))
            # Read src1 from E1 stage to E2 stage.
            self._reg_read.extend([(src1.reg, 1), (src1.reg, 2)])
            # Read src2_l at E1 stage and src2_h at E2 stage.
            self._reg_read.extend([(src2.reg_l, 1), (src2.reg_h, 2)])
            # Write dst_l at E6 stage and dst_h at E7 stage.
            self._reg_write.extend([(dst.reg_l, 6), (dst.reg_h, 7)])

        elif self._ty == InstType.MPYSP2DP:
            src1, src2, dst = self._operands
            if not (isinstance(src1, RegOperand) and isinstance(src2, RegOperand) and isinstance(dst, RegPairOperand)):
                raise RuntimeError("The MPYSP2DP instruction has a standard operand format: <Reg> <Reg> <RegPair>. "
                                   "Current: {} {} {}".format(*self._operands))
            # Read src1 and src2 at E1 stage.
            self._reg_read.extend([(src1.reg, 1), (src2.reg, 1)])
            # Write dst_l at E4 stage and dst_h at E5 stage.
            self._reg_write.extend([(dst.reg_l, 4), (dst.reg_h, 5)])

    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(InstRegBehavior, self).__init__(tokens, *args, **kwargs)

        try:
            self.__reg_read_write_check()
        except Exception as e:
            raise InstRegBehaviorError("{}\n"
                                       "Error type: {}\n"
                                       "Instruction type: {}\n"
                                       "Instruction: {}\n".format(e.__str__(), type(e), self._ty, self.__str__()))

        self._reg_read: Tuple[Tuple[str, int], ...] = tuple(self._reg_read)
        self._reg_write: Tuple[Tuple[str, int], ...] = tuple(self._reg_write)

    @property
    def reg_read_behaviors(self):
        return self._reg_read

    @property
    def reg_write_behaviors(self):
        return self._reg_write


class InstMemAccBehaviorError(Exception):
    def __init__(self, val: str, *args):
        super(InstMemAccBehaviorError, self).__init__(val, *args)


class RegModificationEnum(Enum):
    NoMod = 0
    Pre = 1
    Post = -1


class AddressingTyEnum(Enum):
    RegIndirect = auto()
    RegRelative = auto()
    BasePlusIndex = auto()


class InstMemAccBehavior(InstOperands):

    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(InstMemAccBehavior, self).__init__(tokens, *args, **kwargs)

        self._is_load = self._ty == InstType.LOAD
        self._is_store = self._ty == InstType.STORE
        self._is_memory_access = self._is_load or self._is_store

        try:
            op = self._operands[0] if self._is_load else self._operands[1] if self._is_store else None
            if op is not None:

                if not isinstance(op, IndAddrOperand):
                    raise RuntimeError("A load instruction should have a first indirect-addressing operand. Got {} instead.".format(op.ty))

                pre, post, offset = op.inda_pre, op.inda_post, op.inda_offset
                if pre is not None and post is not None:
                    raise RuntimeError("Both pre and post decorations are not allowed for indirect-addressing operand.")
                if pre is not None and pre not in ('+', '-', '++', '--'):
                    raise RuntimeError("Pre should be one of '+', '-', '++' and '--'. Got {} instead.".format(pre))
                if post is not None and post not in ('++', '--'):
                    raise RuntimeError("Post should be one of '++' and '--'. Got {} instead.".format(post))

                # Check the modification of baseR register.
                self._reg_mod_type = RegModificationEnum.Pre if (pre is not None and pre in ('++', '--')) else \
                    RegModificationEnum.Post if post is not None else RegModificationEnum.NoMod

                # Check addressing type.
                if not op.inda_is_offset:
                    if pre is not None and pre in ('+', '-'):
                        raise RuntimeError("Pre under register-indirect addressing mode should be one of '+' and '-'. Got {} instead.".format(pre))
                    self._addressing_type = AddressingTyEnum.RegIndirect
                else:
                    if op.inda_is_offset_reg:
                        self._addressing_type = AddressingTyEnum.BasePlusIndex
                    elif op.inda_is_offset_imm:
                        self._addressing_type = AddressingTyEnum.RegRelative
                    else:
                        raise RuntimeError("Unknown addressing type. "
                                           "Got offset: {}, is_reg: {} and is_imm: {}.".format(op.inda_is_offset,
                                                                                               op.inda_is_offset_reg, op.inda_is_offset_imm))

        except Exception as e:
            raise InstMemAccBehaviorError("{}\n"
                                          "Error type: {}\n"
                                          "Instruction type: {}\n"
                                          "Instruction: {}\n".format(e.__str__(), type(e), self._ty, self.__str__()))

    @property
    def is_load(self):
        return self._is_load

    @property
    def is_store(self):
        return self._is_store

    @property
    def is_memory_access(self):
        return self._is_memory_access

    @property
    def inda_gen_operand(self) -> IndAddrOperand:
        if not self._is_memory_access:
            raise AttributeError("Only load and store instructions have attribute inda_operand().")
        return self._operands[0] if self._is_load else self._operands[1] if self._is_store else None
    
    @property
    def inda_left_shift(self) -> IndAddrOperand:
        if not self._is_memory_access:
            raise AttributeError("Only load and store instructions have attribute inda_left_shift().")
        
        if self.name in ("LDNDW","STNDW"):
            return 3 if self.inda_gen_operand.inda_is_scaled_offsets else 0
        else:
            return Left_shift_bit[self.name]

    @property
    def addressing_type(self) -> AddressingTyEnum:
        if not self._is_memory_access:
            raise AttributeError("Only load and store instructions have attribute addressing_type().")
        return self._addressing_type

    @property
    def base_reg_modification(self) -> RegModificationEnum:
        if not self._is_memory_access:
            raise AttributeError("Only load and store instructions have attribute base_reg_modification().")
        return self._reg_mod_type


class InstBranchBehaviorError(Exception):
    def __init__(self, val: str, *args):
        super(InstBranchBehaviorError, self).__init__(val, *args)


class InstBranchBehavior(InstOperands):
    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(InstBranchBehavior, self).__init__(tokens, *args, **kwargs)

        try:
            self._is_branch = self._ty == InstType.BRANCH

            if self._is_branch:
                self._is_conditional = self._name in ('BDEC', 'BPOS')
                # Check branch condition.
                if self._is_conditional:
                    if len(self._operands) < 2:
                        raise RuntimeError("Cannot find the condition of a conditional branch instruction.")
                    cond_op = self._operands[1]
                    if not isinstance(cond_op, RegOperand):
                        raise RuntimeError("The condition should be a register. Got {} instead.".format(cond_op.ty))
                    self._b_cond = cond_op.reg
                # Check branch type.
                b_op = self._operands[0]
                if isinstance(b_op, BTargetOperand):
                    self._is_imm_branch_target = True
                elif isinstance(b_op, RegOperand):
                    self._is_imm_branch_target = False
                else:
                    raise RuntimeError("The branch target should be one of Branch-target operand or register. Got {} instead.".format(b_op.ty))

        except Exception as e:
            raise InstBranchBehaviorError("{}\n"
                                          "Error type: {}\n"
                                          "Instruction type: {}\n"
                                          "Instruction: {}\n".format(e.__str__(), type(e), self._ty, self.__str__()))

    @property
    def is_branch(self):
        return self._is_branch

    @property
    def is_conditional(self):
        if not self._is_branch:
            raise AttributeError("Only branch instructions have attribute is_conditional().")
        return self._is_conditional

    @property
    def is_branch_immediate_label(self):
        if not self._is_branch:
            raise AttributeError("Only branch instructions have attribute is_branch_immediate_label().")
        return self._is_imm_branch_target

    @property
    def is_branch_register(self):
        if not self._is_branch:
            raise AttributeError("Only branch instructions have attribute is_branch_register().")
        return not self._is_imm_branch_target

    @property
    def branch_gen_operand(self) -> Union[RegOperand, BTargetOperand]:
        if not self._is_branch:
            raise AttributeError("Only branch instructions have attribute branch_gen_operand().")
        return self._operands[0]


class InstSPLoopBehaviorError(Exception):
    def __init__(self, val: str, *args):
        super(InstSPLoopBehaviorError, self).__init__(val, *args)


class InstSPLoopBehavior(InstOperands):

    __Strict = True

    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(InstSPLoopBehavior, self).__init__(tokens, *args, **kwargs)

        try:
            self._is_sploop_related = self._ty == InstType.SP_LOOP

            if self._is_sploop_related:
                self._sp_type = ISASPLoopType.sp_inst_matching(self._name)
                if self._sp_type is None:
                    raise RuntimeError("Unknown type of current SPLoop-related instruction. Got {}.".format(self._name))
                if self._sp_type == SPInstType.SPUnhandled:
                    if self.__Strict:
                        raise RuntimeError("Unhandled SPLoop-related instruction {}.".format(self._name))
                    else:
                        warnings.warn("Unhandled SPLoop-related instruction {}".format(self._name))

                if self._sp_type == SPInstType.SPLoopHead:
                    ii_op = self._operands[0]
                    if not isinstance(ii_op, ImmOperand):
                        raise RuntimeError("The SPHead instructions should have a first immediate operand. Got {} instead.".format(ii_op.ty))
                    self._sp_ii = ii_op.imm
                elif self._sp_type == SPInstType.SPLoopTail:
                    stg_op, cyc_op = self._operands
                    if not (isinstance(stg_op, ImmOperand) and isinstance(cyc_op, ImmOperand)):
                        raise RuntimeError("The SPTail (currently SPKERNEL only) instruction should have "
                                           "a first immediate operand and a second immediate operand. "
                                           "Got {} and {} istead.".format(stg_op.ty, cyc_op.ty))
                    self._sp_stg, self._sp_cyc = stg_op.imm, cyc_op.imm
                elif self._sp_type == SPInstType.SPCtrl:
                    unit_op = self._operands[0]
                    if not isinstance(unit_op, FuncUnitOperand):
                        raise RuntimeError("The SPCtrl (currently SPMASK only) instruction should have a first function-unit operand. "
                                           "Got {} instead.".format(unit_op.ty))
                    self._sp_unit = unit_op.func_unit

        except Exception as e:
            raise InstSPLoopBehaviorError("{}\n"
                                          "Error type: {}\n"
                                          "Instruction type: {}\n"
                                          "Instruction: {}\n".format(e.__str__(), type(e), self._ty, self.__str__()))

    @property
    def is_sp_related(self):
        return self._is_sploop_related

    @property
    def sp_inst_type(self) -> SPInstType:
        if not self._is_sploop_related:
            raise AttributeError("Only SPLoop-related instructions have attribute sp_inst_type().")
        return self._sp_type

    @property
    def sp_ii(self):
        if not self._is_sploop_related or self._sp_type != SPInstType.SPLoopHead:
            raise AttributeError("Only SPLoopHead instructions have attribute sp_ii().")
        return self._sp_ii

    @property
    def sp_stg(self):
        if not self._is_sploop_related or self._sp_type != SPInstType.SPLoopTail:
            raise AttributeError("Only SPLoopTail instructions have attribute sp_stg().")
        return self._sp_stg

    @property
    def sp_cyc(self):
        if not self._is_sploop_related or self._sp_type != SPInstType.SPLoopTail:
            raise AttributeError("Only SPLoopTail instructions have attribute sp_cyc().")
        return self._sp_cyc

    @property
    def sp_masked_function_unit(self):
        if not self._is_sploop_related or self._sp_type != SPInstType.SPCtrl:
            raise AttributeError("Only SPCtrl instructions have attribute sp_masked_function_unit().")
        return self._sp_unit


class InstMiscBehavior(InstOperands):
    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(InstMiscBehavior, self).__init__(tokens, *args, **kwargs)


class BehaviorEnum(Enum):
    MultiCycleNop = auto()
    RegisterRead = auto()
    RegisterWrite = auto()
    MemoryAccess = auto()
    Branch = auto()
    SPLoop = auto()


class InstBehavior(InstNopBehavior, InstRegBehavior, InstMemAccBehavior, InstBranchBehavior, InstSPLoopBehavior, InstMiscBehavior):
    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(InstBehavior, self).__init__(tokens, *args, **kwargs)

        self._supported_behavior = list()
        if self.is_multi_cycle_nop:
            self._supported_behavior.append(BehaviorEnum.MultiCycleNop)
        if len(self.reg_read_behaviors) > 0:
            self._supported_behavior.append(BehaviorEnum.RegisterRead)
        if len(self.reg_write_behaviors) > 0:
            self._supported_behavior.append(BehaviorEnum.RegisterWrite)
        if self.is_branch:
            self._supported_behavior.append(BehaviorEnum.Branch)
        if self.is_memory_access:
            self._supported_behavior.append(BehaviorEnum.MemoryAccess)
        if self.is_sp_related:
            self._supported_behavior.append(BehaviorEnum.SPLoop)
        self._supported_behavior: Tuple[BehaviorEnum, ...] = tuple(self._supported_behavior)

    @property
    def supported_behavior(self):
        return self._supported_behavior


class Instruction(InstStream, InstBehavior):
    def __init__(self, tokens: Sequence[Optional[str]], *args, **kwargs):
        super(Instruction, self).__init__(tokens, *args, **kwargs)
