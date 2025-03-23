from enum import Enum, auto
from typing import Tuple

from sample.pipeline.constants import pipeline_stage_translation


class PipelineBehavior(Enum):
    """
    Constant of PipelineBehavior stands for a behavior during pipeline simulation.

    Format:
    -------

    - (DO_PIPELINE_SIMULATION_START, block_id)
    - (DO_PIPELINE_SIMULATION_FINISH, block_id)

    - (NEW_PIPELINE_CYCLE, cycle:int)
    - (NEW_STALLED_PIPELINE_CYCLES, begin_cycle:int, end_cycle:int)

    - (PG_NEW_FP_FETCH, fp_id)
    - (FP_TO_NEXT_STAGE, fp_id,
                         last_stage:PipelineStage, last_stage_details:Optional[Any], this_stage:PipelineStage, this_stage_details:Optional[Any])
    - (DC_NEW_EP_DISPATCH, fp_id, ep_id)
    - (EP_TO_NEXT_STAGE, ep_id,
                         last_stage:PipelineStage, last_stage_details:Optional[Any], this_stage:PipelineStage, this_stage_details:Optional[Any])

    - (FP_FETCH_FINISH, )
    - (FP_DISPATCH_FINISH, fp_id)
    - (EP_EXECUTE_FINISH, ep_id, stage:PipelineStage, stage_details:Optional[Any])

    - (PIPELINE_STALL, fp_id)
    - (MULTI_CYCLE_NOP_STALL, ep_id, inst_id, nop_cycle:int)
    - (INST_CACHE_MISS_STALL, fp_id, penalty:int, begin_cycle:int, end_cycle:int)
    - (DATA_CACHE_MISS_STALL, ep_id, inst_id, penalty:int, begin_cycle:int, end_cycle:int)

    - (SPLOOP_BODY, )
    - (SPLOOP_FINISH, ep_id, dynlen:int, ii:int, max_iter:int, extra_cycles:int)

    - (PIPELINE_STATUS, status:str)
    - (SPECIAL_EVENT, event:str)

    """

    # Boundary:
    DO_PIPELINE_SIMULATION_START = auto()  # The simulation of the block starts.
    DO_PIPELINE_SIMULATION_FINISH = auto()  # The simulation of the block has finished.
    """
    A sequence of pipeline behavior should start with DO_PIPELINE_SIMULATION_START and finish with DO_PIPELINE_SIMULATION_FINISH.
    Or something wrong may happen.
    """
    NEW_PIPELINE_CYCLE = auto()
    NEW_STALLED_PIPELINE_CYCLES = auto()

    # Standard behavior:
    PG_NEW_FP_FETCH = auto()  # A new fetch packet is fetched by stage PG.
    FP_TO_NEXT_STAGE = auto()  # A fetch packet moves to next stage of pipeline.
    DC_NEW_EP_DISPATCH = auto()  # A new execute packet is dispatched by stage DP and sent to stage DC.
    EP_TO_NEXT_STAGE = auto()  # An execute packet moves to next stage of pipeline.

    # Flags:
    FP_FETCH_FINISH = auto()  # All fetch packets fetching finish.
    FP_DISPATCH_FINISH = auto()  # A fetch packet is fully dispatched by stage DP.
    EP_EXECUTE_FINISH = auto()  # An execute packet is fully executed. This may happen at any execute stage.

    # Stalls:
    PIPELINE_STALL = auto()  # A pipeline stall.
    MULTI_CYCLE_NOP_STALL = auto()  # A multi-cycle nop stall happen.
    INST_CACHE_MISS_STALL = auto()  # An instruction cache miss stall. This can only happen at stage E3 stage by ST/LD instructions.
    DATA_CACHE_MISS_STALL = auto()  # A data cache miss stall. This can only happen at stage PW.

    # SPLoop:
    SPLOOP_BODY = auto()  # Current block contains a SPLoop body.
    SPLOOP_FINISH = auto()  # SPLoop body finished.

    # Special:
    PIPELINE_STATUS = auto()
    SPECIAL_EVENT = auto()


def default_pipeline_behavior_translation(bh: Tuple) -> str:
    """ """
    e = bh[0]

    if e == PipelineBehavior.DO_PIPELINE_SIMULATION_START:
        _, block_id = bh
        return "Pipeline simulation for block {} start.".format(block_id)
    elif e == PipelineBehavior.DO_PIPELINE_SIMULATION_FINISH:
        _, block_id = bh
        return "Pipeline simulation for block {} finish.".format(block_id)

    elif e == PipelineBehavior.NEW_PIPELINE_CYCLE:
        _, cycle = bh
        return "Pipeline cycle {}.".format(cycle)
    elif e == PipelineBehavior.NEW_STALLED_PIPELINE_CYCLES:
        _, begin_cycle, end_cycle = bh
        return "Pipeline stall from cycle {} to cycle {}.".format(begin_cycle, end_cycle)

    elif e == PipelineBehavior.PG_NEW_FP_FETCH:
        _, fp_id = bh
        return "Fetch new fetch packet {}.".format(fp_id)
    elif e == PipelineBehavior.FP_TO_NEXT_STAGE:
        _, fp_id, s1, d1, s2, d2 = bh
        return "Fetch packet {} moves to next stage {} (from stage {}).".format(fp_id,
                                                                                pipeline_stage_translation(s2, d2),
                                                                                pipeline_stage_translation(s1, d1))
    elif e == PipelineBehavior.DC_NEW_EP_DISPATCH:
        _, fp_id, ep_id = bh
        return "Execute packet {} dispatched from fetch packet {}.".format(ep_id, fp_id)
    elif e == PipelineBehavior.EP_TO_NEXT_STAGE:
        _, ep_id, s1, d1, s2, d2 = bh
        return "Execute packet {} moves to next stage {} (from stage {}).".format(ep_id,
                                                                                  pipeline_stage_translation(s2, d2),
                                                                                  pipeline_stage_translation(s1, d1))

    elif e == PipelineBehavior.FP_FETCH_FINISH:
        return "All fetch packets fetching finish."
    elif e == PipelineBehavior.FP_DISPATCH_FINISH:
        _, fp_id = bh
        return "Fetch packet {} dispatching finish.".format(fp_id)
    elif e == PipelineBehavior.EP_EXECUTE_FINISH:
        _, ep_id, s, d = bh
        return "Execute packet {} executing finish after stage {}".format(ep_id, pipeline_stage_translation(s, d))

    elif e == PipelineBehavior.PIPELINE_STALL:
        _, fp_id = bh
        return "Pipeline stall, fetch packet {}.".format(fp_id)
    elif e == PipelineBehavior.MULTI_CYCLE_NOP_STALL:
        _, ep_id, inst_id, nop_cycle = bh
        return "Multi-cycle NOPs stall, instruction {} in execute packet {} with cycle {}.".format(inst_id, ep_id, nop_cycle)
    elif e == PipelineBehavior.INST_CACHE_MISS_STALL:
        _, fp_id, penalty, begin_cycle, end_cycle = bh
        return "Instruction cache miss stall, fetch packet {}, {} cycles penalty.".format(fp_id, penalty)
    elif e == PipelineBehavior.DATA_CACHE_MISS_STALL:
        _, ep_id, inst_id, penalty, begin_cycle, end_cycle = bh
        return "Data cache miss stall, instruction {} in execute packet {}, {} cycles penalty.".format(inst_id, ep_id, penalty)

    elif e == PipelineBehavior.SPLOOP_BODY:
        return "Current basic block contains a SPLoop Body."
    elif e == PipelineBehavior.SPLOOP_FINISH:
        _, ep_id, dynlen, ii, max_iter, extra_cycle = bh
        return "SPLoop finished after EP {} with extra {} cycles. " \
               "The details of SPLoop is dynlen={}, ii={}, max_iter={}.".format(ep_id, extra_cycle, dynlen, ii, max_iter)

    elif e == PipelineBehavior.PIPELINE_STATUS:
        _, status = bh
        return status
    elif e == PipelineBehavior.SPECIAL_EVENT:
        _, event = bh
        return event

    raise RuntimeError("Unknown type {}.".format(type(e)))
