"""Representation of control flow graph in presence of delay slots.
(We assume that there is no unreachable code in the scheduled, compiled code.)

Reference: Building a Control-flow Graph from Scheduled Assembly Code. 
            Keith D. Cooper, Timothy J. Harvey and Todd Waterman.

TODO: 1. add spurious edge for unreachable code which is the rest of a node 
         after an unconditional jump
      2. Mark the indirect jump node
      3. Consider the case when an execute packet contains more than one branch.
         In this case, it is possible that a node has more than two outgoing edges.
"""
from __future__ import annotations

import copy
import itertools
import json
import os
import string
from collections import deque
from enum import Enum, Flag, auto
from typing import List, Optional, Tuple, Deque, Set, Dict, no_type_check, Sequence, Union

import graphviz

from sample.frontend.isa import Instruction, Addr

debug = False

dummy_start_addr: Addr = Addr("0x88000000")

# only these six regs are used in cond branch
cond_reg = ['A0', 'A1', 'A2', 'B0', 'B1', 'B2']

# branch counter: a pair of branch instruction and a counter 
# representing the leftover cycles before branch takes effect
BCounter = Tuple[Instruction, int]  # type of branch counter

EdgeInfo = Tuple[Addr,
Tuple[BCounter, ...],
Dict[BCounter, List[Instruction]],
Dict[Tuple[BCounter, BCounter], List[Instruction]],
Set[BCounter]]


class CFGException(Exception):
    def __init__(self, msg: str) -> None:
        self.msg = msg

    def __str__(self) -> str:
        return self.msg


class TCFGException(Exception):
    def __init__(self, msg: str) -> None:
        self.msg = msg

    def __str__(self) -> str:
        return self.msg


class LoopKind(Flag):
    LOOP_BODY = 0
    LOOP_HEAD = 1
    LOOP_TAIL = 2
    LOOP_SELF = 3


class CFGEdgeKind(Enum):
    TAKEN = auto()
    NOT_TAKEN = auto()
    NEVER_TAKEN = auto()


class TCFGEdgeKind(Enum):
    TAKEN = auto()
    NOT_TAKEN = auto()
    CALL = auto()
    RET = auto()
    NEVER_TAKEN = auto()


def parse_fpheader(fph: str) -> Instruction:
    words = fph.split()
    return Instruction(opcode=words[1], name=".fphead", func_unit=None,
                       operands=get_operands(fph), addr=Addr(words[0]))


def get_operands(ist: str) -> List[str]:
    if ist[44:] == "":
        return []

    return ist[44:].split(",")


def parse_ist(ist: str) -> Instruction:
    inst = ist.split()
    is_par = (inst[2] == "||")
    cond = None
    if is_par:
        if inst[3] == "[":
            inst[3] += inst[4]
            del inst[4]
        if inst[3].startswith("["):  # conditional parallel execution
            cond = inst[3][1:-1].strip()
            name_with_fu = inst[4]
            operands = get_operands(ist)
        else:  # unconditional parallel execution
            name_with_fu = inst[3]
            operands = get_operands(ist)
    else:
        if inst[2] == "[":
            inst[2] += inst[3]
            del inst[3]
        if inst[2].startswith("["):  # conditional execution
            cond = inst[2][1:-1].strip()
            name_with_fu = inst[3]
            operands = get_operands(ist)
        else:  # unconditional execution
            name_with_fu = inst[2]
            operands = get_operands(ist)

    if "." not in name_with_fu:
        name, func_unit = name_with_fu, ""
    else:
        name, func_unit = name_with_fu.replace(".", " .").split(" ")
    addr = Addr(inst[0])
    opcode = inst[1]
    return Instruction(name, func_unit,
                       operands, addr, opcode=opcode, cond=cond, is_par=is_par)


class EPacket:
    """ Execute packet type. """

    def __init__(self, ists: List[Instruction]) -> None:
        assert 0 < len(ists) <= 8, \
            "An execute packet should have at least one line."
        assert not ists[0].is_par, "The first instruction \
                    in an execute packet should not \
                     be a fpheader or a parallel instruction: %s" % ists[0]

        mcists = [ist for ist in ists if ist.is_multi_cycle]
        assert len(mcists) <= 1, \
            "More than one multi-cycle instruction in an execute packet"

        akcists = [ist for ist in ists if ist.name == "ADDKPC"]
        assert len(akcists) <= 1, \
            "More than one ADDKPC instruction in an execute packet"

        branch_ists = [ist for ist in ists if ist.is_branch or ist.is_call]
        if len(branch_ists) > 1:
            raise NotImplementedError("Multiple branch instructions")

        self.ists = tuple(ists)
        self.num_ists = len(self.ists)
        self.start_addr = self.ists[0].addr
        self.end_addr = self.ists[-1].addr

    def __str__(self) -> str:
        return "\n".join(str(ist) for ist in self.ists)

    def __eq__(self, __o: object) -> bool:
        return isinstance(__o, EPacket) and self.ists == __o.ists

    def __hash__(self) -> int:
        return hash(("EPacket", self.ists))

    def get_addkpc_ist(self) -> Instruction:
        """Return the ADDKPC instruction in current packet"""
        for ist in self.ists:
            if isinstance(ist, Instruction) and ist.name == "ADDKPC":
                return ist
        raise CFGException("Can't find ADDKPC instruction.")

    @property
    def has_addkpc(self):
        return any(ist.name == "ADDKPC" for ist in self.ists)

    @property
    def cycles(self) -> int:
        return max(ist.get_cycles() for ist in self.ists)


def collect_epkt(code: Sequence[Instruction]) -> Tuple[EPacket, ...]:
    if not code:
        return tuple()
    eps = []
    ep = [code[0]]
    for c in code[1:]:
        if c.name == ".fphead":
            ep.append(c)
        elif c.is_par:
            ep.append(c)
        else:
            eps.append(EPacket(ep))
            ep = [c]
    eps.append(EPacket(ep))

    return tuple(eps)


class CFGNode:
    """Control-flow graph node type."""

    def __init__(self, eps: Sequence[EPacket], nid: int) -> None:
        self.nid = nid
        self.eps: Tuple[EPacket, ...] = tuple(eps)
        self.code: Tuple[Instruction, ...] = \
            tuple(ist for ep in self.eps for ist in ep.ists)
        self.num_ep = len(self.eps)
        self.start_addr = self.eps[0].start_addr
        self.in_edges: List[CFGEdge] = []
        self.out_not_taken: List[CFGEdge] = []
        self.out_taken: List[CFGEdge] = []
        self.out_never_taken: Optional[CFGEdge] = None
        self.flags: int = 0
        self.loop_role: LoopKind = LoopKind.LOOP_BODY
        self.bist: List[Instruction] = []

    def __str__(self) -> str:
        return "\n".join(str(ep) for ep in self.eps)

    def __hash__(self) -> int:
        return hash(("CFGNode", self.nid, self.eps))

    def __eq__(self, __o: object) -> bool:
        if not isinstance(__o, CFGNode):
            return False
        return self.eps == __o.eps and self.nid == __o.nid

    def add_bist(self, bist: Optional[Instruction]) -> None:
        if bist is None or bist in self.bist:
            return
        if not bist.is_branch and not bist.is_call \
                and not bist.name == "SPKERNEL":
            raise CFGException("%s is not a branch instruction" % bist)

        self.bist.append(bist)

    def split_block(self, spoint: int, nid: int) -> Tuple[CFGNode, CFGNode]:
        if spoint > self.num_ep:
            raise CFGException("Split block: number of execute packet: %s,\
                     Split point: %s" % (self.num_ep, spoint))

        node1 = CFGNode(self.eps[:spoint], self.nid)
        for edge in self.in_edges:
            src = edge.src
            if edge in src.out_taken:
                new_cfg_edge(src, node1, CFGEdgeKind.TAKEN)
            elif edge in src.out_not_taken:
                new_cfg_edge(src, node1, CFGEdgeKind.NOT_TAKEN)
            elif edge == src.out_never_taken:
                new_cfg_edge(src, node1, CFGEdgeKind.NEVER_TAKEN)

        node2 = CFGNode(self.eps[spoint:], nid)

        def delete_incoming_edges(inv_edge: CFGEdge) -> None:
            inv_edge.dst.in_edges = [e for e in
                                     inv_edge.dst.in_edges if e != inv_edge]

        for edge in self.out_not_taken:
            delete_incoming_edges(edge)
            new_cfg_edge(node2, edge.dst, CFGEdgeKind.NOT_TAKEN)

        for edge in self.out_taken:
            delete_incoming_edges(edge)
            new_cfg_edge(node2, edge.dst, CFGEdgeKind.TAKEN)

        if self.out_never_taken is not None:
            edge = self.out_never_taken
            delete_incoming_edges(edge)
            new_cfg_edge(node2, edge.dst, CFGEdgeKind.NEVER_TAKEN)

        return node1, node2

    def add_in_edge(self, edge: CFGEdge) -> None:
        """Add an in-coming edge."""
        if edge not in self.in_edges:
            self.in_edges.append(edge)
        else:
            for in_edge in self.in_edges:
                if edge == in_edge:
                    in_edge.src = edge.src

    def set_taken_edge(self, edge: CFGEdge) -> None:
        """Set the taken edge."""
        if self.out_never_taken is not None:
            if debug:
                print("Add taken edge: %s This node has a never-taken edge: %s"
                      % (edge, self.out_never_taken))
            if self.out_never_taken == edge:
                self.out_never_taken = None
        if edge in self.out_taken:
            for taken_edge in self.out_taken:
                if edge == taken_edge:
                    taken_edge.src = edge.src
                    taken_edge.dst = edge.dst
                    return
        if edge not in self.out_taken:
            self.out_taken.append(edge)
            if len(self.out_taken) > 1 and debug:
                print("More than one taken edge",
                      "; ".join(str(edge) for edge in self.out_taken))

    def set_not_taken_edge(self, edge: CFGEdge) -> None:
        if self.out_never_taken is not None:
            if debug:
                print("Add not taken edge: %s This node has a never-taken edge: %s"
                      % (edge, self.out_never_taken))
            if self.out_never_taken == edge:
                self.out_never_taken = None
        if edge in self.out_not_taken:
            for not_taken_edge in self.out_not_taken:
                if edge == not_taken_edge:
                    not_taken_edge.src = edge.src
                    not_taken_edge.dst = edge.dst
                    return
        if edge not in self.out_not_taken:
            self.out_not_taken.append(edge)
            if len(self.out_not_taken) > 1 and debug:
                print("More than one not taken edge",
                      "; ".join(str(edge) for edge in self.out_not_taken))

    def set_never_taken_edge(self, edge: CFGEdge) -> None:
        if self.out_never_taken is not None and edge != self.out_never_taken and debug:
            raise CFGException("The never-taken edge has already been set: %s %s" %
                               (self.out_never_taken, edge))

        self.out_never_taken = edge

    def is_nop(self) -> bool:
        """Check if all instructions in current node are NOP."""
        return all(ist.name in ("NOP", ".fphead") for ist in self.code)

    def is_ret(self) -> bool:
        """Return True if any bist is a RET instruction."""
        return any(ist.is_ret for ist in self.bist)

    @property
    def has_addkpc(self) -> bool:
        return any(ep.has_addkpc for ep in self.eps)

    def set_flags(self, flag: int) -> None:
        self.flags = flag

    def set_loop_role(self, role: LoopKind) -> None:
        self.loop_role = role

    def is_loop_head(self) -> bool:
        return bool(self.loop_role & LoopKind.LOOP_HEAD)

    def is_loop_tail(self) -> bool:
        return bool(self.loop_role & LoopKind.LOOP_TAIL)

    def is_self_loop(self) -> bool:
        return self.is_loop_head() and self.is_loop_tail()

    @property
    def is_sploop_buffer(self):
        """Return true if self is a SPLOOP buffer."""
        return self.eps[-1].ists[0].name in ("SPKERNEL", "SPKERNELR")

    def is_in_node(self, addr: Addr) -> bool:
        return self.start_addr <= addr <= self.code[-1].addr


class CFGEdge:
    """Control-flow graph edge type."""

    def __init__(self, src: CFGNode, dst: CFGNode) -> None:
        self.src = src
        self.dst = dst

    def __eq__(self, __o: object) -> bool:
        if not isinstance(__o, CFGEdge):
            return False
        return self.src.start_addr == __o.src.start_addr \
            and self.dst.start_addr == __o.dst.start_addr

    def __str__(self):
        return "%s -> %s" % (self.src.start_addr, self.dst.start_addr)


class CFGDummyNode(CFGNode):
    def __init__(self, nid: int, start_addr: Addr) -> None:
        self.nid = nid
        self.start_addr = start_addr
        self.eps: Tuple[EPacket, ...] = tuple()
        self.code: Tuple[Instruction, ...] = tuple()
        self.in_edges: List[CFGEdge] = []
        self.out_not_taken: List[CFGEdge] = []
        self.out_taken: List[CFGEdge] = []
        self.out_never_taken: Optional[CFGEdge] = None
        self.flags: int = 0
        self.loop_role: LoopKind = LoopKind.LOOP_TAIL
        self.bist = []

    def __str__(self) -> str:
        return str(self.nid)

    def __repr__(self) -> str:
        return "Dummy(%d, %s)" % (self.nid, self.start_addr)

    def __hash__(self) -> int:
        return hash(("CFGDummyNode", self.nid, self.start_addr))

    def add_in_edge(self, edge: CFGEdge) -> None:
        return super().add_in_edge(edge)

    def set_taken_edge(self, edge: CFGEdge) -> None:
        return super().set_taken_edge(edge)

    def set_not_taken_edge(self, edge: CFGEdge) -> None:
        return super().set_not_taken_edge(edge)


class TCFGNode:
    """Type of transformed-CFG node"""

    def __init__(self, bb: CFGNode, proc_name: str, nid: int) -> None:
        self.bb = bb
        self.nid = nid
        self.start_addr = bb.start_addr
        self.proc_name = proc_name
        self.in_edges: List[TCFGEdge] = []
        self.out_edges: List[TCFGEdge] = []
        self.flags = 0
        self.dline: List[Tuple[Addr, int]] = []

    def __eq__(self, __o: object) -> bool:
        if not isinstance(__o, TCFGNode):
            return False
        return self.bb.eps == __o.bb.eps and self.nid == __o.nid

    def __str__(self) -> str:
        return str(self.bb)

    def __hash__(self) -> int:
        return hash(("TCFGNode", self.bb, self.nid))

    def add_in_edge(self, in_edge: TCFGEdge) -> None:
        if in_edge not in self.in_edges:
            self.in_edges.append(in_edge)

    def add_out_edge(self, out_edge: TCFGEdge) -> None:
        """TODO: Add edge type check."""
        if len(self.out_edges) > 1 and out_edge not in self.out_edges and debug:
            print("node addr:", self.start_addr)
            print("Existed edges:")
            for edge in self.out_edges:
                print(edge)
            print("Add edge:", out_edge)
            print()
        if out_edge not in self.out_edges:
            self.out_edges.append(out_edge)

    def is_loop_head(self) -> bool:
        return self.bb.is_loop_head()

    def is_loop_tail(self) -> bool:
        return self.bb.is_loop_tail()

    def is_self_loop(self) -> bool:
        return self.bb.is_self_loop()


class TCFGEdge:
    """Type of transformed-CFG edge"""

    def __init__(self, src: TCFGNode, dst: TCFGNode, edge_kind: TCFGEdgeKind) -> None:
        self.src = src
        self.dst = dst
        self.edge_kind = edge_kind

    def __eq__(self, __o: object) -> bool:
        if not isinstance(__o, TCFGEdge):
            return False
        return self.src.start_addr == __o.src.start_addr and \
            self.dst.start_addr == __o.dst.start_addr \
            and self.edge_kind == __o.edge_kind and \
            self.src.nid == __o.src.nid and self.dst.nid == __o.dst.nid

    def __str__(self) -> str:
        return "%s -> %s" % (self.src.start_addr, self.dst.start_addr)

    def __repr__(self) -> str:
        return "TCFGEdge(%s, %s, %s)" % (self.src, self.dst, self.edge_kind)

    def __hash__(self) -> int:
        return hash(("TCFGEdge", self.src, self.dst, self.edge_kind))

    def is_back_edge(self) -> bool:
        """Distinguish a backedge by comparing start address of src and dst"""
        dst, src = self.dst, self.src
        return dst.proc_name == src.proc_name \
            and dst.start_addr <= src.start_addr

    @property
    def is_taken(self) -> bool:
        return self.edge_kind == TCFGEdgeKind.TAKEN

    @property
    def is_not_taken(self) -> bool:
        return self.edge_kind == TCFGEdgeKind.NOT_TAKEN

    @property
    def is_call(self) -> bool:
        return self.edge_kind == TCFGEdgeKind.CALL

    @property
    def is_never_taken(self) -> bool:
        return self.edge_kind == TCFGEdgeKind.NEVER_TAKEN

    @property
    def is_ret(self) -> bool:
        return self.edge_kind == TCFGEdgeKind.RET


def new_cfg_edge(src: CFGNode, dst: CFGNode, edge_kind: CFGEdgeKind) -> None:
    """Create a cfg edge: src -> dst."""
    edge = CFGEdge(src, dst)
    dst.add_in_edge(edge)
    if edge_kind == CFGEdgeKind.TAKEN:
        src.set_taken_edge(edge)
    elif edge_kind == CFGEdgeKind.NOT_TAKEN:
        src.set_not_taken_edge(edge)
    elif edge_kind == CFGEdgeKind.NEVER_TAKEN:
        src.set_never_taken_edge(edge)
    else:
        raise NotImplementedError


def new_tcfg_edge(src: TCFGNode, dst: TCFGNode, edge_kind: TCFGEdgeKind) -> None:
    """Create a tcfg edge: src -> dst."""
    edge = TCFGEdge(src, dst, edge_kind)
    src.add_out_edge(edge)
    dst.add_in_edge(edge)


def is_const_reg(ists: List[Instruction],
                 cond1: str, cond2: str) -> Tuple[bool, Optional[bool]]:
    """Check whether cond2 is a constant value after executing
    instruction in ists under condition cond1.
    If cond2 becomes a constant, this method will also return its current value.
    """
    cond2_reg: str = cond2[1:] if cond2.startswith("!") else cond2
    modify_cond2_ist = [ist for ist in ists if ist.modifies_reg(cond2_reg)]
    if not modify_cond2_ist:
        return False, None
    last_mod_cond2_ist = modify_cond2_ist[-1]
    if last_mod_cond2_ist.name != "MVK":
        return False, None
    elif not last_mod_cond2_ist.is_cond or \
            last_mod_cond2_ist.cond == cond1:
        cond2_val = bool(int(last_mod_cond2_ist.operands[0]))
        if cond2.startswith("!"):
            return True, not cond2_val
        else:
            return True, cond2_val
    else:
        return False, None


def get_cond_name(cond: str) -> str:
    return cond[1:] if cond.startswith("!") else cond


class CondState:

    def __init__(self, eps: Sequence[Tuple[Instruction, ...]], reg_name: str, reg_val: bool) -> None:
        self.eps = tuple(eps)
        self.reg_name = reg_name
        self.reg_val = reg_val
        self.cond_regs = ['A0', 'A1', 'A2', 'B0', 'B1', 'B2']
        self.state: Dict[str, Optional[bool]] = {reg_name: reg_val}
        for cond_reg in self.cond_regs:
            if cond_reg != self.reg_name:
                self.state[cond_reg] = None

    def __str__(self) -> str:
        s = ''
        for cond_reg, val in self.state.items():
            s += "%s: %s\n" % (cond_reg, val)
        return s

    def __getitem__(self, reg_name: str):
        assert reg_name in self.cond_regs
        return self.state[reg_name]

    def run_state(self):
        for ep in self.eps:
            update_state = {k: v for k, v in self.state.items()}
            for ist in ep:
                dst_reg = ist.operands[-1]
                assert dst_reg in self.cond_regs
                if not ist.is_cond:
                    if ist.name == "MV":
                        moved_reg = ist.operands[0]
                        if moved_reg in self.cond_regs:
                            update_state[dst_reg] = self.state[moved_reg]
                    elif ist.name == "MVK":
                        moved_val = int(ist.operands[0])
                        update_state[dst_reg] = bool(moved_val)
                    else:
                        update_state[dst_reg] = None
                else:
                    cond_reg_val = self.state[get_cond_name(ist.cond)]
                    if isinstance(cond_reg_val, bool) \
                            and ist.cond.startswith("!"):
                        cond_reg_val = not cond_reg_val
                    if cond_reg_val is None:  # unknown value
                        update_state[dst_reg] = None
                    elif cond_reg_val:
                        if ist.name == "MV":
                            moved_reg = ist.operands[0]
                            if moved_reg in self.state:
                                update_state[dst_reg] = self.state[moved_reg]
                            else:
                                update_state[dst_reg] = None
                        elif ist.name == "MVK":
                            if ist.operands[0].startswith("0x"):
                                moved_val = int(ist.operands[0], 16)
                            else:
                                moved_val = int(ist.operands[0])
                            update_state[dst_reg] = bool(moved_val)
                        else:
                            update_state[dst_reg] = None
            self.state.update(update_state)

    def eval_cond(self, cond_exp: str) -> Optional[bool]:
        if cond_exp.startswith("!"):
            assert cond_exp[1:] in self.cond_regs
            is_neg = True
            cond_name = cond_exp[1:]
        else:
            assert cond_exp in self.cond_regs
            is_neg = False
            cond_name = cond_exp
        reg_val = self.state[cond_name]
        if isinstance(reg_val, bool) and is_neg:
            return not reg_val
        else:
            return reg_val


class Proc:
    """Procedure type"""

    def __init__(self, pid: int, name: str, code: List[Instruction], labels: List[Addr], dslots: int = 5) -> None:

        self.nid = pid
        self.name = name
        assert code, "A procedure should contain at least one instruction"
        self.code: Tuple[Instruction, ...] = tuple(code)
        self.start_addr = self.code[0].addr
        nid = 0
        self.exec_pkts = collect_epkt(self.code)

        for i, pkt in enumerate(self.exec_pkts):
            if pkt.ists[0].name in ("SPLOOP", "SPLOOPD", "SPLOOPW",
                                    "SPKERNEL", "SPKERNELR"):
                if i == len(self.exec_pkts) - 1:
                    print(self.name, pkt.ists[0].addr)
                assert i != len(self.exec_pkts) - 1
                if self.exec_pkts[i + 1].start_addr not in labels:
                    labels.append(self.exec_pkts[i + 1].start_addr)
        self.label_addr = tuple(sorted(labels))

        bnodes = []
        eps = [self.exec_pkts[0]]
        for pkt in self.exec_pkts[1:]:
            if pkt.start_addr not in self.label_addr:
                eps.append(pkt)
            else:
                bb = CFGNode(eps, nid=nid)
                nid += 1
                bnodes.append(bb)
                eps = [pkt]
        bnodes.append(CFGNode(eps, nid=nid))
        self.bnodes = tuple(bnodes)
        self.dslots = dslots
        self.cfg_nodes: List[CFGNode] = []
        self.ret_bbi_addr: Optional[Addr] = None

        for ep in reversed(self.bnodes[-1].eps):
            for ist in ep.ists:
                if ist.is_indjump:
                    ist.is_ret = True
                    break

        self.loop_head: Dict[Addr, CFGNode] = dict()
        self.__has_loop: Optional[bool] = None

    def __str__(self) -> str:
        return "\n".join(str(c) for c in self.code)

    def next_entry(self, addr: Addr) -> Optional[Addr]:
        for entry in self.label_addr:
            if entry > addr:
                return entry
        return None

    def pred_entry(self, addr: Addr) -> Addr:
        for i, label in enumerate(self.label_addr):
            if addr < label:
                return self.label_addr[i - 1]
        return self.label_addr[-1]

    def get_ret_addr(self, ist: Instruction, ep: Optional[EPacket] = None) -> Optional[Addr]:
        """
        Given a function call instruction and its execute packet,
        find the address of instruction which will be executed after the function call.
        """

        def find_ep(_ist: Instruction) -> EPacket:
            """Return the execute packet which contains given instruction."""
            for bnode in self.bnodes:
                for ep in bnode.eps:
                    if _ist in ep.ists:
                        return ep
            raise CFGException("Can't find execute packet")

        def find_next_ep(ep: EPacket) -> EPacket:
            """ Return the execute packet which contains given instruction."""
            for i, _ep in enumerate(self.exec_pkts):
                if ep == _ep:
                    assert i != len(self.exec_pkts) - 1
                    return self.exec_pkts[i + 1]
            raise CFGException("Can't find execute packet")

        if ep is None:
            ep = find_ep(ist)
        if not ist.is_call and not ist.is_indjump:
            raise CFGException("%s is not a function call" % ist)
        if ist.name == "CALLP":
            return find_next_ep(ep).start_addr
        elif ist.name in ("B", "BNOP"):
            for node in self.cfg_nodes:
                for i, _ep in enumerate(node.eps):
                    if _ep == ep:
                        counter = self.dslots - ep.cycles + 1
                        remain_eps: List[EPacket] = []
                        if i != len(node.eps) - 1:
                            remain_eps += node.eps[i + 1:]

                        for r_ep in remain_eps:
                            counter -= r_ep.cycles
                            if counter >= 0 and r_ep.has_addkpc:
                                addpkc_ist = r_ep.get_addkpc_ist()
                                return Addr(addpkc_ist.operands[0][-9:-1])

                        if counter > 0:
                            if node.out_taken:
                                for edge in node.out_taken:
                                    k = counter
                                    succ_node = edge.dst
                                    for succ_ep in succ_node.eps:
                                        k -= succ_ep.cycles
                                        if k >= 0 and succ_ep.has_addkpc:
                                            addpkc_ist = succ_ep.get_addkpc_ist()
                                            return Addr(addpkc_ist.operands[0][-9:-1])
                            if node.out_not_taken:
                                for edge in node.out_not_taken:
                                    k = counter
                                    succ_node = edge.dst
                                    for succ_ep in succ_node.eps:
                                        k -= succ_ep.cycles
                                        if k >= 0 and succ_ep.has_addkpc:
                                            addkpc_ist = succ_ep.get_addkpc_ist()
                                            return Addr(addkpc_ist.operands[0][-9:-1])
            return None

        return None

    def _add_normal_cfg(self) -> None:
        """Second step: handling normal control flow."""
        qnodes: Deque[CFGNode] = deque(self.bnodes)
        self.cfg_nodes = []
        self.loop_head = {}
        ndct: Dict[Addr, CFGNode] = dict()  # mapping from address to node
        daddr: Dict[Addr, List[Tuple[Addr, CFGEdgeKind]]] = dict()
        nid = len(self.bnodes)
        while qnodes:
            node = qnodes.popleft()
            bfound = False
            for i, ep in enumerate(node.eps):
                for ist in ep.ists:
                    if ist.is_branch or ist.is_call:
                        bfound = True
                        counter = self.dslots - ist.get_cycles() + 1
                        break
                if bfound:
                    break

            if bfound:
                i += 1
                while i <= node.num_ep - 1 and counter > 0:
                    counter -= node.eps[i].cycles
                    if counter <= 0:
                        i += 1
                        break
                    i += 1
                if counter == 0:
                    if ist.is_djump and ist.get_dtarget() not in self.label_addr:
                        assert len(self.label_addr) == 0, "Unexpected LOOP label"
                        node1_eps = [ep for ep in self.exec_pkts
                                     if ep.start_addr < ist.get_dtarget()]
                        node2_eps = [ep for ep in self.exec_pkts
                                     if ep.start_addr >= ist.get_dtarget()]
                        ndct[self.start_addr] = CFGNode(node1_eps, 0)
                        ndct[ist.get_dtarget()] = CFGNode(node2_eps, 1)
                        break

                    dst_addr: List[Tuple[Addr, CFGEdgeKind]] = []
                    if ist.is_djump:
                        dst_addr.append((ist.get_dtarget(), CFGEdgeKind.TAKEN))

                    bb = CFGNode(node.eps[:i], node.nid)
                    bb.add_bist(ist)
                    next_node_addr: Optional[Addr] = None
                    if i == node.num_ep:
                        next_node_addr = self.next_entry(bb.start_addr)
                    else:
                        next_node = CFGNode(node.eps[i:], nid)
                        nid += 1
                        qnodes.append(next_node)
                        next_node_addr = node.eps[i].start_addr

                    if not ist.is_cond and (ist.is_indjump or ist.is_call):
                        ret_addr = self.get_ret_addr(ist, ep)
                        if ret_addr is not None:
                            dst_addr.append((ret_addr, CFGEdgeKind.NEVER_TAKEN))
                        elif next_node_addr is not None:
                            dst_addr.append((next_node_addr, CFGEdgeKind.NEVER_TAKEN))
                    if next_node_addr is not None and ist.is_cond_jump:
                        dst_addr.append((next_node_addr, CFGEdgeKind.NOT_TAKEN))
                    daddr[bb.start_addr] = dst_addr
                    ndct[bb.start_addr] = bb
                elif counter < 0:
                    ndct[node.start_addr] = node
                            
            if not bfound or counter > 0:
                bb = CFGNode([ep for ep in node.eps], node.nid)
                ne = self.next_entry(bb.start_addr)
                if ne is not None:
                    daddr[bb.start_addr] = [(ne, CFGEdgeKind.NOT_TAKEN)]
                ndct[bb.start_addr] = bb

            if node.start_addr not in ndct:
                raise CFGException("Step 2: node from %s should be added" \
                                   % str(node.start_addr))

        for addr, bb in ndct.items():
            if bb.start_addr not in daddr:
                continue
            for addr, btaken in daddr[bb.start_addr]:
                dst_bb = ndct[addr]
                if btaken == CFGEdgeKind.NOT_TAKEN:
                    new_cfg_edge(bb, dst_bb, CFGEdgeKind.NOT_TAKEN)
                elif btaken == CFGEdgeKind.TAKEN:
                    new_cfg_edge(bb, dst_bb, CFGEdgeKind.TAKEN)
                elif btaken == CFGEdgeKind.NEVER_TAKEN:
                    new_cfg_edge(bb, dst_bb, CFGEdgeKind.NEVER_TAKEN)
                else:
                    raise CFGException("Unexpected edge type: %s" % btaken)

        self.cfg_nodes = sorted([bb for _, bb in ndct.items()], key=lambda x: x.nid)

    def _handle_nested_branch(self):
        """ Handling nested branch. """

        def find_fall_through_block(addr: Addr) -> Optional[CFGNode]:
            """Find the nearest block after the given address."""
            block_addrs = sorted(ndct.keys())
            for block_addr in block_addrs:
                if block_addr > addr:
                    return ndct[block_addr]
            return None

        bct_seen: Set[Tuple[CFGNode, Tuple[BCounter, ...]]] = set()
        node_num = len(self.cfg_nodes)
        ndct = {node.start_addr: node for node in self.cfg_nodes}
        ist_after_bct: Dict[BCounter, Tuple[Tuple[Instruction, ...], ...]] = dict()
        ist_between_bct: Dict[Tuple[BCounter, BCounter], Tuple[EPacket, ...]] = dict()
        init_edge_info = (self.cfg_nodes[0].start_addr,
                          tuple(), dict(), dict(), set())

        worklist: Deque[EdgeInfo] = deque([init_edge_info])
        while worklist:
            edge_info = worklist.popleft()
            node_addr = edge_info[0]
            bcts = edge_info[1]
            ist_after_bct = edge_info[2]
            ist_between_bct = edge_info[3]
            creg_state = edge_info[4]
            assert len(ist_after_bct) == len(bcts)
            assert len(ist_between_bct) == len(bcts) * (len(bcts) - 1) // 2
            has_zero_counter = False
            branch_ist: Optional[Instruction] = None
            node = ndct[node_addr]
            if (node, bcts) in bct_seen:
                continue
            bct_seen.add((node, bcts))
            for i, ep in enumerate(node.eps):
                assert len(set(bct[1] for bct in bcts)) == len(bcts), \
                    "Two branch counters have the same counter value"
                if any(c_d <= 0 for _, c_d in bcts):
                    raise CFGException("Non-positive branch counter")
                bcts = tuple((_, c - ep.cycles)
                             for _, c in bcts
                             if c - ep.cycles >= 0)
                ist_after_bct = {(_, c - ep.cycles): mod_reg_ists
                                 for (_, c), mod_reg_ists
                                 in ist_after_bct.items()
                                 if c - ep.cycles >= 0}
                ist_between_bct = {((_bist1, c1 - ep.cycles),
                                    (_bist2, c2 - ep.cycles)): mod_reg_ists
                                   for ((_bist1, c1), (_bist2, c2)), mod_reg_ists
                                   in ist_between_bct.items()
                                   if c1 >= ep.cycles and c2 >= ep.cycles}
                creg_state = {(_, c - ep.cycles) for _, c in creg_state
                              if c - ep.cycles >= 0}
                modify_reg_ist = []
                for reg in cond_reg:
                    for ep_ist in ep.ists:
                        if ep_ist.modifies_reg(reg):
                            modify_reg_ist.append(ep_ist)
                for ist in ep.ists:
                    if ist.name in ("B", "BNOP", "CALLP"):
                        ist_dslots = self.dslots - ep.cycles + 1
                        new_bct = (ist, ist_dslots)
                        ist_after_bct[new_bct] = []
                        for bct in bcts:
                            ist_between_bct[(bct, new_bct)] = \
                                [ist for ist in ist_after_bct[bct]]
                        bcts += (new_bct,)
                if modify_reg_ist:
                    for bct in ist_after_bct:
                        ist_after_bct[bct].append(tuple(modify_reg_ist))

                zero_bcts = [bct for bct in bcts if bct[1] == 0]
                non_zero_bcts = tuple([bct for bct in bcts if bct[1] != 0])
                if not zero_bcts:  # no counter reaches zero
                    continue
                else:
                    assert len(zero_bcts) == 1
                    zero_bct = zero_bcts[0]
                    has_zero_counter = True
                    break

            bb2: Optional[CFGNode] = None  # the succeeded block
            if i != node.num_ep - 1:
                bb1, bb2 = node.split_block(i + 1, node_num)
                for _bist in node.bist:
                    bb2.add_bist(_bist)
                node_num += 1
                ndct[bb2.start_addr] = bb2
                ndct[bb1.start_addr] = bb1
            else:
                bb1 = node
                bb2 = find_fall_through_block(bb1.start_addr)

            # add fall-through edge
            if has_zero_counter:
                branch_ist = zero_bct[0]
                bb1.add_bist(branch_ist)

                if bb2 is not None:
                    new_cfg_edge(bb1, bb2, CFGEdgeKind.NOT_TAKEN)

                if zero_bct in creg_state:
                    creg_state.remove(zero_bct)
                    if zero_bct[0].is_call:
                        assert len(non_zero_bcts) == 0, "deliver delaying branch to a function call"
                        ret_addr = self.get_ret_addr(branch_ist)
                        new_ist_after_bct = dict()
                        new_ist_between_bct = dict()
                        if ret_addr is not None:
                            worklist.append((ret_addr, non_zero_bcts,
                                             new_ist_after_bct, new_ist_between_bct, creg_state))
                            new_cfg_edge(bb1, ndct[ret_addr], CFGEdgeKind.NEVER_TAKEN)

                    if (zero_bct[0].is_call or zero_bct[0].is_indjump) and bb2 is not None:
                        new_cfg_edge(bb1, bb2, CFGEdgeKind.NEVER_TAKEN)

                elif bb2 is not None and branch_ist.is_cond_jump:
                    cond_name = get_cond_name(branch_ist.cond)
                    new_non_zero_bcts = non_zero_bcts
                    new_ist_after_bct = {k: v for k, v in ist_after_bct.items()}
                    new_ist_between_bct = {k: v for k, v in ist_between_bct.items()}
                    del new_ist_after_bct[zero_bct]
                    for bct in non_zero_bcts:
                        if bct[0].is_cond:
                            modify_reg_ists = ist_between_bct[(zero_bct, bct)]
                            reg_val = False
                            if branch_ist.cond.startswith("!"):
                                reg_val = True
                            cs = CondState(modify_reg_ists, reg_name=cond_name, reg_val=reg_val)
                            cs.run_state()
                            nz_cond = cs.eval_cond(bct[0].cond)
                            # check if we can delete this non_zero branch counter
                            if isinstance(nz_cond, bool):
                                if not nz_cond:
                                    new_non_zero_bcts = tuple(c for c in new_non_zero_bcts if c != bct)
                                    del new_ist_after_bct[bct]
                                    pop_keys = [key for key in new_ist_between_bct if bct in key]
                                    for key in pop_keys:
                                        del new_ist_between_bct[key]
                                else:  # the branch condition is true
                                    creg_state.add(bct)

                    pop_keys = [key for key in new_ist_between_bct if zero_bct in key]
                    for key in pop_keys:
                        del new_ist_between_bct[key]
                    worklist.append((bb2.start_addr, new_non_zero_bcts,
                                     new_ist_after_bct, new_ist_between_bct, creg_state))

                elif not branch_ist.is_cond and (branch_ist.is_indjump or branch_ist.is_call):
                    ret_addr = self.get_ret_addr(branch_ist)
                    if branch_ist.is_call:
                        assert len(non_zero_bcts) == 0, "deliver delaying branch to a function call"
                    new_ist_after_bct = copy.deepcopy(ist_after_bct)
                    del new_ist_after_bct[zero_bct]
                    new_ist_between_bct = copy.deepcopy(ist_between_bct)
                    pop_keys = [key for key in new_ist_between_bct if zero_bct in key]
                    for key in pop_keys:
                        del new_ist_between_bct[key]
                    if ret_addr is not None:
                        worklist.append((ret_addr, non_zero_bcts,
                                         new_ist_after_bct, new_ist_between_bct, creg_state))
                        new_cfg_edge(bb1, ndct[ret_addr], CFGEdgeKind.NEVER_TAKEN)
                    elif bb2 is not None:
                        worklist.append((bb2.start_addr, non_zero_bcts,
                                         new_ist_after_bct, new_ist_between_bct, creg_state))
                        new_cfg_edge(bb1, bb2, CFGEdgeKind.NEVER_TAKEN)

            else:
                f = find_fall_through_block(node.start_addr)  # fall-through block
                if f is not None:
                    new_cfg_edge(bb1, f, CFGEdgeKind.NOT_TAKEN)
                    new_ist_after_bct = copy.deepcopy(ist_after_bct)
                    new_ist_between_bct = copy.deepcopy(ist_between_bct)
                    worklist.append((f.start_addr, non_zero_bcts,
                                     new_ist_after_bct, new_ist_between_bct, creg_state))

            if branch_ist is not None and branch_ist.is_djump:
                bb1.add_bist(branch_ist)
                target_block = ndct[branch_ist.get_dtarget()]
                new_cfg_edge(bb1, target_block, CFGEdgeKind.TAKEN)
                new_non_zero_bcts = non_zero_bcts
                new_ist_after_bct = copy.deepcopy(ist_after_bct)
                new_ist_between_bct = copy.deepcopy(ist_between_bct)
                del new_ist_after_bct[zero_bct]
                if branch_ist.is_cond_jump:
                    not_reg = branch_ist.cond
                    if not_reg[0] == '!':
                        not_reg = not_reg[1:]
                    else:
                        not_reg = '!' + not_reg
                    for bct in non_zero_bcts:
                        if bct[0].is_cond:
                            cond_name = get_cond_name(branch_ist.cond)
                            modify_reg_ists = ist_between_bct[(zero_bct, bct)]
                            reg_val = True
                            if branch_ist.cond.startswith("!"):
                                reg_val = False
                            cs = CondState(modify_reg_ists, reg_name=cond_name, reg_val=reg_val)
                            cs.run_state()
                            nz_cond = cs.eval_cond(bct[0].cond)
                            if isinstance(nz_cond, bool):
                                if not nz_cond:
                                    new_non_zero_bcts = tuple(c for c in new_non_zero_bcts if c != bct)
                                    del new_ist_after_bct[bct]
                                    pop_keys = [key for key in new_ist_between_bct if bct in key]
                                    for key in pop_keys:
                                        del new_ist_between_bct[key]
                                else:
                                    creg_state.add(bct)
                pop_keys = [key for key in new_ist_between_bct if zero_bct in key]
                for key in pop_keys:
                    del new_ist_between_bct[key]
                worklist.append((target_block.start_addr, new_non_zero_bcts,
                                 new_ist_after_bct, new_ist_between_bct, creg_state))

        self.cfg_nodes = sorted([bb for _, bb in ndct.items()], key=lambda x: x.nid)

    def _refine_fall_through_edge(self) -> None:
        """delete redundant not-taken edge"""
        useful_edge: List[CFGEdge] = []

        bct_seen: Set[Tuple[CFGNode, Tuple[BCounter, ...]]] = set()
        ist_after_bct: Dict[BCounter, Tuple[Tuple[Instruction, ...], ...]] = dict()
        ist_between_bct: Dict[Tuple[BCounter, BCounter], Tuple[EPacket, ...]] = dict()
        init_edge_info = (self.cfg_nodes[0].start_addr,
                          tuple(), dict(), dict(), set())

        worklist: Deque[EdgeInfo] = deque([init_edge_info])
        while worklist:
            edge_info = worklist.popleft()
            node_addr = edge_info[0]
            bcts = edge_info[1]
            ist_after_bct = edge_info[2]
            ist_between_bct = edge_info[3]
            creg_state = edge_info[4]

            assert len(ist_after_bct) == len(bcts)
            assert len(ist_between_bct) == len(bcts) * (len(bcts) - 1) // 2

            has_zero_counter = False
            branch_ist: Optional[Instruction] = None
            node = [node for node in self.cfg_nodes if node.start_addr == node_addr][0]
            if (node, bcts) in bct_seen:
                continue
            bct_seen.add((node, bcts))

            for i, ep in enumerate(node.eps):
                assert len(set(bct[1] for bct in bcts)) == len(bcts), \
                    "Two branch counters have the same counter value"
                if any(c_d <= 0 for _, c_d in bcts):
                    raise CFGException("Non-positive branch counter")
                bcts = tuple((_, c - ep.cycles)
                             for _, c in bcts
                             if c - ep.cycles >= 0)
                ist_after_bct = {(_, c - ep.cycles): mod_reg_ists
                                 for (_, c), mod_reg_ists
                                 in ist_after_bct.items()
                                 if c - ep.cycles >= 0}
                ist_between_bct = {((_bist1, c1 - ep.cycles),
                                    (_bist2, c2 - ep.cycles)): mod_reg_ists
                                   for ((_bist1, c1), (_bist2, c2)), mod_reg_ists
                                   in ist_between_bct.items()
                                   if c1 >= ep.cycles and c2 >= ep.cycles}
                creg_state = {(_, c - ep.cycles) for _, c in creg_state
                              if c - ep.cycles >= 0}
                modify_reg_ist = []
                for reg in cond_reg:
                    for ep_ist in ep.ists:
                        if ep_ist.modifies_reg(reg):
                            modify_reg_ist.append(ep_ist)
                for ist in ep.ists:
                    if ist.name in ("B", "BNOP", "CALLP"):
                        ist_dslots = self.dslots - ep.cycles + 1
                        new_bct = (ist, ist_dslots)
                        ist_after_bct[new_bct] = []
                        for bct in bcts:
                            ist_between_bct[(bct, new_bct)] = \
                                [ist for ist in ist_after_bct[bct]]
                        bcts += (new_bct,)
                if modify_reg_ist:
                    for bct in ist_after_bct:
                        ist_after_bct[bct].append(tuple(modify_reg_ist))

                zero_bcts = [bct for bct in bcts if bct[1] == 0]
                non_zero_bcts = tuple([bct for bct in bcts if bct[1] != 0])
                if not zero_bcts:  # no counter reaches zero
                    continue
                else:
                    assert len(zero_bcts) == 1
                    zero_bct = zero_bcts[0]
                    has_zero_counter = True
                    break

            assert i == node.num_ep - 1, "unhandled bct in _handled_nested_branch"
            bb2: Optional[CFGNode] = None  # the succeeded block
            bb1 = node
            if bb1.out_not_taken:
                assert len(bb1.out_not_taken) == 1, "node %i more than 1 out not taken" % bb1.nid
                bb2 = bb1.out_not_taken[0].dst

            if has_zero_counter:
                branch_ist = zero_bct[0]

                if zero_bct in creg_state:
                    creg_state.remove(zero_bct)
                    if zero_bct[0].is_call:
                        ret_addr = self.get_ret_addr(branch_ist)
                        new_ist_after_bct = dict()
                        new_ist_between_bct = dict()
                        if ret_addr is not None:
                            worklist.append((ret_addr, non_zero_bcts,
                                             new_ist_after_bct, new_ist_between_bct, creg_state))

                elif bb2 is not None and branch_ist.is_cond_jump:
                    cond_name = get_cond_name(branch_ist.cond)
                    new_non_zero_bcts = non_zero_bcts
                    new_ist_after_bct = {k: v for k, v in ist_after_bct.items()}
                    new_ist_between_bct = {k: v for k, v in ist_between_bct.items()}
                    del new_ist_after_bct[zero_bct]
                    for bct in non_zero_bcts:
                        if bct[0].is_cond:
                            modify_reg_ists = ist_between_bct[(zero_bct, bct)]
                            reg_val = False
                            if branch_ist.cond.startswith("!"):
                                reg_val = True
                            cs = CondState(modify_reg_ists, reg_name=cond_name, reg_val=reg_val)
                            cs.run_state()
                            nz_cond = cs.eval_cond(bct[0].cond)
                            if isinstance(nz_cond, bool):
                                if not nz_cond:
                                    new_non_zero_bcts = tuple(c for c in new_non_zero_bcts if c != bct)
                                    del new_ist_after_bct[bct]
                                    pop_keys = [key for key in new_ist_between_bct if bct in key]
                                    for key in pop_keys:
                                        del new_ist_between_bct[key]
                                else:  # the branch condition is true
                                    creg_state.add(bct)

                    pop_keys = [key for key in new_ist_between_bct if zero_bct in key]
                    for key in pop_keys:
                        del new_ist_between_bct[key]
                    worklist.append((bb2.start_addr, new_non_zero_bcts,
                                     new_ist_after_bct, new_ist_between_bct, creg_state))

                    if bb1.out_not_taken[0] not in useful_edge:
                        useful_edge.append(bb1.out_not_taken[0])

                elif not branch_ist.is_cond and (branch_ist.is_indjump or branch_ist.is_call):
                    ret_addr = self.get_ret_addr(branch_ist)
                    new_ist_after_bct = copy.deepcopy(ist_after_bct)
                    del new_ist_after_bct[zero_bct]
                    new_ist_between_bct = copy.deepcopy(ist_between_bct)
                    pop_keys = [key for key in new_ist_between_bct if zero_bct in key]
                    for key in pop_keys:
                        del new_ist_between_bct[key]
                    if ret_addr is not None:
                        worklist.append((ret_addr, non_zero_bcts,
                                         new_ist_after_bct, new_ist_between_bct, creg_state))
                    elif bb2 is not None:
                        worklist.append((bb2.start_addr, non_zero_bcts,
                                         new_ist_after_bct, new_ist_between_bct, creg_state))

            else:
                if bb2 is not None:
                    new_ist_after_bct = copy.deepcopy(ist_after_bct)
                    new_ist_between_bct = copy.deepcopy(ist_between_bct)
                    worklist.append((bb2.start_addr, non_zero_bcts,
                                     new_ist_after_bct, new_ist_between_bct, creg_state))

                    if bb1.out_not_taken[0] not in useful_edge:
                        useful_edge.append(bb1.out_not_taken[0])

            # go taken edge
            if branch_ist is not None and branch_ist.is_djump:
                target_block = [node for node in self.cfg_nodes if node.start_addr == branch_ist.get_dtarget()][0]
                new_non_zero_bcts = non_zero_bcts
                new_ist_after_bct = copy.deepcopy(ist_after_bct)
                new_ist_between_bct = copy.deepcopy(ist_between_bct)
                del new_ist_after_bct[zero_bct]
                if branch_ist.is_cond_jump:
                    not_reg = branch_ist.cond
                    if not_reg[0] == '!':
                        not_reg = not_reg[1:]
                    else:
                        not_reg = '!' + not_reg
                    for bct in non_zero_bcts:
                        if bct[0].is_cond:
                            cond_name = get_cond_name(branch_ist.cond)
                            modify_reg_ists = ist_between_bct[(zero_bct, bct)]
                            reg_val = True
                            if branch_ist.cond.startswith("!"):
                                reg_val = False
                            cs = CondState(modify_reg_ists, reg_name=cond_name, reg_val=reg_val)
                            cs.run_state()
                            nz_cond = cs.eval_cond(bct[0].cond)
                            if isinstance(nz_cond, bool):
                                if not nz_cond:
                                    new_non_zero_bcts = tuple(c for c in new_non_zero_bcts if c != bct)
                                    del new_ist_after_bct[bct]
                                    pop_keys = [key for key in new_ist_between_bct if bct in key]
                                    for key in pop_keys:
                                        del new_ist_between_bct[key]
                                else:
                                    creg_state.add(bct)
                pop_keys = [key for key in new_ist_between_bct if zero_bct in key]
                for key in pop_keys:
                    del new_ist_between_bct[key]
                worklist.append((target_block.start_addr, new_non_zero_bcts,
                                 new_ist_after_bct, new_ist_between_bct, creg_state))

        for node in self.cfg_nodes:
            for edge in node.out_not_taken:
                if not edge in useful_edge:
                    node.out_not_taken.remove(edge)
                if node.out_not_taken != [] and node.out_never_taken is not None and node.out_never_taken != []:
                    node.out_never_taken = None

    def create_cfg(self) -> None:
        """Create a CFG."""
        self._add_normal_cfg()
        self._handle_nested_branch()
        self._refine_fall_through_edge()
        self._identify_loops()

    def _loop_check(self, start_node: CFGNode, end_node: CFGNode) -> None:
        """
        If there is a loop path across given start and end node,
        mark the start node as loop head and end node as loop tail.
        """

        def check_loop_tail(head: CFGNode, tail: CFGNode) -> None:
            """Check and add dummy node if head have more than one loop tails."""
            if head.start_addr not in self.loop_head:
                self.loop_head[head.start_addr] = tail
                return

            assert any(edge for edge in tail.out_taken
                       if edge.src == tail and edge.dst == head)
            assert any(edge for edge in head.in_edges
                       if edge.src == tail and edge.dst == head)
            tail.out_taken = [edge for edge in tail.out_taken
                              if not (edge.src == tail and edge.dst == head)]
            head.in_edges = [edge for edge in head.in_edges
                             if not (edge.src == tail and edge.dst == head)]

            t = self.loop_head[head.start_addr]
            if head != tail:
                tail.set_loop_role(LoopKind.LOOP_BODY)
            else:
                tail.set_loop_role(LoopKind.LOOP_HEAD)
            if isinstance(t, CFGDummyNode):
                new_cfg_edge(tail, t, CFGEdgeKind.TAKEN)
            elif isinstance(t, CFGNode):
                t.set_loop_role(LoopKind.LOOP_BODY)
                dummy_node_num = len([k for _, k in self.loop_head.items()
                                      if isinstance(k, CFGDummyNode)])
                global dummy_start_addr
                dummy_tail = CFGDummyNode(len(self.cfg_nodes) + dummy_node_num,
                                          dummy_start_addr)
                dummy_start_addr += Addr(4)
                self.loop_head[head.start_addr] = dummy_tail
                # create edge: tail -> dummy
                new_cfg_edge(tail, dummy_tail, CFGEdgeKind.TAKEN)
                # create edge: dummy ->  head
                new_cfg_edge(dummy_tail, head, CFGEdgeKind.TAKEN)
                # delete edge: t -> head
                t.out_taken = [edge for edge in t.out_taken
                               if not (edge.src == t and edge.dst == head)]
                head.in_edges = [edge for edge in head.in_edges
                                 if not (edge.src == t and edge.dst == head)]
                # create edge: t ->dummy
                new_cfg_edge(t, dummy_tail, CFGEdgeKind.TAKEN)

        if start_node.nid == end_node.nid:
            self.__has_loop = True
            start_node.set_loop_role(LoopKind.LOOP_SELF)
            check_loop_tail(start_node, start_node)
            return
        worklist = deque([start_node])
        start_node.set_flags(end_node.nid)
        while worklist:
            bb = worklist.popleft()
            if bb.nid == end_node.nid:
                self.__has_loop = True
                start_node.set_loop_role(LoopKind.LOOP_HEAD)
                end_node.set_loop_role(LoopKind.LOOP_TAIL)
                check_loop_tail(start_node, end_node)
                break
            if bb.out_not_taken:
                for edge in bb.out_not_taken:
                    ndst = edge.dst
                    if ndst.flags != end_node.nid:
                        worklist.append(ndst)
                    ndst.set_flags(end_node.nid)
            if bb.out_taken:
                for edge in bb.out_taken:
                    tdst = edge.dst
                    if tdst.flags != end_node.nid:
                        worklist.append(tdst)
                        tdst.set_flags(end_node.nid)
            if bb.out_never_taken is not None and not bb.is_ret():
                nt_dst = bb.out_never_taken.dst
                if nt_dst.flags != end_node.nid:
                    worklist.append(nt_dst)
                    nt_dst.set_flags(end_node.nid)

    def _identify_loops(self) -> None:
        """Find and mark the cfg nodes which is loop head, tail, or both."""
        if not self.cfg_nodes:
            raise CFGException("No CFG node")

        for node in reversed(self.cfg_nodes):
            if not node.out_taken:
                continue
            for edge in node.out_taken:
                src_addr = node.start_addr
                dst_addr = edge.dst.start_addr
                if dst_addr <= src_addr:
                    self._loop_check(edge.dst, node)

        if self.__has_loop is None:
            self.__has_loop = False

        for node in self.cfg_nodes:
            node.set_flags(0)

        self.cfg_nodes += \
            sorted([dnode for _, dnode in self.loop_head.items()
                    if isinstance(dnode, CFGDummyNode)], key=lambda x: x.start_addr)

    @property
    def has_loop(self) -> Optional[bool]:
        return self.__has_loop

    @property
    def entry_node(self) -> CFGNode:
        """Return the entry node of CFG."""
        if not self.cfg_nodes:
            raise CFGException("CFG %s is not built now" % self.name)
        return min(self.cfg_nodes, key=lambda n: n.start_addr)

    def dump_cfg(self) -> None:
        """
        Dump the CFG in the following format
        """
        s = "%s: cfg\n" % self.name
        for node in self.cfg_nodes:
            dsts = set()
            for edge in node.out_taken:
                dsts.add(edge.dst.nid)
            for edge in node.out_not_taken:
                dsts.add(edge.dst.nid)
            if node.out_never_taken is not None:
                dsts.add(node.out_never_taken.dst.nid)
            s += "%s : %s : [%s]\n" % \
                 (node.nid, node.start_addr, ", ".join(str(dst) for dst in dsts))

        print(s)

    def dump_fig(self, to_svg: bool = False, display_bist: bool = False) -> graphviz.Digraph:
        """
        Return the CFG graph.
        """
        if not self.cfg_nodes:
            raise CFGException("CFG is not built now %s" % self.name)

        dot = graphviz.Digraph('%s' % self.name)
        for cn in self.cfg_nodes:
            label = "%s\n0x%s" % (cn.nid, cn.start_addr)
            if display_bist:
                label += "\n%s" % "\n".join(str(bist) + " " + str(bist.is_ret) for bist in cn.bist)
            if cn.loop_role != LoopKind.LOOP_BODY:
                label += "\n%s" % cn.loop_role
            if isinstance(cn, CFGDummyNode):
                dot.node(str(cn.nid), label=label, shape="diamond", style="rounded, filled")
            else:
                dot.node(str(cn.nid), label=label)
            for edge in cn.out_taken:
                dot.edge(str(edge.src.nid), str(edge.dst.nid), color='lightcoral')
            for edge in cn.out_not_taken:
                dot.edge(str(edge.src.nid), str(edge.dst.nid))
            if cn.out_never_taken is not None:
                dot.edge(str(cn.out_never_taken.src.nid), str(cn.out_never_taken.dst.nid), style="dashed")
        if to_svg:
            dot.format = 'svg'
            dot.render(directory='output').replace('\\', '/')
        return dot

    def get_offset_ist(self, offset: str) -> Instruction:
        """Return the instruction on the offset from start address."""
        assert offset.startswith("0x")
        assert all(c in string.hexdigits for c in offset[2:])
        ist_addr = self.start_addr + Addr(offset)
        if ist_addr > self.code[-1].addr:
            raise CFGException("Offset overflow: %s" % offset)
        for ist in self.code:
            if isinstance(ist, Instruction) and ist_addr == ist.addr:
                return ist

        raise TCFGException("Can't find instruction on address %s" % ist_addr)

    def find_cfg_node(self, addr: Addr) -> CFGNode:
        """Return the cfg node starting from given address."""
        if not self.cfg_nodes:
            raise CFGException("CFG is not available now.")

        for node in self.cfg_nodes:
            if node.start_addr == addr:
                return node

        raise CFGException("Can't find cfg node starting from %s" % addr)


class Prog:
    """Program type.

    - file_name: the program file
    """

    def __init__(self, file_name: str,
                 jtable: Optional[str] = None, dslots: int = 5) -> None:

        self.procs: List[Proc] = []
        self.tcfg_nodes: List[TCFGNode] = []
        self.dslots: int = dslots

        if jtable is not None:
            assert jtable.endswith(".json")

        if jtable is not None:
            assert file_name is not None

        self.file_name = file_name
        self.ill_ret_proc: Tuple[str, ...] = tuple()
        self.jtable = jtable
        self.back_point: Sequence[str] = []

        if self.file_name is not None:
            self.read_file(self.file_name)
            if self.jtable is not None:
                self.read_jtable(self.jtable)

        self.inline_relation: List[Tuple[int, str]] = []
        self.neg_proc: Sequence[str] = ["printf"]

    def __str__(self) -> str:
        return "\n".join(proc.name for proc in self.procs)

    def read_file(self, file_name: str) -> None:
        """Parse the disassembly file."""
        assert file_name.endswith(".asm"), \
            "Invalid disassembly file name %s" % file_name
        with open(file_name, "r", encoding="UTF-8") as f:
            da = [line.strip() if line != "\n" else line for line in f.readlines()]

        cur_proc_addr: Optional[str] = None

        sections = [list(g) for k, g in
                    itertools.groupby(da, lambda x: x == "\n") if not k]
        text_sections = [section[1:] for section in sections
                         if section[0].startswith("TEXT")]

        self.procs = []
        pid = 0  # proc id
        for lines in text_sections:
            proc_name = lines[0].split()[1][:-1]
            code: List[Instruction] = []
            labels: List[Addr] = []
            for l in lines[1:]:
                words = l.split()
                if len(words) == 2:
                    addr, name = words
                    if name.startswith(".") or addr == cur_proc_addr:
                        continue
                    name = name[:-1] if name.endswith(":") else name
                    if name.startswith("$C$") or name.startswith("Back_Point"):  # label
                        if addr not in labels:
                            labels.append(Addr(addr))
                    elif name.startswith("LOOP"):
                        pass
                    elif code:
                        self.procs.append(Proc(pid, proc_name, code, labels, self.dslots))
                        proc_name = name
                        cur_proc_addr = addr
                        code, labels = [], []
                        pid += 1
                elif len(words) > 2 and words[2] == ".fphead":
                    fp_header = parse_fpheader(l)
                    code.append(fp_header)
                else:
                    inst = parse_ist(l)
                    code.append(inst)
            self.procs.append(Proc(pid, proc_name, code, labels, self.dslots))

        self.proc_map = {proc.start_addr: proc for proc in self.procs}

    def read_jtable(self, jtable: str) -> None:
        """Read the (common) jump table."""
        assert jtable.endswith(".json"), "%s should be a JSON file" % jtable
        d = {_proc.name: _proc.start_addr for _proc in self.procs}
        with open(jtable, 'r') as f:
            data = json.load(f)
        for _p in data['proc']:
            proc_name = _p['proc_name']
            if not self.has_proc(proc_name):
                continue
            proc = self.get_proc(proc_name)
            for _j in _p['jtable']:
                offset = _j['offset']
                target_names = _j['target_name']
                for target_name in target_names:
                    assert target_name in d and target_name != proc_name, target_name
                    ist = proc.get_offset_ist(offset)
                    ist.add_ind_target(d[target_name])
            if "ret_target" in _p:  # the target node after return instruction
                target_offset = _p["ret_target"]["target_offset"]
                target_name = _p["ret_target"]["target_name"]
                addr = d[target_name] + Addr(target_offset)
                assert target_name in d and target_name != proc_name
                proc.ret_bbi_addr = addr
            if "ret_inst_offset" in _p:  # the return instruction
                for offset in _p["ret_inst_offset"]:
                    ist = proc.get_offset_ist(offset)
                    ist.is_ret = True
        if "ill_ret_proc" in data:  # procedures which do not contain return instruction
            self.ill_ret_proc = tuple(data["ill_ret_proc"])

    def build_cfgs(self, dump_name: bool = False) -> None:
        """Build CFG for each procedure in the prog."""
        for proc in self.procs:
            if dump_name:
                print(proc.name)
            proc.create_cfg()

    def build_proc(self, name: str) -> None:
        proc = self.get_proc(name)
        proc.create_cfg()

    def has_proc(self, name: str) -> bool:
        for proc in self.procs:
            if proc.name == name:
                return True
        return False

    def get_proc(self, name: str) -> Proc:
        for proc in self.procs:
            if proc.name == name:
                return proc

        raise CFGException("Proc %s is not found" % name)

    def proc_inline(self, proc_name: str,
                    call_bbi: Optional[TCFGNode],
                    ret_bbi: Optional[TCFGNode], end_addr: Optional[Addr] = None) -> Optional[TCFGNode]:
        """TODO: refactoring, the code style is terrible now."""
        jump_node = dict()

        def find_jump_node(ist: Instruction) -> List[TCFGNode]:
            if ist not in jump_node:
                jump_node[ist] = [node for _, node in
                                  tcfg_dict.items() if ist in node.bb.bist]
            return jump_node[ist]

        if call_bbi is not None:
            if (call_bbi.nid, proc_name) in self.inline_relation:
                return None
            self.inline_relation.append((call_bbi.nid, proc_name))
        proc = self.get_proc(proc_name)
        tcfg_dict: Dict[Addr, TCFGNode] = dict()

        start_nid = len(self.tcfg_nodes)
        for bb in proc.cfg_nodes:
            if end_addr is not None and bb.start_addr > end_addr:
                continue
            tcfg_dict[bb.start_addr] = TCFGNode(bb, proc_name, start_nid)
            start_nid += 1

        for bb in proc.cfg_nodes:
            if end_addr is not None and bb.start_addr >= end_addr:
                continue
            src = tcfg_dict[bb.start_addr]
            for edge in bb.out_taken:
                if end_addr is not None and edge.dst.start_addr > end_addr:
                    continue
                dst = tcfg_dict[edge.dst.start_addr]
                new_tcfg_edge(src, dst, TCFGEdgeKind.TAKEN)
            for edge in bb.out_not_taken:
                if end_addr is not None and edge.dst.start_addr > end_addr:
                    continue
                dst = tcfg_dict[edge.dst.start_addr]
                new_tcfg_edge(src, dst, TCFGEdgeKind.NOT_TAKEN)
            if bb.out_never_taken is not None:
                if end_addr is not None and bb.out_never_taken.dst.start_addr > end_addr:
                    continue
                dst = tcfg_dict[bb.out_never_taken.dst.start_addr]
                new_tcfg_edge(src, dst, TCFGEdgeKind.NEVER_TAKEN)

        if call_bbi is not None:
            entry_tnode = tcfg_dict[proc.entry_node.start_addr]
            new_tcfg_edge(call_bbi, entry_tnode, TCFGEdgeKind.CALL)

        self.tcfg_nodes += [bb for _, bb in tcfg_dict.items()]

        for _, t_node in tcfg_dict.items():
            for ep in t_node.bb.eps:
                for ist in ep.ists:
                    if ist.is_call:
                        cname, _ = ist.get_callee()
                        if cname == proc.name:
                            raise TCFGException("Recursive call is not supported now")
                        ret_addr = proc.get_ret_addr(ist, ep)
                        if end_addr is not None and ret_addr \
                                is not None and ret_addr > end_addr:
                            continue
                        if ret_addr is not None:
                            ret_node = tcfg_dict[ret_addr]
                        else:
                            ret_node = None
                        for call_node in find_jump_node(ist):
                            if cname not in self.neg_proc:
                                self.proc_inline(cname, call_bbi=call_node, ret_bbi=ret_node)
                            elif not call_node.bb.out_taken and not call_node.bb.out_not_taken and \
                                    call_node.bb.out_never_taken is not None:
                                never_taken_edge = call_node.out_edges[0]
                                assert never_taken_edge.edge_kind == TCFGEdgeKind.NEVER_TAKEN
                                never_taken_edge.edge_kind = TCFGEdgeKind.NOT_TAKEN

                for ist in ep.ists:
                    if ist.is_indjump and ist.ind_target:
                        for addr in ist.ind_target:
                            ret_addr = proc.get_ret_addr(ist, ep)
                            if end_addr is not None and \
                                    ret_addr is not None and ret_addr > end_addr:
                                continue
                            if ret_addr is not None:
                                ret_node = tcfg_dict[ret_addr]
                            elif proc_name in self.ill_ret_proc:
                                ret_node = ret_bbi
                            else:
                                ret_node = None
                            for call_node in find_jump_node(ist):
                                cname = self.proc_map[addr].name
                                if cname not in self.neg_proc:
                                    self.proc_inline(self.proc_map[addr].name,
                                                     call_bbi=call_node, ret_bbi=ret_node)
                                elif not call_node.bb.out_taken and not call_node.bb.out_not_taken and \
                                        call_node.bb.out_never_taken is not None:
                                    never_taken_edge = call_node.out_edges[0]
                                    assert never_taken_edge.edge_kind == TCFGEdgeKind.NEVER_TAKEN
                                    never_taken_edge.edge_kind = TCFGEdgeKind.NOT_TAKEN
        if proc_name in self.ill_ret_proc:
            return None

        ret_insts = [ist for ist in proc.code if ist.is_ret]
        if ret_insts:
            exit_nodes = [node for ist in ret_insts for node in find_jump_node(ist)]
            for exit_node in exit_nodes:
                if ret_bbi is not None:
                    new_tcfg_edge(exit_node, ret_bbi, TCFGEdgeKind.RET)
                elif proc.ret_bbi_addr is not None:
                    _tn = self.get_tnode(proc.ret_bbi_addr)
                    if _tn is not None:
                        new_tcfg_edge(exit_node, _tn, TCFGEdgeKind.RET)
        else:
            fall_through_proc = self.find_next_proc(proc_name)
            last_tcfg_node_addr = max(tcfg_dict.keys(), key=lambda x: x.addr)
            last_tcfg_node = tcfg_dict[last_tcfg_node_addr]
            self.proc_inline(fall_through_proc.name, last_tcfg_node, None)
        return tcfg_dict[proc.cfg_nodes[0].start_addr]

    def find_next_proc(self, proc_name: str) -> Proc:
        proc = self.get_proc(proc_name)
        next_proc_start_addr = proc.code[-1].addr + len(proc.code[-1].opcode) // 2
        return self.find_proc(next_proc_start_addr)

    def find_proc(self, addr: Addr) -> Proc:
        for proc in self.procs:
            if proc.start_addr == addr:
                return proc
        raise CFGException("can't find proc at %s" % addr)

    def build_tcfg(self, start: str = "main", end_addr: Optional[Addr] = None) -> None:
        self.tcfg_nodes = []
        self.inline_relation.clear()
        self.proc_inline(start, None, None, end_addr=end_addr)
        assert all(node.nid == i for i, node in enumerate(self.tcfg_nodes))

    def dump_call_graph(self, start="main") -> None:
        call_graph: Dict[str, List[str]] = dict()

        def add_call(caller: str, callee: str) -> None:
            if caller not in call_graph:
                call_graph[caller] = [callee]
            elif callee not in call_graph[caller]:
                call_graph[caller].append(callee)

        for node in self.tcfg_nodes:
            for edge in node.out_edges:
                if edge.edge_kind == TCFGEdgeKind.CALL:
                    add_call(edge.src.proc_name, edge.dst.proc_name)

        def rec(p: str, indent: str = "  ") -> str:
            if p not in call_graph:
                return p
            s = "%s" % p
            for callee in call_graph[p]:
                s += "\n%s%s" % (indent, rec(callee, "  " + indent))
            return s

        print(rec(start))

    def add_dline(self):
        if not self.tcfg_nodes:
            raise CFGException("TCFG is not built now")
        dline_path = self.file_name[:-3] + 'dline'
        if not os.path.exists(dline_path):
            raise CFGException("dline file: " + dline_path + " doesn't exist")
        with open(dline_path) as f:
            flag = False
            lines = f.readlines()
            for i in range(len(lines)):
                line = ' '.join(lines[i].split())
                contents = line.split()
                if flag:
                    if not contents or contents[0][0:2] != '0x':
                        flag = False
                        continue
                    addr = Addr(contents[0])
                    line_no = int(contents[2])
                    for node in self.tcfg_nodes:
                        if node.bb.start_addr <= addr <= node.bb.eps[-1].end_addr:
                            node.dline.append((addr, line_no))
                    if contents[-1] == '(end)':
                        flag = False
                elif contents and contents[0] == "address":
                    flag = True
                    i += 1
        for node in self.tcfg_nodes:
            if node.dline:
                node.dline.sort(key=lambda x: x[1])

    def dump_fig(self, to_svg=False, directory: str = "output") -> graphviz.Digraph:
        if not self.tcfg_nodes:
            raise CFGException("TCFG is not built now")
        self.add_dline()
        dot = graphviz.Digraph(self.file_name.split('/')[-1][:-4])
        proc_id = {proc.name: i for i, proc in enumerate(self.procs)}
        addrs = []
        for proc in self.procs:
            if proc.code:
                addrs.append(proc.code[0].addr)
        for tn in self.tcfg_nodes:
            s = hex(tn.start_addr.to_dec())
            if tn.bb.code:
                tail_ist = tn.bb.code[-1]
                e = hex(tail_ist.addr.to_dec())
            else:
                e = hex(tn.bb.start_addr.to_dec())
            label = "%s\n%s - %s" % (tn.nid, s, e)
            if tn.dline:
                label += "\nline "
                if tn.dline[0][1] == tn.dline[-1][1]:
                    label += str(tn.dline[0][1])
                else:
                    label += "%s~%s" % (tn.dline[0][1], tn.dline[-1][1])
            if tn.bb.loop_role != LoopKind.LOOP_BODY:
                label += "\n%s" % tn.bb.loop_role
            if tn.start_addr in addrs:
                dot.node(str(tn.nid), label=label,
                         style="filled", fillcolor="/set312/" + str(proc_id[tn.proc_name] % 12 + 1),
                         xlabel=tn.proc_name)
            else:
                dot.node(str(tn.nid), label=label,
                         style="filled", fillcolor="/set312/" + str(proc_id[tn.proc_name] % 12 + 1))
            for edge in tn.out_edges:
                if edge.edge_kind == TCFGEdgeKind.CALL:
                    dot.edge(str(edge.src.nid), str(edge.dst.nid), color='red')
                elif edge.edge_kind == TCFGEdgeKind.RET:
                    dot.edge(str(edge.src.nid), str(edge.dst.nid), color='green')
                elif edge.edge_kind == TCFGEdgeKind.TAKEN:
                    dot.edge(str(edge.src.nid), str(edge.dst.nid), color='darkgoldenrod1')
                elif edge.edge_kind == TCFGEdgeKind.NOT_TAKEN:
                    dot.edge(str(edge.src.nid), str(edge.dst.nid))
                else:
                    dot.edge(str(edge.src.nid), str(edge.dst.nid), style="dashed")
        if to_svg:
            dot.format = 'svg'
            dot.render(directory=directory, cleanup=True).replace('\\', '/')
        return dot

    def get_tnode(self, addr: Addr) -> Optional[TCFGNode]:
        for node in self.tcfg_nodes:
            if node.start_addr == addr:
                return node

        return None

    def get_tnode_by_id(self, nid: int) -> TCFGNode:
        for node in self.tcfg_nodes:
            if node.nid == nid:
                return node
        raise ValueError

    @no_type_check
    def dump_tcfg_json(self, dump: bool = True):
        assert self.tcfg_nodes, "TCFG is not built now"
        tcfg_info = dict()
        nl = []
        for _tn in self.tcfg_nodes:
            tnode_info = dict()
            tnode_info["node_id"] = _tn.nid
            tnode_info["node_addr"] = str(_tn.start_addr)
            dsts_info = []
            for _edge in _tn.out_edges:
                edge_info = dict()
                dstn = _edge.dst
                if _edge.edge_kind == TCFGEdgeKind.TAKEN:
                    branch = "TAKEN"
                elif _edge.edge_kind == TCFGEdgeKind.NOT_TAKEN:
                    branch = "NOT-TAKEN"
                elif _edge.edge_kind == TCFGEdgeKind.NEVER_TAKEN:
                    branch = "NEVER-TAKEN"
                elif _edge.edge_kind == TCFGEdgeKind.CALL:
                    branch = "CALL"
                elif _edge.edge_kind == TCFGEdgeKind.RET:
                    branch = "RETURN"
                else:
                    raise TCFGException("Unexpected kind of tcfg edges")
                edge_info["dst_id"] = dstn.nid
                edge_info["dst_addr"] = str(dstn.start_addr)
                edge_info["kind"] = branch
                edge_info["dst_proc"] = _edge.dst.proc_name
                dsts_info.append(edge_info)
            tnode_info["edge"] = dsts_info
            tnode_info["proc"] = _tn.proc_name
            nl.append(tnode_info)
        tcfg_info["TCFG"] = nl
        if dump:
            file_name = "%s.tcfg.json" % self.file_name[:-4]
            with open(file_name, mode="w", encoding="UTF-8") as f:
                json.dump(tcfg_info, f, indent=4)
        else:
            return tcfg_info

    @no_type_check
    def dump_cfg_json(self, dump: bool = True) -> Optional[dict]:
        d = dict()
        d["file_name"] = self.file_name
        cfgs = []
        for proc in self.procs:
            assert proc.cfg_nodes, "CFG is not built now"
            cfg_info = dict()
            cfg_info["proc_name"] = proc.name
            nl: List[Dict[str, str]] = []
            for node in proc.cfg_nodes:
                node_info = dict()
                node_info["node_id"] = node.nid
                node_info["node_addr"] = str(node.start_addr)
                dsts_info = []
                for edge in node.out_taken:
                    edge_info = dict()
                    dst = edge.dst
                    edge_info["dst_id"] = dst.nid
                    edge_info["dst_addr"] = str(dst.start_addr)
                    edge_info["kind"] = "TAKEN"
                    dsts_info.append(edge_info)
                for edge in node.out_not_taken:
                    edge_info = dict()
                    dst = edge.dst
                    edge_info["dst_id"] = dst.nid
                    edge_info["dst_addr"] = str(dst.start_addr)
                    edge_info["kind"] = "NOT-TAKEN"
                    dsts_info.append(edge_info)
                if node.out_never_taken is not None:
                    edge_info = dict()
                    dst = node.out_never_taken.dst
                    edge_info["dst_id"] = dst.nid
                    edge_info["dst_addr"] = str(dst.start_addr)
                    edge_info["kind"] = "NEVER-TAKEN"
                    dsts_info.append(edge_info)

                node_info["edge"] = dsts_info
                nl.append(node_info)
            cfg_info["CFG"] = nl
            cfgs.append(cfg_info)
        d["CFGs"] = cfgs
        if dump:
            file_name = "%s.cfg.json" % self.file_name[:-4]
            with open(file_name, mode="w", encoding="UTF-8") as f:
                json.dump(d, f, indent=4)
        else:
            return d

    def dump_indirect_jump(self):
        for proc in self.procs:
            for c in proc.code:
                if c.is_indjump:
                    print(c)
                    print(proc.name)
                    print()

    def dump_loop_proc(self) -> Set[str]:
        procs = set([self.get_proc(node.proc_name) for node in self.tcfg_nodes])
        return {proc.name for proc in procs if proc.has_loop}

    def check_cfgs(self) -> None:
        for proc in self.procs:
            try:
                cfg_nodes = sorted(proc.cfg_nodes, key=lambda n: n.start_addr)
                assert len(cfg_nodes) >= 1
                node_ids = set(node.nid for node in cfg_nodes)
                assert len(cfg_nodes) == len(node_ids)
                in_edge_d: Dict[Addr, Set[Addr]] = {node.start_addr: set() for node in cfg_nodes}
                out_edge_d: Dict[Addr, Set[Addr]] = {node.start_addr: set() for node in cfg_nodes}
                for node in cfg_nodes:
                    for in_edge in node.in_edges:
                        assert in_edge.dst.start_addr == node.start_addr
                        in_edge_d[node.start_addr].add(in_edge.src.start_addr)
                    for edge in node.out_not_taken:
                        assert edge.src.start_addr == node.start_addr
                        out_edge_d[node.start_addr].add(edge.src.start_addr)
                    for edge in node.out_taken:
                        assert edge.src.start_addr == node.start_addr
                        out_edge_d[node.start_addr].add(edge.src.start_addr)
                    if node.out_never_taken is not None:
                        assert node.out_never_taken.src.start_addr == node.start_addr
                        out_edge_d[node.start_addr].add(node.out_never_taken.src.start_addr)
                first_node, last_node = cfg_nodes[0], cfg_nodes[-1]
                assert len(in_edge_d[first_node.start_addr]) == 0
                assert len(out_edge_d[last_node.start_addr]) == 0
                for node in cfg_nodes[1:-1]:
                    if node == first_node:
                        assert len(in_edge_d[node.start_addr]) == 0
                        assert len(out_edge_d[node.start_addr]) >= 1
                    elif node == last_node:
                        assert out_edge_d[node.start_addr] == 0
                        assert len(in_edge_d[node.start_addr]) >= 1
                    else:
                        assert len(in_edge_d[node.start_addr]) >= 1
                        assert len(out_edge_d[node.start_addr]) >= 1
            except AssertionError as e:
                print("Find error during checking %s" % proc.name)
                print(e)


class SimpProg:
    def __init__(self, nodes: list[TCFGNode]) -> None:
        self.tcfg_nodes = tuple(nodes)
