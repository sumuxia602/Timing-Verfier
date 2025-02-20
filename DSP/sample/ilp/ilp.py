import warnings
from typing import List, Set, Tuple, Dict, Sequence, Union, Optional
import subprocess
import json
import re
import time

from sample.frontend.isa import Addr
from sample.frontend.cfg import TCFGNode, TCFGEdgeKind, CFGNode
from sample.frontend.dline import DLine
from sample.frontend.loops import LoopHrchy
from sample.cache.memory_block import MemoryBlock
from sample.cache.cache_config import CacheConfig
from sample.isa.isa_syntax import Instruction


class ILPException(Exception):
    def __init__(self, err_msg: str) -> None:
        self.err_msg = err_msg

    def __str__(self) -> str:
        return self.err_msg


def atoi(text: str) -> Union[int, str]:
    return int(text) if text.isdigit() else text


def natural_keys(text: str) -> Tuple[Union[int, str], ...]:
    """ alist.sort(key=natural_keys) sorts in human order """
    return tuple([atoi(c) for c in re.split(r'(\d+)', text)])


class ILPModel:
    """ Representation of ILP model w.r.t the predicted number of running cycles for each block. """

    def __init__(self, lp_hrchy: LoopHrchy, dline_file: str, 
                 inst_cache_cons: Dict[int, Dict[MemoryBlock, int]], data_cache_cons: Dict[int, Dict[Instruction, int]],
                 inst_cache_config: CacheConfig, data_cache_config: CacheConfig,
                 loop_cons_file: Optional[str] = None,pred_cycle: Optional[Dict[int, List[int]]] = None):

        # TCFG nodes
        self.__tcfg_nodes: Tuple[TCFGNode, ...] = tuple(lp_hrchy.tcfg_nodes)

        # Loop Hierarchy
        self.__lp_hrchy: LoopHrchy = lp_hrchy

        # mapping from node id to its predicted cycles
        # TODO: Two values for self.__pred_cycle, the first is cycle under must analysis, and the second is cycle under persistent analysis.
        #       For the worst case, and which is now used, only cycle under must analysis is considered.
        if not pred_cycle:
            self.__pred_cycle: Dict[int, List[int]] = {node.nid: [node.bb.num_ep * 2] for node in self.__tcfg_nodes}
        else:
            self.__pred_cycle: Dict[int, List[int]] = pred_cycle

        """
        Integer Variables
         - bx is the number of times block x in t-cfg will be executed in.
         - dx_y is the number of times edge 'x -> y' in t-cfg will be executed in.
         - dSta_0 denotes the number of times initial edge is executed
        """
        self.__int_vars: Set[str] = set()
        for node in self.__tcfg_nodes:
            self.__int_vars.add("b%s" % node.nid)
            for edge in node.out_edges:
                if edge.edge_kind != TCFGEdgeKind.NEVER_TAKEN:
                    self.__int_vars.add("d%s_%s" % (node.nid, edge.dst.nid))
        self.__int_vars.add("dSta_0")

        for node in self.__tcfg_nodes:
            if (len(self.__pred_cycle[node.nid]))>1:
                for duplicate in range(len(self.__pred_cycle[node.nid])):
                    self.__int_vars.add("b%d.v%d"%(node.nid ,duplicate ))
        
        for node_id, inst_con in inst_cache_cons.items():
            for block_id in range(len(inst_con)) :
                self.__int_vars.add("x%d_%d.h"%(node_id, block_id))
                self.__int_vars.add("x%d_%d.m"%(node_id, block_id))

        for node_id, data_con in data_cache_cons.items():
            for inst_id in range(len(data_con)) :
                self.__int_vars.add("dr%d_%d.h"%(node_id, inst_id))
                self.__int_vars.add("dr%d_%d.m"%(node_id, inst_id))

        # The loop constraint file
        self.__loop_cons_file = loop_cons_file

        # The debug line file
        self.__dline_file = dline_file

        # loop id map to its bound
        self.__loop_bounds: Dict[int, int] = dict()

        # persistent block for generating cache constrain
        self.__inst_cache_cons = inst_cache_cons

        # persistent data reference for generating cache constrain
        self.__data_cache_cons = data_cache_cons

        # inst cache config
        self.__inst_cache_config = inst_cache_config

        # data cache config
        self.__data_cache_config = data_cache_config

    def gen_obj_func(self) -> str:
        """ 
        Generate object function.
        The object function is of the form: c_0 * b_0 + c_1 * b_1 + ... + c_n * b_n
        where c_i is the running time of the block in the worst case,
        b_i is the number of times block B_i is executed when the program take the maximum time to complete.
        """

        costs: List[str] = []
        for node in self.__tcfg_nodes:
            """ Remove all unreachable nodes from integer variables. """
            if len(node.in_edges) == 1 and node.in_edges[0].edge_kind == TCFGEdgeKind.NEVER_TAKEN:
                # Current node is an unreachable node.
                self.__int_vars.remove("b{}".format(node.nid))
                continue
            c_i = self.__pred_cycle[node.nid]
            # TODO: One times for under must analysis, one times for under persistent analysis.
            # context term
            costs.extend(["%s b%s.v%d" % (c_i[idx], node.nid ,idx)  if len(c_i)>1 else "%s b%s" % (c_i[0], node.nid) 
                   for idx in range(len(c_i))])
        
        # inst cache term 
        for node_id, inst_con in self.__inst_cache_cons.items():
            costs.extend(["%s x%d_%d.m"%(self.__inst_cache_config.penalty, node_id, block_id) 
                                for block_id in range(len(inst_con))])
            
        # data cache term 
        for node_id, data_con in self.__data_cache_cons.items():
            costs.extend(["%s dr%d_%d.m"%(self.__data_cache_config.penalty, node_id, inst_id) 
                                for inst_id in range(len(data_con))])
        
        obj_func = " + ".join(costs)
        obj_func = obj_func.replace("+ -","- ") # # Negative execute cycles may occur
        return obj_func

    def gen_tcfg_cons(self) -> Tuple[str, ...]:
        """ Generate the linear constraints which describe the relation between tcfg nodes and edges.
        
        The constraints are of the form
              b_i - (d_i_j1 + ... + d_i_jn) = 0
              b_i - (d_j1_i + ... + d_jn_i) = 0
        where b_i has the same meaning as it in object function, d_i_jk means the number of times edge b_i -> b_jk is executed.
        """

        cons: List[str] = ["dSta_0 = 1", "b0 - dSta_0 = 0"]  # the head of TCFG can only be executed once

        for node in self.__tcfg_nodes:

            in_edge_times = " - ".join("d%s_%s" % (edge.src.nid, node.nid)
                                       for edge in node.in_edges if edge.edge_kind != TCFGEdgeKind.NEVER_TAKEN)
            if in_edge_times:
                cons.append("b%s - %s = 0" % (node.nid, in_edge_times))

            out_edge_times = " - ".join("d%s_%s" % (node.nid, edge.dst.nid)
                                        for edge in node.out_edges if edge.edge_kind != TCFGEdgeKind.NEVER_TAKEN)
            if out_edge_times:
                cons.append("b%s - %s = 0" % (node.nid, out_edge_times))

        return tuple(cons)

    def find_tcfg_node(self, addr: Addr) -> Tuple[TCFGNode, ...]:
        return tuple(node for node in self.__tcfg_nodes if node.start_addr == addr)

    def find_cfg_nodes(self, addrs:Sequence[Addr]) -> Set[CFGNode]:
        return set([node.bb for node in self.__tcfg_nodes for addr in addrs if node.bb.is_in_node(addr)])

    def find_loop_addr(self, addrs: Sequence[Addr]) -> Tuple[Addr, Addr]:
        """Given the related address of loop condition, locating the loop and return the pair (head_addr, tail_addr).
        
        Note: the implementation is based on the hypothesis that there are at most two cfg blocks related to a line in source file,
        one is outside the loop (executed in the first iteration) and the other is inside the loop.
        """

        # All nodes in CFG that address in 'addrs' may lie in.
        cfg_node = self.find_cfg_nodes(addrs=addrs)
        # Check the hypothesis.
        if not (len(cfg_node) == 1 or len(cfg_node) == 2):
            raise RuntimeError("Hypothesis does not hold, length of cfg_node is {} for addrs {}.".format(len(cfg_node), addrs))

        if len(cfg_node) == 1:
            """ Situation 1: self loop, len(cfg_node) == 1. """
            node = cfg_node.pop()
            if node.is_self_loop():
                # raise RuntimeError("Node {} is considered as a self loop but attribute is_self_loop is False.".format(node.nid))
                return node.start_addr, node.start_addr
            elif node.is_loop_head() or node.is_loop_tail():
                loop = self.__lp_hrchy.loop_map[self.find_tcfg_node(node.start_addr)[0].nid]
                return loop.head.start_addr, loop.tail.start_addr
            else:
                raise NotImplementedError
        else:
            """ Situation 2: loop with head node and tail node.
            This function first find all nodes in t-CFG (to tcfg_body_nodes) that are duplicated from tail node of loop in CFG, 
            If find one, the loop which the first t-CFG node found lies in can be found by self.__lp_hrchy, and this loop is considered 
            as the ONLY loop. 
            A non-self loop should have both head node and tail node. If so, return the start address of them. 
            """
            head, tail = cfg_node
            if head.start_addr > tail.start_addr:
                head, tail = tail, head
            tcfg_body_nodes = self.find_tcfg_node(tail.start_addr)  # All nodes in t-CFG that are duplicated from this tail node (in CFG).
            try:
                loop = self.__lp_hrchy.loop_map[tcfg_body_nodes[0].nid]
            except IndexError:
                tail: CFGNode
                if len(tcfg_body_nodes) == 0:
                    raise RuntimeError("Could not find any node in t-CFG "
                                       "that are duplicated from node {} with start address {} in cfg.".format(tail.nid, tail.start_addr))
                else:
                    raise RuntimeError("Could not find loop mapping of t-CFG node {} in loop hrchy.".format(tcfg_body_nodes[0].nid))
            if loop.tail is None:
                raise RuntimeError("Loop {} is considered as a non-self loop but attribute tail is None.".format(loop.lid))

            return loop.head.start_addr, loop.tail.start_addr

    def find_loop_ht(self, addrs: Sequence[Addr]) -> Tuple[Tuple[TCFGNode, TCFGNode], ...]:
        """ Given addresses whose instructions are within the loop, return the corresponding loop head. """
        head_addr, tail_addr = self.find_loop_addr(addrs)
        # The order of adding t-CFG nodes is carried out according to Proc, and a loop will only appear once in it,
        # so it should be able to guarantee the success of zip pairing.
        return tuple(zip(self.find_tcfg_node(head_addr), self.find_tcfg_node(tail_addr)))

    def add_loop_bound(self, loop_head: TCFGNode, loop_tail: TCFGNode, bound: int) -> str:
        """ Given a loop head node and its upper bound, generate corresponding loop constraint in which
        the execution times of loop head would be less than (bound - 1) times of its predecessor.
        """
        if len(loop_head.in_edges) > 2:
            raise NotImplementedError("More than two incoming edges is not supported now.")
        tail_addr = loop_tail.start_addr
        pred_edges = tuple([edge for edge in loop_head.in_edges if edge.src.start_addr != tail_addr])
        cons = "b%s - " % loop_head.nid

        if loop_head.is_self_loop():
            return "%s%s <= 0" % (cons, " - ".join("%s d%s_%s" % (bound, edge.src.nid, edge.dst.nid) for edge in pred_edges))
        else:
            return "%s%s <= 0" % (cons, " - ".join("%s d%s_%s" % (bound , edge.src.nid, edge.dst.nid) for edge in pred_edges))

    def gen_loop_bounds(self) -> Tuple[str, ...]:

        if self.__loop_cons_file is None:
            warnings.warn("No loop bound file specified. For programs with loops, this may cause ILP solving to fail.")
            return tuple()

        with open(self.__loop_cons_file, "r", encoding="utf-8") as f:
            loop_cons_info = json.load(f)
        dline_info = DLine(self.__dline_file)

        bounds: List[str] = []
        for loop_cons in loop_cons_info["src"]:
            src_name = loop_cons["name"]
            lnp = dline_info[src_name]  # A dict mapping from line number in src code to address (maybe more than one) in asm file.
            for con in loop_cons["cons"]:
                if "line number" in con and "upper bound" in con:
                    line_num, bound = con["line number"], con["upper bound"]
                    try:
                        assoc_addrs = lnp[line_num]
                    except KeyError:
                        raise RuntimeError("Could not find line {} in dline files. existed line: {}".format(line_num, lnp.keys()))
                    for head, tail in self.find_loop_ht(assoc_addrs):
                        bounds.append(self.add_loop_bound(head, tail, bound))
                        self.__loop_bounds[self.__lp_hrchy.loop_map[head.nid].lid] = bound
                else:
                    assert "func" in con and "loop bounds" in con
                    for line_num, bound in con['loop bounds']:
                        try:
                            assoc_addrs = lnp[line_num]
                        except KeyError:
                            raise RuntimeError("Could not find line {} in dline files. existed line: {}".format(line_num, lnp.keys()))
                        if not self.find_cfg_nodes(assoc_addrs):
                            continue
                        for head, tail in self.find_loop_ht(assoc_addrs):
                            bounds.append(self.add_loop_bound(head, tail, bound))
                            self.__loop_bounds[self.__lp_hrchy.loop_map[head.nid].lid] = bound
        return tuple(bounds)
    
    def gen_context_cons(self) -> str:
        """ Generate the linear constraints for duplicates.
        
        The constraints are of the form
              b_i - (b_i.v0 + ... + b_i.vn) = 0
              b_i.vi - (d_j_i) = 0    # validate if necessary
        where b_i and d_i_jk have the same meaning as it in object function,the vi suffix represents its duplicate
        """
 
        cons: List[str] = []  

        for node in self.__tcfg_nodes:
            if (len(self.__pred_cycle[node.nid]))>1:
                duplicate_times=" - ".join("b%d.v%d"%(node.nid ,duplicate ) for duplicate in range(len(self.__pred_cycle[node.nid])))

                cons.append("b%s - %s = 0" % (node.nid, duplicate_times))
                cons.extend(["b%d.v%d - d%s_%s = 0" % (node.nid,idx,edge.src.nid, node.nid) for idx,edge in enumerate(node.in_edges) 
                            if edge.edge_kind != TCFGEdgeKind.NEVER_TAKEN])
                    
        return tuple(cons)
    
    def gen_miss_bounds(self, loop_id):
        """ Returns the product of the outer-loop(loop_id) loop bound  """

        miss_bound = 1
        while self.__lp_hrchy.loops[loop_id].get_parent().lid:
            miss_bound = miss_bound * self.__loop_bounds[self.__lp_hrchy.loops[loop_id].get_parent().lid]
            loop_id = self.__lp_hrchy.loops[loop_id].get_parent().lid
        
        return miss_bound

    def gen_inst_cache_cons(self):
        """ Generate the cache constraints for persistent blocks.
        
        The constraints are of the form
              b_i - (x_i.h + x_i.m... ) = 0
              x_i.m <= miss_bound(persistent loop level)
              
        where b_i have the same meaning as it in object function,the x_i.m represents miss times of memery block i
        and x_i.h represents git times of memery block i
        """
        
        miss_bounds: Dict[int, int] = {loop_level : self.gen_miss_bounds(loop_level) 
                                                for loop_level in self.__lp_hrchy.loops.keys()
                                                    if loop_level}
        cons: List[str] = []

        for node_id, inst_con in self.__inst_cache_cons.items():
            for block_id, loop_level in enumerate(list(inst_con.values())) :
                memory_block_hit = "x%d_%d.h"%(node_id, block_id)
                memory_block_miss = "x%d_%d.m"%(node_id, block_id)
                cons.append("b%s - %s - %s = 0" % (node_id, memory_block_hit, memory_block_miss))
                cons.append("%s <= %d" % (memory_block_miss, miss_bounds[loop_level]))

        return tuple(cons)
    
    def gen_data_cache_cons(self):
        """ Generate the data cache constraints for persistent blocks.
        
        The constraints are of the form
              b_i - (dr_i.h + dr_i.m... ) = 0
              dr_i.m <= miss_bound(persistent loop level)
        where b_i have the same meaning as it in object function,the dr_i.m represents miss times of memery block i
        and dr_i.h represents git times of memery block i
        """
        
        miss_bounds: Dict[int, int] = {loop_level : self.gen_miss_bounds(loop_level) 
                                                for loop_level in self.__lp_hrchy.loops.keys()
                                                    if loop_level}
        cons: List[str] = []

        for node_id, data_con in self.__data_cache_cons.items():
            for inst_id, loop_level in enumerate(list(data_con.values())) :
                data_refer_hit = "dr%d_%d.h"%(node_id, inst_id)
                data_refer_miss = "dr%d_%d.m"%(node_id, inst_id)
                cons.append("b%s - %s - %s = 0" % (node_id, data_refer_hit, data_refer_miss))
                cons.append("%s <= %d" % (data_refer_miss, miss_bounds[loop_level]))

        return tuple(cons)

    def gen_ilp_model(self) -> str:
        """ Generating ilp model consists of the following steps.
            1. Generate object function.
            2. Generate tcfg constraints.
            3. Generate loop bounds.
            4. Generate context constraints.
            5. Generate cache constraints.
            6. Tell lp solver about the integer variables.
            7. Generate the statistics which include the number of constraints and the number of variables.
        """

        tcfg_cons = self.gen_tcfg_cons()
        loop_bounds = self.gen_loop_bounds()
        context_cons = self.gen_context_cons()
        inst_cache_cons = self.gen_inst_cache_cons()
        data_cache_cons = self.gen_data_cache_cons()
        obj_func = self.gen_obj_func()

        lp_model = [
            "Maximize\n\n", obj_func,
            "\n\n\nSubject to\n\n",
            "\\ === tcfg constraints ===\n", "\n".join(con for con in tcfg_cons),
            "\n\n\n\\ === header constraints ===\n", "\n".join(bound for bound in loop_bounds),
            "\n\n\n\\ === context constraints ===\n", "\n".join(context for context in context_cons),
            "\n\n\n\\ === inst cache constraints ===\n", "\n".join(cache for cache in inst_cache_cons),
            "\n\n\n\\ === data cache constraints ===\n", "\n".join(cache for cache in data_cache_cons),
            "\n\n\nGenerals\n\n\n",
            "\n".join(sorted(self.__int_vars, key=natural_keys)),
            "\n\n\nEnd\n",
            "\\ total cons: %s    total vars: %s\n" % (len(tcfg_cons) + len(loop_bounds) + len(context_cons) +
                                                        len(context_cons) +len(inst_cache_cons) + len(data_cache_cons),
                                                          len(self.__int_vars))
        ]
        return "".join(lp_model)


class LPSolve:
    """ Interface of open-source linear programming solver lp_solve (https://sourceforge.net/projects/lpsolve/).
    
    Parameters:
    - lp_file: the path of file xxx.lp which is of CPLEX LP format.
    """

    def __init__(self, lp_file: str) -> None:
        assert lp_file.endswith(".lp") or lp_file.endswith(".mps")
        self.lp_file = lp_file

        # denote whether the constraints are feasible
        self.__is_sat: Optional[bool] = None

        # denote whether the objective function is bounded or not
        self.__is_bound: Optional[bool] = None

        # store the maximum value of object function
        self.__obj_max_val: Optional[float] = None

        # store the assignments of each integer variable when 
        # the object function reach the maximum value
        self.__vars: Dict[str, int] = dict()

        # the number of constraints, variables, and integer variables
        self.__cons_num: Optional[int] = None
        self.__vars_num: Optional[int] = None
        self.__ivars_num: Optional[int] = None

    @property
    def is_sat(self) -> bool:
        if self.__is_sat is None:
            raise ILPException("The model has not been solved yet.")
        return self.__is_sat

    @property
    def is_bound(self) -> bool:
        if self.__is_sat is None:
            raise ILPException("The model has not been solved yet.")
        if not self.__is_sat:
            raise ILPException("Contraints in lp model are infeasile.")
        assert self.__is_bound is not None
        return self.__is_bound

    @property
    def obj_max_val(self) -> Optional[float]:
        if self.__is_sat is None:
            raise ILPException("The model has not been solved yet.")
        if not self.__is_sat:
            raise ILPException("Contraints in lp model are infeasile.")
        if self.__obj_max_val is None:
            raise ILPException("The objective function is unbounded under current constraints.")
        return self.__obj_max_val

    def get_val(self, var_name: str) -> int:
        if self.__is_sat is None:
            raise ILPException("The model has not been solved yet.")
        if not self.__is_sat:
            raise ILPException("Contraints in lp model are infeasile.")
        if self.__obj_max_val is None:
            raise ILPException("The objective function is unbounded under current constraints.")
        if var_name not in self.__vars:
            raise ILPException("Can't find the exact value of %s." % var_name)
        return self.__vars[var_name]

    @property
    def vars(self) -> Dict[str, int]:
        if self.__is_sat is None:
            raise ILPException("The model has not been solved yet.")
        if not self.__is_sat:
            raise ILPException("Contraints in lp model are infeasible.")
        if self.__vars is None:
            raise ILPException("The objective function is unbounded under current constraints.")
        return self.__vars

    @property
    def cons_num(self) -> int:
        if self.__cons_num is None:
            raise ILPException("The model has not been sent to lp_solve.")
        return self.__cons_num

    @property
    def vars_num(self) -> int:
        if self.__vars_num is None:
            raise ILPException("The model has not been sent to lp_solve.")
        return self.__vars_num

    @property
    def ivars_num(self) -> int:
        if self.__ivars_num is None:
            raise ILPException("The model has not been sent to lp_solve.")
        return self.__ivars_num

    def parse_output(self, res: str) -> None:
        """The output of lp_solve have three possible forms:
        1. Infeasible: when the overall constraints are not consistent.
        2. Unbounded: when the constraints are not strong enough to 
           bound the objective function.
        3. Successful: when the value of objective function has been solved
           as well as each integer variable is assigned with a suitable value.
        """
        lines = [s.strip() for s in res.split("\n")]
        if not lines[0].startswith("set_XLI"):
            lines = ["set_XLI: Successfully loaded 'xli_CPLEX'"] + lines
        xli_info = lines[0]
        # the message of loading CPLEX XLI (external language interface) 
        # is supposed to generate. 
        assert xli_info == "set_XLI: Successfully loaded 'xli_CPLEX'", xli_info
        cons_num_line = lines[1]
        assert cons_num_line.startswith("Constraints:"), cons_num_line
        self.__cons_num = int(cons_num_line[13:])
        vars_num_line = lines[2]
        assert vars_num_line.startswith("Variables  :"), vars_num_line
        self.__vars_num = int(vars_num_line[13:])
        ivars_num_line = lines[3]
        assert ivars_num_line.startswith("Integers   :"), ivars_num_line
        self.__ivars_num = int(ivars_num_line[13:])
        for i, line in enumerate(lines[4:]):
            if line == "This problem is infeasible":
                self.__is_sat = False
                return
            self.__is_sat = True
            if line == "This problem is unbounded":
                self.__is_bound = False
                return
            self.__is_bound = True
            if line.startswith("Value of objective function"):
                self.__obj_max_val = float(line[29:])
                break
        ivar_val_lines = lines[i + 6:]
        assert ivar_val_lines[0] == "Actual values of the variables:"
        for line in ivar_val_lines[1:-1]:
            var_name, val = line.split()
            self.__vars[var_name] = int(val)

    def solve(self) -> float:
        """Solving given .lp file through lp_solve."""
        if self.lp_file.endswith(".lp"):
            args = [
                "-stat",
                "-rxli",
                "xli_CPLEX",
                self.lp_file
            ]
        else :
            args = [
                "-fmps",
                "-stat",
                self.lp_file
            ]

        start = time.perf_counter()
        with subprocess.Popen("lp_solve %s" % " ".join(args),
                              stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True) as p:
            out, err_msg = p.communicate()
        end = time.perf_counter()

        if err_msg != b"":
            raise ILPException(err_msg.decode("UTF-8"))
        self.parse_output(out.decode("UTF-8"))
        return end - start

    def dump_stat(self, show_ivar: bool = False) -> str:
        if self.__obj_max_val is None:
            raise RuntimeError("objective max val is None.")
        stat = [
            "Statistics",
            "Constraints: %s" % self.__cons_num,
            "Variables  : %s" % self.__vars_num,
            "Integers   : %s" % self.__ivars_num,
            "Value of objective function: %.3f" % self.__obj_max_val
        ]
        if show_ivar:
            stat.append("Actual values of the variables:")
            for name, val in self.__vars.items():
                stat.append("{:<15}{:>15}".format(name, val))

        return "\n".join(stat)

class MPS:
    """Generate mps format file from ILPModel"""
    def __init__(self, obj_func: str, tcfg_cons: Tuple[str], loop_bounds: Tuple[str], prob_name: Optional[str] = "TEST"):
        # Load obj func, tcfg cons and loop bounds from an ILPModel
        self.obj_func = obj_func
        self.tcfg_cons = tcfg_cons
        self.loop_bounds = loop_bounds

        # these four sections are main parts of mps file
        self.NAME: str = prob_name

        # rows are type and name for each obj_func, tcfg_cons and loop_bounds
        # type      meaning
        # E         equality
        # L         less than or equal
        # G         greater than or equal
        # N         objective
        # N         no restriction
        self.ROWS: Tuple[Tuple[str, str], ...] = tuple()
        # Tuple[Tuple[type:str, name: str]]

        # COLUMNS are coefficients of each variable
        self.COLUMNS: Dict[str, Dict[str, int]] = dict()
        # Dict[var_name: str, Dict[row_name: str, coefficient: int]]

        # RHS are right-hand side of each obj_func, tcfg_cons and loop_bounds
        self.RHS: Dict[str, int] = dict()
        # Dict[row_name: str, value: int]

    def gen_ROWS(self) -> None:
        rows = [("N", "OBJ")]
        for i in range(len(self.tcfg_cons)):
            rows.append(("E", "CONS%s" % i))
        for i in range(len(self.loop_bounds)):
            rows.append(("L","BOUND%s" % i))
        self.ROWS = tuple(rows)

    def gen_COLUMNS(self) -> None:

        def update_col(col: str, row: str, val: int) -> None:
            """util func to add {row: val} to self.COLUMNS[col]"""
            if col not in self.COLUMNS:
                tmp_dict = dict()
            else:
                tmp_dict = self.COLUMNS[col]
            tmp_dict[row] = val
            self.COLUMNS[col] = tmp_dict

        obj_func = self.obj_func
        obj_func = obj_func.replace('*', '')
        obj_func_split = obj_func.split()
        # now form: coeff0 b0 coeff1 b1 coeff2 b2 ...
        for i in range(len(obj_func_split)):
            if obj_func_split[i].startswith('b'):
                update_col(obj_func_split[i], "OBJ", int(obj_func_split[i-1]))

        for i, cons in enumerate(self.tcfg_cons):
            row = "CONS%s" % i

            cols = cons
            for useless_char in "+-()":
                cols = cols.replace(useless_char, '')
            # only vars, '=' and rhs_value are left
            cols = cols.split()

            # cons form is b0-(b1+b2...)=0, so coeff0 = 1 and other coeff -1
            update_col(cols[0], row, 1)
            for col in cols[1:]:
                if col == '=':
                    break
                update_col(col, row, -1)

        for i, bound in enumerate(self.loop_bounds):
            row = "BOUND%s" % i
            cols = bound.replace('-', '').split()
            # bound form: b0 - (coeff1*b1 + coeff2*b2...) <= 0. coeff0 = 1 and others are negative value
            # now form: b0 coeff1 b1 coeff2 b2 ... <= 0

            update_col(cols[0], row, 1)
            for i in range(1, len(cols)):
                if cols[i] == '<=':
                    break
                if cols[i].isdigit():
                    continue
                update_col(cols[i], row, -int(cols[i-1]))
    
    def gen_RHS(self) -> None:
        
        for i, cons in enumerate(self.tcfg_cons):
            if int(cons.split()[-1]) != 0: # zero is default
                self.RHS["CONS%s" % i] = int(cons.split()[-1])

        for i, bound in enumerate(self.loop_bounds):
            if int(bound.split()[-1]) != 0: # zero is default
                self.RHS["BOUND%s" % i] = int(bound.split()[-1])

    def gen_mps_file(self) -> str:
        self.gen_ROWS()
        self.gen_COLUMNS()
        self.gen_RHS()
        mps = [
            "NAME           %s" % self.NAME,
            "OBJSENSE",
            " MAX",
            "ROWS",
            "\n".join(" %-3s%s" % (Type, name) for Type, name in self.ROWS),
            "COLUMNS",
            "    MARK0000  'MARKER'                 'INTEND'",
            "\n".join("\n".join("    %-10s%-10s%12s" % (col, row, val) for row, val in self.COLUMNS[col].items()) for col in self.COLUMNS),
            "    MARK0000  'MARKER'                 'INTEND'",
            "RHS",
            "\n".join("    %-10s%-10s%12s" % ("rhs", row, val) for row, val in self.RHS.items()),
            "SOS",
            "ENDATA"]
        
        return "\n".join(mps)
