import sys
import warnings
from collections import deque
from enum import Enum, auto
from typing import Dict, List, Optional, Sequence, Set, Tuple
from graphviz import Digraph
from tabulate import tabulate

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


class ProcedureNetwork:

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
                x:tuple = s[1]  # x:tuple
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
        """
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

    def __init__(self, asm_reader: AsmFileReader, skip_as_plt: list):
        statements = self.__parser_from_asm_reader(asm_reader)
        self.__skip_as_plt = skip_as_plt
        self.__procedures = self.__proc_identify(statements)
        self.__proc_name2instance: Dict[str, Procedure] = {proc.name: proc for proc in self.__procedures}

        for skip_procedure_name in self.__skip_as_plt:
            if skip_procedure_name in self.__proc_name2instance:
                self.__proc_name2instance[skip_procedure_name].set_as_plt()

        self.__proc_draw_edges()
        if (possible_cycle := self.__find_cycle()) is not None:
            c = [p.name for p in possible_cycle]
            raise RuntimeError("Loop between procedures is not allowed: {}.".format(c))

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


class CallGraphNode:
    def __init__(self, name: str, proc: Procedure):
        self.__name = name
        self.__proc = proc

        self.incoming_edges = list()
        self.outgoing_edges = list()

    @property
    def name(self):
        return self.__name

    @property
    def procedure(self):
        return self.__proc

    @property
    def is_plt(self):
        return self.__proc.is_plt


class CallGraphEdge:
    def __init__(self, src: CallGraphNode, dst: CallGraphNode):
        self.__src = src
        self.__dst = dst

    @property
    def src(self):
        return self.__src

    @property
    def dst(self):
        return self.__dst


class TCfgAsCallGraph:
    def __init__(self, procedure_network: ProcedureNetwork, start_label: str = 'main'):
        self.__proc_network = procedure_network
        self.__start_label = start_label

        self.__nodes: Tuple[CallGraphNode] = tuple()
        self.__edges: Tuple[CallGraphEdge] = tuple()

        self.__build()

    def __build(self):
        mapping_name2instance = self.__proc_network.mapping_name2instance
        if self.__start_label not in mapping_name2instance:
            raise KeyError("Unknown start label {}.".format(self.__start_label))

        nodes_list, edges_list = list(), list()

        entry_proc = mapping_name2instance[self.__start_label]
        bfs_q = deque(
            [CallGraphNode(entry_proc.name, entry_proc)]
        )
        while len(bfs_q) != 0:
            node: CallGraphNode = bfs_q.popleft()
            nodes_list.append(node)
            proc = node.procedure
            for inst in proc.instruction:
                b, _, label, _, _ = inst.branch_info
                if b and (label != proc.name):
                    new_node = CallGraphNode(
                        f"{node.name}|{inst.addr.hex_str()}#{label}", mapping_name2instance[label]
                    )
                    edge = CallGraphEdge(node, new_node)
                    node.outgoing_edges.append(edge)
                    new_node.incoming_edges.append(edge)
                    bfs_q.append(new_node)
                    edges_list.append(edge)

        self.__nodes = tuple(nodes_list)
        self.__edges = tuple(edges_list)

    @property
    def nodes(self):
        return self.__nodes

    @property
    def edges(self):
        return self.__edges

    def all_identifications(self):
        return [node.name for node in self.__nodes]

    def api_call_relation(self, fmt: bool = False) -> list:
        data = list()
        for node in self.__nodes:
            incoming = tuple([e.src.name for e in node.incoming_edges])
            outgoing = tuple([e.dst.name for e in node.outgoing_edges])
            if fmt:
                data.append([node.name, '\n'.join(incoming), '\n'.join(outgoing)])
            else:
                data.append([node.name, incoming, outgoing])
        return data

    def formatted_call_relation(self, fmt='grid') -> str:
        header = ['Name', 'Incoming', 'Outgoing']
        data = self.api_call_relation(fmt=True)
        return tabulate(data, headers=header, tablefmt=fmt)

    def draw_graph(self, filename='call_graph.gv', fmt='svg') -> Digraph:
        g = Digraph('Call Graph', filename=filename, format=fmt)
        for node in self.__nodes:
            g.node(node.name)
        for edge in self.__edges:
            g.edge(edge.src.name, edge.dst.name)
        return g


class TCfgNode:
    def __init__(self, name, base_proc: CallGraphNode, instructions: Sequence[Instruction]):
        self.__name = name
        self.__base_proc = base_proc
        self.__instructions = tuple(instructions)

        self.inside_loop: Optional[TCfgLoopHrchy] = None  # Used for loop hrchy building.
        self.ident_number = 0  # Used for readable output. This is mutable and not for hashing, so it should not be used for development.

        self.outgoing_edge: List[TCfgEdge] = list()
        self.incoming_edge: List[TCfgEdge] = list()

        # 处理非标准loop需要的参数
        self.in_regular_loop = True
        self.is_loop_incoming = False
        self.is_loop_outgoing = False
        # 读写分析和建立需要用到的数据
        self.still_out_num = 0
        self.out_num = 0
        self.still_in_num = 0
        self.in_num = 0
        self.is_head = False
        self.is_end = False
        self.in_loop = False
        

        # 读写分析建立过程中需要的参数
        self.no_out = False
        self.no_in = False
        self.node_value = 0
        self.loop_time = 1

        # 热度分析需要的草书
        self.loadlist = list()
        self.storelist = list()
        self.heat_ld_result = dict()
        self.heat_st_result = dict()  # 储存着所有的地址对应的次数

        # cache分析需要的部分
        self.__ins_mb = list()
        self.__data_mb = list()
        self.probability = 1 # 默认概率是100%
        self.__ins_reference = dict()
        self.__data_reference = dict()

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
    
    @property
    def is_in_loop(self):
        if self.inside_loop == None:
            self.in_loop = False
        else:
            self.in_loop = True
        return self.in_loop

    
    @property
    def is_point_to_loop(self):
        temp_bool = False
        for e in self.outgoing_edge:
            if e.dst.is_in_loop:
                temp_bool = True
            else:
                pass
        return temp_bool
    
    @property
    def in_nodes(self):
        return set([edge.src.name  for edge in self.incoming_edge])
    
    @property
    def out_nodes(self):
        return set([edge.dst.name  for edge in self.outgoing_edge])

    

    def set_rw_data(self):
        # 用来算有多少个入边和出边，still_xx用于下面遍历计算
        # TODO 感觉可以用sizeof类似的优化
        if self.in_regular_loop:
            for e in self.outgoing_edge:
                if e.is_backEdge:
                    pass
                else:
                    self.still_out_num += 1
                    self.out_num += 1
            for e in self.incoming_edge:
                if e.is_backEdge:
                    pass
                else:
                    self.still_in_num += 1
                    self.in_num += 1

            # 用来设置头部参数，用于往后启动
            if self.in_num == 0:
                self.is_head = True
                self.no_in = True
                self.node_value = 1
                if self.out_num == 0:  # 说明是单节点，没有前面也没有后面
                    for e in self.outgoing_edge:
                        if e.is_backEdge:
                            # 设置一下吧，万一漏了啥
                            pass
                else:
                    for e in self.outgoing_edge:
                        if e.is_backEdge:
                            pass
                        else:
                            e.edge_value = self.node_value / self.out_num
            if self.out_num == 0:
                self.is_end = True
                self.no_out = True
        else:
            for e in self.outgoing_edge:
                if e.is_backEdge:
                    pass
                elif e.irl_outgoing:
                    self.inside_loop.still_out_num += 1
                    self.inside_loop.out_num += 1
            for e in self.incoming_edge:
                if e.is_backEdge:
                    pass
                elif e.irl_incoming:
                    self.inside_loop.still_in_num += 1
                    self.inside_loop.in_num += 1

    
    def set_rw_value(self):
        if self.in_regular_loop:
            if self.no_out:
                pass
            elif self.no_in:
                # if self.inside_loop == None:
                #     print("regular",self.name)
                # else:
                #     print("regular",self.name,self.inside_loop.name)
                for e in self.outgoing_edge:
                    if e.is_backEdge:
                        pass
                    else:
                        e.dst.get_rw_value(e.edge_value)
                        self.still_out_num -= 1
                if self.still_out_num == 0:
                    self.no_out = True
        else:
            if self.inside_loop.no_out:
                pass
            elif self.inside_loop.no_in:
                # print("irregular",self.name,self.inside_loop.name)
                for e in self.inside_loop.ir_outgoing_edge:
                    if e.is_backEdge:
                        pass
                    else:
                        e.dst.get_rw_value(e.edge_value)
                        self.inside_loop.still_out_num -= 1
                if self.still_out_num == 0:
                    self.inside_loop.no_out = True
                    for node in self.inside_loop._all_nodes:
                        node.no_out = True


    def get_rw_value(self, value):
        if self.in_regular_loop:
            self.node_value += value
            self.still_in_num -= 1
            if self.still_in_num == 0:
                self.no_in = True
                if self.is_end:
                    pass
                else:
                    for e in self.outgoing_edge:
                        if e.is_backEdge:
                            pass
                        else:
                            e.edge_value = self.node_value / self.out_num
        else:
            self.inside_loop.irloop_value += value
            self.inside_loop.still_in_num -= 1
            if self.inside_loop.still_in_num == 0:
                self.inside_loop.no_in = True
                for node in self.inside_loop._all_nodes:
                    node.no_in = True
                if self.inside_loop.is_end:
                    pass
                else:
                    for e in self.inside_loop.ir_outgoing_edge:
                        if e.is_backEdge:
                            pass
                        else:
                            e.edge_value = self.inside_loop.irloop_value / self.inside_loop.out_num

    def add_ins_mbs(self,mb):
        self.__ins_mb.append(mb)
    
    @property
    def ins_mbs(self):
        return self.__ins_mb
    
    def add_data_mbs(self,mb):
        self.__data_mb.append(mb)
    
    @property
    def data_mbs(self):
        return self.__data_mb
    
    @property
    def ins_reference(self):
        return self.__ins_reference
    
    def add_ins_reference(self,ins,reference):
        self.__ins_reference[ins] = reference
    
    @property
    def data_reference(self):
        return self.__data_reference

    def add_data_reference(self,ins,reference):
        if ins in self.__data_reference:
            self.__data_reference[ins].add(reference)
        else:
            self.__data_reference[ins] = set()
            self.__data_reference[ins].add(reference)



class TCfgEdgeType(Enum):
    Textual = auto()
    BranchTaken = auto()
    BranchNoTaken = auto()
    ProcCall = auto()
    ProcReturn = auto()
    PltBelieved = auto()


class TCfgEdge:
    def __init__(self, src: TCfgNode, dst: TCfgNode, kind: TCfgEdgeType):
        self.__src = src
        self.__dst = dst
        self.__kind = kind


        # for irregular loop
        self.irl_incoming = False
        self.irl_outgoing = False
        # for rw_ayalysis while guguji still unable to use dataclass
        # TODO: rewrite it using dataclass
        self.is_backEdge = False
        self.edge_value = 0
        self.loop_value = 0


    @property
    def src(self):
        return self.__src

    @property
    def dst(self):
        return self.__dst

    @property
    def kind(self):
        return self.__kind


class TCfgNodeClusterInOneCallGraphNode:

    def __proc_segmentation_position(self):
        """ Find all segmentation positions.
             A segmentation is inserted between instruction i and instruction i+1 if:
             - instruction i is a branch or call instruction;
             - instruction i is a ``ret`` instruction;
             - instruction i+1 is jumped by other branch instruction.
        """
        if self.__call_graph_node.is_plt:
            return set(), set()

        proc = self.__call_graph_node.procedure
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

    def __proc_do_segmentation(self, seg_before_addr, seg_after_addr) -> List[TCfgNode]:
        """ Segment every procedure into basic blocks (TCfgNode) with respect to the segmentation positions. """
        proc = self.__call_graph_node.procedure

        global_idx = 0
        all_nodes = list()

        def __add_new_node(_inst_slicing):
            nonlocal all_nodes, global_idx
            _new_node = TCfgNode(f"{self.__call_graph_node.name}-n{global_idx}", self.__call_graph_node, _inst_slicing)
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

    def __search_exit_nodes(self):
        if self.__call_graph_node.is_plt:
            return [self.__all_nodes[-1]]
        else:
            nodes = [
                node for node in self.__all_nodes if node.instructions[-1].name == 'ret'
            ]
            if len(nodes) == 0:
                warnings.warn(f"{self.__call_graph_node.name} is not a Plt-procedure and do not have 'ret' instruction.")
                nodes = [self.__all_nodes[-1]]
            return nodes

    def __init__(self, call_graph_node: CallGraphNode):
        self.__call_graph_node = call_graph_node

        seg_before_addr, seg_after_addr = self.__proc_segmentation_position()
        self.__all_nodes = self.__proc_do_segmentation(seg_before_addr, seg_after_addr)

        self.__entry_node: TCfgNode = self.__all_nodes[0]
        self.__exit_nodes: List[TCfgNode] = self.__search_exit_nodes()

    @property
    def call_graph_node(self):
        return self.__call_graph_node

    @property
    def all_nodes(self) -> List[TCfgNode]:
        """ The returned nodes are sorted by the start address. """
        return self.__all_nodes

    @property
    def entry_node(self) -> TCfgNode:
        return self.__entry_node

    @property
    def exit_nodes(self) -> Tuple[TCfgNode]:
        return tuple(self.__exit_nodes)

    def formatted_all_tcfg_nodes(self, fmt='grid'):
        header = ['Name', 'Addr Range', 'Incoming', 'Outgoing']
        data = list()
        for node in self.__all_nodes:
            data.append([
                node.name,
                f"{node.inst_range[0].hex_str()}-{node.inst_range[1].hex_str()}",
                "\n".join([f"{e.kind.name} @ {e.src.name}" for e in node.incoming_edge]),
                "\n".join([f"{e.kind.name} @ {e.dst.name}" for e in node.outgoing_edge])
            ])
        return tabulate(data, headers=header, tablefmt=fmt)


class TCfg:
    def __init__(self, call_graph: TCfgAsCallGraph):
        self._call_graph = call_graph

        self._clusters: List[TCfgNodeClusterInOneCallGraphNode] = list()
        self._nodes: List[TCfgNode] = list()
        self._edges: List[TCfgEdge] = list()

        self._ident2cluster: Dict[str, TCfgNodeClusterInOneCallGraphNode] = dict()

        for call_graph_node in self._call_graph.nodes:
            cluster_node = TCfgNodeClusterInOneCallGraphNode(call_graph_node)
            # Update fields.
            self._clusters.append(cluster_node)
            self._ident2cluster[cluster_node.call_graph_node.name] = cluster_node
            self._nodes.extend(cluster_node.all_nodes)

        for idx, node in enumerate(self._nodes):
            node.ident_number = idx

    @property
    def clusters(self):
        return self._clusters

    @property
    def ident2cluster(self):
        return self._ident2cluster

    @property
    def all_tcfg_nodes(self):
        return self._nodes

    @property
    def all_tcfg_edges(self):
        return self._edges
    @property
    def node_idents(self):
        return [node.name for node in self.all_tcfg_nodes]

    def __new_edge(self, src: TCfgNode, dst: TCfgNode, edge_kind: TCfgEdgeType):
        """ This function is to add an edge from ``src`` to ``dst`` with edge kink ``edge_kind``.
         The edge will be updated into ``self.__edges``. """
        e = TCfgEdge(src, dst, edge_kind)
        src.outgoing_edge.append(e)
        dst.incoming_edge.append(e)
        self._edges.append(e)

    def __draw_edges_inner_procedure(self):
        """ If one tcfg node ends with a branch instruction, and the target address is within current procedure,
          then inner-procedure edge(s) will be added.
          If the last one instruction is not a branch or 'ret' instruction, then a textual edge will be added.
          """
        def __one_cluster(_cluster: TCfgNodeClusterInOneCallGraphNode):

            # All tcfg nodes inside the cluster
            _tcfg_nodes = _cluster.all_nodes
            # Build mappings from start address to the tcfg node.
            _addr2node = {node.inst_range[0].val(): node for node in _tcfg_nodes}
            # Current procedure
            _proc = _cluster.call_graph_node.procedure

            # Check nodes one by one. If the block is branching to inner-procedure address, then add edge(s).
            for _cur_idx, _cur_node in enumerate(_tcfg_nodes):
                _tail_inst = _cur_node.instructions[-1]
                _b, _cond, _t_label, _, _t_addr = _tail_inst.branch_info
                _is_ret = _tail_inst.name == 'ret'

                # Textual edge
                if not (_b or _is_ret):
                    try:
                        _next_textual_node = _tcfg_nodes[_cur_idx + 1]
                    except IndexError:
                        pass
                    else:
                        self.__new_edge(_cur_node, _tcfg_nodes[_cur_idx + 1], TCfgEdgeType.Textual)

                # inner-procedure edge(s)
                elif _b and _t_label == _proc.name:
                    _t_addr: Address
                    _branch_target_node = _addr2node[_t_addr.val()]
                    if _cond:
                        self.__new_edge(_cur_node, _branch_target_node, TCfgEdgeType.BranchTaken)
                        try:
                            _next_textual_node = _tcfg_nodes[_cur_idx + 1]
                        except IndexError:
                            pass
                        else:
                            self.__new_edge(_cur_node, _tcfg_nodes[_cur_idx + 1], TCfgEdgeType.BranchNoTaken)
                    else:
                        self.__new_edge(_cur_node, _branch_target_node, TCfgEdgeType.BranchTaken)

            return

        for cluster in self._clusters:
            if not cluster.call_graph_node.is_plt:
                __one_cluster(cluster)

    def __draw_edges_inter_procedures(self):
        """
        The start tcfg node of a procedure is always the first tcfg node in all_nodes.
        The end tcfg node(s) is all nodes ended with 'ret' instruction, else, the last one tcfg node.
        """
        def __one_cluster(_cluster: TCfgNodeClusterInOneCallGraphNode):

            # All tcfg nodes inside the cluster
            _tcfg_nodes = _cluster.all_nodes
            # Build mappings from start address to the tcfg node.
            _addr2node = {node.inst_left_range.val(): node for node in _tcfg_nodes}
            # Current call graph node and procedure
            _call_graph_node, _proc = _cluster.call_graph_node, _cluster.call_graph_node.procedure

            # Check nodes one by one. If the block is branching to inter-procedure address, then add edge(s).
            for _cur_idx, _cur_node in enumerate(_tcfg_nodes):
                _tail_inst = _cur_node.instructions[-1]
                _b, _, _t_label, _, _t_addr = _tail_inst.branch_info

                if _b and _t_label != _proc.name:

                    _return_back_node = None
                    try:
                        _return_back_node = _tcfg_nodes[_cur_idx + 1]
                    except IndexError:
                        _return_back_node = None
                        # lr, rr = _cur_node.inst_range[0].hex_str(), _cur_node.inst_range[1].hex_str()
                        # raise RuntimeError("Unexpected Error. The TCFG block ending with an inter-procedural jump instruction"
                        #                    " cannot be the last block of the entire Procedure.\n"
                        #                    f"See the node {_cur_node.name} with range {lr} - {rr}")

                    target_call_graph_node_identification = f"{_call_graph_node.name}|{_tail_inst.addr.hex_str()}#{_t_label}"
                    try:
                        target_cluster = self._ident2cluster[target_call_graph_node_identification]
                    except KeyError:
                        raise RuntimeError(f"The Call Graph block named {target_call_graph_node_identification} cannot be found throughout the program.")
                    target_entry_node = target_cluster.entry_node
                    target_exit_nodes = target_cluster.exit_nodes

                    self.__new_edge(_cur_node, target_entry_node, TCfgEdgeType.ProcCall)
                    t = TCfgEdgeType.PltBelieved if target_cluster.call_graph_node.is_plt else TCfgEdgeType.ProcReturn
                    if _return_back_node is not None:
                        for node in target_exit_nodes:
                            self.__new_edge(node, _return_back_node, t)

            return

        for cluster in self._clusters:
            if not cluster.call_graph_node.is_plt:
                __one_cluster(cluster)

    def build(self):
        self.__draw_edges_inner_procedure()
        self.__draw_edges_inter_procedures()

    def draw_tcfg(self, filename='tcfg.gv', fmt='svg') -> Digraph:
        g = Digraph('TCFG', filename=filename, format=fmt)

        # Draw nodes.
        for cluster in self._clusters:
            for node in cluster.all_nodes:
                if not node.outgoing_edge and not node.incoming_edge:
                    # Dead block elimination.
                    continue
                lr, rr = node.inst_left_range, node.inst_right_range
                if cluster.call_graph_node.is_plt:
                    g.node(
                        node.name,
                        label=f"n{node.ident_number}\n{cluster.call_graph_node.procedure.name}\n{lr.hex_str()}-{rr.hex_str()}",
                        fillcolor="turquoise"
                    )
                else:
                    g.node(
                        node.name,
                        label=f"n{node.ident_number}\n{lr.hex_str()}-{rr.hex_str()}",
                    )

        # Draw edges.
        for edge in self._edges:
            kind = edge.kind
            if kind == TCfgEdgeType.Textual:
                g.edge(edge.src.name, edge.dst.name)
            elif kind == TCfgEdgeType.BranchTaken:
                g.edge(edge.src.name, edge.dst.name, label=f"branch taken", color='green')
            elif kind == TCfgEdgeType.BranchNoTaken:
                g.edge(edge.src.name, edge.dst.name, label=f"branch not taken", color='red')
            elif kind == TCfgEdgeType.ProcCall:
                g.edge(edge.src.name, edge.dst.name, color='blue', label=f"call\n{edge.dst.base_proc.name}")
            elif kind == TCfgEdgeType.ProcReturn:
                g.edge(edge.src.name, edge.dst.name, color='blue', label=f"return\n{edge.dst.base_proc.name}")
            elif kind == TCfgEdgeType.PltBelieved:
                g.edge(edge.src.name, edge.dst.name, color='blue', label=f"@plt return\n{edge.dst.base_proc.name}")

        return g
    

class TCfgLoop:
    def __init__(self, name, head: TCfgNode, tail: TCfgNode, back_edge: TCfgEdge, all_nodes: List[TCfgNode], is_regular):
        self._name = name
        self._head: TCfgNode = head
        self._tail: TCfgNode = tail
        self._back_edge: TCfgEdge = back_edge
        self._all_nodes: frozenset[TCfgNode] = frozenset(all_nodes)
        self._is_regular: bool = is_regular

        # 针对irregular loop的value处理方案
        # 读写分析和建立需要用到的数据
        self.ir_incoming_edge: List[TCfgEdge] = list()
        self.ir_outgoing_edge: List[TCfgEdge] = list()

        self.still_out_num = 0
        self.out_num = 0
        self.still_in_num = 0
        self.in_num = 0
        self.is_head = False
        self.is_end = False
        self.no_out = False
        self.no_in = False
        self.irloop_value = 0
        self.loop_time = 1

        self.bound = 0

    @property
    def name(self):
        return self._name

    @property
    def head(self):
        return self._head

    @property
    def tail(self):
        return self._tail

    @property
    def back_edge(self):
        return self._back_edge

    @property
    def all_nodes(self):
        return self._all_nodes
    
    @property
    def is_regular(self):
        return self._is_regular
    
    def set_irloop_rw_data(self):
        # 用来设置头部参数，用于往后启动
            if self.in_num == 0:
                self.is_head = True
                self.no_in = True
                self.node_value = 1
                if self.out_num == 0:  # 说明是单节点，没有前面也没有后面
                    for e in self.ir_outgoing_edge:
                        if e.is_backEdge:
                            # 设置一下吧，万一漏了啥
                            pass
                else:
                    for e in self.ir_outgoing_edge:
                        if e.is_backEdge:
                            pass
                        else:
                            e.edge_value = self.node_value / self.out_num

            if self.out_num == 0:
                self.is_end = True
                self.no_out = True
    
    @property
    def loop_outgoing_node(self):
        for node in self._all_nodes:
            for e in node.outgoing_edge:
                if e.dst not in self._all_nodes:
                    return e.dst


class IrregularLoopFound(RuntimeError):
    def __init__(self, msg: str, all_nodes: list) -> None:
        super().__init__()
        self.msg = msg
        self.all_nodes = tuple(all_nodes)
    
    def __str__(self) -> str:
        return f"Irregular loop found, type {self.msg}.\nCheck nodes: {self.all_nodes}"


class TCfgLoopHrchy(TCfgLoop):
    def __init__(self, name, head: TCfgNode, tail: TCfgNode, back_edge: TCfgEdge, all_nodes: List[TCfgNode], is_regular: bool = True):
        super().__init__(name, head, tail, back_edge, all_nodes, is_regular)
        self.father: Optional[TCfgLoopHrchy] = None
        self.children: List[TCfgLoopHrchy] = list()
        self._head = head

    def formatted_loop_info(self):
        if self._is_regular:
            return [
                self._name,
                self._is_regular,
                self._head.ident_number, self._tail.ident_number,
                ", ".join([f"n{node.ident_number}" for node in self._all_nodes]),
                self.father.name if self.father is not None else "",
                ", ".join([cl.name for cl in self.children])
            ]
        else:
            return [
                self._name,
                self._is_regular,
                None, None,
                ", ".join([f"n{node.ident_number}" for node in self._all_nodes]),
                self.father.name if self.father is not None else "",
                None
            ]
    
    @property
    def name(self):
        return self._name

    @property
    def head(self):
        return self._head

class TCfgWithLoopHrchy(TCfg):
    def __init__(self, call_graph: TCfgAsCallGraph):
        super().__init__(call_graph)
        self._loops: List[TCfgLoopHrchy] = list()

    @property
    def loops(self):
        return self._loops
    
    @property
    def loop_idents(self):
        return [loop.name for loop in self._loops]

    @staticmethod
    def __tarjan_scc(nodes_considered: List[TCfgNode], edges_considered: Set[TCfgEdge]) -> List[List[TCfgNode]]:
        sys.setrecursionlimit(3000) 
        # with open("/Users/gugujixiao/SyncSpace/workspace/project/HW_Cache/code/hw_cache_analysis/benchmark/testcase1/debug",'a+') as f:
        #     f.write("__tarjan_scc\n")
            

        """ This function is to find all strongly-connected components given a graph including considered nodes and considered edges.
        Code is generated by ChatGPT with suitable prompt.
        The loop finding problem with safety assumption that all loops are affine can be reduced to the SCC problem. See
        https://en.wikipedia.org/wiki/Strongly_connected_component#:~:text=A%20directed%20graph%20is%20called,second%20vertex%20to%20the%20first.
        for details.
        """

        index_counter = 1
        index_mapping: Dict[TCfgNode, int] = {n: None for n in nodes_considered}
        lowlink_mapping: Dict[TCfgNode, int] = {n: None for n in nodes_considered}

        stack: List[TCfgNode] = list()
        onstack_mapping: Dict[TCfgNode, bool] = {n: False for n in nodes_considered}

        scc_list: List[List[TCfgNode]] = list()

        def strong_connect(node: TCfgNode):
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

        for n in nodes_considered:
            if index_mapping[n] is None:
                strong_connect(n)

        return scc_list

    def build_loop_hrchy(self):

        loop_counter = 0

        def build_subgraph(loop: TCfgLoopHrchy):
            nodes = loop.all_nodes
            edges = [e for n in nodes for e in n.outgoing_edge if (e.dst in nodes) and (e != loop.back_edge)]
            return list(nodes), set(edges)

        def find_loops(nodes_considered: List[TCfgNode], edges_considered: Set[TCfgEdge], base=None, is_regular: bool = True):
            """"""

            nonlocal loop_counter

            loop_list: List[TCfgLoopHrchy] = list()
            irr_loop_list: List[TCfgLoopHrchy] = list()
            loop_total_list: List[TCfgLoopHrchy] = list()

            if is_regular:
                scc_list = self.__tarjan_scc(nodes_considered, edges_considered)
            else:
                # For irregular loops, do not do further explorations.
                scc_list = []

            # This search is disabled by setting scc_list an empty list for irregular loops.
            for scc in scc_list:
                try:
                    if len(scc) == 1:
                        """ Check if this is a self-loop. """
                        self_loop_node = scc[0]
                        back_edge: List[TCfgEdge] = [e for e in self_loop_node.outgoing_edge if (e in edges_considered) and (e.dst == self_loop_node)]
                        if len(back_edge) != 0:
                            loop = TCfgLoopHrchy(f"l{loop_counter}", self_loop_node, self_loop_node, back_edge[0], scc)
                            loop_counter += 1
                            loop_total_list.append(loop)
                            loop_list.append(loop)
                        continue

                    nodes_set = set(scc)
                    """ An affine loop has exactly one entry node and one exit node. """
                    loop_entry: List[TCfgNode] = list()
                    loop_exit: List[TCfgNode] = list()
                    for node in nodes_set:
                        if [e for e in node.incoming_edge if (e in edges_considered) and (e.src not in nodes_set)]:
                            loop_entry.append(node)
                        if [e for e in node.outgoing_edge if (e in edges_considered) and (e.dst not in nodes_set)]:
                            loop_exit.append(node)
                    if len(loop_entry) != 1 or len(loop_exit) != 1:
                        raise IrregularLoopFound(
                            msg= 'Loop entry: {}. Loop exit: {}.'.format([node.ident_number for node in loop_entry], [node.ident_number for node in loop_exit]),
                            all_nodes=[node.ident_number for node in nodes_set]
                        )
                    entry_node, exit_node = loop_entry[0], loop_exit[0]

                    """ An affine loop has exactly one back edge that pointed to the entry node. """
                    back_edge: List[TCfgEdge] = [e for e in entry_node.incoming_edge if (e in edges_considered) and (e.src in nodes_set)]
                    if len(back_edge) != 1:
                        raise IrregularLoopFound(
                            msg= 'Loop entry: {}. Loop exit: {}. Back edge: {}'.format(
                                [node.ident_number for node in loop_entry], 
                                [node.ident_number for node in loop_exit],
                                [(e.src.ident_number, e.dst.ident_number) for e in back_edge]
                            ),
                            all_nodes=[node.ident_number for node in nodes_set]
                        )
                except IrregularLoopFound as e:
                    # TODO: Raise an exception if irregular is not allowed.
                    # raise e
                    loop = TCfgLoopHrchy(f"l{loop_counter}", None, None, None, scc, is_regular=False)
                    loop_counter += 1
                    loop_total_list.append(loop)
                    irr_loop_list.append(loop)
                else:
                    loop = TCfgLoopHrchy(f"l{loop_counter}", entry_node, exit_node, back_edge[0], scc)
                    loop_counter += 1
                    loop_total_list.append(loop)
                    loop_list.append(loop)

            """ Append loops to self._loops """
            self._loops.extend(loop_total_list)

            """ After finding all loops, iterative search for all sub-loops. """
            # For regular loop, call build_subgraph() to generate a new cfg without back edges.
            for loop in loop_list:
                loop.father = base
                c_nodes, c_edges = build_subgraph(loop)
                find_loops(c_nodes, c_edges, loop)
            # For irregular loop, directly call find_loops() again to build loop relations.
            for loop in irr_loop_list:
                loop.father = base
                c_nodes, c_edges = list(loop.all_nodes), set()
                find_loops(c_nodes, c_edges, loop, is_regular=False)

            """ Label all nodes the loop inside and build loop hierarchy. """
            if base is not None:
                base.children = loop_total_list
            for n in nodes_considered:
                if n.inside_loop is None:
                    n.inside_loop = base

        # Search
        considered_nodes = self._nodes
        considered_edges = set(self._edges)
        find_loops(considered_nodes, considered_edges, base=None, is_regular=True)

    def formatted_loop_hrchy(self, fmt='grid'):
        header = ['Name', 'Regular', 'Head', 'Tail', 'Include Node', 'Father', 'Children']
        data = [loop.formatted_loop_info() for loop in self._loops]
        return tabulate(data, headers=header, tablefmt=fmt)

    def add_loop_bound(self, file_name: str):
        bound_mapping = dict()
        with open(file_name, "r", encoding='utf-8') as fp:
            for line in fp.readlines():
                lb_src, lb_dst, bound = line.split()
                bound_mapping[(lb_src, lb_dst)] = int(bound)
        for lp in self._loops:
            if (b := bound_mapping.get(((e := lp.back_edge).src.name, e.dst.name), None)) is None:
                raise KeyError(f"Cannot find loop bound for loop {lp.name}:{lp.all_nodes} with back edge {lp.back_edge.src.name}-{lp.back_edge.dst.name}.")
            lp.bound = b


    
