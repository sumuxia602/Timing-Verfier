from __future__ import annotations
import string
from lark import v_args, Transformer, Lark
from typing import List, Optional, Tuple, Union

"Name of general-purpose registers"
gp_reg_names = tuple(["A%s" % i for i in range(32)]) + \
               tuple(["B%s" % i for i in range(32)])

cond_reg_names = tuple(["A0", "A1", "A2", "B0", "B1", "B2"])


class ISAException(Exception):
    """Indication error during processing instructions."""

    def __init__(self, msg: str) -> None:
        self.msg = msg

    def __str__(self) -> str:
        return self.msg


class Addr:
    """Address type."""

    def __init__(self, addr: Union[str, int]) -> None:
        if isinstance(addr, int):
            self.addr = hex(addr)[2:]
        else:
            if addr.startswith("0x"):
                addr = addr[2:]
            assert all(i in string.hexdigits for i in addr), addr
            self.addr = addr

    def __str__(self) -> str:
        return self.addr

    def __repr__(self) -> str:
        return "Address %s" % self.addr

    def __hash__(self) -> int:
        return hash(("Addr", self.addr))

    def __eq__(self, other) -> bool:
        if not isinstance(other, Addr):
            return False

        return int(self.addr, 16) == int(other.addr, 16)

    def to_dec(self) -> int:
        """Return the decimal form of address"""
        return int(self.addr, 16)

    def __lt__(self, other: Addr) -> bool:
        return self.to_dec() < other.to_dec()

    def __le__(self, other: Addr) -> bool:
        return self.to_dec() <= other.to_dec()

    def __gt__(self, other: Addr) -> bool:
        return self.to_dec() > other.to_dec()

    def __ge__(self, other: Addr) -> bool:
        return self.to_dec() >= other.to_dec()

    def __add__(self, other: Union[Addr, int]) -> Addr:
        if isinstance(other, Addr):
            return Addr(hex(int(self.addr, 16) + int(other.addr, 16)))
        else:
            return Addr(hex(int(self.addr, 16) + other))

    def __minus__(self, other: Addr) -> Addr:
        return Addr(hex(int(self.addr, 16) - int(other.addr, 16)))


class Operand:
    @property
    def is_reg(self) -> bool:
        return isinstance(self, Reg)

    @property
    def is_ref(self) -> bool:
        return isinstance(self, MemRef)

    @property
    def is_const(self) -> bool:
        return isinstance(self, ConstVal)

    @property
    def is_hex(self) -> bool:
        return isinstance(self, HexVal)

    @property
    def is_reg_pair(self) -> bool:
        return isinstance(self, RegPair)


class Reg(Operand):
    def __init__(self, name: str) -> None:
        assert name in gp_reg_names, \
            "invalid register name %s" % name
        self.name = name

    def __str__(self) -> str:
        return self.name

    def __repr__(self) -> str:
        return "Reg(%s)" % self.name

    def __hash__(self) -> int:
        return hash(("Reg", self.name))

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, Reg):
            return False
        return self.name == other.name


class RegPair(Operand):
    def __init__(self, reg1: str, reg2: str) -> None:
        assert reg1 in gp_reg_names and reg2 in gp_reg_names, \
            "%s:%s" % (reg1, reg2)
        self.reg1 = Reg(reg1)
        self.reg2 = Reg(reg2)

    def __str__(self) -> str:
        return "%s:%s" % (self.reg1, self.reg2)

    def __repr__(self) -> str:
        return "RegPair(%s, %s)" % (self.reg1, self.reg2)

    def __hash__(self) -> int:
        return hash(("RegPair", self.reg1, self.reg2))

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, RegPair):
            return False

        return self.reg1 == other.reg1 and self.reg2 == other.reg2


class NegReg(Reg):
    """Representation of the negation value of a register"""

    def __init__(self, name: str) -> None:
        super().__init__(name)

    def __str__(self) -> str:
        return "-%s" % super().__str__()

    def __repr__(self) -> str:
        return "NegReg(%s)" % self.name

    def __hash__(self) -> int:
        return hash(("NegReg", self.name))

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, NegReg):
            return False
        return self.name == other.name


class Cond:
    def __init__(self, e: str) -> None:
        self.is_neg = e.startswith("!")
        if self.is_neg:
            reg_name = e[1:]
        else:
            reg_name = e
        assert reg_name in cond_reg_names, \
            "%s is not supposed to be a conditional register" % reg_name
        self.reg = Reg(reg_name)

    def __str__(self) -> str:
        if self.is_neg:
            return "[!%s]" % self.reg
        else:
            return "[%s]" % self.reg

    def __repr__(self) -> str:
        if self.is_neg:
            return "Cond(%s, -)" % self.reg
        else:
            return "Cond(%s, +)" % self.reg

    def __hash__(self) -> int:
        return hash(("Cond", self.reg, self.is_neg))


grammar = r"""
    idx: INT -> mk_id

    ?reg: "A" idx -> mk_a_reg 
        | "B" idx -> mk_b_reg

    ?mem: mem1 | mem2 | mem3 | mem4 | mem5 | mem6 | mem7 | mem8

    ?mem1: "*" reg -> mk_normal_indirect

    ?mem2: "*" reg "[" idx "]" -> mk_normal_offset

    ?mem3: "*" reg "++[" idx "]" -> mk_shift_post_incr
            | "*"reg"--[" idx "]" -> mk_shift_post_decr

    ?mem4: "*++" reg "[" idx "]"  -> mk_shift_pre_incr
            | "*--" reg "[" idx "]"  -> mk_shift_pre_decr

    ?mem5: "*++" reg "(" idx ")" -> mk_plus_pre_incr
            | "*--" reg "(" idx ")" -> mk_plus_pre_decr

    ?mem6: "*+" reg "(" idx ")" -> mk_plus_offset
            | "*+" reg "[" idx "]" -> mk_shift_offset
            | "*-" reg "[" idx "]" -> mk_dec_shift_offset
            | "*-" reg "(" idx ")" -> mk_dec_offset
            | "*" reg "[" reg "]" -> mk_shift_reg
    
    ?mem7: "*+" reg "(" reg ")" -> mk_plus_reg
            | "*+" reg "[" reg "]" -> mk_shift_reg
            | "*-" reg "[" reg "]" -> mk_dec_shift_reg
            | "*-" reg "(" reg ")" -> mk_dec_plus_reg

    ?mem8: "*++" reg "(" reg ")" -> mk_plus_reg_pre_incr


    %import common.INT
    %import common.WS
    %ignore WS
"""


@v_args(inline=True)
class IndAddrTransformer(Transformer):
    def mk_id(self, n: int) -> int:
        return int(n)

    def mk_a_reg(self, idx: int) -> Reg:
        return Reg("A%s" % idx)

    def mk_b_reg(self, idx: int) -> Reg:
        return Reg("B%s" % idx)

    def mk_normal_indirect(self, reg: Reg) -> tuple[Reg, int, int]:
        return reg, 0, 0

    def mk_normal_offset(self, reg: Reg, offset: int) -> tuple[Reg, int, int]:
        return reg, offset * 4, 0

    def mk_shift_post_incr(self, reg: Reg, change: int) -> tuple[Reg, int, int]:
        return reg, 0, 4 * change

    def mk_shift_post_decr(self, reg: Reg, change: int) -> tuple[Reg, int, int]:
        return reg, 0, -4 * change

    def mk_shift_pre_incr(self, reg: Reg, offset: int) -> tuple[Reg, int, int]:
        return reg, offset * 4, offset * 4

    def mk_shift_pre_decr(self, reg: Reg, offset: int) -> tuple[Reg, int, int]:
        return reg, -(offset * 4), -(offset * 4)

    def mk_plus_pre_incr(self, reg: Reg, offset: int) -> tuple[Reg, int, int]:
        return reg, offset, offset

    def mk_plus_pre_decr(self, reg: Reg, offset: int) -> tuple[Reg, int, int]:
        return reg, -offset, -offset

    def mk_plus_offset(self, reg: Reg, offset: int) -> tuple[Reg, int, int]:
        return reg, offset, 0

    def mk_shift_offset(self, reg: Reg, offset: int) -> tuple[Reg, int, int]:
        return reg, offset * 4, 0

    def mk_dec_shift_offset(self, reg: Reg, offset: int) -> tuple[Reg, int, int]:
        return reg, -offset * 4, 0

    def mk_dec_offset(self, reg: Reg, offset: int) -> tuple[Reg, int, int]:
        return reg, -offset, 0

    def mk_plus_reg(self, reg: Reg, offset: Reg) -> tuple[Reg, Reg, int]:
        return reg, offset, 0

    def mk_shift_reg(self, reg: Reg, offset: Reg) -> tuple[Reg, Reg, int]:
        return reg, offset, 0

    def mk_dec_shift_reg(self, reg: Reg, offset: Reg) -> tuple[Reg, Reg, int]:
        return reg, NegReg(offset.name), 0

    def mk_dec_plus_reg(self, reg: Reg, offset: Reg) -> tuple[Reg, Reg, int]:
        return reg, NegReg(offset.name), 0

    def mk_plus_reg_pre_incr(self, reg: Reg, offset: Reg) -> tuple[Reg, Reg, Reg]:
        return reg, offset, offset


ind_addr_parser = Lark(grammar=grammar, start="mem", parser="lalr", transformer=IndAddrTransformer())


def parse_ind_addr(s: str):
    return ind_addr_parser.parse(s)


class MemRef(Operand):
    """
    Memory reference.

    A memory reference consists a base register with an offset, the offset
    can be either a constant or a register. 
    """

    def __init__(self, repr: str) -> None:

        self.repr = repr
        reg_offset = parse_ind_addr(repr)
        self.baseR: Reg = reg_offset[0]
        self.offset: int | Reg = reg_offset[1]
        self.baseR_change: int | Reg = reg_offset[2]

    def __str__(self) -> str:
        return self.repr

    def __repr__(self) -> str:
        return "MemRef(%s, %s, %s, %s)" % \
            (self.repr, self.baseR, self.offset, self.baseR_change)

    def __hash__(self) -> int:
        return hash(("MemRef", self.repr, self.baseR,
                     self.offset, self.baseR_change))

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, MemRef):
            return False

        if self.baseR != other.baseR:
            return False

        if self.offset != other.offset:
            return False

        if not self.is_reg_change and not other.is_reg_change:
            return True

        if self.is_reg_change != other.is_reg_change:
            return False

        if self.is_pre != other.is_pre:
            return False

        return self.reg_change_val == other.reg_change_val

    @property
    def is_const_offset(self) -> bool:
        return isinstance(self.offset, int)

    @property
    def is_reg_offset(self) -> bool:
        return isinstance(self.offset, Reg)

    @property
    def is_shift(self) -> bool:
        return self.repr[-1] == "]"

    @property
    def is_plus(self) -> bool:
        return self.repr[-1] == ")"

    @property
    def is_reg_change(self) -> bool:
        return not (isinstance(self.baseR_change, int)
                    and self.baseR_change == 0)

    @property
    def is_pre(self) -> bool:
        """Return true if the change of register is before the addressing."""
        return self.is_reg_change and self.repr.startswith("*--") \
            or self.repr.startswith("*++")

    def reg_change_val(self) -> int:
        if not isinstance(self.baseR_change, int):
            raise ValueError(self.baseR_change)
        return self.baseR_change


class ConstVal(Operand):
    def __init__(self, val: int) -> None:
        self.val = val

    def __str__(self) -> str:
        return str(self.val)

    def __repr__(self) -> str:
        return "IntVal(%s)" % self.val

    def __hash__(self) -> int:
        return hash(("IntVal", self.val))

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, ConstVal):
            return False
        return self.val == other.val


class HexVal(Operand):
    def __init__(self, hval: str) -> None:
        assert hval.startswith("0x")
        self.hval = hval

    def __str__(self) -> str:
        return self.hval

    def __repr__(self) -> str:
        return "HexVal({})".format(self.hval)

    def __hash__(self) -> int:
        return hash(("HexVal", self.hval))

    def __eq__(self, other: object) -> bool:
        if not isinstance(other, HexVal):
            return False
        return self.hval == other.hval


class Instruction(object):

    def __init__(self, name: str, func_unit: Optional[str],
                 operands: List[str], addr: Addr, opcode: str = '',
                 cond: Optional[str] = None, is_par: bool = False,
                 label: Optional[str] = None, delay_slot: int = 0, ful: int = 0) -> None:
        self._opcode = opcode
        self._name = name
        self._func_unit = func_unit
        self._operands = tuple(operands)
        self._addr = addr
        self._cond = cond
        self._is_par = is_par
        self._label = label
        self._delay_slot = delay_slot
        self._ful = ful
        self.ind_target: List[Addr] = []
        self.is_ret = False

    def __str__(self) -> str:
        def par_cond_inst():
            return "{}{:>11} || [{:>3}]  {:<14}{}".format(self.addr,
                                                          self.opcode, self._cond, self.name + self.func_unit,
                                                          ",".join(self.operands))

        def par_uncond_inst():
            return "{}{:>11} ||        {:<14}{}".format(
                self.addr, self.opcode, self.name + self.func_unit, ",".join(self.operands))

        def unpar_cond_inst():
            return "{}{:>11}    [{:>3}]  {:<14}{}".format(self.addr,
                                                          self.opcode, self._cond, self.name + self.func_unit,
                                                          ",".join(self.operands))

        def unpar_uncond_inst():
            return "{}{:>11}           {:<14}{}".format(
                self.addr, self.opcode, self.name + self.func_unit, ",".join(self.operands))

        if self.name == ".fphead":
            return "{}{:>11}           {:<14}{}".format(self.addr,
                                                        self.opcode, ".fphead", ",".join(self.operands))

        if self.is_par:
            if self._cond is not None:
                return par_cond_inst()
            else:
                return par_uncond_inst()
        else:
            if self._cond is not None:
                return unpar_cond_inst()
            else:
                return unpar_uncond_inst()

    def __repr__(self) -> str:
        return "Instruction(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)" \
            % (self.opcode, self.name, self.func_unit, ",".join(self.operands),
               self.addr, self._cond, self.is_par, self.label, self.delay_slot, self.ful)

    def __hash__(self) -> int:
        return hash(("Instruction", self.opcode, self.name, self.func_unit,
                     self.operands, self.addr, self._cond, self.is_par,
                     self.label, self.delay_slot, self.ful))

    def __eq__(self, __o: object) -> bool:
        if not isinstance(__o, Instruction):
            return False
        return self.addr == __o.addr

    @property
    def addr(self) -> Addr:
        return self._addr

    @property
    def operands(self) -> Tuple[str, ...]:
        return self._operands

    @property
    def is_nop(self) -> bool:
        return self.name == "NOP"

    @property
    def dst(self) -> str:
        return self._operands[-1]

    @property
    def src_operands(self) -> Tuple[str, ...]:
        if len(self.operands) < 2:
            raise NotImplementedError
        return self._operands[:-1]

    @property
    def opcode(self) -> str:
        return self._opcode

    @property
    def is_par(self):
        return self._is_par

    @property
    def name(self):
        return self._name

    @property
    def is_branch(self) -> bool:
        """Return True if self is a branch."""
        return self._name in ("B", "BNOP")

    @property
    def cond(self) -> str:
        if self._cond is None:
            raise ISAException("%s does not have a condition" % self)
        return self._cond

    @property
    def is_fp_head(self) -> bool:
        return self.name == ".fphead"

    @property
    def func_unit(self) -> Optional[str]:
        return self._func_unit

    @property
    def label(self) -> Optional[str]:
        return self._label

    @property
    def delay_slot(self) -> int:
        return self._delay_slot

    @property
    def ful(self) -> int:
        return self._ful

    @property
    def is_call(self) -> bool:
        """ Return True if self is a function call. """
        if self.name == "CALLP":
            return True
        elif self.is_branch:
            op = self.operands[0]
            return not (op.startswith("$C$") or
                        op.startswith("LOOP")) and op[-1] == ")"
        else:
            return False

    def get_callee(self) -> Tuple[str, Addr]:
        """ Return the callee's name and address of a call """
        if not self.is_call:
            raise ISAException("%s is not a call instruction" % self)
        return self.operands[0].split(" ")[0], Addr(self.operands[0][-9:-1])

    @property
    def is_djump(self) -> bool:
        """ Return true if self is a (intra-)direct jump (jump to an address). """
        if not self.is_branch:
            return False
        target = self.operands[0]
        return (target.startswith("$C") or target.startswith("LOOP")) and target.endswith(")")

    @property
    def is_indjump(self) -> bool:
        return self.is_branch and not self.is_djump

    def get_dtarget(self) -> Addr:
        """ Return the target's address of direct jump. """
        if not self.is_djump:
            raise ISAException("%s is not a direct jump" % self)

        return Addr(self.operands[0][-9:-1])

    @property
    def is_cond(self) -> bool:
        """ return True if self is a conditional """
        return self._cond is not None

    @property
    def is_cond_jump(self) -> bool:
        return self.is_cond and self.is_branch

    @property
    def is_multi_cycle(self) -> bool:
        if self.name == "IDLE":
            raise NotImplementedError
        elif self.name in ("ADDKPC", "CALLP", "B"):
            return True
        elif self.name == "NOP":
            if len(self.operands) == 0:
                return False
            else:
                nop_num = int(self.operands[0])
                return nop_num > 1
        elif self.name == "BNOP":
            c = int(self.operands[-1])
            return c != 0
        else:
            return False

    def get_cycles(self) -> int:
        """ The number of cycles self will take. """
        if self.name == ".fphead":
            return 0
        elif self._name == "NOP":
            if not self.operands:
                return 1
            else:
                return int(self.operands[0])
        elif self.name in ("BNOP", "ADDKPC"):
            return int(self.operands[-1]) + 1
        elif self.name == "CALLP":
            return 6
        else:
            return 1

    def add_ind_target(self, addr: Addr) -> None:
        """ Add a possible destination for an indirect jump. """
        if not self.is_branch:
            raise ISAException("Only branch could have indirect jump")
        if self.is_djump:
            raise ISAException("%s is a direct jump")

        self.ind_target.append(addr)

    def modifies_reg(self, reg_name: str) -> bool:
        if self.name == ".fphead" or self.is_branch:
            return False
        elif len(self.operands) == 0:
            return False
        last_operand = self.operands[-1]
        if last_operand.endswith("]"):
            return False
        if last_operand == reg_name:
            return True

        return False

    def change_addr_reg(self):
        """ Return true if the instruction is a load / store instruction and
        it modifies the base register. """
        if not self.name in ("STW", "LDW", "STH", "LDH", "LDHU"):
            return False
        if self.name in ("STW", "STH"):
            mem = MemRef(self.operands[-1])
        else:
            mem = MemRef(self.operands[0])
        return mem.is_reg_change
