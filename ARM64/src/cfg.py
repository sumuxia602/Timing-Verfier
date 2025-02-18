import types
import sys
import warnings
from collections import deque
from enum import Enum, auto
from typing import Dict, List, Optional, Sequence, Set, Tuple, Hashable
from graphviz import Digraph
from tabulate import tabulate

from src.cache.abstract_state import MultiLevelCacheState
from src.isa import Address, Instruction
from src.read_asm import AsmFileReader, StatementType


class Procedure:
    def __init__(self, name: str, beg_addr: Address, instructions: list):
        self.__name = name
        self.__beg_addr = beg_addr
        self.__instructions = tuple(instructions)

        self.__is_plt = "@plt" in self.__name

        self.incoming_proc: Set[Procedure] = set()
        self.outgoing_proc: Set[Procedure] = set()

        self.entry_node = None
        self.exit_nodes = None
        self.nodes = list()
        self.edges = list()

        self.entry_state: Optional[MultiLevelCacheState] = None
        self.entry_state_nc: Optional[List[MultiLevelCacheState]] = None
        self.dummyNodes_state: Optional[Dict[Hashable, MultiLevelCacheState]] = None
        self.dummyNodes_state_nc: Optional[Dict[Hashable, List[MultiLevelCacheState]]] = None

    def set_as_plt(self):
        warnings.warn(f"This procedure is considered as a plt-procedure. Procedure name: {self.__name}")
        self.__is_plt = True

    @property
    def name(self):
        """ Return the name/label of procedure. """
        return self.__name

    @property
    def is_plt(self):
        return self.__is_plt

    @property
    def beg_addr(self):
        """ Return the beginning address of procedure. The returned is an instance of type ``Address``. """
        return self.__beg_addr

    @property
    def instruction(self) -> Tuple[Instruction]:
        """ Return a tuple containing all instructions of the procedure in order. Modifications to it is illegal. """
        return self.__instructions

    def add_proc_segmentation(self, all_nodes):
        self.nodes = all_nodes
        if self.nodes == []:
            pass
        else:
            self.entry_node = self.nodes[0]

    def draw_inner_cfg(self, filename='inner_procedure_cfg.gv', fmt='svg'):
        g = Digraph('Call Graph', filename=filename, format=fmt)
        for node in self.nodes:
            g.node(node.name)
        for edge in self.edges:
            g.edge(edge.src.name, edge.dst.name)
        return g


class ProcedureNetwork:

    def __init__(self, asm_reader: AsmFileReader, skip_as_plt: list):
        statements = self.__parser_from_asm_reader(asm_reader)
        self.__skip_as_plt = skip_as_plt
        self.__procedures = self.__proc_identify(statements)
        self.__proc_name2instance: Dict[str, Procedure] = {proc.name: proc for proc in self.__procedures}

        for skip_procedure_name in self.__skip_as_plt:
            if skip_procedure_name in self.__proc_name2instance:
                self.__proc_name2instance[skip_procedure_name].set_as_plt()

        self.__proc_draw_edges()
        # if (possible_cycle := self.__find_cycle()) is not None:
        #     c = [p.name for p in possible_cycle]
        #     raise RuntimeError("Loop between procedures is not allowed: {}.".format(c))

    @staticmethod
    def __parser_from_asm_reader(asm_reader: AsmFileReader):
        statements: List[tuple] = list()
        """
        For instructions, the element in statements is Tuple[StatementType.Instruction, Instruction].
        For sub-procedures, the element in statements is Tuple[StatementType.SubProcedure, x:tuple], where x[0] is address and x[1] is procedure name.
        """
        for exp, s in zip(asm_reader.statements, asm_reader.parsed_statements):
            ty, tokens = s
            if ty == StatementType.Instruction:
                statements.append((ty, Instruction(exp, tokens)))
            elif ty == StatementType.SubProcedure:
                statements.append(s)
        return statements

    @staticmethod
    def __proc_identify(statements: List[tuple]):
        all_proc: List[Procedure] = list()

        proc_name, proc_addr, proc_inst = None, None, list()
        for s in statements:
            ty = s[0]
            if ty == StatementType.Instruction:
                inst: Instruction = s[1]
                proc_inst.append(inst)
            elif ty == StatementType.SubProcedure:
                x: tuple = s[1]  # x:tuple
                if proc_name is not None and proc_addr is not None:
                    all_proc.append(Procedure(proc_name, proc_addr, proc_inst))
                proc_addr, proc_name = x[0], x[1]
                proc_inst.clear()
        else:
            if proc_name is not None and proc_addr is not None:
                all_proc.append(Procedure(proc_name, proc_addr, proc_inst))

        return all_proc

    def __find_cycle(self) -> Optional[List[Procedure]]:
        def dfs(proc, visited_proc, path):
            visited_proc.add(proc)
            path.append(proc)
            for to_p in proc.outgoing_proc:
                if to_p in path:
                    return path[path.index(to_p):]
                elif to_p not in visited_proc:
                    f_cycle = dfs(to_p, visited_proc, path)
                    if f_cycle:
                        return f_cycle
            path.pop()
            return None

        cycle = None
        visited = set()
        for p in self.__procedures:
            if p not in visited:
                cycle = dfs(p, visited, [])
                if cycle:
                    break
        return cycle

    def __proc_draw_edges(self):
        """
        This function is used to build the call graph of the procedures.
_       """
        for proc in self.__procedures:
            proc.incoming_proc.clear()
            proc.outgoing_proc.clear()

        for proc in self.__proc_name2instance.values():
            instructions = proc.instruction
            for inst in instructions:
                b, _, label, _, _ = inst.branch_info
                if b and (label != proc.name):
                    proc.outgoing_proc.add(self.__proc_name2instance[label])
                    self.__proc_name2instance[label].incoming_proc.add(proc)

    @property
    def procedures(self):
        return self.__procedures

    @property
    def mapping_name2instance(self):
        return self.__proc_name2instance

    def api_basic(self) -> list:
        data = list()
        for proc in self.__procedures:
            begin_addr = proc.beg_addr.val()

            inst_len = len(proc.instruction)
            stop_addr = begin_addr + inst_len * 4
            begin_addr, stop_addr = hex(begin_addr), hex(stop_addr)
            data.append([proc.name, begin_addr, stop_addr, inst_len])
        return data

    def formatted_basic(self, fmt='psql') -> str:
        header = ['Name', 'Begin Addr', 'Stop Addr', 'Inst Len']
        data = self.api_basic()
        return tabulate(data, headers=header, tablefmt=fmt)

    def api_call_relation(self, fmt: bool = False) -> list:
        data = list()
        for proc in self.__procedures:
            incoming = tuple([p.name for p in proc.incoming_proc])
            outgoing = tuple([p.name for p in proc.outgoing_proc])
            if fmt:
                data.append([proc.name, '\n'.join(incoming), '\n'.join(outgoing)])
            else:
                data.append([proc.name, incoming, outgoing])
        return data

    def formatted_call_relation(self, fmt='grid') -> str:
        header = ['Name', 'Incoming', 'Outgoing']
        data = self.api_call_relation(fmt=True)
        return tabulate(data, headers=header, tablefmt=fmt)

    def dot_call_graph(self, filename='procedure_graph.gv', fmt='svg') -> Digraph:
        g = Digraph('Procedure Graph', filename=filename, format=fmt)
        for proc in self.__procedures:
            g.node(proc.name)
        for proc in self.__procedures:
            for to_proc in proc.outgoing_proc:
                g.edge(proc.name, to_proc.name)
        return g


class InnerProcNode:
    def __init__(self, name, base_proc: Procedure, instructions: Sequence[Instruction]):
        self.__name = name
        self.__base_proc = base_proc
        self.__instructions = tuple(instructions)

        self.outgoing_edge: List[InnerProcEdge] = list()
        self.incoming_edge: List[InnerProcEdge] = list()

        self.is_inner = True
        self.inside_loop = False

        # cache分析需要的部分
        self.__ins_mb = list()
        self.__data_mb = list()

        self.__ins_reference = dict()
        self.__data_reference = dict()

        # 概率化NC需要用到的部分
        self.probability = 0

    @property
    def name(self):
        return self.__name

    @property
    def base_proc(self):
        return self.__base_proc

    @property
    def inst_range(self):
        return self.__instructions[0].addr, Address(hex(self.__instructions[-1].addr.val() + 4))

    @property
    def inst_left_range(self):
        return self.__instructions[0].addr

    @property
    def inst_right_range(self):
        return Address(hex(self.__instructions[-1].addr.val() + 4))

    @property
    def instructions(self):
        return self.__instructions

    def add_ins_mbs(self, mb):
        self.__ins_mb.append(mb)

    @property
    def ins_mbs(self):
        return self.__ins_mb

    def add_data_mbs(self, mb):
        self.__data_mb.append(mb)

    @property
    def data_mbs(self):
        return self.__data_mb

    @property
    def ins_reference(self):
        return self.__ins_reference

    def add_ins_reference(self, ins, reference):
        self.__ins_reference[ins] = reference

    @property
    def data_reference(self):
        return self.__data_reference

    def add_data_reference(self, ins, reference):
        if ins in self.__data_reference:
            self.__data_reference[ins].add(reference)
        else:
            self.__data_reference[ins] = set()
            self.__data_reference[ins].add(reference)


class InterProcNode(InnerProcNode):
    def __init__(self, base_proc: Procedure, entry_node: InnerProcNode, call_proc: Procedure, call_node: InnerProcNode):
        super().__init__(call_node.name + "-<" + base_proc.name + ">", call_proc, [])

        self.__actual_proc = base_proc
        self.__actual_node = entry_node
        self.is_inner = False

    @property
    def actual_proc(self):
        return self.__actual_proc

    @property
    def actual_node(self):
        return self.__actual_node


class InnerProcEdgeType(Enum):
    Textual = auto()
    BranchTaken = auto()
    BranchNoTaken = auto()
    ProcCall = auto()
    ProcReturn = auto()
    PltBelieved = auto()


class InnerProcEdge:
    def __init__(self, src: InnerProcNode, dst: InnerProcNode, kind: InnerProcEdgeType):
        self.__src = src
        self.__dst = dst
        self.__kind = kind
        self.is_back_edge = False

        # 概率化NC需要用到的部分
        self.probability = 0

    @property
    def src(self):
        return self.__src

    @property
    def dst(self):
        return self.__dst

    @property
    def kind(self):
        return self.__kind


class InnerProcLoop:
    def __init__(self, base_proc, loop_nodes, loop_head, loop_tail, loop_back_edge):
        self.proc = base_proc
        self.nodes = loop_nodes
        self.head = loop_head
        self.tail = loop_tail
        self.back_edge = loop_back_edge
        self.name = None

        if self.tail is not None:
            self.name = self.tail.name + "->" + self.head.name
            self.back_edge.is_back_edge = True
            for n in self.nodes:
                n.inside_loop = self.name

        self.father: Optional[InnerProcLoop] = None
        self.children: List[InnerProcLoop] = list()


class InnerProcCFG:
    def __init__(self, proc_net: ProcedureNetwork):
        self.__procedures = proc_net.procedures
        self.__name2proc = proc_net.mapping_name2instance
        self.__loops: List[InnerProcLoop] = list()
        self.__related_procs = set()

        for proc in self.__procedures:
            seg_before_addr, seg_after_addr = self.__proc_segmentation_position(proc)
            # print(proc.name,seg_before_addr,seg_after_addr)
            nodes = self.__proc_do_segmentation(proc, seg_before_addr, seg_after_addr)
            proc.add_proc_segmentation(nodes)
            self.__search_exit_nodes(proc)
            # for node in nodes:
            #     print(node.name,node.inst_left_range.val())
        self.__draw_edges_inner_procedures()
        self.__draw_edges_inter_procedures()
        self.__build_loops()

    def __proc_segmentation_position(self, proc: Procedure):
        """ Find all segmentation positions in the procedure.
             A segmentation is inserted between instruction i and instruction i+1 if:
             - instruction i is a branch or call instruction;
             - instruction i is a ``ret`` instruction;
             - instruction i+1 is jumped by other branch instruction.
        """
        seg_before_addr, seg_after_addr = set(), set()

        for inst in proc.instruction:
            b, _, t_label, _, t_addr = inst.branch_info
            if b:
                # Situation 1: Instruction is a branch or call instruction.
                seg_after_addr.add(inst.addr.val())
                if t_label == proc.name:
                    # Situation 2: Instruction is jumped by other branch instruction.
                    seg_before_addr.add(t_addr.val())
            elif inst.name == 'ret':
                # Situation 2: Instruction is a ``ret`` instruction.
                seg_after_addr.add(inst.addr.val())

        return seg_before_addr, seg_after_addr

    def __proc_do_segmentation(self, this_proc, seg_before_addr, seg_after_addr):
        """ Segment every procedure into basic blocks (TCfgNode) with respect to the segmentation positions. """
        proc = this_proc

        global_idx = 0
        all_nodes = list()

        def __add_new_node(_inst_slicing):
            nonlocal all_nodes, global_idx
            _new_node = InnerProcNode(f"{proc.name}-n{global_idx}", proc, _inst_slicing)
            global_idx += 1
            all_nodes.append(_new_node)

        inst_slicing = list()
        for inst in proc.instruction:
            if inst.addr.val() in seg_before_addr and len(inst_slicing) != 0:
                __add_new_node(inst_slicing)
                inst_slicing.clear()
            inst_slicing.append(inst)
            if inst.addr.val() in seg_after_addr and len(inst_slicing) != 0:
                __add_new_node(inst_slicing)
                inst_slicing.clear()
        else:
            if len(inst_slicing) != 0:
                __add_new_node(inst_slicing)

        return all_nodes

    def __search_exit_nodes(self, proc):
        if proc.is_plt:
            nodes = [proc.nodes[-1]]
            proc.exit_nodes = nodes
            return nodes
        else:
            nodes = [node for node in proc.nodes if node.instructions[-1].name == 'ret']
            if len(nodes) == 0:
                warnings.warn(f"{proc.name} is not a Plt-procedure and do not have 'ret' instruction.")
                if len(proc.nodes) == 0:
                    nodes = 0
                else:
                    nodes = [proc.nodes[-1]]
            proc.exit_nodes = nodes
            return nodes

    def __new_inner_edge(self, src: InnerProcNode, dst: InnerProcNode, edge_kind: InnerProcEdgeType, proc: Procedure):
        e = InnerProcEdge(src, dst, edge_kind)
        src.outgoing_edge.append(e)
        dst.incoming_edge.append(e)
        proc.edges.append(e)

    def __draw_edges_inner_procedures(self):
        """ If one tcfg node ends with a branch instruction, and the target address is within current procedure,
        then inner-procedure edge(s) will be added.
        If the last one instruction is not a branch or 'ret' instruction, then a textual edge will be added.
        """

        def __draw(proc: Procedure):
            _proc = proc
            # All tcfg nodes inside the cluster
            # cluster is used for tcfg build.In cfg build,we only need proc
            _all_nodes = _proc.nodes
            # Build mappings from start address to the tcfg node.
            _addr2node = {node.inst_range[0].val(): node for node in _all_nodes}

            # Check nodes one by one. If the block is branching to inner-procedure address, then add edge(s).
            for _cur_idx, _cur_node in enumerate(_all_nodes):
                _tail_inst = _cur_node.instructions[-1]
                _b, _cond, _t_label, _, _t_addr = _tail_inst.branch_info
                _is_ret = _tail_inst.name == 'ret'

                # Textual edge
                if not (_b or _is_ret):
                    try:
                        _next_textual_node = _all_nodes[_cur_idx + 1]
                    except IndexError:
                        pass
                    else:
                        self.__new_inner_edge(_cur_node, _all_nodes[_cur_idx + 1], InnerProcEdgeType.Textual, _proc)

                # inner-procedure edge(s)
                elif _b and _t_label == _proc.name:
                    _t_addr: Address
                    _branch_target_node = _addr2node[_t_addr.val()]
                    if _cond:
                        self.__new_inner_edge(_cur_node, _branch_target_node, InnerProcEdgeType.BranchTaken, _proc)
                        try:
                            _next_textual_node = _all_nodes[_cur_idx + 1]
                        except IndexError:
                            pass
                        else:
                            self.__new_inner_edge(_cur_node, _all_nodes[_cur_idx + 1], InnerProcEdgeType.BranchNoTaken,
                                                  _proc)
                    else:
                        self.__new_inner_edge(_cur_node, _branch_target_node, InnerProcEdgeType.BranchTaken, _proc)

        for proc in self.__procedures:
            __draw(proc)

    def __new_inter_edge(self, src: InnerProcNode, dst: InnerProcNode, edge_kind: InnerProcEdgeType, proc: Procedure):
        e = InnerProcEdge(src, dst, edge_kind)
        src.outgoing_edge.append(e)
        dst.incoming_edge.append(e)
        proc.edges.append(e)

    def __draw_edges_inter_procedures(self):
        """
        The start tcfg node of a procedure is always the first tcfg node in all_nodes.
        The end tcfg node(s) is all nodes ended with 'ret' instruction, else, the last one tcfg node.
        """

        def __draw(proc: Procedure):
            _proc = proc
            # All tcfg nodes inside the cluster
            # cluster is used for tcfg build.In cfg build,we only need proc
            _all_nodes = _proc.nodes
            # Build mappings from start address to the tcfg node.
            _addr2node = {node.inst_range[0].val(): node for node in _all_nodes}
            # Current call graph node and procedure

            # Check nodes one by one. If the block is branching to inter-procedure address, then add edge(s).
            for _cur_idx, _cur_node in enumerate(_all_nodes):
                if _cur_node.is_inner:
                    _tail_inst = _cur_node.instructions[-1]
                    _b, _, _t_label, _, _t_addr = _tail_inst.branch_info

                    if _b and _t_label != _proc.name:
                        _return_back_node = None
                        try:
                            _return_back_node = _all_nodes[_cur_idx + 1]
                        except IndexError:
                            _return_back_node = None

                        try:
                            target_proc = self.__name2proc[_t_label]
                        except KeyError:
                            raise RuntimeError(
                                f"The Call Graph block named {_t_label} cannot be found throughout the program.")
                        target_entry_node = target_proc.entry_node
                        target_exit_nodes = target_proc.exit_nodes

                        func_call_node = InterProcNode(target_proc, target_entry_node, _proc, _cur_node)
                        _proc.nodes.append(func_call_node)

                        self.__new_inter_edge(_cur_node, func_call_node, InnerProcEdgeType.ProcCall, _proc)
                        t = InnerProcEdgeType.PltBelieved if _proc.is_plt else InnerProcEdgeType.ProcReturn
                        if _return_back_node is not None:
                            self.__new_inter_edge(func_call_node, _return_back_node, t, _proc)
                            # for node in target_exit_nodes:
                            #     self.__new_inter_edge(node, _return_back_node, t,_proc)

        for proc in self.__procedures:
            __draw(proc)

    def __tarjan_scc(self, nodes_considered: List[InnerProcNode], edges_considered: Set[InnerProcEdge]) -> List[
        List[InnerProcNode]]:
        """ This function is to find all strongly-connected components 
        given a graph including considered nodes and considered edges.
        """

        def strong_connect(node: InnerProcNode):
            nonlocal index_counter, index_mapping, lowlink_mapping, stack, onstack_mapping, scc_list

            index_mapping[node] = index_counter
            lowlink_mapping[node] = index_counter
            index_counter += 1
            stack.append(node)
            onstack_mapping[node] = True

            for edge in node.outgoing_edge:
                if edge not in edges_considered:
                    continue
                successor = edge.dst
                if index_mapping[successor] is None:
                    strong_connect(successor)
                    lowlink_mapping[node] = min(lowlink_mapping[node], lowlink_mapping[successor])
                elif onstack_mapping[successor]:
                    lowlink_mapping[node] = min(lowlink_mapping[node], index_mapping[successor])

            if lowlink_mapping[node] == index_mapping[node]:
                scc = list()
                while True:
                    successor = stack.pop()
                    onstack_mapping[successor] = False
                    scc.append(successor)
                    if successor == node:
                        break
                scc_list.append(scc)

        # 针对规模特别大的代码，这个方法可以解决递归溢出的问题
        sys.setrecursionlimit(3000)
        index_counter = 1
        index_mapping: Dict[InnerProcNode, int] = {n: None for n in nodes_considered}
        lowlink_mapping: Dict[InnerProcNode, int] = {n: None for n in nodes_considered}

        stack: List[InnerProcNode] = list()
        onstack_mapping: Dict[InnerProcNode, bool] = {n: False for n in nodes_considered}

        scc_list: List[List[InnerProcNode]] = list()

        for n in nodes_considered:
            if index_mapping[n] is None:
                strong_connect(n)

        return scc_list

    def __build_loops(self):
        loop_counter = 0

        def build_subgraph(loop: InnerProcLoop):
            nodes = loop.nodes
            edges = [e for n in nodes for e in n.outgoing_edge if (e.dst in nodes) and (e != loop.back_edge)]
            return list(nodes), set(edges)

        def find_loops(base_proc: Procedure, nodes_considered: List[InnerProcNode],
                       edges_considered: Set[InnerProcEdge], base=None, is_regular: bool = True):
            """
            """
            nonlocal loop_counter
            proc = base_proc

            loop_list: List[InnerProcLoop] = list()
            irr_loop_list: List[InnerProcLoop] = list()
            loop_total_list: List[InnerProcLoop] = list()

            if is_regular:
                scc_list = self.__tarjan_scc(nodes_considered, edges_considered)
            else:
                # For irregular loops, do not do further explorations.
                scc_list = []

            for scc in scc_list:
                try:
                    if len(scc) == 1:
                        """ Check if this is a self-loop. """
                        self_loop_node = scc[0]
                        back_edge: List[InnerProcEdge] = [e for e in self_loop_node.outgoing_edge if
                                                          (e in edges_considered) and (e.dst == self_loop_node)]
                        if len(back_edge) != 0:
                            loop = InnerProcLoop(proc, scc, self_loop_node, self_loop_node, back_edge[0])
                            loop_counter += 1
                            loop_total_list.append(loop)
                            loop_list.append(loop)
                        continue

                    nodes_set = set(scc)
                    """ An affine loop has exactly one entry node and one exit node. """
                    loop_entry: List[InnerProcNode] = list()
                    loop_exit: List[InnerProcNode] = list()
                    for node in nodes_set:
                        if [e for e in node.incoming_edge if (e in edges_considered) and (e.src not in nodes_set)]:
                            loop_entry.append(node)
                        if [e for e in node.outgoing_edge if (e in edges_considered) and (e.dst not in nodes_set)]:
                            loop_exit.append(node)
                    if len(loop_entry) != 1 or len(loop_exit) != 1:
                        raise IrregularLoopFound(
                            msg='Loop entry: {}. Loop exit: {}.'.format([node.name for node in loop_entry],
                                                                        [node.name for node in loop_exit]),
                            all_nodes=[node.name for node in nodes_set]
                        )
                    entry_node, exit_node = loop_entry[0], loop_exit[0]

                    """ An affine loop has exactly one back edge that pointed to the entry node. """
                    back_edge: List[InnerProcEdge] = [e for e in entry_node.incoming_edge if
                                                      (e in edges_considered) and (e.src in nodes_set)]
                    if len(back_edge) != 1:
                        raise IrregularLoopFound(
                            msg='Loop entry: {}. Loop exit: {}. Back edge: {}'.format(
                                [node.name for node in loop_entry],
                                [node.name for node in loop_exit],
                                [(e.src.name, e.dst.name) for e in back_edge]
                            ),
                            all_nodes=[node.name for node in nodes_set]
                        )
                except IrregularLoopFound as e:
                    loop = InnerProcLoop(proc, scc, None, None, None)
                    loop_counter += 1
                    loop_total_list.append(loop)
                    irr_loop_list.append(loop)
                else:
                    loop = InnerProcLoop(proc, scc, entry_node, exit_node, back_edge[0])
                    loop_counter += 1
                    loop_total_list.append(loop)
                    loop_list.append(loop)

            """ Append loops to self._loops """
            self.__loops.extend(loop_total_list)

            """ After finding all loops, iterative search for all sub-loops. """
            # For regular loop, call build_subgraph() to generate a new cfg without back edges.
            for loop in loop_list:
                loop.father = base
                c_nodes, c_edges = build_subgraph(loop)
                find_loops(proc, c_nodes, c_edges, loop)

            # For irregular loop, directly call find_loops() again to build loop relations.
            for loop in irr_loop_list:
                loop.father = base
                c_nodes, c_edges = list(loop.nodes), set()

                find_loops(proc, c_nodes, c_edges, loop, is_regular=False)

            """ Label all nodes the loop inside and build loop hierarchy. """
            if base is not None:
                base.children = loop_total_list
            for n in nodes_considered:
                if n.inside_loop is None:
                    n.inside_loop = base

        for proc in self.__procedures:
            considered_nodes = proc.nodes
            considered_edges = set(proc.edges)
            find_loops(proc, considered_nodes, considered_edges, base=None, is_regular=True)

    @property
    def loops(self):
        return self.__loops

    def find_related_procs(self) -> set[Procedure]:
        """ 找出从main函数开始所有相关的函数 """
        procs = self.__procedures

        # 查找main函数
        main_proc = next((proc for proc in procs if proc.name == "main"), None)
        if not main_proc:
            raise ValueError("main函数没有找到")

        # 使用DFS查找所有与main函数有调用关系的函数
        self.__related_procs = set()  # 与 main函数相关的所有相关的函数集合
        stack = [main_proc]
        while stack:
            current_proc = stack.pop()
            if current_proc not in self.__related_procs:
                self.__related_procs.add(current_proc)
                for outgoing in current_proc.outgoing_proc:
                    if outgoing not in self.__related_procs:
                        stack.append(outgoing)
        return self.__related_procs

    def find_related_loops(self) -> Set[InnerProcLoop]:
        # 使用字典来记录每个节点的入度
        sorted_loops = set()
        related_procs = self.find_related_procs()
        for loop in self.loops:
            if loop.proc in related_procs:
                sorted_loops.add(loop)
        return sorted_loops

    # def node_probability(self):
    #     procs = self.__procs
    #     def compute_node_probabilitu(proc):
    #         node_list = list()

    #         proc.entry_node.probability = 1
    #         for edge in proc.entry_node.outgoing_edge:
    #             edge.probability = 1/(len(proc.entry_node.outgoing_edge))
    #             node_list.append(edge.dst)

    #         while True:
    #             if len(node_list) == 0:
    #                 break
    #             for node in node_list:
    #                 temp_prob = 0 
    #                 for edge in node.incoming_edge:
    #                     temp_prob += edge.probability
    #                     if edge.probability == 0:
    #                         break
    #                     elif edge.is_back_edge:
    #                         pass
    #                     node.prob = temp_prob
    #                     node_list

    # for proc in procs:
    #     compute_node_probabilitu(proc)


class IrregularLoopFound(RuntimeError):
    def __init__(self, msg: str, all_nodes: list) -> None:
        super().__init__()
        self.msg = msg
        self.all_nodes = tuple(all_nodes)

    def __str__(self) -> str:
        return f"Irregular loop found, type {self.msg}.\nCheck nodes: {self.all_nodes}"
