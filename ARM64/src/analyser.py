import copy
from collections import defaultdict
from typing import List, Dict, Hashable, Optional, Set
import json
import datetime
from toolset.memory_usage import *
from src.cache.abstract_state import MultiLevelCacheState
from src.cache.memory_block import MemoryBlock
from src.cfg import *
from src.cache.constants import CacheHierarchy, RefType, CacheAnalysisMethod, CHMC
from src.cache.fixpoint import Fixpoint, FixpointState
from src.cache.cache_config import CacheConfig, MultiLevelCacheConfig
from src.cache.memory_ref import Reference
from src.isa import Instruction

INST_CHMC = Tuple[CacheHierarchy, CHMC]
DATA_CHMC = Tuple[CacheHierarchy, CHMC]


class CacheAnalyser:
    def __init__(self, cfg: InnerProcCFG, cache_config: MultiLevelCacheConfig,
                 proc_inst_ref: Dict[Procedure, Dict[Hashable, Dict[Instruction, Reference]]],
                 proc_data_ref: Dict[Procedure, Dict[Hashable, Dict[Instruction, Set[Reference]]]],
                 related_procs: Set[Procedure],
                 regular_loops: Set[InnerProcLoop],
                 debug_path: str,
                 debug: bool) -> None:

        self.__cache_config = cache_config
        self.__cfg = cfg
        self.__related_procs = related_procs
        self.__regular_loops: Set[InnerProcLoop] = regular_loops
        self.__debug_path: str = debug_path
        self.__debug: bool = debug

        self.__proc_access_order: Dict[Procedure, Dict[Hashable, List[Set[Reference]]]] = defaultdict(dict)
        self.__proc_inst_ref: Dict[Procedure, Dict[Hashable, Dict[Instruction, Reference]]] = proc_inst_ref
        self.__proc_data_ref: Dict[Procedure, Dict[Hashable, Dict[Instruction, Set[Reference]]]] = proc_data_ref

        self.__proc_fixpoint: Dict[Procedure, Fixpoint] = defaultdict()
        for proc in self.__related_procs:
            self.gen_access_order(proc)  # 初始化 proc_access_order
            self.__proc_fixpoint[proc] = Fixpoint(proc, self.__debug_path, self.__debug, self.__cache_config,
                                                  loop=None)  # 初始化 proc 对应的 fixpoint

        self.__loop_fixpoint: Dict[InnerProcLoop, Fixpoint] = defaultdict()
        for loop in self.__regular_loops:
            self.__loop_fixpoint[loop] = Fixpoint(loop.proc, self.__debug_path, self.__debug, self.__cache_config,
                                                  loop=loop)  # 初始化 proc 对应的 fixpoint

        self.__proc_Per_states: Dict[Procedure, List[Dict[Hashable, FixpointState]]] = defaultdict(
            list)  # proc需要合并的state

        # [proc, [node, [cache_level, set(blocks)]]]: loop中Persistent的所有内存块
        self.__proc_PS_blocks: Dict[Procedure, Dict[Hashable, Dict[CacheHierarchy, Set[MemoryBlock]]]] = defaultdict(
            lambda: defaultdict(lambda: defaultdict(set)))

        self.__proc_inst_chmc: Dict[Procedure, Dict[Hashable, List[INST_CHMC]]] = defaultdict(dict)
        self.__proc_data_chmc: Dict[Procedure, Dict[Hashable, List[DATA_CHMC]]] = defaultdict(dict)

    def gen_access_order(self, function: Procedure):
        """ 生成在 proc 中每个节点的访问顺序, 根据该节点的指令引用信息构建一个访问序列，其中包括加载/存储指令的相关数据引用。"""
        for node, refs in self.__proc_inst_ref[function].items():
            node_access_order = []
            if refs is not None:
                for inst, ref in refs.items():
                    if not node_access_order or ref not in node_access_order[-1]:
                        node_access_order.append({ref})
                    if inst.is_ls:
                        if node in self.__proc_data_ref[function]:  # 存在问题
                            dic = self.__proc_data_ref[function][node]
                            node_access_order.append(dic[inst])
            self.__proc_access_order[function][node] = node_access_order

    @property
    def proc_inst_chmc(self):
        return self.__proc_inst_chmc

    def kahn_topological_sort(self):
        """
        self.call_proc = []  # 某函数调用函数的列表
        main.call_proc = [A, C]
        A.call_proc = [B, D]
        B.call_proc = [C, D]
        C.call_proc = [E]
        sorted_functions = ['main', 'A', 'B', 'C', 'E', 'D']
        """

        # Step 1: Create a mapping from function names to Proc objects
        proc_map = {proc.name: proc for proc in self.__related_procs}

        # Step 2: Create an adjacency list for the call graph
        call_graph = {proc: set() for proc in self.__related_procs}
        in_degree = {proc: 0 for proc in self.__related_procs}

        for caller in self.__related_procs:
            for callee in caller.outgoing_proc:
                call_graph[caller].add(callee)
                in_degree[callee] += 1

        # Step 3: Initialize a queue with all functions that have an in-degree of 0
        zero_in_degree_queue = [proc for proc in in_degree if in_degree[proc] == 0]

        # Step 4: Perform topological sort
        sorted_functions = []

        while zero_in_degree_queue:
            current_proc = zero_in_degree_queue.pop(0)
            sorted_functions.append(current_proc)

            for neighbor in call_graph[current_proc]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    zero_in_degree_queue.append(neighbor)

        # Check for cycles in the graph
        if len(sorted_functions) != len(self.__related_procs):
            print("Have recursion")
            remaining = set(self.__related_procs) - set(sorted_functions)
            for proc in remaining:
                sorted_functions.append(proc)
            return sorted_functions
        else:
            print("No recursion:")
            return sorted_functions

    def Union_Persistent_Mb(self):
        per_states = self.__proc_Per_states
        cache_level = [CacheHierarchy.L1I, CacheHierarchy.L1D, CacheHierarchy.L2]

        for proc in self.__related_procs:
            # 使用字典推导式初始化 self.__proc_PS_blocks
            self.__proc_PS_blocks[proc] = {
                node.name: {level: set() for level in cache_level}  # 使用字典推导式创建每个节点的子字典
                for node in proc.nodes  # 遍历每个节点
            }
            # 检查 proc 是否有相关的 loop, 若有则获取所有loop的state，并将其合并。
            if len(self.__proc_Per_states[proc]):
                for proc_state in per_states[proc]:  # 遍历每个proc_state和其包含的node
                    for node in proc.nodes:
                        if node.name in proc_state:
                            for level in cache_level:  # 获取每个缓存级别的内存块并更新
                                pre_blocks = self.__proc_PS_blocks[proc][node.name][
                                    level]  # 检查一下为什么会变成 set(), 是否与default dict有关
                                state_pre = proc_state[node.name].in_state.get_state(CacheAnalysisMethod.PERSISTENT,
                                                                                     level)
                                blocks = set([mem_block
                                              for cache_set in state_pre.get_all_set_lines(do_sort=False)
                                              # All set in cache.
                                              for age_list in cache_set
                                              # Abstract age line of memory block with the same age in a set.
                                              for mem_block in age_list])
                                blocks.update(pre_blocks)
                                self.__proc_PS_blocks[proc][node.name][level] = blocks

    def do_analysis(self):
        # 对调用关系排序
        sorted_functions = self.kahn_topological_sort()
        max_iterations = 10  # Set a limit to prevent infinite loops
        iteration_count = 0
        fixed = False
        main_checked = 0

        while iteration_count < max_iterations and not fixed:
            """ 先对整体（不包含loop）进行不动点迭代。 状态不变，或者达到规定次数的情况下停止循环 """
            fixed = True
            iteration_count += 1
            print("[" + datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S") + "]", end=' ')
            print("iteration_count:", iteration_count)

            if self.__debug:
                name = "\n\niteration_count: " + str(iteration_count)
                with open(self.__debug_path + "/fixpoint_time.txt", 'a') as file:
                    file.write(name + "\n")
                memory_usage(self.__debug_path, name)

            for function in sorted_functions:
                " 设置初始状态EntryState，main函数初始状态为空；其他函数的初始状态为caller nodes的out state的union。 "
                if function.name == "main":
                    EntryState = None
                    main_checked += 1
                else:
                    # 获取本函数入口节点前的调用节点
                    caller_nodes: List[InnerProcNode] = []
                    for caller in function.incoming_proc:
                        for edge in caller.edges:
                            if edge.kind == InnerProcEdgeType.ProcCall and edge.dst.actual_node == function.entry_node:
                                caller_nodes.append(edge.src)
                    # 获取调用节点的 out_state
                    caller_entry_states = []
                    for caller_node in caller_nodes:
                        base_proc = caller_node.base_proc
                        node_name = caller_node.name
                        if base_proc in self.__related_procs:  # 该函数可能被与main无关的函数调用，仅分析与main有关的函数
                            caller_state = copy.deepcopy(self.__proc_fixpoint[base_proc].state_map[node_name].out_state)
                            caller_entry_states.append(caller_state)

                    # 确保在访问列表索引之前检查列表的长度
                    if not caller_entry_states:  # 处理空列表的情况，一般不会出现此情况
                        EntryState = None  #
                    elif len(caller_entry_states) == 1:  # 只有一个元素的情况
                        EntryState = caller_entry_states[0]
                    else:  # 正常情况，使用 sum 计算
                        EntryState = sum(caller_entry_states[1:], start=caller_entry_states[0])

                if isinstance(function.entry_state,
                              type(EntryState)) and function.entry_state == EntryState and main_checked > 1:
                    # print("FIX IN:", function.name)
                    pass
                else:
                    " 如果入口节点传入的状态fixed，则无需再迭代 "
                    function.entry_state = EntryState  # 保留函数入口节点的State，后续迭代时需要继续使用
                    # 将 caller 调用节点的抽象状态传递给 callee 的入口节点，作为 callee 的初始状态。
                    if self.__debug:
                        name = function.name + "-before "
                        memory_usage(self.__debug_path, name)
                    self.__proc_fixpoint[function].do_analysis(self.__proc_access_order[function],
                                                               EntryState=function.entry_state,
                                                               DummyNodes_State=function.dummyNodes_state)
                    if self.__debug:
                        name = function.name + "-after "
                        memory_usage(self.__debug_path, name)

            for function in sorted_functions:
                " 将 callee 的出口状态递回 caller 函数调用后的节点，并对其进行更新。"
                if not function.outgoing_proc:
                    DummyNodes_State = None
                else:
                    # 若它调用过其他函数，获取本function调用函数后的节点，和调用函数的输出状态
                    DummyNodes_State = defaultdict()
                    for edge in function.edges:
                        if edge.kind == InnerProcEdgeType.ProcReturn:
                            base_proc: Procedure = edge.src.actual_node.base_proc
                            exit_nodes = base_proc.exit_nodes
                            callee_exit_states = []
                            # 与main相关的函数outgoing_proc一定与main有关
                            for exit_node in exit_nodes:
                                callee_state = copy.deepcopy(
                                    self.__proc_fixpoint[base_proc].state_map[exit_node.name].out_state)
                                callee_exit_states.append(callee_state)

                            if len(callee_exit_states) == 1:
                                DummyNodes_State[edge.src.name] = callee_exit_states[0]
                            else:
                                DummyNodes_State[edge.src.name] = sum(callee_exit_states[1:],
                                                                      start=callee_exit_states[0])

                if isinstance(function.dummyNodes_state,
                              type(DummyNodes_State)) and function.dummyNodes_state == DummyNodes_State:
                    # print("FIX OUT:", function.name)
                    pass
                else:
                    fixed = False
                    function.dummyNodes_state = DummyNodes_State
                    # 将 callee 的出口状态传递回 caller 函数调用之后的节点。
                    if self.__debug:
                        name = function.name + "-before "
                        memory_usage(self.__debug_path, name)
                    self.__proc_fixpoint[function].do_analysis(self.__proc_access_order[function],
                                                               EntryState=function.entry_state,
                                                               DummyNodes_State=function.dummyNodes_state)
                    if self.__debug:
                        name = function.name + "-after "
                        memory_usage(self.__debug_path, name)

    def persistent_analysis(self):
        for function in self.__related_procs:
            """ 处理Persistent，找出属于该function的loops，并判断该函数是否被嵌套在其他函数的loop中 """
            loops = []  # 属于该函数的loops
            for loop in self.__regular_loops:
                if loop.proc == function:
                    loops.append(loop)

            # 遍历 loops，进行不动点迭代
            if loops:
                for loop in loops:
                    if self.__debug:
                        name = function.name + loop.name + "-before "
                        memory_usage(self.__debug_path, name)

                    self.__loop_fixpoint[loop].do_analysis(self.__proc_access_order[function],
                                                           EntryState=None,
                                                           DummyNodes_State=function.dummyNodes_state)
                    if self.__debug:
                        name = function.name + loop.name + "-after "
                        memory_usage(self.__debug_path, name)

                    self.__proc_Per_states[function].append(self.__loop_fixpoint[loop].state_map)

            " 判断 incoming_proc -> function 所代表的虚拟节点是否在loop中 "
            in_procs = function.incoming_proc
            inOtherProcLoop = False  # 该函数是否被嵌套在其他函数的loop
            for p in in_procs:
                for node in p.nodes:
                    if isinstance(node, InterProcNode) and node.actual_node == function and node.inside_loop:
                        inOtherProcLoop = True
            if inOtherProcLoop:
                self.__proc_Per_states[function].append(self.__proc_fixpoint[function].state_map)

        self.Union_Persistent_Mb()

    def categorize_inst(self, proc: Procedure, node: Hashable, ref: Reference, cache_hierarchy):
        if (self.__proc_fixpoint[proc].state_map[node].in_state.get_state(CacheAnalysisMethod.MUST, cache_hierarchy).
                in_cache(ref.get_block(cache_hierarchy))):
            return cache_hierarchy, CHMC.AH

        elif cache_hierarchy != CacheHierarchy.L3 and ref.get_block(cache_hierarchy) in \
                self.__proc_PS_blocks[proc][node][cache_hierarchy]:  # L3没有PS分析
            return cache_hierarchy, CHMC.PS

        elif not (
        self.__proc_fixpoint[proc].state_map[node].in_state.get_state(CacheAnalysisMethod.MAY, cache_hierarchy).
                in_cache(ref.get_block(cache_hierarchy))):
            return cache_hierarchy, CHMC.AM
        else:
            may_count = 0
            must_count = 0
            base_count = len(self.__proc_fixpoint[proc].state_map[node].nc_in_state_list)
            if base_count == 0:
                nc_proc = 0.0  
            else:
                for state in self.__proc_fixpoint[proc].state_map[node].nc_in_state_list:
                    if state.get_state(CacheAnalysisMethod.MAY, cache_hierarchy).in_cache(
                            ref.get_block(cache_hierarchy)):
                        may_count += 1
                    if state.get_state(CacheAnalysisMethod.MUST, cache_hierarchy).in_cache(
                            ref.get_block(cache_hierarchy)):
                        must_count += 1
                nc_proc = self.nc_proc_cal(must_count, may_count, base_count)
            return cache_hierarchy, nc_proc

    def categorize_data(self, proc: Procedure, node: Hashable, refs: Set[Reference], cache_hierarchy):
        if all(self.__proc_fixpoint[proc].state_map[node].in_state.
                       get_state(CacheAnalysisMethod.MUST, cache_hierarchy).
                       in_cache(ref.get_block(cache_hierarchy))
               for ref in refs):
            return cache_hierarchy, CHMC.AH

        elif cache_hierarchy != CacheHierarchy.L3 and all(
                ref.get_block(cache_hierarchy) in self.__proc_PS_blocks[proc][node][cache_hierarchy]
                for ref in refs):  # L3没有PS分析
            return cache_hierarchy, CHMC.PS

        elif all(not self.__proc_fixpoint[proc].state_map[node].in_state.
                get_state(CacheAnalysisMethod.MAY, cache_hierarchy).
                in_cache(ref.get_block(cache_hierarchy))
                 for ref in refs):
            return cache_hierarchy, CHMC.AM

        else:
            may_count = 0
            must_count = 0
            base_count = len(self.__proc_fixpoint[proc].state_map[node].nc_in_state_list)
            if base_count == 0:
                nc_proc = 0.0  # 默认值（或者根据需求设定）
            else:
                for state in self.__proc_fixpoint[proc].state_map[node].nc_in_state_list:
                    for ref in refs:
                        if state.get_state(CacheAnalysisMethod.MAY, cache_hierarchy).in_cache(
                                ref.get_block(cache_hierarchy)):
                            may_count += 1
                        if state.get_state(CacheAnalysisMethod.MUST, cache_hierarchy).in_cache(
                                ref.get_block(cache_hierarchy)):
                            must_count += 1
                nc_proc = self.nc_proc_cal(must_count, may_count, base_count)
            return cache_hierarchy, nc_proc

    def nc_proc_cal(self, must_count, may_count, base_count):
        may_proc = (may_count / base_count) * 0.4
        if must_count == 0:
            must_proc = 0
        else:
            must_proc = 0.6
        if may_proc + must_proc >= 1:
            return 0.933
        return may_proc + must_proc
        
    def Categorize(self):
        for proc in self.__related_procs:
            for node, refs in self.__proc_inst_ref[proc].items():
                if refs:
                    for inst, ref in refs.items():
                        # chmc = [self.categorize_inst(proc, node, ref, CacheHierarchy.L1I),
                        #         self.categorize_inst(proc, node, ref, CacheHierarchy.L2),
                        #         self.categorize_inst(proc, node, ref, CacheHierarchy.L3)
                        #         ]
                        chmc = [self.categorize_inst(proc, node, ref, CacheHierarchy.L1I),
                                self.categorize_inst(proc, node, ref, CacheHierarchy.L2)
                                ]
                        self.__proc_inst_chmc[proc][
                            inst.addr.hex_str()] = chmc  # cache_line addr: chmc (inst.addr.hex_str())

            for node, data_refs in self.__proc_data_ref[proc].items():
                if data_refs:
                    for inst, refs in data_refs.items():
                        if refs:
                            chmc = [self.categorize_data(proc, node, refs, CacheHierarchy.L1D),
                                    self.categorize_data(proc, node, refs, CacheHierarchy.L2)
                                    ]
                            self.__proc_data_chmc[proc][inst.addr.hex_str()] = chmc

    def Statistical(self, target_range: Tuple[int, int], execution_intervals: List[dict[str, int]], output_dir):
        def get_inst_number(addr_range: Tuple[int, int], intervals: List[dict[str, int]]) -> Dict[str, int]:
            """ 首先计算每条指令的执行次数, 在计算 cache misses数量 """
            instruction_execution_counts: Dict[str, int] = {}  # 字典：存储每条指令的执行次数
            # 遍历目标指令地址范围
            for addr in range(addr_range[0], addr_range[1] + 1, 4):
                # 初始化每条指令的执行次数为 0
                hex_str = hex(addr)[2:]
                instruction_execution_counts[hex_str] = 0
                # 遍历每个执行区间
                for interval in intervals:
                    interval_start = interval['start_address']
                    interval_end = interval['end_address']
                    execution_count = interval['execution_count']
                    # 如果当前指令在当前区间范围内
                    if interval_start <= addr <= interval_end:
                        # 将该区间的执行次数加到指令的执行次数中
                        instruction_execution_counts[hex_str] += execution_count
            return instruction_execution_counts

        def group_addresses_by_cache_block(addresses: Tuple[int, int]) -> Dict[int, list[int]]:
            """ 将地址按照 cache_address 进行划分 """
            cache_blocks: Dict[int, list[int]] = {}
            # Step 1: 将地址按照 cache_address 进行划分
            for addr in range(addresses[0], addresses[1] + 1, 4):
                cache_address = addr >> 6
                if cache_address not in cache_blocks:
                    cache_blocks[cache_address] = []
                cache_blocks[cache_address].append(addr)
            return cache_blocks

        # ==============================================================================
        inst_number = get_inst_number(target_range, execution_intervals)
        # ================================= 分类L1I======================================
        L1_icache_loads = 0
        L1I_inst_chmc: Dict[Hashable, float | str] = {}
        for proc in self.__related_procs:
            for inst_addr, inst_chmc in self.__proc_inst_chmc[proc].items():
                for cache_level, chmc in inst_chmc:
                    if cache_level == CacheHierarchy.L1I:
                        L1I_inst_chmc[inst_addr] = chmc if isinstance(chmc, float) else chmc.name
        L1I_inst_chmc = dict(sorted(L1I_inst_chmc.items()))

        for address in range(target_range[0], target_range[1] + 1, 4):  # 计算 L1I 加载指令的数量
            hex_str_no_prefix = hex(address)[2:]
            if hex_str_no_prefix in L1I_inst_chmc and hex_str_no_prefix in inst_number:
                L1_icache_loads += inst_number[hex_str_no_prefix]

        # Step 1: 将地址按照 cache_address 进行划分
        mb_list = group_addresses_by_cache_block(target_range)

        # Step 2: 遍历每个内存块中的地址
        L1_icache_misses = 0
        L1_icache_misses_noNC = 0
        for cache_address, inst_addrs in mb_list.items():
            inst_addrs.sort()  # 保证地址是连续的顺序
            start_addr = hex(inst_addrs[0])[2:]  # 16进制无前缀
            current_category = L1I_inst_chmc[start_addr]
            current_exec_count = inst_number[start_addr]
            current_miss = 0
            current_miss_noNC = 0
            # 处理 mb 的第一个指令
            if current_category == 'AH':
                pass
            elif current_category == 'AM':
                current_miss += current_exec_count
                current_miss_noNC += current_exec_count
            elif current_category == 'PS':
                current_miss += 1
                current_miss_noNC += current_exec_count
            else:
                current_miss += current_exec_count * (1 - current_category)
                current_miss_noNC += current_exec_count

            # Step 3: 找到分类和执行次数相同的连续指令地址
            for i in range(1, len(inst_addrs)):
                addr = hex(inst_addrs[i])[2:]
                # 如果分类和执行次数不同，则结束当前连续地址的计算
                if L1I_inst_chmc[addr] != current_category or inst_number[addr] != current_exec_count:
                    # 累加之前连续地址的 cost
                    if L1I_inst_chmc[addr] == 'AH':
                        pass
                    elif L1I_inst_chmc[addr] == 'AM':
                        current_miss += inst_number[addr]
                        current_miss_noNC += inst_number[addr]
                    elif L1I_inst_chmc[addr] == 'PS':
                        current_miss += 1
                        current_miss_noNC += 1
                    else:
                        current_miss += inst_number[addr] * (1 - L1I_inst_chmc[addr])
                        current_miss_noNC += inst_number[addr]
                    # 更新为新的地址块
                    start_addr = addr
                    current_category = L1I_inst_chmc[start_addr]
                    current_exec_count = inst_number[start_addr]

            # Step 4: 累加每个 cache block 的计算结果
            L1_icache_misses += current_miss
            L1_icache_misses_noNC += current_miss_noNC

        L1_icache_rate = L1_icache_misses / L1_icache_loads
        L1_icache_rate_noNC = L1_icache_misses_noNC / L1_icache_loads

        print("L1_icache_loads:", L1_icache_loads)
        print("L1_icache_misses:", L1_icache_misses)
        print("L1i misses rate:", L1_icache_rate)
        print("L1_icache_misses noNC", L1_icache_misses_noNC)
        print("L1i misses rate noNC:", L1_icache_rate_noNC)

        # ================================= 分类L1D ================================================
        L1_dcache_loads = 0
        L1_dcache_misses = 0
        L1_dcache_misses_noNC = 0
        L1D_inst_chmc: Dict[Hashable, float | str] = {}
        for proc in self.__related_procs:
            for inst_addr, data_chmc in self.__proc_data_chmc[proc].items():
                for cache_level, chmc in data_chmc:
                    if cache_level == CacheHierarchy.L1D:
                        L1D_inst_chmc[inst_addr] = chmc if isinstance(chmc, float) else chmc.name
        L1D_inst_chmc = dict(sorted(L1D_inst_chmc.items()))

        for address in range(target_range[0], target_range[1] + 1, 4):  # 计算L1I加载指令的数量
            hex_str_no_prefix = hex(address)[2:]
            if hex_str_no_prefix in L1D_inst_chmc and hex_str_no_prefix in inst_number:
                L1_dcache_loads += inst_number[hex_str_no_prefix]
                if L1D_inst_chmc[hex_str_no_prefix] == 'AM':
                    L1_dcache_misses += inst_number[hex_str_no_prefix]
                    L1_dcache_misses_noNC += inst_number[hex_str_no_prefix]
                elif L1D_inst_chmc[hex_str_no_prefix] == 'PS':
                    L1_dcache_misses += 1
                    L1_dcache_misses_noNC += 1
                elif L1D_inst_chmc[hex_str_no_prefix] == 'AH':
                    pass
                else:
                    L1_dcache_misses += inst_number[hex_str_no_prefix] * (1 - L1D_inst_chmc[hex_str_no_prefix])
                    L1_dcache_misses_noNC += inst_number[hex_str_no_prefix]

        L1_dcache_rate = L1_dcache_misses / L1_dcache_loads
        L1_dcache_rate_noNC = L1_dcache_misses_noNC / L1_dcache_loads

        # print("L1_dcache_loads:", L1_dcache_loads)
        print("L1_dcache_misses:", L1_dcache_misses)
        print("L1_dcache_rate:", L1_dcache_rate)
        print("L1_dcache_misses noNC:", L1_dcache_misses_noNC)
        print("L1_dcache_rate noNC:", L1_dcache_rate_noNC)

        output_format = {
            "CACHE_STATS": {
                "L1_icache_loads": L1_icache_loads,
                "L1_icache_misses": L1_icache_misses,
                "L1_icache_rate": L1_icache_rate,
                "L1_icache_misses_noNC": L1_icache_misses_noNC,
                "L1_icache_rate_noNC": L1_icache_rate_noNC,
                "L1_dcache_loads": L1_dcache_loads,
                "L1_dcache_misses": L1_dcache_misses,
                "L1_dcache_rate": L1_dcache_rate,
                "L1_dcache_misses_noNC": L1_dcache_misses_noNC,
                "L1_dcache_rate_noNC": L1_dcache_rate_noNC
            }
        }
        with open(output_dir, 'a') as file:
            json.dump(output_format, file, indent=1)

    def output_chmc(self, output_dir):
        # 暂时地输出形式
        output_format = {"INST": {}, "DATA": {}}
        for proc in self.__related_procs:
            for inst_addr, inst_chmc in self.__proc_inst_chmc[proc].items():
                temp = {}
                for cache_level, chmc in inst_chmc:
                    if isinstance(chmc, float):
                        temp[cache_level.name] = chmc
                    else:
                        temp[cache_level.name] = chmc.name
                output_format["INST"][inst_addr] = temp
            output_format["INST"] = dict(sorted(output_format["INST"].items()))

            for inst_addr, data_chmc in self.__proc_data_chmc[proc].items():
                temp = {}
                for cache_level, chmc in data_chmc:
                    if isinstance(chmc, float):
                        temp[cache_level.name] = chmc
                    else:
                        temp[cache_level.name] = chmc.name
                output_format["DATA"][inst_addr] = temp
            output_format["DATA"] = dict(sorted(output_format["DATA"].items()))

        with open(output_dir, 'w') as file:
            json.dump(output_format, file, indent=1)

