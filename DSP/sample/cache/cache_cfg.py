import os.path
from copy import deepcopy
from typing import List, Hashable, Optional, Dict, Set, Tuple

from graphviz import Digraph

from sample.frontend.cfg import Prog, TCFGEdgeKind, TCFGNode
from sample.frontend.loops import LoopHrchy
from sample.frontend.loop_bound import LoopAnalysis
from sample.isa.isa_syntax import Instruction


class CacheCFGNode:
    def __init__(self, ident: Hashable, instructions: Optional[List[Instruction]] = None,
                 dupl_from_ident: Optional[Hashable] = None, root: Optional[Hashable] = None):
        self.__ident = ident
        self.__dupl_from_ident = dupl_from_ident
        self.__root = root if root is not None else ident
        self.__insts = instructions if instructions is not None else None

        self.in_nodes: Set[Hashable] = set()
        self.out_nodes: Set[Hashable] = set()

    @property
    def ident(self):
        return self.__ident

    @property
    def dupl_from(self):
        return self.__dupl_from_ident

    @property
    def root(self):
        return self.__root

    @property
    def insts(self):
        return self.__insts


class CacheCFGLoop:
    def __init__(self, ident: Hashable, head_ident: Hashable, tail_ident: Hashable,
                 father_loop: Optional[Hashable] = None):
        self.__ident = ident
        self.__head_node_ident = head_ident
        self.__tail_node_ident = tail_ident
        self.__father_loop: Optional[Hashable] = father_loop
        self.__paths: Tuple[Tuple[int, ...], ...] = None
        self.__loop_bound = None
        self.node_in_loop: Set[Hashable] = set()
        self.ancestor: List[Hashable] = list()
        self.descendant: List[Hashable] = list()

    @property
    def ident(self):
        return self.__ident

    def set_head(self, new_head):
        self.__head_node_ident = new_head

    @property
    def head(self):
        return self.__head_node_ident

    def set_tail(self, new_tail):
        self.__tail_node_ident = new_tail

    @property
    def tail(self):
        return self.__tail_node_ident

    @property
    def father_loop(self):
        return self.__father_loop

    def set_paths(self, paths):
        self.__paths = paths

    @property
    def paths(self):
        return self.__paths


class CacheCFG:
    def __init__(self, instructions: List[Instruction]):
        self.__entry_node_ident = None
        self.__node_pool: Dict[Hashable, CacheCFGNode] = dict()
        self.__loop_pool: Dict[Hashable, CacheCFGLoop] = dict()
        self.__removed_edges: List[Tuple[Hashable, Hashable]] = list()
        self.__instructions: List[Instruction] = instructions
        self.__node_loop_map: Dict[Hashable, List[CacheCFGLoop]] = dict()

    def __add_edge(self, src: Hashable, dst: Hashable):
        self.__node_pool[src].out_nodes.add(dst)
        self.__node_pool[dst].in_nodes.add(src)

    def __remove_edge(self, src: Hashable, dst: Hashable, restrict: bool = False, record: bool = True):
        if restrict:
            self.__node_pool[src].out_nodes.remove(dst)
            self.__node_pool[dst].in_nodes.remove(src)
        else:
            self.__node_pool[src].out_nodes.discard(dst)
            self.__node_pool[dst].in_nodes.discard(src)
        if record:
            self.__removed_edges.append((src, dst))

    def get_instruction(self, address: int) -> int:
        left = 0
        right = len(self.__instructions) - 1
        while left <= right:
            mid = (right + left) // 2
            if self.__instructions[mid].address == address:
                return mid
            elif address > self.__instructions[mid].address:
                left = mid + 1
            else:
                right = mid - 1
        raise LookupError

    def get_all_paths_loop_node(self, target_node, loop_id):
        '''
        This implementation does not work for some node  when the loop has multiple tails
        '''
        loop = self.get_loop(loop_id)
        loop_paths = loop.paths
        paths = set()
        for path in loop_paths:
            try:
                index = path.index(target_node)
            except:
                continue
            else:
                paths.add(path[:index + 1][::-1])
        return list(paths)

    def get_all_paths_node(self, node_id, max_depth=4):
        paths = []
        start_node = self.get_node(node_id)

        def dfs(current_node: CacheCFGNode, current_path: List[Hashable], depth):
            current_path.append(current_node.ident)

            if depth == 0 or not current_node.in_nodes:
                paths.append(current_path[:])  # Make a copy of the current path
                return
            else:
                for child in current_node.in_nodes:
                    dfs(self.get_node(child), current_path, depth - 1)

            current_path.pop()

        dfs(start_node, [], max_depth)
        return paths

    def __loop_relation_analysis(self):
        """ Ancestors (outer loops) """
        for ident in self.__loop_pool:
            chain = list()
            cur_ident = ident
            while self.__loop_pool[cur_ident].father_loop is not None:
                father_loop = self.__loop_pool[cur_ident].father_loop
                chain.append(father_loop)
                cur_ident = father_loop
            self.__loop_pool[ident].ancestor.extend(chain)

        """ Descendants (inner loops) """
        for ident in self.__loop_pool:
            self.__loop_pool[ident].descendant.extend(
                [target_ident for target_ident in self.__loop_pool if ident in self.__loop_pool[target_ident].ancestor]
            )

    def read_from_front_end(self, prog: Prog, loop_hr: LoopHrchy):
        """ """
        """ Nodes """
        for node in prog.tcfg_nodes:
            start_inst = 0
            inline_data_num = 0
            # Not contain ".word"
            for inst in node.bb.code:
                if inst.name:
                    break
                start_inst += 1
            for inst in node.bb.code:
                if not inst.name:
                    inline_data_num += 1
            start_index = self.get_instruction(node.bb.code[start_inst].addr.to_dec())
            number_of_inst = len(node.bb.code) - inline_data_num
            inst_list = self.__instructions[start_index: start_index + number_of_inst]

            self.__node_pool[node.nid] = CacheCFGNode(ident=node.nid, instructions=inst_list,
                                                      dupl_from_ident=None, root=None)
        self.__entry_node_ident = 0

        """ Edges """
        for node in prog.tcfg_nodes:
            for edge in node.out_edges:
                if edge.edge_kind == TCFGEdgeKind.NEVER_TAKEN:
                    continue
                self.__add_edge(edge.src.nid, edge.dst.nid)
                
        """ Loops """
        for ident, loop in loop_hr.loops.items():
            # CacheCFG does not take whole-procedure-loop into consideration.
            if ident == 0:
                continue
            head: TCFGNode = loop.head
            tail: TCFGNode = loop.tail
            # If parent is 0, then it has no parent loop.
            father_loop = None if loop.parent.lid == 0 else loop.parent.lid
            self.__loop_pool[ident] = CacheCFGLoop(ident, head.nid, tail.nid, father_loop=father_loop)
            self.__loop_pool[ident].set_paths(LoopAnalysis(loop).enumerate_path())
        self.__loop_relation_analysis()

        """ Mapping of Nodes and Loop """
        for ident, loop in loop_hr.loop_map.items():
            # If parent is 0, then it has no parent loop.
            loop_list: List[CacheCFGLoop] = list()
            if loop.lid == 0:
                self.__node_loop_map[ident] = []
                continue
            self.__loop_pool[loop.lid].node_in_loop.add(ident)
            loop_list.append(self.__loop_pool[loop.lid])
            # 如果A属于Loop1并且Loop2是Loop1的上层循环（ancestor），那么A也属于Loop2.
            for ancestor in self.__loop_pool[loop.lid].ancestor:
                self.__loop_pool[ancestor].node_in_loop.add(ident)
                loop_list.append(self.__loop_pool[ancestor])

            '''From outermost to innermost Loop'''
            loop_list.reverse()
            self.__node_loop_map[ident] = loop_list

    def __loop_topsort(self) -> List[Hashable]:
        """ """
        in_loops: Dict[Hashable, Set[Hashable]] = {ident: set() for ident in self.__loop_pool}
        for ident, loop in self.__loop_pool.items():
            if loop.father_loop is not None:
                in_loops[loop.father_loop].add(ident)

        topsorted: List[Hashable] = list()
        while len(in_loops) > 0:
            candidate: List[Hashable] = [ident for ident, in_set in in_loops.items() if len(in_set) == 0]
            topsorted.extend(candidate)
            for ident in candidate:
                in_loops.pop(ident)
                if self.__loop_pool[ident].father_loop is not None:
                    in_loops[self.__loop_pool[ident].father_loop].remove(ident)
        return topsorted

    def __node_duplicate(self, node: CacheCFGNode) -> Hashable:
        times = 0
        while True:
            new_ident = "{}_d{}".format(node.ident, times)
            if new_ident not in self.__node_pool:
                break
            times += 1
        self.__node_pool[new_ident] = CacheCFGNode(new_ident, dupl_from_ident=node.ident, root=node.root)
        return new_ident

    def __loop_unrolling_basic(self, loop_ident: Hashable, keep_tail_out_edges: bool = True):
        """ """
        loop = self.__loop_pool[loop_ident]
        ident_mapping: Dict[Hashable, Hashable] = dict()

        """ 复制所有的结点 """
        for ident in loop.node_in_loop:
            new_ident = self.__node_duplicate(self.__node_pool[ident])
            # 由于first-round-unrolling在原循环之上完成，因此如果被复制的结点是入口结点，那么要更新入口结点。
            self.__entry_node_ident = ident if ident == self.__entry_node_ident else self.__entry_node_ident
            ident_mapping[ident] = new_ident

        """ 复制所有结点的out edge，如果dst是被复制的结点，那么将dst更新为复制后的结点 """
        new_head_ident, new_tail_ident = ident_mapping[loop.head], ident_mapping[loop.tail]
        for ident in loop.node_in_loop:
            src_ident = ident_mapping[ident]
            for dst_ident in self.__node_pool[ident].out_nodes:
                dst_ident = ident_mapping.get(dst_ident, dst_ident)
                self.__add_edge(src_ident, dst_ident)
        """ 如果keep_tail_out_edges为True，那么删除从new_tail指向new_head的回边，否则，删除new_tail所有的出边 """
        # "出边"在这里特指离开循环的边。
        # 删除所有的出边仅是指如果该出边的目的结点不是被复制的结点，那么删除它；如果目的结点是被复制的结点（例如两个循环相同tail的情况），
        # 那么我们不认为这是一条出边。
        # These edges were added wrongly in the previous step, so we do not consider them as 'removed_edge'.
        if keep_tail_out_edges:
            self.__remove_edge(new_tail_ident, new_head_ident, record=False)
        else:
            new_idents = set(ident_mapping.values())
            # 依然需要删除从new_tail指向new_head的回边，因此需要从new_idents中移出new_tail
            new_idents.remove(ident_mapping[loop.head])
            for out_ident in list(self.__node_pool[new_tail_ident].out_nodes):
                if out_ident not in new_idents:
                    self.__remove_edge(new_tail_ident, out_ident, record=False)
        """ 删除原头节点除了backside外的所有入边，并添加对应的指向new_head的入边 """
        for in_ident in list(self.__node_pool[loop.head].in_nodes):
            if in_ident == loop.tail:
                continue
            self.__remove_edge(in_ident, loop.head)
            self.__add_edge(in_ident, new_head_ident)
        """ 建立从new_tail到头结点的边 """
        self.__add_edge(new_tail_ident, loop.head)

        """ 更新循环的node_in_loop. 新的结点都属于该循环的所有上层循环（ancestor）. """
        new_idents = list(ident_mapping.values())
        for ancestor in loop.ancestor:
            self.__loop_pool[ancestor].node_in_loop.update(new_idents)

        """ 如果除当前正在展开的循环外，其他循环的头/尾结点是当前循环的头节点，那么循环结构会被破坏，需要修改循环 """
        """ 
        对于self-loop来说，由于头结点和尾结点的ident实际上是相同的，因此在这种情况下，需要进行特殊判断：
          - 如果其他循环的尾结点与self-loop重合，那么不需要进行任何修改。
          - 如果其他循环的头节点与self-loop重合，那么需要更新头节点。
        """
        for target_loop in self.__loop_pool.values():
            if target_loop.ident == loop_ident:
                continue
            if target_loop.head == loop.head:
                target_loop.set_head(new_head_ident)
            if loop.head != loop.tail and target_loop.tail == loop.head:
                target_loop.set_tail(new_head_ident)

    def loop_unrolling(self, keep_tail_out_edges: bool = True):
        """ """
        """
        避免交叉循环：
          - 对于任意两个循环loop1和loop2，如果loop1包含在loop2中，那么loop1的所有结点都属于loop2。
          - 对于任意两个循环loop1和loop2，如果他们之间不存在交叉关系，那么loop1与loop2的交集应该属于空。
        程序默认输入的CFG满足这两条并且不进行检查。
        """
        loop_topsorted = self.__loop_topsort()
        for loop_ident in loop_topsorted:
            self.__loop_unrolling_basic(loop_ident, keep_tail_out_edges=keep_tail_out_edges)

    def draw_loop_relationship(self, fig_name: str = "Loop Relationship",
                               head_and_tail: bool = True,
                               node_in_loop: bool = True,
                               to_svg: bool = False,
                               directory: str = "graphviz_output", keep_gv: bool = False) -> Digraph:
                                   
        dot = Digraph(fig_name)
        dot.node("PROC_MAIN_LOOP", "MAIN", shape="diamond")
        for ident, loop in self.__loop_pool.items():
            label = str(ident) if not head_and_tail else "{}[{}: {}]".format(ident, loop.head, loop.tail)
            if node_in_loop:
                label += "\n{}".format(loop.node_in_loop)
            dot.node(str(ident), label)
            father = self.__loop_pool[ident].father_loop
            dot.edge(str(father) if father is not None else "PROC_MAIN_LOOP", str(ident))

        if to_svg:
            dot.format = "svg"
            dot.render(directory=directory).replace("\\", "/")
        if not keep_gv:
            os.remove(os.path.join(directory, "{}.gv".format(fig_name)))
        return dot

    def draw_cfg(self, fig_name: str = "Cache CFG",
                 removed_node: bool = True,
                 removed_edge: bool = True,
                 highlight_dupl_node: bool = True,
                 highlight_dupl_edge: bool = True,
                 highlight_backside: bool = True,
                 node_dupl_label: bool = True,
                 backside_label: bool = True,
                 to_svg: bool = False, directory: str = "graphviz_output", keep_gv: bool = False) -> Digraph:

        dot = Digraph(fig_name)

        for ident, node in self.__node_pool.items():
            is_dupl: bool = node.dupl_from is not None
            is_removed: bool = len(node.out_nodes) == 0 if self.__entry_node_ident == ident else \
                len(node.in_nodes) == 0 and len(node.out_nodes) == 0
            if is_removed and not removed_node:
                continue
            label = str(ident) if (not is_dupl) or (not node_dupl_label) else \
                "{} [:{}]".format(ident, node.dupl_from)
            fillcolor = "white" if is_removed else "gold" if highlight_dupl_node and is_dupl else "azure"
            fontcolor = "gray" if is_removed else "black"
            style = "dashed, filled" if is_removed else "filled"
            dot.node(str(ident), label=label, fillcolor=fillcolor, fontcolor=fontcolor, style=style)

        backsides = {(loop.tail, loop.head): ident for ident, loop in self.__loop_pool.items()}
        for node in self.__node_pool.values():
            src = node.ident
            for dst in node.out_nodes:
                is_backside: bool = (src, dst) in backsides
                is_dupl: bool = \
                    self.__node_pool[src].dupl_from is not None or self.__node_pool[dst].dupl_from is not None
                label = "L:{}".format(backsides[(src, dst)]) if is_backside and backside_label else ""
                color = "chocolate4" if is_backside and highlight_backside \
                    else "darkgreen" if is_dupl and highlight_dupl_edge else "black"
                fontcolor = "chocolate4" if is_backside and highlight_backside \
                    else "darkgreen" if is_dupl and highlight_dupl_edge else "black"
                dot.edge(str(src), str(dst), label=label, color=color, fontcolor=fontcolor)
                
        if removed_edge:
            for src, dst in self.__removed_edges:
                dot.edge(str(src), str(dst), color="gray", style="dashed")
        if to_svg:
            dot.format = "svg"
            dot.render(directory=directory).replace("\\", "/")
        if not keep_gv:
            os.remove(os.path.join(directory, "{}.gv".format(fig_name)))
            
        return dot

    @property
    def node_idents(self):
        return list(self.__node_pool.keys())

    @property
    def loop_idents(self):
        return list(self.__loop_pool.keys())

    @property
    def entry_node_ident(self):
        return self.__entry_node_ident

    def get_node(self, ident):
        return deepcopy(self.__node_pool[ident])

    def get_loop(self, ident):
        return deepcopy(self.__loop_pool[ident])

    def get_node_map_loop(self, ident):
        """
        Get all Loops where the node is located, in order from outer to inner
        """
        return self.__node_loop_map[ident]
