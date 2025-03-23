from collections import deque, defaultdict
from copy import deepcopy
from typing import List, Dict, Hashable, Optional, Set

from sample.cache.abstract_state import CacheConfig, CacheState
from sample.cache.cache_cfg import CacheCFG, CacheCFGNode, CacheCFGLoop
from sample.cache.constants import CacheAnalysisMethod
from sample.cache.memory_ref import InstMemoryRef, DataMemoryRef


class FixpointState:
    """ 不动点的 instate和 outstate """
    def __init__(self, cache_config: Optional[CacheConfig] = None, analysis_type: Optional[CacheAnalysisMethod] = None,
                 init_state: Optional[CacheState] = None):

        if cache_config is not None and analysis_type is not None:
            self.in_state = CacheState(cache_config=cache_config, analysis_type=analysis_type)
            self.out_state = CacheState(cache_config=cache_config, analysis_type=analysis_type)
        elif init_state is not None:
            self.in_state = deepcopy(init_state)
            self.out_state = deepcopy(init_state)
        else:
            raise ValueError("At least one of (cache_config, analysis_type) and init_state should be provided for "
                             "initialization.")


class Fixpoint:
    """ 用于不动点迭代 """
    def __init__(self, cfg: CacheCFG, cache_config: CacheConfig):
        self.__cfg = cfg
        self.__cache_config = cache_config
        self.__nodes_dict: Dict[Hashable, CacheCFGNode] = {ident: cfg.get_node(ident) for ident in cfg.node_idents}
        self.__loops_dict: Dict[Hashable, CacheCFGLoop] = {ident: cfg.get_loop(ident) for ident in cfg.loop_idents}

    def do_analysis_inst(self, analysis_type: CacheAnalysisMethod, inst_refs: InstMemoryRef,
                         level: Optional[Hashable] = None) -> Dict[Hashable, FixpointState]:
        """"""
        " Fixpoint分析的入口结点 "
        entry_node: Hashable = self.__cfg.entry_node_ident if level is None else self.__loops_dict[level].head
        " 被考虑的结点的集合 "
        node_considered: Set[Hashable] = set(self.__cfg.node_idents) if level is None \
            else self.__loops_dict[level].node_in_loop
        " 从Node ident到Abstract State的映射 "
        state_map: Dict[Hashable, FixpointState] = defaultdict(
            lambda: FixpointState(cache_config=self.__cache_config, analysis_type=analysis_type)
        )

        """ 判断是否已经达到全局不动点，即检查到的所有的状态都没有发生变化，那么就认为到达了不动点。 """
        global_reach_fixpoint = False

        while not global_reach_fixpoint:
            global_reach_fixpoint = True
            checked = set()
            q = deque([entry_node])
            while len(q) != 0:
                """ 获取当前考察的结点。 """
                cur_node_ident: Hashable = q.popleft()
                cur_node = self.__nodes_dict[cur_node_ident]

                """ 获取该结点的in_state以及哈希值，以供后续比较。 """
                old_in_state: CacheState = state_map[cur_node_ident].in_state
                old_in_state_hashed = old_in_state.runtime_ident.__hash__()

                """ 获取该结点所有的前驱结点，并进一步获得在considered中的所有前驱结点的out_state。 """
                predecessor: Set[Hashable] = cur_node.in_nodes
                to_join_states: List[CacheState] = [state_map[o].out_state
                                                    for o in predecessor if o in node_considered]

                """ 合并（join）所有的状态，得到新的状态并赋值给当前结点的in_state，并获得新的状态对应的Hash值。 """
                if len(to_join_states) != 0:
                    new_in_state = sum(to_join_states[1:], start=to_join_states[0])
                    new_in_state_hashed = new_in_state.runtime_ident.__hash__()
                    state_map[cur_node_ident].in_state = new_in_state
                else:
                    """ 如果该节点没有任何的前驱结点，那么不改变它的Cache State。 """
                    new_in_state_hashed = old_in_state_hashed

                """ 
                如果这是第一次访问该结点，那么无论是否到达fixpoint，都进行后续的步骤。
                如果这不是第一次访问该节点，检查新旧in_state的哈希值是否相同。如果相同，则说明该节点已经到达了fixpoint，
                不再考察该结点。否则，执行后续的步骤。
                """
                if new_in_state_hashed != old_in_state_hashed:
                    """ 只要存在一个结点没有到达fixpoint，则整个状态都没有到达fixpoint。  """
                    global_reach_fixpoint = False
                elif cur_node_ident in checked:
                    continue
                """ 标记该结点已经被访问过。 """
                checked.add(cur_node_ident)

                """ 该结点的新的out_state是新的in_state与将当前结点的所有mem_blocks进行update的结果。 """
                new_out_state = deepcopy(state_map[cur_node_ident].in_state)
                # 使用cur_node.root，获得该结点最原始的结点对应的下标。
                new_out_state.update(inst_refs.get_blocks(cur_node.root))
                state_map[cur_node_ident].out_state = new_out_state

                """ 将该节点所有的后继结点加入队列q中。 """
                q.extend(node for node in cur_node.out_nodes if node in node_considered)

        return dict(state_map)

    
    def do_analysis_data(self, analysis_type: CacheAnalysisMethod, data_refs: DataMemoryRef,
                         level: Optional[Hashable] = None) -> Dict[Hashable, FixpointState]:
        """"""
        " Fixpoint分析的入口结点 "
        entry_node: Hashable = self.__cfg.entry_node_ident if level is None else self.__loops_dict[level].head
        " 被考虑的结点的集合 "
        node_considered: Set[Hashable] = set(self.__cfg.node_idents) if level is None \
            else self.__loops_dict[level].node_in_loop
        " 从Node ident到Abstract State的映射 "
        state_map: Dict[Hashable, FixpointState] = defaultdict(
            lambda: FixpointState(cache_config=self.__cache_config, analysis_type=analysis_type)
        )

        """ 判断是否已经达到全局不动点，即检查到的所有的状态都没有发生变化，那么就认为到达了不动点。 """
        global_reach_fixpoint = False

        while not global_reach_fixpoint:
            global_reach_fixpoint = True
            checked = set()
            q = deque([entry_node])
            while len(q) != 0:
                """ 获取当前考察的结点。 """
                cur_node_ident: Hashable = q.popleft()
                cur_node = self.__nodes_dict[cur_node_ident]

                """ 获取该结点的in_state以及哈希值，以供后续比较。 """
                old_in_state: CacheState = state_map[cur_node_ident].in_state
                old_in_state_hashed = old_in_state.runtime_ident.__hash__()

                """ 获取该结点所有的前驱结点，并进一步获得在considered中的所有前驱结点的out_state。 """
                predecessor: Set[Hashable] = cur_node.in_nodes
                to_join_states: List[CacheState] = [state_map[o].out_state
                                                    for o in predecessor if o in node_considered]

                """ 合并（join）所有的状态，得到新的状态并赋值给当前结点的in_state，并获得新的状态对应的Hash值。 """
                if len(to_join_states) != 0:
                    new_in_state = sum(to_join_states[1:], start=to_join_states[0])
                    new_in_state_hashed = new_in_state.runtime_ident.__hash__()
                    state_map[cur_node_ident].in_state = new_in_state
                else:
                    """ 如果该节点没有任何的前驱结点，那么不改变它的Cache State。 """
                    new_in_state_hashed = old_in_state_hashed

                """ 
                如果这是第一次访问该结点，那么无论是否到达fixpoint，都进行后续的步骤。
                如果这不是第一次访问该节点，检查新旧in_state的哈希值是否相同。如果相同，则说明该节点已经到达了fixpoint，
                不再考察该结点。否则，执行后续的步骤。
                """
                if new_in_state_hashed != old_in_state_hashed:
                    """ 只要存在一个结点没有到达fixpoint，则整个状态都没有到达fixpoint。  """
                    global_reach_fixpoint = False
                elif cur_node_ident in checked:
                    continue
                """ 标记该结点已经被访问过。 """
                checked.add(cur_node_ident)

                """ 该结点的新的out_state是新的in_state与将当前结点的所有mem_blocks进行update的结果。 """
                new_out_state = deepcopy(state_map[cur_node_ident].in_state)
                # 使用cur_node.root，获得该结点最原始的结点对应的下标。

                # 对于一个data reference可能访问的内存块，先分别Update再Join
                for blocks in data_refs[cur_node_ident].values():
                    if len(blocks) == 1:
                        new_out_state.update(blocks)
                    if len(blocks) > 1:
                        state_list = []
                        for block in blocks:
                            state = deepcopy(new_out_state)
                            state.update([block])
                            state_list.append(state)
                        new_out_state = sum(state_list[1:], start=state_list[0])

                # new_out_state.update(data_refs.get_blocks(cur_node.root))
                state_map[cur_node_ident].out_state = new_out_state

                """ 将该节点所有的后继结点加入队列q中。 """
                q.extend(node for node in cur_node.out_nodes if node in node_considered)

        return dict(state_map)
