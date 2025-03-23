from typing import List, Tuple, Optional, Dict
import yaml
from sample.pipeline.behaviors import default_pipeline_behavior_translation, PipelineBehavior


class PipelineTracer:
    def __init__(self):
        """"""

        self.__current_cycle: int = 0

        """ Basic """
        self.__block_id: Optional[int] = None
        # Records the behavior of the pipeline at each execution cycle.
        self.__behavior_by_cycle: Dict[int, List[Tuple]] = dict()

        """ Overview of CPU cycles. """
        self.__cycle_total: int = 0
        self.__extra_sp_cycle: int = 0
        self.__cycle_cpu: int = 0
        self.__cycle_stall: int = 0
        self.__cycle_inst_stall: int = 0
        self.__cycle_data_stall: int = 0

        """ Overview of cache misses. """
        self.__inst_miss_time: int = 0
        self.__data_miss_time: int = 0

        """ The time point of fetch packet and execute packet in the pipeline. """
        # Fetch packet: Dict of Cycle_In, Cycle_Dispatch_Finish with FP_ID keys.
        # Execute packet: Dict of Cycle_Dispatched, Cycle_Execute_Finish with EP_ID keys.

        self.__fp_cycle_point: Dict[int, Dict] = dict()
        self.__ep_cycle_point: Dict[int, Dict] = dict()

        """ Details of instruction stalls and data stalls. """
        # Inst stall: List of Tuple[Fetch_Packet_ID, Start_Cycle, Finish_Cycle]
        # Data stall: List of Tuple[Execute_Packet_ID, Inst_ID, Start_Cycle, Finish_Cycle]

        self.__inst_stall_detail: List[Tuple[int, int, int]] = list()
        self.__data_stall_detail: List[Tuple[int, int, int, int]] = list()

    @property
    def block_id(self):
        return self.__block_id

    @property
    def behaviors(self):
        return self.__behavior_by_cycle

    @property
    def cycle_total(self):
        return self.__cycle_total

    @property
    def cycle_cpu(self):
        return self.__cycle_cpu

    @property
    def cycle_stall(self):
        return self.__cycle_stall

    @property
    def cycle_inst_stall(self):
        return self.__cycle_inst_stall

    @property
    def cycle_data_stall(self):
        return self.__cycle_data_stall

    @property
    def inst_miss_time(self):
        return self.__inst_miss_time

    @property
    def data_miss_time(self):
        return self.__data_miss_time

    @property
    def fp_cycle_point(self):
        return self.__fp_cycle_point

    @property
    def ep_cycle_point(self):
        return self.__ep_cycle_point

    @property
    def inst_stall_detail(self):
        return self.__inst_stall_detail

    @property
    def data_stall_detail(self):
        return self.__data_stall_detail

    def __do_pipeline_simulation_start(self, behavior: tuple):
        _, block_id = behavior

        if self.__block_id is not None and self.__block_id != block_id:
            raise RuntimeError("Inconsistent block ID.")
        self.__block_id = block_id

    def __do_pipeline_simulation_finish(self, behavior: tuple):
        _, block_id = behavior

        if self.__block_id is not None and self.__block_id != block_id:
            raise RuntimeError("Inconsistent block ID.")

    def __new_pipeline_cycle(self, behavior: tuple):
        _, cycle = behavior

        self.__current_cycle = cycle
        if self.__current_cycle in self.__behavior_by_cycle:
            raise RuntimeError("Repeated execution cycle.")
        self.__behavior_by_cycle[self.__current_cycle] = list()
        self.__cycle_total += 1
        self.__cycle_cpu += 1

    def __new_stalled_pipeline_cycle(self, behavior: tuple):
        _, cycle_start, cycle_finish = behavior
        duration = cycle_finish - cycle_start + 1

        self.__cycle_total += duration
        self.__cycle_stall += duration

    def __pg_new_fp_fetch(self, behavior: tuple):
        _, fp_id = behavior

        self.__behavior_by_cycle[self.__current_cycle].append(behavior)
        if fp_id in self.__fp_cycle_point:
            raise RuntimeError("Repeated fetch packet.")
        self.__fp_cycle_point[fp_id] = {"in": self.__current_cycle, "finish": None}

    def __fp_to_next_stage(self, behavior: tuple):

        self.__behavior_by_cycle[self.__current_cycle].append(behavior)

    def __dc_new_ep_dispatch(self, behavior: tuple):
        _, _, ep_id = behavior

        self.__behavior_by_cycle[self.__current_cycle].append(behavior)
        if ep_id == "nop":
            return
        if ep_id in self.__ep_cycle_point:
            raise RuntimeError("Repeated execute packet.")
        self.__ep_cycle_point[ep_id] = {"dispatch": self.__current_cycle, "finish": None}

    def __ep_to_next_stage(self, behavior: tuple):

        self.__behavior_by_cycle[self.__current_cycle].append(behavior)

    def __fp_fetch_finish(self, behavior: tuple):

        self.__behavior_by_cycle[self.__current_cycle].append(behavior)

    def __fp_dispatch_finish(self, behavior: tuple):
        _, fp_id = behavior

        self.__behavior_by_cycle[self.__current_cycle].append(behavior)
        try:
            self.__fp_cycle_point[fp_id]["finish"] = self.__current_cycle
        except KeyError:
            raise RuntimeError("There is no corresponding fetch packet.")

    def __ep_execute_finish(self, behavior: tuple):
        _, ep_id, _, _ = behavior

        self.__behavior_by_cycle[self.__current_cycle].append(behavior)
        if ep_id == "nop":
            return
        try:
            self.__ep_cycle_point[ep_id]["finish"] = self.__current_cycle
        except KeyError:
            raise RuntimeError("There is no corresponding execute packet.")

    def __pipeline_stall(self, behavior: tuple):

        self.__behavior_by_cycle[self.__current_cycle].append(behavior)

    def __multi_cycle_nop_stall(self, behavior: tuple):

        self.__behavior_by_cycle[self.__current_cycle].append(behavior)

    def __inst_cache_miss_stall(self, behavior: tuple):
        _, fp_id, penalty, begin_cycle, end_cycle = behavior

        if not penalty == end_cycle - begin_cycle + 1:
            raise RuntimeError("Penalty does not match the cycle.")
        self.__behavior_by_cycle[self.__current_cycle].append(behavior)
        self.__cycle_inst_stall += penalty
        self.__inst_miss_time += 1
        self.__inst_stall_detail.append((fp_id, begin_cycle, end_cycle))

    def __data_cache_miss_stall(self, behavior: tuple):
        _, ep_id, inst_id, penalty, begin_cycle, end_cycle = behavior

        if not penalty == end_cycle - begin_cycle + 1:
            raise RuntimeError("Penalty does not match the cycle.")
        self.__behavior_by_cycle[self.__current_cycle].append(behavior)
        self.__cycle_data_stall += penalty
        self.__data_miss_time += 1
        self.__data_stall_detail.append((ep_id, inst_id, begin_cycle, end_cycle))

    def __sploop_body(self, behavior: tuple):
        pass

    def __sploop_finish(self, behavior: tuple):
        _, _, _, _, _, extra_cycle = behavior

        self.__extra_sp_cycle = extra_cycle
        self.__cycle_total += extra_cycle
        self.__behavior_by_cycle[self.__current_cycle].append(behavior)

    def __pipeline_status(self, behavior: tuple):
        pass

    def __special_event(self, behavior: tuple):

        self.__behavior_by_cycle[self.__current_cycle].append(behavior)

    def append(self, behavior: tuple):
        code: PipelineBehavior = behavior[0]
        if not isinstance(code, PipelineBehavior):
            raise TypeError("Unknown type {} of the first element in behavior.".format(type(code)))

        if code == PipelineBehavior.DO_PIPELINE_SIMULATION_START:
            self.__do_pipeline_simulation_start(behavior)
        elif code == PipelineBehavior.DO_PIPELINE_SIMULATION_FINISH:
            self.__do_pipeline_simulation_finish(behavior)

        elif code == PipelineBehavior.NEW_PIPELINE_CYCLE:
            self.__new_pipeline_cycle(behavior)
        elif code == PipelineBehavior.NEW_STALLED_PIPELINE_CYCLES:
            self.__new_stalled_pipeline_cycle(behavior)

        elif code == PipelineBehavior.PG_NEW_FP_FETCH:
            self.__pg_new_fp_fetch(behavior)
        elif code == PipelineBehavior.FP_TO_NEXT_STAGE:
            self.__fp_to_next_stage(behavior)
        elif code == PipelineBehavior.DC_NEW_EP_DISPATCH:
            self.__dc_new_ep_dispatch(behavior)
        elif code == PipelineBehavior.EP_TO_NEXT_STAGE:
            self.__ep_to_next_stage(behavior)

        elif code == PipelineBehavior.FP_FETCH_FINISH:
            self.__fp_fetch_finish(behavior)
        elif code == PipelineBehavior.FP_DISPATCH_FINISH:
            self.__fp_dispatch_finish(behavior)
        elif code == PipelineBehavior.EP_EXECUTE_FINISH:
            self.__ep_execute_finish(behavior)

        elif code == PipelineBehavior.PIPELINE_STALL:
            self.__pipeline_stall(behavior)
        elif code == PipelineBehavior.MULTI_CYCLE_NOP_STALL:
            self.__multi_cycle_nop_stall(behavior)
        elif code == PipelineBehavior.INST_CACHE_MISS_STALL:
            self.__inst_cache_miss_stall(behavior)
        elif code == PipelineBehavior.DATA_CACHE_MISS_STALL:
            self.__data_cache_miss_stall(behavior)

        elif code == PipelineBehavior.SPLOOP_BODY:
            self.__sploop_body(behavior)
        elif code == PipelineBehavior.SPLOOP_FINISH:
            self.__sploop_finish(behavior)

        elif code == PipelineBehavior.PIPELINE_STATUS:
            self.__pipeline_status(behavior)
        elif code == PipelineBehavior.SPECIAL_EVENT:
            self.__special_event(behavior)

    def dump(self, output_dir: str,
             behaviors: bool = True, cpu_overview: bool = True, cache_miss_overview: bool = True,
             packet_point: bool = True, stall_detail: bool = True):

        data = dict()
        # Check if output_dir is a valid file path.
        with open(output_dir, "w") as f:
            pass

        data["Block ID"] = self.__block_id
        if cpu_overview:
            data["Cycle overview"] = {
                "cycle.total": self.__cycle_total, "cycle.cpu": self.__cycle_cpu, "cycle.stall.total": self.__cycle_stall,
                "cycle.SPLoop": self.__extra_sp_cycle,
                "cycle.stall.inst": self.__cycle_inst_stall, "cycle.stall.data": self.__cycle_data_stall
            }
        if cache_miss_overview:
            data["Miss overview"] = {"inst": self.__inst_miss_time, "data": self.__data_miss_time}
        if packet_point:
            data["Packet point"] = {
                "Fetch Packet": self.__fp_cycle_point,
                "Execute Packet": self.__ep_cycle_point
            }
        if stall_detail:
            data["Inst stall details"] = [{"fp_id": fp_id, "start_cycle": sc, "finish_cycle": fc} for fp_id, sc, fc in self.__inst_stall_detail]
            data["Data stall details"] = [{"fp_id": fp_id, "inst_id": inst_id, "start_cycle": sc, "finish_cycle": fc}
                                          for fp_id, inst_id, sc, fc in self.__data_stall_detail]
        if behaviors:
            data["Behaviors"] = {c: [default_pipeline_behavior_translation(behavior) for behavior in behaviors]
                                 for c, behaviors in self.__behavior_by_cycle.items()}

        with open(output_dir, "w") as f:
            yaml.dump(data, f, default_flow_style=False, sort_keys=False, encoding='utf-8')
