from __future__ import annotations
from collections import deque
import warnings
from z3 import z3

from sample.frontend.cfg import TCFGNode, Instruction, Addr
from sample.frontend.isa import gp_reg_names, Reg, MemRef, Cond, Operand, ConstVal, HexVal, RegPair
from sample.frontend.loops import Loop


class RankFinderException(Exception):
    """ Drop this exception when RankFinder can't prove the termination of given program. """

    def __init__(self, A1: Mat, A2: Mat, b_vec: Col) -> None:
        self.A1 = A1
        self.A2 = A2
        self.b_vec = b_vec

    def __str__(self) -> str:
        s = "Can't prove termination of the following LASW program\n"
        s += "A = %s\nA' = %s\nb = %s\n" % (self.A1, self.A2, self.b_vec)
        return s


cond_expand_inst_names = [
    "CMPGT", "MVK", "MV", "CMPGTU", "CMPLT", "CMPLTU", "LDW", "STW", "LDH", "STH"
]


def is_reg(s: str) -> bool:
    return s in gp_reg_names


def is_ref(s: str) -> bool:
    return s.startswith("*")


def is_reg_pair(s: str) -> bool:
    if not len(s.split(':')) == 2:
        return False
    reg1, reg2 = s.split(':')
    return is_reg(reg1) and is_reg(reg2)


def parse_operand(s: str) -> Operand:
    if s.isdigit() or s.lstrip('-').isdigit():
        return ConstVal(int(s))
    elif s.startswith('0x'):
        return HexVal(s)
    elif is_ref(s):
        return MemRef(s)
    elif is_reg(s):
        return Reg(s)
    elif s.endswith('b'):
        return ConstVal(int(s[:-1], 2))
    elif s.endswith(')'):
        return HexVal(s[-11:-1])
    elif is_reg_pair(s):
        return RegPair(*s.split(':'))
    else:
        raise NotImplementedError(s)


def split_mem_inst(inst: Instruction) -> tuple[Instruction, Instruction]:
    """ Split the given load / store instruction """
    assert inst.name in ("STW", "STH", "LDW", "LDH", "LDHU"), \
        "%s is not a load / store instruction"
    if inst.name in ("STW", "STH"):
        mem = MemRef(inst.operands[1])
    else:
        mem = MemRef(inst.operands[0])
    assert mem.is_reg_change, mem.repr

    val = mem.reg_change_val()
    baseR = str(mem.baseR)
    mod_reg_inst = Instruction("ADD", inst.func_unit,
                               [baseR, str(val), baseR],
                               addr=inst.addr, is_par=inst.is_par)
    if inst.name in ("STW", "STH"):
        mem_inst = Instruction(inst.name, inst.func_unit,
                               [inst.operands[0], "*%s" % baseR],
                               addr=inst.addr, is_par=inst.is_par)
    else:
        mem_inst = Instruction(inst.name, inst.func_unit,
                               ["*%s" % baseR, inst.operands[1]],
                               addr=inst.addr, is_par=inst.is_par)
    if mem.is_pre:
        return mod_reg_inst, mem_inst
    else:
        return mem_inst, mod_reg_inst


Col = tuple[int, ...]
Row = tuple[int, ...]
Mat = tuple[Row, ...]
Var = Reg | MemRef


class OpNode:

    def __init__(self, root: Operand,
                 prevs: tuple[Instruction, ...],
                 loc: Addr,
                 children: tuple[OpNode, ...] = tuple(),
                 level: int = 0,
                 op: str | None = None,
                 addr: Addr | None = None) -> None:
        self.root = root
        self.prevs = prevs
        self.loc = loc
        self.children = children
        self.level = level
        self.op = op
        self.addr = addr
        self.post_order_nodes: tuple[OpNode, ...] = tuple()

    def __str__(self) -> str:
        s = "%s at %s\n" % (str(self.root), self.addr)
        for child in self.children:
            for line in str(child).splitlines():
                s += "  %s\n" % line
        return s

    def __hash__(self) -> int:
        return hash(("OpNode", self.root, self.prevs, self.children, self.level, self.op, self.addr))

    def expand(self) -> OpNode:
        if len(self.prevs) == 0:
            return self
        if isinstance(self.root, (HexVal, ConstVal)):
            return self
        for i, inst in enumerate(self.prevs):
            dst = parse_operand(inst.dst)
            # first check if the root is changed by the compound load / store instruction
            # e.g. if we want to track *B15[2] but we met the instruction LDW *++B15[2],B10.
            # the value of B15 has been changed and we have to stop expanding at here.
            if isinstance(self.root, MemRef) and dst.is_reg and self.root.baseR == dst:
                return OpNode(self.root, self.prevs, self.loc, children=tuple(),
                              level=self.level, op=self.op, addr=self.addr)
            if self.root == dst:
                self.op = inst.name
                self.addr = inst.addr
                j = i + 1
                if inst.is_par:  # ignore the instructions in the same execute packet
                    while j < len(self.prevs) and self.prevs[j].is_par:
                        j += 1
                    j += 1
                child_prevs = tuple([prev_inst for prev_inst in self.prevs[j:]])
                children = []
                for src in inst.src_operands:
                    child_root = parse_operand(src.lstrip())
                    children.append(OpNode(child_root, child_prevs, loc=inst.addr, level=self.level + 1).expand())
                return OpNode(self.root, self.prevs, self.loc,
                              children=tuple(children),
                              level=self.level,
                              op=self.op,
                              addr=self.addr)

        return self

    def post_order(self) -> tuple[OpNode, ...]:
        """ Post-order traversal. """
        if self.post_order_nodes:
            return self.post_order_nodes
        if not self.children:
            return tuple([self])
        res = [n for child in self.children for n in child.post_order()]
        res.append(self)
        if not self.post_order_nodes:
            self.post_order_nodes = tuple(res)
        return self.post_order_nodes

    @property
    def depth(self) -> int:
        if not self.children:
            return 1
        else:
            return 1 + max(child.depth for child in self.children)

    @property
    def is_compare(self) -> bool:
        return self.op in ("CMPGT", "CMPEQ", "CMPLT", "CMPGTU", "CMPLTU")

    def gen_step(self, level: int) -> tuple[tuple[tuple[str, int], ...],
    tuple[tuple[Operand, Addr], ...]]:
        """Generate the computation tree and 
        expand information on a given level."""
        tree = []
        nodes = self.post_order()
        expand_addrs: list[tuple[Operand, Addr]] = []
        elems_at_i = [e for e in nodes if e.level <= level]
        for e in elems_at_i:
            if e.children:
                if e.level == level:
                    assert e.addr is not None
                    expand_addrs.append((e.root, e.addr))
                    tree.append(((str(e.root)), e.level))
                elif e.level < level:
                    assert e.op is not None
                    tree.append((str(e.op), e.level))
            else:
                tree.append((str(e.root), e.level))
        return tuple(tree), tuple(expand_addrs)

    def convert(self, tree_info: tuple[tuple[tuple[str, int], ...],
    tuple[tuple[Operand, Addr], ...]],
                with_addr: bool = False) -> str:
        """Generate the expression of the tree.

        If with_addr is true, the step will also add the expand information 
        at the current level.
        """
        d: dict[int, list[str]] = dict()
        tree, expand_info = tree_info
        if len(tree) == 1:
            return str(tree[0][0])
        for s, l in tree:
            if l + 1 in d:
                if l not in d:
                    d[l] = ["%s(%s)" % (s, ", ".join(d[l + 1]))]
                else:
                    d[l].append("%s(%s)" % (s, ", ".join(d[l + 1])))
                del d[l + 1]
            else:
                if l in d:
                    d[l].append(str(s))
                else:
                    d[l] = [str(s)]
        assert len(d[tree[-1][1]]) == 1, str(tree_info)
        step = d[tree[-1][1]][0]
        if with_addr:
            s = "\t# %s" % "; ".join("expand {} at {}"
                                     .format(str(r), str(addr)) for r, addr in expand_info)
            return "{:<30} {}".format(step, s)
        else:
            return step

    def pprint(self, with_addr: bool = True) -> str:
        """Print the process of register expansion."""
        steps = [self.convert(self.gen_step(i), with_addr=with_addr)
                 for i in range(self.level, self.depth)]
        if self.addr is not None and with_addr:
            s = "{:<7} = {}{:>44} {} at {}\n".format(str(self.root), steps[0], "# expand",
                                                     str(self.root), str(self.addr))
        else:
            s = "{:<7} = {}\n".format(str(self.root), steps[0])
        for step in steps[1:-1]:
            s += "        = {}\n".format(step)
        if len(steps) > 1 and with_addr:
            s += "        = {}finished".format(steps[-1])
        else:
            s += "        = {}".format(steps[-1])
        return s

    def get_vars(self) -> tuple[Reg, ...]:
        def rec(n: OpNode) -> tuple[Reg, ...]:
            if isinstance(n.root, Reg) and not n.children:
                return tuple([n.root])
            else:
                return tuple([k for child in n.children for k in rec(child)])

        return rec(self)

    def leaves(self) -> tuple[OpNode, ...]:
        """Return the leaves."""
        if not self.children:
            return (OpNode(self.root, self.prevs, self.loc, tuple(),
                           self.level, self.op, self.addr),)
        return tuple([leaf for child in self.children
                      for leaf in child.leaves()])

    def subst_leaf(self, m: Operand, r: Operand) -> OpNode:
        """Replace a memory reference in the leaf to a register."""
        if not self.children:
            if self.root == m:
                return OpNode(r, self.prevs, self.loc, tuple(),
                              self.level, self.op, self.addr)
            else:
                return self
        else:
            children = [child.subst_leaf(m, r) for child in self.children]
            return OpNode(self.root,
                          self.prevs,
                          self.loc,
                          tuple(children),
                          self.level,
                          self.op,
                          self.addr)

    def subst(self, m: Operand, r: OpNode) -> OpNode:
        if not self.children:
            if self.root == m:
                return r
            else:
                return self
        else:
            children = [child.subst(m, r) for child in self.children]
            assert len(children) <= 2
            return OpNode(self.root,
                          self.prevs,
                          self.loc,
                          tuple(children),
                          self.level,
                          self.op,
                          self.addr)

    def norm_level(self, level=0) -> OpNode:
        children = [child.norm_level(level + 1) for child in self.children]
        return OpNode(self.root, self.prevs, self.loc, children=tuple(children), level=level,
                      op=self.op, addr=self.addr)

    def is_const(self) -> bool:
        return all(isinstance(node.root, (ConstVal, HexVal)) for node in self.leaves())


class CondOpNode(OpNode):
    def __init__(self, root: Operand,
                 prevs: tuple[Instruction, ...],
                 loc: Addr,
                 children: tuple[CondOpNode, ...] = tuple(),
                 level: int = 0,
                 op: str | None = None,
                 addr: Addr | None = None,
                 is_neg: bool = False) -> None:
        super().__init__(root, prevs, loc, children, level, op, addr)
        self.is_neg = is_neg

    def __hash__(self) -> int:
        return hash(("CondOpNode", self.root, self.prevs,
                     self.children, self.level, self.op, self.addr, self.is_neg))

    def expand(self) -> CondOpNode:
        """ The expanding of conditional register is defined as
        only unfolding CMPGT, MVK, MV instructions. """
        for i, inst in enumerate(self.prevs):
            dst = parse_operand(inst.dst)
            if self.root == dst:
                if inst.name not in cond_expand_inst_names:
                    return self
                self.op = inst.name
                self.addr = inst.addr
                j = i + 1
                if inst.is_par:
                    while j < len(self.prevs) and self.prevs[j].is_par:
                        j += 1
                    j += 1
                child_prevs = tuple([prev_inst for prev_inst in self.prevs[j:]])
                children = []
                for src in inst.src_operands:
                    child_root = parse_operand(src)
                    child_node = CondOpNode(child_root, child_prevs, inst.addr, level=self.level + 1,
                                            is_neg=self.is_neg)
                    children.append(child_node.expand())
                return CondOpNode(self.root, self.prevs, self.loc,
                                  children=tuple(children),
                                  level=self.level,
                                  op=self.op,
                                  addr=self.addr,
                                  is_neg=self.is_neg)
        return self

    def expand_info(self) -> dict[Var, Addr]:
        """Return the address of each register in the leaves."""
        leaves = self.leaves()
        d = {leaf.root: leaf.loc for leaf in leaves
             if isinstance(leaf.root, (Reg, MemRef))}
        if len(d) == 0:
            assert isinstance(self.root, Reg | MemRef)
            return {self.root: self.loc}
        else:
            return d


def check_square_mat(m: Mat) -> bool:
    """ Check if the number of rows equals to the number of columns. """
    row_num = len(m)
    return all(len(col) == row_num for col in m)


def transpose(m: Mat) -> Mat:
    """Return the transposition of the given matrix"""
    if not m:
        return tuple()
    col_num = len(m[0])
    return tuple([tuple([row[i] for row in m]) for i in range(col_num)])


def collect_coeff(p: z3.ExprRef) -> tuple[tuple[int, str], ...]:
    """Given a linear z3 expression, return the pair of (coeff, var)."""
    if z3.is_add(p):
        return collect_coeff(p.arg(0)) + collect_coeff(p.arg(1))
    elif z3.is_mul(p):
        return ((p.arg(0).as_long(), str(p.arg(1))),)
    elif z3.is_int(p):
        return ((1, str(p)),)
    else:
        raise NotImplementedError


def dot_product(v1: tuple, v2: tuple):
    assert len(v1) == len(v2)
    vec = [i * j for i, j in zip(v1, v2)]
    return sum(vec[1:], vec[0])


class RankFinder:
    """ Build rank function on the given sequences of transition relations. """

    def __init__(self, cond: CondOpNode, update: tuple[OpNode, ...]) -> None:
        self.cond = cond
        self.is_neg_cond = self.cond.is_neg
        self.update = update
        self.names: dict[str, str] = dict()

    def convert_to_z3_expr(self, op: str,
                           operands: list[z3.ExprRef]
                           ) -> z3.ExprRef | z3.BoolRef:
        """Return the corresponding z3 expression 
        on the given opcode and operands."""
        if op in ("MV", "LDW", "STW", "MVK", "LDHU", "STH", "LDH"):
            assert len(operands) == 1
            return operands[0]
        elif op == "ADD":
            assert len(operands) == 2
            return operands[0] + operands[1]
        elif op == "SUB":
            assert len(operands) == 2
            return operands[0] - operands[1]
        elif op in ("CMPGT", "CMPGTU"):
            assert len(operands) == 2
            if self.is_neg_cond:
                return operands[0] - operands[1] <= 0
            else:
                return operands[1] - operands[0] + 1 <= 0
        elif op in ("CMPLT", "CMPLTU"):
            assert len(operands) == 2
            if self.is_neg_cond:
                return operands[1] - operands[0] <= 0
            else:
                return operands[0] - operands[1] + 1 <= 0
        else:
            raise NotImplementedError(op)

    def translate(self, m: OpNode) -> z3.ExprRef | z3.BoolRef:
        """Translate the given opnode to a z3 expression."""
        depth = m.depth
        tree_info, _ = m.gen_step(depth)
        d: dict[int, list[z3.ExprRef]] = dict()
        for s, level in tree_info:
            if level + 1 in d:
                if level not in d:
                    d[level] = [self.convert_to_z3_expr(s, d[level + 1])]
                else:
                    d[level].append(self.convert_to_z3_expr(s, d[level + 1]))
                del d[level + 1]
            else:
                e: z3.ExprRef
                if is_ref(s) or is_reg(s):
                    if s not in self.names:
                        self.names[s] = z3.Int("v_%s" % len(self.names))
                    e = self.names[s]
                elif s.startswith("0x"):
                    e = z3.IntVal(int(s, 16))
                elif s.isdigit() or s.lstrip('-').isdigit():
                    e = z3.IntVal(int(s))
                else:
                    raise NotImplementedError
                if level not in d:
                    d[level] = [e]
                else:
                    d[level].append(e)
        assert len(d[0]) == 1
        return z3.simplify(d[0][0], arith_ineq_lhs=True)

    def translate_cond(self) -> z3.BoolRef | z3.ArithRef:
        """Build the z3 expression for the loop condition."""
        cond_expr = self.translate(self.cond)
        if self.cond.is_compare:
            if z3.is_le(cond_expr):
                return cond_expr
            elif z3.is_ge(cond_expr):
                lhs, rhs = cond_expr.arg(0), cond_expr.arg(1)
                if z3.is_int(lhs) and z3.is_int_value(rhs):  # x >= 0
                    return (-1) * lhs <= -rhs.as_long()
                else:
                    raise NotImplementedError(cond_expr)
            return cond_expr
        elif z3.is_int_value(cond_expr) or z3.is_true(cond_expr) or z3.is_false(cond_expr):
            return cond_expr
        else:
            return -1 * cond_expr <= -1

    def translate_update(self, m: OpNode) -> z3.ExprRef:
        """Build the z3 expression for an update."""
        if str(m.root) not in self.names:
            self.names[str(m.root)] = z3.Int("v_%s" % len(self.names))
        update_var = z3.Int("%s'" % self.names[str(m.root)])
        update_expr = self.translate(m=m)
        return update_var == update_expr

    def gen_update_ineq(self, update: z3.BoolRef,
                        cond: z3.BoolRef) -> z3.BoolRef:
        """Generate the update linear inequality for variable v_k"""
        assert z3.is_eq(update)
        assert z3.is_le(cond)
        d_cond = {c: v for v, c in collect_coeff(cond.arg(0))}
        update_cv_pair = collect_coeff(update.arg(1))
        d_update = {v: c for c, v in update_cv_pair}
        if not z3.is_int_value(update.arg(0)):
            var = str(update.arg(0))[:-1]
            if var not in d_cond or d_cond[var] == 0:
                warnings.warn("can't find %s in the loop condition %s" % (var, cond))
            if var not in d_update or d_update[var] == 0:
                warnings.warn("can't find %s in the update expression %s" % (var, update))
            if var in d_cond and d_cond[var] > 0:
                # The variable is increasing in the update.
                return z3.simplify(update.arg(1) - update.arg(0) <= 0)
            else:
                return z3.simplify(update.arg(0) - update.arg(1) <= 0)
        else:
            raise NotImplementedError(update)

    def gen_lasw_row(self, e: z3.BoolRef) -> \
            tuple[tuple[int, ...], tuple[int, ...], int]:
        """Given an inequality, return the corresponding row in AA' <= b."""
        var_num = len(self.names)
        assert z3.is_le(e)
        lhs, rhs = e.arg(0), e.arg(1)
        assert z3.is_int_value(rhs)
        l = collect_coeff(lhs)  # store the (coeff, var) pairs
        d: dict[int, int] = dict()
        for c, v in l:
            if not v.endswith("'"):
                i = int(v[2:])
            else:
                i = var_num + int(v[2:-1])
            d[i] = c

        A = []
        for i in range(2 * var_num):
            if i in d:
                A.append(d[i])
            else:
                A.append(0)
        A1, A2 = A[:var_num], A[var_num:]
        assert len(A1) == len(A2)
        return tuple(A1), tuple(A2), rhs.as_long()

    def gen_lasw_mat(self) -> tuple[Mat, Mat, Col]:
        """Generate the LASW matrix AA' ≤ b."""
        A1, A2, b_vec = [], [], []
        ineqs = []
        cond_expr = self.translate_cond()
        if not z3.is_int_value(cond_expr) and not z3.is_true(cond_expr):
            ineqs.append(cond_expr)
        for u in self.update:
            ineqs.append(self.gen_update_ineq(self.translate_update(u), cond_expr))
        for ineq in ineqs:
            a1, a2, b = self.gen_lasw_row(ineq)
            A1.append(a1);
            A2.append(a2);
            b_vec.append(b)
        return tuple(A1), tuple(A2), tuple(b_vec)

    def check_system(self, A1: Mat, A2: Mat, b_vec: Col) -> bool:
        """Check if there exists x' satisfies the system:
            AA'⋅[x,x']^T ≤ b
        """
        assert A1 and A2 and b_vec
        assert len(A1) == len(A2) == len(b_vec)
        assert isinstance(A1[0], tuple)
        var_num = len(A1[0])
        x_vec = z3.Ints(" ".join("x_%s" % i for i in range(var_num)))
        update_x_vec = z3.Ints(" ".join("x_%s'" % i for i in range(var_num)))
        s = z3.Solver()
        for row1, row2, b in zip(A1, A2, b_vec):
            s.add(dot_product(row1, x_vec) + dot_product(row2, update_x_vec) <= b)
        return str(s.check()) == "sat"

    def gen_rank_fun(self, debug: bool = False) -> tuple[z3.ExprRef, int, int]:
        """ Return the ranking function, derivative and lower bound of
        the given LASW (linear arithmetic simple while) program. """
        A1, A2, b_vec = self.gen_lasw_mat()
        assert A1 and A2 and b_vec
        assert len(A1[0]) == len(self.names)
        A1_tran, A2_tran = transpose(A1), transpose(A2)
        n = len(b_vec)

        l1 = z3.Ints(' '.join('p_%s' % i for i in range(n)))
        l2 = z3.Ints(' '.join('q_%s' % i for i in range(n)))
        solver = z3.Solver()
        for p_i, q_i in zip(l1, l2):
            solver.add(p_i >= 0, q_i >= 0)
        for row in A2_tran:
            solver.add(dot_product(row, l1) == 0)
        for row in A1_tran:
            solver.add(dot_product(tuple([p_i - q_i
                                          for p_i, q_i in zip(l1, l2)]), row) == 0)
        for row1, row2 in zip(A1_tran, A2_tran):
            solver.add(dot_product(tuple([r1 + r2
                                          for r1, r2 in zip(row1, row2)]), l2) == 0)
        solver.add(dot_product(l2, b_vec) < 0)

        res = solver.check()
        if str(res) == "unsat":
            if debug:
                print("Can't prove termination for cond\n")
                print(self.cond.pprint(with_addr=True))
                for update in self.update:
                    print(update.pprint(with_addr=True))
            raise RankFinderException(A1, A2, b_vec)
        model = solver.model()

        l1_m = tuple([model[p] for p in l1])
        l2_m = tuple([model[q] for q in l2])

        assert self.check_system(A1, A2, b_vec)

        r = tuple([dot_product(l2_m, row) for row in A2_tran])
        vars = tuple(z3.Ints(' '.join('v_%s' % i for i in range(len(r)))))
        rf = z3.simplify(dot_product(vars, r))
        delta_0 = z3.simplify(-dot_product(l1_m, b_vec)).as_long()
        delta = z3.simplify(-dot_product(l2_m, b_vec))

        assert delta.as_long() > 0

        if debug:
            print("A1", A1)
            print("A2", A2)
            print("b_vec", b_vec)
            print("model", model)
            print("ranking function =", rf)
            print("lower bound δ_0 =", delta_0)
            print("derivative δ =", delta)

        return rf, delta_0, delta

    def dump_lasw(self) -> None:
        """Generate the lasw program."""
        print("Information about lasw")
        cond = self.translate_cond()
        print("condition")
        print(cond)
        print()
        print("updates")
        for u in self.update:
            update = self.translate_update(u)
            print(update)
            print(self.gen_update_ineq(update, cond))
            print()


def refine_code(insts: tuple[Instruction, ...]) -> tuple[Instruction, ...]:
    """Delete the code which are not useful in register 
    expansion and split the non-atomic instructions"""
    r = []
    for inst in insts:
        if inst.is_fp_head:
            continue
        elif inst.is_branch:
            continue
        elif inst.is_nop:
            continue
        elif inst.change_addr_reg():
            inst1, inst2 = split_mem_inst(inst)
            r.append(inst1)
            r.append(inst2)
        else:
            r.append(inst)
    return tuple(r)


def find_loop_insts(insts: tuple[Instruction, ...],
                    addr: Addr) -> tuple[Instruction, ...]:
    """Given a sequence of loop instructions and an address addr, 
    return instructions which are executed before the instruction on addr 
    in the loop."""
    before, after = [], []
    for i, inst in enumerate(insts):
        before.append(inst)
        if inst.addr == addr:
            while before[-1].is_par:
                after.append(before.pop())
            break

    after += list(insts[i + 1:])
    exec_inst = tuple(reversed(after + before))
    return refine_code(exec_inst)


ID = int
Path = tuple[ID, ...]


class LoopAnalysis:
    """Analyze the loop bound through the algorithm proposed in 
            `A Complete Method for the Synthesis of Linear Ranking Functions`.
    """

    def __init__(self, lp: Loop) -> None:
        self.lp = lp
        self.nodes: dict[tuple[int, ...], tuple[TCFGNode, ...]] = dict()

    def enumerate_path_rec(self) -> tuple[Path, ...]:
        """Recursively depth-first traversal version of enumerating loop paths."""

        def rec(node: TCFGNode) -> \
                tuple[tuple[int, ...], ...]:
            nid = node.nid
            path: tuple[tuple[int, ...], ...] = tuple()
            tail = self.lp.tail
            if tail is not None and nid == tail.nid:
                return tuple([(nid,)])
            nid = node.nid
            for edge in node.out_edges:
                if edge.is_back_edge() or edge.is_never_taken() or edge in self.lp.exit_edges:
                    continue
                dst = edge.dst
                dst_paths = rec(dst)
                new_paths = tuple([(nid,) + dst_path for dst_path in dst_paths])
                path += new_paths
            return tuple(path)

        return rec(self.lp.head)

    def enumerate_path(self) -> tuple[Path, ...]:
        """Iteratively depth-first traversal version of enumerating loop paths."""
        assert self.lp.tail is not None, "tail does not exist"
        tail_id = self.lp.tail.nid
        path: list[Path] = []
        worklist: deque[tuple[TCFGNode, Path]] = \
            deque([(self.lp.head, (self.lp.head.nid,))])
        while worklist:
            node, cur_path = worklist.pop()
            if node.nid == tail_id:
                path.append(cur_path)
                continue
            for edge in node.out_edges:
                if edge.is_back_edge() or edge.is_never_taken \
                        or edge in self.lp.exit_edges:
                    continue
                dst = edge.dst
                worklist.append((dst, cur_path + (dst.nid,)))
        return tuple(path)

    def path_node(self, path: tuple[int, ...]) -> tuple[TCFGNode, ...]:
        assert path and path[0] == self.lp.head.nid
        if path in self.nodes:
            return self.nodes[path]
        nodes = [self.lp.head]
        cur_node = self.lp.head
        k = 1
        while k < len(path):
            for edge in cur_node.out_edges:
                if edge.dst.nid == path[k]:
                    nodes.append(edge.dst)
                    cur_node = edge.dst
                    k += 1
                    break
        self.nodes[path] = tuple(nodes)
        return self.nodes[path]

    def path_insts(self, path: Path) -> tuple[Instruction, ...]:
        """Return the instructions in the given path"""
        nodes = self.path_node(path)
        return tuple(inst for node in nodes for inst in node.bb.code)

    def find_loop_cond(self, path: Path, debug: bool = False
                       ) -> tuple[CondOpNode, ...]:
        """ Given a loop path, return all of the conditions. """
        if debug:
            print("Start handling loop conditions")
        nodes = self.path_node(path)
        insts = tuple([inst for node in nodes for inst in node.bb.code])
        assert len(insts) > 0
        cond_nodes = []
        cond_insts = []
        for node in nodes:
            if node.nid in self.lp.exit_nodes:
                for inst in reversed(node.bb.code):
                    if inst.is_branch and inst.is_cond:
                        if debug:
                            print("Find loop exit condition: %s" % inst)
                        cond_insts.append(inst)
                        break

        def check_in_loop(addr: Addr) -> bool:
            for node in nodes:
                if node.start_addr == addr:
                    return True
            return False

        assert cond_insts, "can't find the condition of loop"

        for loop_cond_branch in cond_insts:
            preds = []
            for inst in insts:
                preds.append(inst)
                if inst.addr == loop_cond_branch.addr:
                    break
            pred_insts = tuple(reversed(refine_code(tuple(preds))))

            while pred_insts and pred_insts[0].is_par:
                pred_insts = pred_insts[1:]
                if pred_insts and not pred_insts[0].is_par:
                    pred_insts = pred_insts[1:]

            target = loop_cond_branch.get_dtarget()
            cond = Cond(loop_cond_branch.cond)
            if not check_in_loop(target):
                cond.is_neg = not cond.is_neg
            loop_cond = CondOpNode(cond.reg, pred_insts, loop_cond_branch.addr, is_neg=cond.is_neg).expand()
            if debug:
                print(loop_cond.pprint(with_addr=True))
                print()
            cond_nodes.append(loop_cond)

        return tuple(cond_nodes)

    def find_mem_val(self, root: Reg, insts: tuple[Instruction, ...], m: MemRef
                     ) -> Reg:
        """
        Find the register whose value is stored in the given 
        memory reference m after executing the code in path and equals to root.
        """
        for inst in insts:
            if inst.name == "STW":
                src = parse_operand(inst.operands[0])
                dst = parse_operand(inst.operands[1])
                if dst == m:
                    if src == root:
                        assert isinstance(src, Reg)
                        return src
                    else:
                        break
            elif inst.name in ("LDW", "LDHU"):  # LDW MEM REG
                src = parse_operand(inst.operands[0])
                dst = parse_operand(inst.operands[1])
                if src == m and dst == root:
                    return Reg(inst.dst)
            elif len(inst.operands) > 0:
                dst = parse_operand(inst.dst)
                if dst == root:
                    break

        raise NotImplementedError

    def find_loop_relation(self, path: Path,
                           loop_cond: CondOpNode,
                           debug: bool = False) -> tuple[OpNode, ...]:
        """Given a loop path and a condition, return the update statement for 
        each register appearing in the loop condition.
        """
        if debug:
            print("Start finding loop relations")
        insts = self.path_insts(path)
        trans: dict[Var, OpNode] = dict()
        leaves_info = loop_cond.expand_info()

        worklist: deque[tuple[Var, Addr]] \
            = deque([(var, addr) for var, addr in leaves_info.items()])

        cond_vars = leaves_info.keys()
        if debug:
            print("Variable appearing in the conditions: %s" % (", ".join(str(k) for k in cond_vars)))
        while worklist:
            var, addr = worklist.pop()
            op_node = OpNode(var, find_loop_insts(insts, addr), addr).expand()
            if debug:
                print("Process %s at %s" % (var, addr))
                print("Initial expansion")
                print(op_node.pprint())
                print()
            leaves = [leaf for leaf in op_node.leaves() if isinstance(leaf.root, MemRef | Reg)]
            leaves_ops = [leaf.root for leaf in leaves]
            if var in leaves_ops:
                if debug:
                    print("Variable %s already found in RHS" % var)
                trans[var] = op_node
            else:
                for leaf in leaves:
                    if isinstance(leaf.root, MemRef):
                        try:
                            assert isinstance(op_node.root, Reg)
                            reg = self.find_mem_val(op_node.root, op_node.prevs, leaf.root)
                        except NotImplementedError:
                            continue
                        op_node = op_node.subst_leaf(leaf.root, reg)
                        if debug:
                            print("Substitute %s by %s" % (leaf.root, reg))
                            print(op_node.pprint())
                            print()
                trans[var] = op_node
            leaves = [leaf for leaf in op_node.leaves() if isinstance(leaf.root, MemRef | Reg)]
            leaves_ops = [leaf.root for leaf in leaves]
            for leaf in leaves:
                if leaf.root not in cond_vars and leaf.root not in trans:
                    assert isinstance(leaf.root, MemRef | Reg)
                    worklist.appendleft((leaf.root, op_node.loc))
                    if debug:
                        print("Add %s at %s to worklist" % (leaf.root, op_node.loc))

        return tuple(trans[i] for i in trans)

    def gen_rank_arguments(self, path: Path, debug: bool = False) \
            -> tuple[tuple[z3.ExprRef, int, int], ...]:
        """Given a loop path, return all the possible triple 
        (ranking functions, lower bound, derivative)."""

        rank_args = []
        conds = self.find_loop_cond(path, debug=debug)
        for cond in conds:
            if debug:
                print("Process\n%s" % cond.pprint(with_addr=True))
            trans = self.find_loop_relation(path, cond, debug=debug)
            rf = RankFinder(cond, trans)
            cond_expr = rf.translate_cond()
            if z3.is_int_value(cond_expr) or z3.is_true(cond_expr) or z3.is_false(cond_expr):
                if debug:
                    print("%s is not a symbolic condition" % cond_expr)
                continue
            assert isinstance(cond_expr, z3.ExprRef)
            try:
                rank_args.append(rf.gen_rank_fun(debug=debug))
            except RankFinderException as e:
                if debug:
                    print("Can't prove termination when condition is\n%s" % cond.pprint())
                    print(e)
        return tuple(rank_args)
