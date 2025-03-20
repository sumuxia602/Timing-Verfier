import copy
from collections import deque, defaultdict
from copy import deepcopy
from typing import List, Dict, Hashable, Optional, Set

from src.cache.abstract_state import MultiLevelCacheState
from src.cfg import *
from src.cache.constants import CacheAnalysisMethod, RefType
from src.cache.memory_ref import Reference
from src.cache.cache_config import MultiLevelCacheConfig


class FixpointState:

    def __init__(self, cache_config: Optional[MultiLevelCacheConfig] = None,
                 init_state: Optional[MultiLevelCacheState] = None):
        self.nc_in_state_list = list()
        self.nc_out_state_list = list()
        if cache_config is not None:
            self.in_state = MultiLevelCacheState(multilevel_cache_config=cache_config)
            self.out_state = MultiLevelCacheState(multilevel_cache_config=cache_config)
        elif init_state is not None:
            self.in_state = deepcopy(init_state)
            self.out_state = deepcopy(init_state)
        else:
            raise ValueError("At least one of cache_config and init_state should be provided for initialization.")

    def reset(self):
        # 重置 in_state 和 out_state
        self.in_state.clear()  # 或者定义自定义清除方法
        self.out_state.clear()
        self.nc_in_state_list = list()
        self.nc_out_state_list = list()


class Fixpoint:
    def __init__(self, proc: Procedure,
                 debug_path: str,
                 debug: bool,
                 cache_config: MultiLevelCacheConfig,
                 loop: Optional[InnerProcLoop] = None):
        self.__proc = proc
        self.__debug_path = debug_path
        self.__debug = debug
        self.__cache_config = cache_config
        self.__nodes_dict: Dict[Hashable, InnerProcNode] = {node.name: node for node in proc.nodes}
        self.__state_map: Dict[Hashable, FixpointState] = defaultdict()  # 从 Node ident 到 Abstract State 的映射

        for node in self.__proc.nodes:
            self.__state_map[node.name] = FixpointState(cache_config=self.__cache_config)
        self.__loop = loop

    @property
    def state_map(self) -> Dict[Hashable, FixpointState]:
        return self.__state_map

    def do_analysis(self, refs: Dict[Hashable, List[Set[Reference]]], EntryState: Optional[MultiLevelCacheState] = None,
                    DummyNodes_State: Optional[Dict[Hashable, MultiLevelCacheState]] = None):

        """ 对整体进行不动点迭代：MUST, MAY, PERSISTENT(得到外部函数的loop嵌套本函数的情况) """

        " Fixpoint分析的入口结点 "
        entry_node: Hashable = self.__proc.entry_node.name if self.__loop is None else self.__loop.head.name

        " 被考虑的结点的集合 "
        if self.__loop is not None:
            node_considered: Set[Hashable] = set([node.name for node in self.__loop.nodes])
        else:
            node_considered: Set[Hashable] = set(node.name for node in self.__proc.nodes)

        " 使用直接重置对象属性的方法来清空每个节点的状态 "
        for node_name, state in self.__state_map.items():
            state.reset()

        " 设置入口节点的状态 "
        if EntryState is not None:
            self.__state_map[entry_node].in_state = copy.deepcopy(EntryState)
            self.__state_map[entry_node].nc_in_state_list.append(EntryState)
        else:
            # nc list = [], add state to nc list
            self.__state_map[entry_node].nc_in_state_list.append(self.__state_map[entry_node].in_state)

        " 判断是否已经达到全局不动点，即检查到的所有的状态都没有发生变化，那么就认为到达了不动点。"
        global_reach_fixpoint = False

        fixpoint_count = 0
        proc_name = self.__proc.name.ljust(50)
        file_txt = ""
        while not global_reach_fixpoint:
            if self.__debug:
                fixpoint_count += 1
                if fixpoint_count == 1:
                    file_txt = proc_name + " in " + str(fixpoint_count) + " time fixpoint \n"
                else:
                    file_txt = proc_name + " in " + str(fixpoint_count) + " times fixpoint \n"

            global_reach_fixpoint = True
            checked = set()
            q = deque([entry_node])
            while len(q) != 0:
                """ 获取当前考察的结点。 """
                cur_node_ident: Hashable = q.popleft()
                cur_node = self.__nodes_dict[cur_node_ident]

                """ 获取该结点的in_state, 以供后续比较。 """
                old_in_state: MultiLevelCacheState = self.__state_map[cur_node_ident].in_state

                """ 获取该结点所有的前驱结点，并进一步获得在considered中的所有前驱结点的out_state。 """
                predecessor: Set[Hashable] = set()
                for edge in self.__proc.edges:
                    if edge.dst == cur_node:  # 本函数的节点
                        predecessor.add(edge.src.name)

                to_join_states: List[MultiLevelCacheState] = [self.__state_map[o].out_state
                                                              for o in predecessor if o in node_considered]
                """ 合并（join）所有的状态，得到新的状态并赋值给当前结点的in_state """
                if len(to_join_states) != 0:
                    new_in_state = sum(to_join_states[1:], start=to_join_states[0])
                    self.__state_map[cur_node_ident].in_state = new_in_state
                    self.__state_map[cur_node_ident].nc_in_state_list.extend(to_join_states)
                    # NC概率化将相邻的两个状态合并成一个，直到状态列表的长度小于或等于8。
                    if len(self.__state_map[cur_node_ident].nc_in_state_list) > 8:
                        join_states = self.__state_map[cur_node_ident].nc_in_state_list
                        # 如果状态列表长度超过 8，执行两两合并
                        while len(join_states) > 8:
                            new_states = []  # 存储合并后的新状态列表
                            for i in range(0, len(join_states) - 1, 2):  # 两两合并，i 每次步进 2
                                merged_state = sum([join_states[i + 1]], start=join_states[i])  # 合并相邻的两个状态
                                new_states.append(merged_state)
                            # 如果原始列表是奇数个，最后一个未被合并，直接加入新的列表中
                            if len(join_states) % 2 != 0:
                                new_states.append(join_states[-1])
                            # 用合并后的新列表替换当前的状态列表
                            join_states = new_states
                        # 将最终的状态列表更新回节点，确保长度 <= 8
                        self.__state_map[cur_node_ident].nc_in_state_list = join_states
                else:
                    new_in_state = old_in_state

                """ 
                如果这是第一次访问该结点，那么无论是否到达fixpoint，都进行后续的步骤。
                如果这不是第一次访问该节点，检查新旧in_state是否相同。如果相同，则说明该节点已经到达了fixpoint，
                不再考察该结点。否则，执行后续的步骤。
                """
                if new_in_state != old_in_state and not isinstance(cur_node, InterProcNode):
                    """ 只要存在一个结点没有到达fixpoint，则整个状态都没有到达fixpoint。  """
                    global_reach_fixpoint = False

                elif cur_node_ident in checked:
                    continue
                """ 标记该结点已经被访问过。 """
                checked.add(cur_node_ident)

                """ 令dummy_node的out_state赋值为调用函数末节点的out_state """
                if isinstance(cur_node, InterProcNode) and DummyNodes_State:
                    if cur_node_ident in DummyNodes_State:
                        new_out_state = copy.deepcopy(DummyNodes_State[cur_node_ident])
                        new_nc_out_state_list = [new_out_state]
                    else:
                        new_out_state = MultiLevelCacheState(multilevel_cache_config=self.__cache_config)
                        new_nc_out_state_list = [new_out_state]
                else:
                    """ 该结点的新的out_state是新的in_state与将当前结点的所有mem_blocks进行update的结果。 """
                    new_out_state = deepcopy(self.__state_map[cur_node_ident].in_state)
                    new_nc_out_state_list = deepcopy(self.__state_map[cur_node_ident].nc_in_state_list)
                    for ref in refs[cur_node_ident]:
                        if ref:
                            if list(ref)[0].ref_type == RefType.INST:
                                # RefType.INST, 一条指令
                                for item in ref:
                                    new_out_state.update(item)
                                    for nc_output_state in new_nc_out_state_list:
                                        nc_output_state.update(item)
                            else:
                                # RefType.DATA, 数据确定其对应的数据块(1)。
                                if len(ref) == 1:
                                    new_out_state.update(list(ref)[0])
                                    for nc_output_state in new_nc_out_state_list:
                                        nc_output_state.update(list(ref)[0])
                                # RefType.DATA, 数据无法确定对应的数据块，所以赋值为可能对应的多个数据块(>1)，分别进行更新再合并。
                                if len(ref) > 1:
                                    " state进行更新 "
                                    state_list = []
                                    for may_access_ref in ref:
                                        state = deepcopy(new_out_state)
                                        state.update(may_access_ref)
                                        state_list.append(state)
                                    new_out_state = sum(state_list[1:], start=state_list[0])

                                    " nc state进行更新 "
                                    nc_state_list = []
                                    for nc_output_state in new_nc_out_state_list:  # 对于nc list中的每个state更新多个内存块再join
                                        nc_state_list = []
                                        for may_access_ref in ref:
                                            nc_state = deepcopy(nc_output_state)
                                            nc_state.update(may_access_ref)
                                            nc_state_list.append(nc_state)  # 每个state更新多个内存块合并的状态
                                        nc_new_out_state = sum(nc_state_list[1:], start=nc_state_list[0])
                                        nc_state_list.append(nc_new_out_state)
                                    new_nc_out_state_list = nc_state_list

                self.__state_map[cur_node_ident].out_state = new_out_state
                self.__state_map[cur_node_ident].nc_out_state_list = new_nc_out_state_list

                """ 将该节点所有的后继结点加入队列q中。 """
                successor: Set[InnerProcNode] = set()
                for edge in self.__proc.edges:
                    if edge.src == cur_node:
                        successor.add(edge.dst.name)

                q.extend(node for node in successor if node in node_considered)

        if self.__debug:
            with open(self.__debug_path + "/fixpoint_time.txt", 'a') as file:
                file.write(file_txt)
