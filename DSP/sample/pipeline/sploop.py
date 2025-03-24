import warnings
from enum import Enum, auto
from typing import Optional, Hashable, List, Tuple
from sample.frontend.cfg import Prog


class SPLoopType(Enum):
    """ Three kinds of SPLoop, started by instructions SPLOOP, SPLOOPD and SPLOOPW respectively. """
    SPLoop = auto()
    SPLoopD = auto()
    SPLoopW = auto()


def sp_loop_scan(prog: Prog, cons_f: Optional[str] = None, default_max_iter: int = 65536) -> List[Tuple[int, SPLoopType, int, int]]:
    """
    Scan the entire TCFG, if there is a SPLOOP instruction in a basic block, regard its outgoing block as the body of SPLOOP,
    and provide corresponding information (SPLOOP type, ii, etc.)
    Args:
        cons_f: User-supplied SPLOOP constraints for the program.
        default_max_iter: The default maximum number of iterations when no constraints are provided for this SPLOOP.
        prog: programs to scan.

    Returns: A list representing SPLOOP, in which every element is a triplet,
    including ID of the basic block, type of SPLOOP (Enum in ``SPLoopType``), ii, and maximum iteration.
    """
    spl_list: List[Tuple[int, SPLoopType, int, int]] = list()

    if cons_f is not None:
        with open(cons_f, "r") as f:
            # TODO: Add user-supplied constraints to generate a more precise analysis results.
            pass

    for node in prog.tcfg_nodes:
        sp_loop_type: Optional[SPLoopType] = None
        ii: int = 0

        for inst in node.bb.code:
            if inst.name in ("SPLOOP", "SPLOOPD", "SPLOOPW"):
                sp_loop_type = SPLoopType.SPLoop if inst.name == "SPLOOP" else SPLoopType.SPLoopW if inst.name == "SPLOOPW" else SPLoopType.SPLoopD
                ii = int(inst.operands[0])
                break
        else:
            continue  # No SPLOOP instruction found. continue to next basic block.
        """ When reaching here, a SPLOOP instruction is found and the outgoing block is a SPLOOP body """

        if len(node.out_edges) == 0:
            raise RuntimeError("Basic block {} containing SPLOOP instruction has no outgoing edge.".format(node.nid))
        if len(node.out_edges) > 1:
            raise RuntimeError("Basic block {} containing SPLOOP instruction has more than one outgoing edges.".format(node.nid))

        out_block_id = node.out_edges[0].dst.nid

        """ Check if outgoing block has an SPKERNEL instruction """
        for inst in prog.tcfg_nodes[out_block_id].bb.code:
            # TODO: SPKERNELR is not supported.
            if inst.name == "SPKERNEL":
                break  # A SPKERNEL instruction found.
        else:
            s, t = prog.tcfg_nodes[out_block_id].start_addr, prog.tcfg_nodes[out_block_id].bb.code[-1].addr
            raise RuntimeError("No SPKERNEL instruction in basic block {} with start address {} and tail address {}. "
                               "This supposes to be a SPLOOP body.".format(out_block_id, s, t))

        # TODO: Add user-supplied constraints to generate a more precise analysis results.
        warnings.warn("No constraints for SPLOOP body {}. A default max_iter={} is applied.".format(out_block_id, default_max_iter))
        max_iter = default_max_iter

        spl_list.append((out_block_id, sp_loop_type, ii, max_iter))

    return spl_list


class SPLoopSimulator:

    def __init__(self, spl_type: SPLoopType, ii: int, max_iter: int):

        self.__spl_type = spl_type
        self.__ii = ii
        self.__max_iter = max_iter

        self.__sp_finish = False

        self.__dynlen = 0
        self.__penalty = 0
        self.__extra_cycle = 0

    @property
    def spl_type(self):
        return self.__spl_type

    @property
    def ii(self):
        return self.__ii

    @property
    def max_iter(self):
        return self.__max_iter

    def new_ep(self):
        if self.__sp_finish:
            raise RuntimeError("SPLOOP new_ep() error: Try to insert a new EP into a SPLOOP already finished. "
                               "Check whether there are multiple SPKERNEL instructions in the basic block. "
                               "This can be caused by nested SPLOOPs or wrong CFG generation algorithms.")
        self.__dynlen += 1

    def data_miss_happen(self, penalty: int):
        if self.__sp_finish:
            raise RuntimeError("SPLOOP data_miss_happen() error: Current SPLOOP has already finished. "
                               "Check whether there are multiple SPKERNEL instructions in the basic block. "
                               "This can be caused by nested SPLOOPs or wrong CFG generation algorithms.")
        self.__penalty += penalty

    def finish(self) -> int:
        """
        Returns: Return extra cycles by current SPLoop.
        """

        if self.__sp_finish:
            raise RuntimeError("SPLOOP finish() error: Current SPLOOP has already finished. "
                               "Check whether there are multiple SPKERNEL instructions in the basic block. "
                               "This can be caused by nested SPLOOPs or wrong CFG generation algorithms.")
        self.__sp_finish = True
        self.__extra_cycle = (self.__dynlen + self.__penalty + 10) + (self.__max_iter - 2) * self.__ii
        return self.__extra_cycle

    @property
    def dynlen(self):
        return self.__dynlen

    @property
    def penalty(self):
        return self.__penalty

    @property
    def extra_cycle(self):
        return self.__extra_cycle

