from __future__ import annotations

import itertools
from collections import deque
from typing import List, Deque, Optional, Dict, Tuple

from sample.frontend.cfg import TCFGNode, TCFGEdge, TCFGEdgeKind, Addr


class LoopsExeception(Exception):
    def __init__(self, msg: str) -> None:
        self.msg = msg


class Loop:
    """Loop type."""

    def __init__(self, lid: int, head: TCFGNode, tail: Optional[TCFGNode] = None) -> None:
        self.lid = lid
        self.head = head
        self.tail: Optional[TCFGNode] = tail
        self.parent: Optional[Loop] = None
        self.exit_edges: List[TCFGEdge] = []
        self.exit_nodes: List[int] = []
        self.flags: Optional[int] = None

    def __str__(self) -> str:
        if self.tail is not None:
            return "Loop %d: %d <--> %d" % \
                (self.lid, self.head.nid, self.tail.nid)
        else:
            return "Loop %d: %d <--> ?" % (self.lid, self.head.nid)

    def __eq__(self, __o: object) -> bool:
        if not isinstance(__o, Loop):
            return False

        return self.lid == __o.lid and self.head == __o.head and \
            self.tail == __o.tail and self.parent == __o.parent and \
            self.exit_edges == __o.exit_edges and \
            self.flags == __o.flags and \
            self.exit_nodes == __o.exit_nodes

    def __repr__(self) -> str:
        if self.tail is not None:
            s = "%d, %s, %s" % (self.lid, self.head.start_addr,
                                self.tail.start_addr)
        else:
            s = "%d, %s, unknown" % (self.lid, self.head.start_addr)
        if self.parent is not None:
            s += ", %s" % self.parent
        if self.exit_edges:
            s += ", [%s]" % ", ".join(str(e) for e in self.exit_edges)
        if self.flags:
            s += ", %d" % self.flags
        return "Loop(%s)" % s

    def __hash__(self) -> int:
        return hash(("Loop", self.head, self.tail, self.parent,
                     tuple(self.exit_edges), tuple(self.exit_nodes), self.flags))

    def get_head(self) -> TCFGNode:
        return self.head

    def set_tail(self, tail: TCFGNode) -> None:
        if self.tail is not None:
            raise LoopsExeception("Tail already exists")
        self.tail = tail

    def get_tail(self) -> TCFGNode:
        if self.tail is None:
            raise LoopsExeception("Tail is not set now")
        return self.tail

    def set_parent(self, parent: Loop) -> None:
        if self.parent is not None:
            raise LoopsExeception("Parent already exists")
        self.parent = parent

    def get_parent(self) -> Loop:
        if self.parent is None:
            raise LoopsExeception("Parent is not set now")
        return self.parent

    def add_exit_edge(self, edge: TCFGEdge) -> None:
        if edge in self.exit_edges:
            raise LoopsExeception("%s has been in exits")
        self.exit_edges.append(edge)

    def add_exit_node(self, node: TCFGNode) -> None:
        if node.nid in self.exit_nodes:
            raise LoopsExeception("%s has been in exits")
        self.exit_nodes.append(node.nid)

    def set_flags(self, flags: int) -> None:
        self.flags = flags

    def swap_head_tail(self):
        assert self.tail is not None
        self.head, self.tail = self.tail, self.head


class LoopHrchy:
    """Traverse tcfg to form a loop hierarchy and associate 
    each bbi its loop level."""

    def __init__(self, tcfg_nodes: List[TCFGNode]) -> None:
        self.tcfg_nodes = tuple(tcfg_nodes)
        self.num_tcfg_loops = 1
        self.loop_map: Dict[int, Loop] = dict()
        self.loops: Dict[int, Loop] = dict()
        self.loop_comm_ances: Dict[Tuple[int, int], Loop] = dict()

    def new_loop(self, edge: TCFGEdge) -> Loop:
        loop = Loop(self.num_tcfg_loops, head=edge.dst, tail=edge.src)
        self.num_tcfg_loops += 1
        return loop

    def find_loops(self) -> None:
        """Construct loops: find all loops in tcfg by checking backedge"""
        tcfg_edges = [edge for tcfg_node in self.tcfg_nodes \
                      for edge in tcfg_node.out_edges]
        for edge in tcfg_edges:
            if edge.is_back_edge() and edge.dst not in self.loop_map:
                src, dst = edge.src.bb, edge.dst.bb
                if dst.is_loop_head() and src.is_loop_tail():
                    self.loop_map[edge.src.nid] = \
                        self.loop_map[edge.dst.nid] = self.new_loop(edge)

        proc_loop = Loop(0, self.tcfg_nodes[0])
        self.loop_map[0] = self.loops[0] = proc_loop
        for node in self.tcfg_nodes:
            if node.nid in self.loop_map:
                lp_id = self.loop_map[node.nid].lid
                self.loops[lp_id] = self.loop_map[node.nid]

    def exit_loop(self, edge: TCFGEdge) -> bool:
        """Judge if dst exits the loop to which src belongs."""
        src, dst = edge.src, edge.dst
        if src.nid not in self.loop_map:
            raise LoopsExeception("%s has not been associated with a loop" % edge.src.nid)
        src_loop = self.loop_map[src.nid]

        if self.loop_map[src.nid].lid == 0:
            return False
        elif dst.proc_name != src_loop.head.proc_name:
            return False
        elif src_loop.tail is None:
            raise LoopsExeception("The src loop does not have a tail")
        elif dst.start_addr < src_loop.head.start_addr:
            return True
        elif dst.start_addr > src_loop.tail.start_addr:
            return True
        else:
            return False

    def deal_exit_edge(self, edge: TCFGEdge) -> None:
        """
        This method assumes that all loops outside src have been found.
        """
        src, dst = edge.src, edge.dst
        if src.nid not in self.loop_map:
            raise LoopsExeception("%s has not been associated with a loop")
        src_loop = self.loop_map[edge.src.nid]
        src_loop.add_exit_edge(edge)
        src_loop.add_exit_node(edge.src)
        src_parent_loop = src_loop.get_parent()

        if dst.nid in self.loop_map:
            dst_loop = self.loop_map[dst.nid]
            if dst_loop.get_head() != dst:
                return
            if dst_loop.parent is not None:
                return
            while src_parent_loop.lid != 0:
                parent_head = src_parent_loop.head
                parent_tail = src_parent_loop.get_tail()
                parent_proc = parent_head.proc_name
                if dst.proc_name != parent_proc:
                    dst_loop.set_parent(src_parent_loop)
                    break
                elif parent_head.start_addr >= dst.start_addr >= parent_tail.start_addr:
                    dst_loop = src_parent_loop
                    break
                src_parent_loop = src_parent_loop.get_parent()

            if self.loop_map[dst.nid].parent is None:
                dst_loop.set_parent(self.loops[0])
        else:
            while src_parent_loop.lid != 0:
                parent_head = src_parent_loop.head
                parent_tail = src_parent_loop.get_tail()
                parent_proc = parent_head.proc_name
                if dst.proc_name != parent_proc:
                    self.loop_map[dst.nid] = src_parent_loop
                    break
                elif parent_head.start_addr <= dst.start_addr <= parent_tail.start_addr:
                    self.loop_map[dst.nid] = src_parent_loop
                    break
                src_parent_loop = src_parent_loop.get_parent()

            if dst.nid not in self.loop_map:
                self.loop_map[dst.nid] = self.loops[0]

    def deal_other_edge(self, edge: TCFGEdge) -> None:
        """if dst is not processed, assign dst a loop. 
        Otherwise, assign dst a parent loop."""
        src, dst = edge.src, edge.dst
        if src.nid not in self.loop_map:
            raise LoopsExeception("%s has not been assigned a loop" % src.nid)
        if dst.nid not in self.loop_map:
            self.loop_map[dst.nid] = self.loop_map[src.nid]
        elif self.loop_map[src.nid] != self.loop_map[dst.nid]:
            self.loop_map[dst.nid].set_parent(self.loop_map[src.nid])

    def map_bbi_loop(self) -> None:
        """
        Construct loop_map : map every TCFGNode to its loop, and map every head and tail of loops a parent loop.
        """
        worklist: Deque[TCFGNode] = deque([self.tcfg_nodes[0]])
        while worklist:
            src = worklist.popleft()
            for edge in src.out_edges:
                if edge.edge_kind == TCFGEdgeKind.NEVER_TAKEN:
                    continue
                dst = edge.dst
                if self.exit_loop(edge):
                    self.deal_exit_edge(edge)
                elif dst.flags == 0:
                    self.deal_other_edge(edge)
                elif self.loop_map[dst.nid].lid == 0 and self.loop_map[edge.src.nid].lid != 0:
                    self.loop_map[dst.nid] = self.loop_map[src.nid]

                if dst.flags == 0:
                    worklist.append(dst)
                    dst.flags = 1

    def loop_relations(self) -> None:
        """Construct loop_comm_ances : find common ancestor of any two loops"""
        loops = [loop for _, loop in self.loops.items()]
        for lp1, lp2 in itertools.combinations(loops, 2):
            found = False
            lp1_ances = [lp1]
            lp = lp1.parent
            while lp is not None:
                if lp == lp2:
                    self.loop_comm_ances[(lp1.lid, lp2.lid)] = \
                        self.loop_comm_ances[(lp2.lid, lp1.lid)] = lp2
                    found = True
                    break
                lp1_ances.append(lp)
                lp = lp.parent

            if found:
                continue

            lp = lp2
            while lp is not None:
                if lp in lp1_ances:
                    self.loop_comm_ances[(lp1.lid, lp2.lid)] = self.loop_comm_ances[(lp2.lid, lp1.lid)] = lp
                    break
                lp = lp.parent

    def check_head_tail(self):
        """Switch the head and tail of a loop 
        if the entry node of a loop is its tail."""
        tcfg_edges = [edge for tcfg_node in self.tcfg_nodes for edge in tcfg_node.out_edges]
        for edge in tcfg_edges:
            if edge.edge_kind == TCFGEdgeKind.NEVER_TAKEN:
                continue
            src, dst = edge.src, edge.dst
            if not src.in_edges:
                continue
            lp1, lp2 = self.loop_map[src.nid], self.loop_map[dst.nid]
            if lp1 != lp2 and self.loop_comm_ances[(lp1.lid, lp2.lid)] != lp2 \
                    and dst.is_loop_tail() and not dst.is_loop_head():
                self.loop_map[dst.nid].swap_head_tail()

    def loop_process(self) -> None:
        self.find_loops()
        self.map_bbi_loop()
        self.loop_relations()
        self.check_head_tail()

    def dump_loops(self) -> None:
        print("Dump loops")
        print("----------------")
        for node in self.tcfg_nodes:
            if node.nid not in self.loop_map:
                continue
            loop = self.loop_map[node.nid]
            head = loop.head
            if head == self.tcfg_nodes[0]:
                print("%s.%d: \t%d[start - end]" %
                      (node.proc_name, node.nid, loop.lid))
            else:
                tail = loop.get_tail()
                parent_loop = loop.get_parent()
                print("%s.%d: \t%d[%s.%d - %s.%d] / parent:%d" % (
                    node.proc_name, node.nid, loop.lid,
                    head.proc_name, head.nid, tail.proc_name, tail.nid,
                    parent_loop.lid
                ))

    def dump_loop_comm_ances(self) -> None:
        print("\ndump loop common ancestors:")
        print("----------------------------------")
        loops = [loop for _, loop in self.loops.items()]
        for loop1, loop2 in itertools.combinations(loops, 2):
            print("loop1: %d loop2: %d / comm_ances: %d" %
                  (loop1.lid, loop2.lid, self.loop_comm_ances[(loop1.lid, loop2.lid)].lid))
        print()
