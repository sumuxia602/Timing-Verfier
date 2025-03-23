from sample.frontend.loops import LoopHrchy, Loop
from sample.frontend.cfg import TCFGNode, TCFGEdge, TCFGEdgeKind
from sample.frontend.isa import Instruction, Operand, Reg, MemRef, ConstVal, HexVal, RegPair, gp_reg_names, Cond
from sample.ilp.ilp import LPSolve
from typing import List, Set, Tuple, Dict, Optional
import z3
import time

class InfPathException(Exception):
    def __init__(self, err_msg: str) -> None:
        self.err_msg = err_msg

    def __str__(self) -> str:
        return self.err_msg

class SMTModel:
    """ representation of an SMT model """
    def __init__(self) -> None:
        self._solver = z3.Solver()
        self.props: List[z3.Bool] = []
        self.prop_to_cons: Dict[z3.Bool, z3.BoolRef] = dict()
        self._index = 0
    
    def add_cons(self, cons: z3.BoolRef) -> None:
        p = z3.Bool("p%i" % self._index)
        self._index += 1
        self.props.append(p)
        self.prop_to_cons[p] = cons
        self._solver.add(z3.Implies(p, cons))
    
    def solve(self) -> List[z3.BoolRef]|None:
        res = self._solver.check(self.props)
        if res == z3.sat:
            return None
        elif res == z3.unsat:
            return [self.prop_to_cons[p] for p in self._solver.unsat_core()]
        elif res == z3.unknown:
            raise InfPathException('z3.check failed')
        else:
            raise InfPathException('unknown z3.check result')

    def Print(self):
        print(self._solver)

def parse_operand(s: str) -> Operand:
    if s.isdigit() or s.lstrip('-').isdigit():
        return ConstVal(int(s))
    elif s.startswith('0x'):
        return HexVal(s)
    elif s.startswith("*"):
        return MemRef(s)
    elif s in gp_reg_names:
        return Reg(s)
    elif s.endswith('b'):
        return ConstVal(int(s[:-1], 2))
    elif s.endswith(')'):
        return HexVal(s[-11:-1])
    elif len(s.split(':')) == 2 and s.split(':')[0] in gp_reg_names and s.split(":")[1] in gp_reg_names:
        return RegPair(*s.split(':'))
    else:
        raise NotImplementedError(s)

class InfPath:
    """ generate a series of SMTModel to check satisfiability of a wcet path """
    """ TODO: sliding window, associate first iteration and above && last iteration and behind """

    def __init__(self, loophrchy: LoopHrchy, lp_file: str) -> None:
        self._lp_file = lp_file
        self._tcfg_nodes: Tuple[TCFGNode, ...] = tuple(loophrchy.tcfg_nodes)
        self._loop_map: Dict[int, Loop] = loophrchy.loop_map
        self._loops: Dict[int, Loop] = loophrchy.loops
        self._cons_map: Dict[str, Tuple(TCFGEdge, List[Tuple(int, Optional[Instruction])])] = dict()
        # mapping from a constraint of an SMT model to the corresponding edge and trace of all reg

        self._smt: List[SMTModel] = []

        self._trace: Dict[Operand, List[Tuple(int, Instruction | None)]] = dict()
        # mapping from register to its current assign-use trace. used in debug

        for reg_name in gp_reg_names:
            self._trace[Reg(reg_name)] = []

        lp_solve = LPSolve(lp_file)
        lp_solve.solve()
        assert(lp_solve.is_bound)
        self._vars: Dict[str, int]= lp_solve.vars
    
    def reset(self, op: Operand, operand_state: Dict[Operand, z3.ExprRef], reg_index:Dict[Reg, int]) -> None:
        if not op in operand_state.keys():
            return
        if not op.is_reg:
            operand_state.pop(op)
            self._trace.pop(op)
            return
        operand_state[op] = z3.Int("%s_%i" % (op.name, reg_index[op]))
        reg_index[op] += 1
        self._trace[op] = []
        return

    def update_state(self, bb: TCFGNode, operand_state: Dict[Operand, z3.ExprRef], reg_index:Dict[Reg, int], path:List[TCFGNode]) -> None:
        """ update operand state by symbolic executing code of a tcdgnode. """
        code = bb.bb.code
        for i in range(len(code)):
            inst = code[i]
            if inst.is_cond_jump:
                idx = path.index(bb)
                outedge = [edge for edge in bb.out_edges if edge.dst == path[idx+1]][0]
                cons, trace = self.gen_cons(inst, operand_state, outedge)
                self._smt[-1].add_cons(cons)
                # print(outedge, cons, operand_state)
                if cons not in self._cons_map:
                    self._cons_map[cons] = (outedge, trace)
                continue
            if inst.name in (".fphead", "MVC") or inst.is_branch or inst.name.startswith("SP"):
                continue
            elif len(inst.operands) == 0:
                continue
            
            last_operand = parse_operand(inst.operands[-1])
            
            # handle conditional inst
            if inst.is_cond:
                cond = Cond(inst._cond)
                if not z3.is_int_value(z3.simplify(operand_state[cond.reg])):
                    self.reset(last_operand, operand_state, reg_index)
                    continue
                if (not cond.is_neg) and (z3.simplify(operand_state[cond.reg]) == 0)\
                    or cond.is_neg and (not (z3.simplify(operand_state[cond.reg]) == 0)):
                    continue
            
            # symbolic execution
            if inst.name == 'MVK':
                op = inst.operands[0]
                if op.startswith("0x"):
                    op = z3.IntVal(int(op, 16))
                elif op.isdigit() or op.lstrip('-').isdigit():
                    op = z3.IntVal(int(op))
                operand_state[last_operand] = op
                self._trace[last_operand] = [(bb.nid, inst)]
            elif inst.name == 'MV':
                if not inst.operands[0] in operand_state.keys():
                    self.reset(last_operand, operand_state, reg_index)
                    continue
                op = parse_operand(inst.operands[0])
                operand_state[last_operand] = operand_state[op]
                self._trace[last_operand] = self._trace[op] + [(bb.nid, inst)]
            elif inst.name == 'ADD':
                trace = []
                op1 = parse_operand(inst.operands[0])
                if op1.is_hex:
                    op1 = z3.IntVal(int(op1.hval, 16))
                elif op1.is_const:
                    op1 = z3.IntVal(int(op1.val))
                elif op1 in operand_state.keys():
                    trace += self._trace[op1]
                    op1 = operand_state[op1]
                else:
                    self.reset(last_operand, operand_state, reg_index)
                    continue
                op2 = parse_operand(inst.operands[1])
                if op2.is_hex:
                    op2 = z3.IntVal(int(op2.hval, 16))
                elif op2.is_const:
                    op2 = z3.IntVal(int(op2.val))
                elif op2 in operand_state.keys():
                    trace += self._trace[op2]
                    op2 = operand_state[op2]
                else:
                    self.reset(last_operand, operand_state, reg_index)
                    continue
                operand_state[last_operand] = z3.simplify(op1 + op2)
                self._trace[last_operand] = trace + [(bb.nid, inst)]
            elif inst.name == 'ADDK':
                op = parse_operand(inst.operands[0])
                if op.is_hex:
                    op = z3.IntVal(int(op.hval, 16))
                elif op.is_const:
                    op = z3.IntVal(int(op.val))
                operand_state[last_operand] = z3.simplify(operand_state[last_operand] + op)
                self._trace[last_operand] = self._trace[last_operand] + [(bb.nid, inst)]
            elif inst.name == 'SUB':
                trace = []
                op1 = parse_operand(inst.operands[0])
                if op1.is_hex:
                    op1 = z3.IntVal(int(op1.hval, 16))
                elif op1.is_const:
                    op1 = z3.IntVal(int(op1.val))
                elif op1 in operand_state.keys():
                    trace += self._trace[op1]
                    op1 = operand_state[op1]
                else:
                    self.reset(last_operand, operand_state, reg_index)
                    continue
                op2 = parse_operand(inst.operands[1])
                if op2.is_hex:
                    op2 = z3.IntVal(int(op2.hval, 16))
                elif op2.is_const:
                    op2 = z3.IntVal(int(op2.val))
                elif op2 in operand_state.keys():
                    trace += self._trace[op2]
                    op2 = operand_state[op2]
                else:
                    self.reset(last_operand, operand_state, reg_index)
                    continue
                operand_state[last_operand] = z3.simplify(op1 - op2)
                self._trace[last_operand] = trace + [(bb.nid, inst)]
            elif inst.name in ("LDW", "LDH", "LDHU", "LDBU"):
                op = parse_operand(inst.operands[0])
                assert isinstance(op, MemRef)
                
                # case: addr never met, reset reg
                if not op in operand_state.keys():
                    self.reset(last_operand, operand_state, reg_index)
                    continue
                
                # case: addr met but modified
                if op.is_reg_change:
                    # modify addr before load, reset reg
                    if op.is_pre:
                        self.reset(last_operand, operand_state, reg_index)
                    else:
                        operand_state[last_operand] = operand_state[op]
                        self._trace[last_operand] = self._trace[op] + [(bb.nid, inst)]
                    
                    # since addr is modified, always reset addr state
                    self.reset(op, operand_state, reg_index)
                    continue

                # case: addr met and not modified
                operand_state[last_operand] = operand_state[op]
                self._trace[last_operand] = self._trace[op] + [(bb.nid, inst)]
            elif inst.name in ("STW", "STH", "STB"):
                assert isinstance(last_operand, MemRef)
                op = parse_operand(inst.operands[0])
                if not op in operand_state.keys() or last_operand.is_reg_change:
                    self.reset(last_operand, operand_state, reg_index)
                    continue
                operand_state[last_operand] = operand_state[op]
                self._trace[last_operand] = self._trace[op] + [(bb.nid, inst)]
            elif inst.name in ('CMPEQ', 'CMPLT', 'CMPGT', 'CMPLTU', 'CMPGTU'):
                trace = []
                op1 = parse_operand(inst.operands[0])
                if op1.is_hex:
                    op1 = z3.IntVal(int(op1.hval, 16))
                elif op1.is_const:
                    op1 = z3.IntVal(int(op1.val))
                elif op1 in operand_state.keys():
                    trace += self._trace[op1]
                    op1 = operand_state[op1]
                else:
                    self.reset(last_operand, operand_state, reg_index)
                    continue
                op2 = parse_operand(inst.operands[1])
                if op2.is_hex:
                    op2 = z3.IntVal(int(op2.hval, 16))
                elif op2.is_const:
                    op2 = z3.IntVal(int(op2.val))
                elif op2 in operand_state.keys():
                    trace += self._trace[op2]
                    op2 = operand_state[op2]
                else:
                    self.reset(last_operand, operand_state, reg_index)
                    continue
                op = inst.name[3:5]
                if op == 'EQ':
                    operand_state[last_operand] = z3.simplify(op1 == op2)
                elif op == 'LT':
                    operand_state[last_operand] = z3.simplify(op1 < op2)
                else:
                    operand_state[last_operand] = z3.simplify(op1 > op2)
                self._trace[last_operand] = trace + [(bb.nid, inst)]

            else:
                if last_operand in operand_state.keys():
                    self.reset(last_operand, operand_state, reg_index)

        # if nothing happens to the operand, add bb.nid to its trace for debug
        for reg, trace in self._trace.items():
            if trace != [] and trace[-1][0] != bb.nid:
                self._trace[reg] += [(bb.nid, None)]


    def gen_cons(self, last_inst: Instruction, operand_state: Dict[Operand, z3.ExprRef], edge: TCFGEdge)\
                    -> Tuple[z3.BoolRef, List[Tuple[int, Instruction|None]]]:
        """ generate constraint of a cond jump. return inequality and trace """
        assert not edge.edge_kind in [TCFGEdgeKind.CALL, TCFGEdgeKind.RET, TCFGEdgeKind.NEVER_TAKEN]

        cond = Cond(last_inst.cond)
        neg = cond.is_neg
        reg = cond.reg
        if edge.edge_kind == TCFGEdgeKind.NOT_TAKEN:
            neg = 1 - neg
        
        if neg:
            if isinstance(operand_state[cond.reg], z3.BoolRef):
                return z3.simplify(z3.Not(operand_state[cond.reg])), self._trace[cond.reg]
            else:
                return z3.simplify(operand_state[cond.reg] == 0), self._trace[cond.reg]
        else:
            if isinstance(operand_state[cond.reg], z3.BoolRef):
                return z3.simplify(operand_state[cond.reg]), self._trace[cond.reg]
            else:
                return z3.simplify(operand_state[cond.reg] != 0), self._trace[cond.reg]

    def gen_smt_single_path(self, loop: Loop, path: List[TCFGNode]) -> None:
        """
        dfs the whole loop to collect all the branch condition

        operand_state mapping from register name to its value
        reg_ssa mapping from reg_name to tuple of (its ssa index, used(bool))
        bb is node we are currently traversing
        """
        operand_state: Dict[Operand, z3.ExprRef] = dict()
        reg_index:Dict[Reg, int] = dict()
        for reg_name in gp_reg_names:
            operand_state[Reg(reg_name)] = z3.Int("%s_0" % reg_name)
            reg_index[Reg(reg_name)] = 1

        self._smt.append(SMTModel())

        i = 0
        while i < len(path):
            # consider inner loop as black box
            # use bool flag to reset all operands only once
            flag = False
            while i<len(path) and self._loop_map[path[i].nid].lid != loop.lid:
                i += 1
                flag = True
            if i >= len(path)-1:
                break
            if flag:
                operand_state = dict()
                self._trace = dict()
                for reg_name in gp_reg_names:
                    reg = Reg(reg_name)
                    operand_state[reg] = z3.Int("%s_%i" % (reg_name, reg_index[reg]))
                    reg_index[reg] += 1
                    self._trace[reg] = []
            
            node = path[i]

            self.update_state(node, operand_state, reg_index, path)
            
            i += 1
        
    
    def dfs_collect_paths(self, loop: Loop, node: TCFGNode) -> List[List[TCFGNode]]:
        if node.out_edges == []: # end of loop 0 (end of prog)
            return [[node]]
        if loop.lid != 0 and node == loop.tail: # end of normal loop
            return [[node]]

        # find all edges whose lp result are not 0 and ignore back_edge
        possible_edges = [edge for edge in node.out_edges\
                    if 'd{}_{}'.format(node.nid, edge.dst.nid) in self._vars\
                    and self._vars['d{}_{}'.format(node.nid, edge.dst.nid)] != 0\
                    and not edge.is_back_edge()]

        if possible_edges == []: # end of loop 0 (with never taken edge)
            return [[node]]
        for edge in possible_edges:
            return [[node] + path for path in self.dfs_collect_paths(loop, edge.dst)]


    def gen_smt(self) -> None:
        for loop in self._loops.values():
            paths = self.dfs_collect_paths(loop, loop.head)
            for path in paths:
                self.gen_smt_single_path(loop, path)

    def solve(self, verbal = True) -> Optional[Set[Tuple[str]]]:
        # initialize for iteration
        self._smt = []
        self._cons_map = dict()
        self._trace = dict()
        for reg_name in gp_reg_names:
            self._trace[Reg(reg_name)] = []

        self.gen_smt()
        new_cons = set()
        for SMTModel in self._smt:
            unsat_core = SMTModel.solve()
            if unsat_core != None:
                
                for cons in unsat_core:
                    trace_edges = []
                    final_edge = self._cons_map[cons][0]
                    trace = self._cons_map[cons][1]

                    if verbal:
                        print('trace back of Cons: ', end='')
                        print(cons)
                        flag = True
                        for (id, inst) in trace:
                            if id == final_edge.dst.nid:
                                print('infeasible jump to node %d' % id)
                                for inst in final_edge.src.bb.code[-1::-1]:
                                    if inst.name != ".fphead":
                                        print(inst)
                                        print(final_edge.edge_kind)
                                        break
                                print()
                                flag = False
                                break
                            print('node %d' % id, end='')
                            if inst != None:
                                print('\t%s' % inst, end='')
                            print()
                        if flag:
                            print('infeasible jump to node %d' % final_edge.dst.nid)
                            for inst in final_edge.src.bb.code[-1::-1]:
                                if inst.name != ".fphead":
                                    print(inst)
                                    print(final_edge.edge_kind)
                                    break
                        
                        print()

                    if len(trace) > 0:
                        flag = True
                        last = trace[0][0]
                        for (id, _) in trace[1:]:
                            if id == last:
                                continue
                            trace_edges.append("d{}_{}".format(last, id))
                            last = id
                            if id == final_edge.dst.nid:
                                flag = False
                                break
                        if flag:
                            trace_edges.append("d{}_{}".format(final_edge.src.nid, final_edge.dst.nid))
                        new_cons.add(tuple(trace_edges))

                    if verbal:
                        print("{%s} at most %d non-zero" % (", ".join(trace_edges), len(trace_edges)-1))

        if new_cons == set():
            if verbal:
                print('sat')
            return None
        else:
            if verbal:
                print('unsat')
            return new_cons
        
    def iterative_solve(self, verbal = False) -> int:
        """ TODO: random stop """
        it_count = 1
        index = 0
        start_time = time.time()
        while True:
            print("iteration %d:" % it_count, end='')
            res = self.solve(verbal = verbal)
            if res == None:
                if not verbal:
                    print("sat!")
                end_time = time.time()
                return end_time - start_time

            with open(self._lp_file, 'r') as lp_file:
                lines = [line.strip() for line in lp_file.readlines()]
                pos = lines.index("Generals")
                # add header
                if "\\ === infeasible path constraints ===" not in lines:
                    lines.insert(pos, "\\ === infeasible path constraints ===")
                    pos += 1

                for conflict_edges in res:
                    edge_num = len(conflict_edges)
                    # add support var range bound
                    for i in range(index, index + edge_num):
                        lines.insert(pos, "x%d <= 1" % i)
                        pos += 1
                    
                    # add support var non-zero constraint
                    lines.insert(pos, "%s <= %d" % (" + ".join(["x%d" % i for i in range(index, index + edge_num)]), edge_num-1))
                    pos += 1

                    # add edge constraint
                    for i in range(edge_num):
                        lines.insert(pos, "%s - 99999 x%d <= 0" % (conflict_edges[i], index + i))
                        pos += 1

                    lines.insert(pos, "")
                    lines.insert(pos, "")
                    pos += 2

                    # add support var type constraint
                    pos += 1
                    for i in range(index, index + edge_num):
                        lines.insert(pos, "x%d" % i)
                        pos += 1

                    index += edge_num

            with open(self._lp_file, 'w') as lp_file:
                lp_file.write("\n".join(lines))
            
            lp_solve = LPSolve(self._lp_file)
            lp_solve.solve()
            self._vars = lp_solve.vars
            it_count += 1

            if not verbal:
                print("unsat.")
