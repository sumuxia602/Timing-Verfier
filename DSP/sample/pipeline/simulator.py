import warnings
from typing import Sequence, Set, Tuple, Optional, List, Hashable

import tabulate

from sample.cache.cache_config import CacheConfig
from sample.cache.memory_block import MemoryBlock
from sample.pipeline.abstract_interpretation import FPInPipeline, FPDispatch, EPInPipeline, EP_WITH_SINGLE_NOP
from sample.pipeline.behaviors import PipelineBehavior
from sample.pipeline.constants import InstType, PipelineStage
from sample.pipeline.sploop import SPLoopType, SPLoopSimulator
from sample.pipeline.tracer import PipelineTracer


def do_pipeline_simulation_in_block(block_id, fps: Sequence[FPInPipeline], fps_is_line_head: Sequence[bool],
                                    fps_line_addr: Sequence[MemoryBlock], 
                                    hit_blocks: Set[MemoryBlock], hit_data_refer: Set[Hashable],
                                    inst_cache_config: CacheConfig, data_cache_config: CacheConfig,
                                    is_sp_loop_body: bool,
                                    sp_type: Optional[SPLoopType] = None, ii: Optional[int] = None, max_iter: Optional[int] = None,
                                    log: bool = False, status_log: bool = False) -> Tuple[int, PipelineTracer]:
    """ Do block sim for single block. """

    def behavior_append(tracer: PipelineTracer, behavior: Tuple):
        if log:
            tracer.append(behavior)

    if inst_cache_config.penalty <= 0:
        warnings.warn("No instruction miss stall occurs during pipeline simulation because inst_penalty <= 0.")
    if data_cache_config.penalty <= 0:
        warnings.warn("No data miss stall occurs during pipeline simulation because data_penalty <= 0.")

    """ This buffer contains all cache behaviors in chronological order. """
    pipeline_tracer: PipelineTracer = PipelineTracer()

    # Before Decode:DP stage, data flows in FP.
    fp_in_pg: Optional[FPInPipeline] = None
    fp_in_ps: Optional[FPInPipeline] = None
    fp_in_pw: Optional[FPInPipeline] = None
    fp_in_pr: Optional[FPInPipeline] = None
                                      
    # Decode:DP is the stage when FP is dispatched into EP(s).
    fp_in_dp: Optional[FPDispatch] = None
                                      
    # After Decode:DP, data flows in EP.
    ep_in_dc: Optional[EPInPipeline] = None
                                      
    """ The last entry of ep_in_ei is redundant. This prevents external check for E10. """
    ep_in_ei: List[Optional[EPInPipeline]] = [None for _ in range(10 + 1)]  # So it is. the length of ep_in_ei is 11.

    num_fp = len(fps)  # The number of fetch packets.
    next_fp_idx = 0  # Next fetch packet ready to move to pipeline.
    current_cycle = 0  # Current simulation cycle.
    cpu_cycle = 0   # Do not consider stall
    next_stage_penalty = 0  # If the value of this variable is not 0, then a global stall will occur.
    multi_cycle_nop, next_stage_multi_cycle_nop = 0, 0  # Multi-cycle NOPs stall
    total_multi_cycle_nop = 0   # The number of multi-cycle nop
    overlap_cycle = 0   # Overlapping cycles with subsequent nodes

    # TODO: This two extra cycles is only a temporary handling of cases where pipeline emulation is currently not possible.
    #  optimize and delete it.
    sp_loop_extra_cycles = 0  # Extra cycles due to SPLoop.
    hazard_extra_cycles = 0  # Extra cycles due to use-after-load hazard.

    # TODO: Do a pass of all EPs. Find all EPs with load instructions but that without an over-4-cycle-multi-nop instruction following.
    all_eps = [ep for fp in fps for ep in fp.eps]
    hazard_ep_num = len([idx for idx in range(len(all_eps) - 1) if all_eps[idx].is_load_inst and (not all_eps[idx + 1].is_over_4_cycle_nop)])
    # and not all_eps[idx + 1].is_over_4_cycle_nop
    hazard_extra_cycles = 4 * hazard_ep_num
    if hazard_ep_num > 0:
        warnings.warn("{} EPs may lead to pipeline hazard in basic block {}.".format(hazard_ep_num, block_id))

    behavior_append(pipeline_tracer, (PipelineBehavior.DO_PIPELINE_SIMULATION_START, block_id))

    """
    SPLOOP related.
    if current basic block is SPLOOP body, then initialize an instance of SPLoopSimulator, and set sp_looping to True.
    """
    # TODO: Safety assumption: If the basic block contains a SPLOOP body,
    #  then the SPLOOP body starts from the first instruction of the block and ends at SPKERNEL.
    #  The SPLOOP body is not further split into blocks.

    sp_simulator: Optional[SPLoopSimulator]
    sp_looping: bool  # True if current block is a SPLOOP body and set to False until getting an SPKERNEL instruction.
    if is_sp_loop_body:
        behavior_append(pipeline_tracer, (PipelineBehavior.SPLOOP_BODY, ))
        sp_simulator = SPLoopSimulator(spl_type=sp_type, ii=ii, max_iter=max_iter)
        sp_looping = True
    else:
        sp_simulator = None
        sp_looping = False

    while True:

        if next_stage_penalty != 0:
            penalty_start, penalty_finish = current_cycle + 1, current_cycle + next_stage_penalty
            behavior_append(pipeline_tracer, (PipelineBehavior.NEW_STALLED_PIPELINE_CYCLES, penalty_start, penalty_finish))
            next_stage_penalty = 0  # penalty clear.
            current_cycle = penalty_finish
            continue

        current_cycle += 1
        cpu_cycle += 1
        behavior_append(pipeline_tracer, (PipelineBehavior.NEW_PIPELINE_CYCLE, current_cycle))

        """ ========================================================================================================================= """
        """ ========================================================================================================================= """
        # Do pipeline stage simulation here :)

        """ 
        --------------------------------------------------------------------------------------
        Execution_1 to Execution_10 is about to move to next stage or finish their executions.
        --------------------------------------------------------------------------------------
        """

        # Instruction execute at least one stage.
        for ei in reversed(range(10)):
            # ei is current stage. It will be moved to next stage, i.e. ei + 1.

            """ 
            Step 1: Move execute packet to next stage or just finish it. 
            """

            if ep_in_ei[ei] is None:
                ep_in_ei[ei + 1] = None
            elif ei + 1 == ep_in_ei[ei].execute_cycle:
                ep_in_ei[ei + 1] = None
                behavior_append(pipeline_tracer, (PipelineBehavior.EP_EXECUTE_FINISH, ep_in_ei[ei].ep_id, PipelineStage.Execute, ei + 1))
                # Execute stage counts from 0
            else:
                ep_in_ei[ei + 1] = ep_in_ei[ei]
                behavior_append(pipeline_tracer, (PipelineBehavior.EP_TO_NEXT_STAGE, ep_in_ei[ei].ep_id,
                                                  PipelineStage.Execute, ei + 1, PipelineStage.Execute, ei + 2))
                # Execute stage counts from 0

            """ 
            Step 2: After moving execute packet to next stage (ep_in_ei[ei + 1]), what will happen?
            """

            """ E3: Data access by Store may cause a program memory(data) stall. """
            # data_penalty <= 0 means memory stalls never happen.
            if data_cache_config.penalty > 0:
                if ei + 2 == 3 and ep_in_ei[ei + 1] is not None:  # Count from 0
                    ep_in_e3 = ep_in_ei[ei + 1]
                    # Check if current execute packet have a store instructions.
                    store_inst = [ep_in_e3[idx] for idx in range(len(ep_in_e3)) if ep_in_e3[idx].type == InstType.STORE]
                    load_inst = [ep_in_e3[idx] for idx in range(len(ep_in_e3)) if ep_in_e3[idx].type == InstType.LOAD]
                    # Store
                    for inst in store_inst:
                        if inst.addr not in hit_data_refer:
                            behavior_append(pipeline_tracer, (PipelineBehavior.DATA_CACHE_MISS_STALL, ep_in_e3.ep_id, inst.addr,
                                                            data_cache_config.penalty, current_cycle + 1, current_cycle + data_cache_config.penalty))
                            # Choose the longest stall.
                            next_stage_penalty = max(next_stage_penalty, data_cache_config.penalty)
                    # Load
                    for inst in load_inst:
                        if inst.addr not in hit_data_refer:
                            behavior_append(pipeline_tracer, (PipelineBehavior.DATA_CACHE_MISS_STALL, ep_in_e3.ep_id, inst.addr,
                                                            data_cache_config.penalty, current_cycle + 1, current_cycle + data_cache_config.penalty))
                            # Choose the longest stall.
                            next_stage_penalty = max(next_stage_penalty, data_cache_config.penalty)

                    """ SPLooping Handling """
                    if sp_looping:
                        sp_simulator.data_miss_happen(next_stage_penalty)

            """ End of simulation for stage E1 to E10 moving to next stage. """

        """ 
        ---------------------------------------------
        Execution_1 is about to get EP from DC stage. 
        ---------------------------------------------
        """

        ep_in_ei[0] = ep_in_dc
        if ep_in_ei[0] is not None:
            if ep_in_ei[0].execute_cycle == 0:
                """ If current EP only contains control instructions(e.g. SPLOOP, SPKERNEL, ect), then it executes finished. """
                behavior_append(pipeline_tracer, (PipelineBehavior.EP_EXECUTE_FINISH, ep_in_ei[0].ep_id, PipelineStage.Decode, PipelineStage.DC))
                ep_in_ei[0] = None
            else:
                behavior_append(pipeline_tracer, (PipelineBehavior.EP_TO_NEXT_STAGE, ep_in_ei[0].ep_id,
                                                  PipelineStage.Decode, PipelineStage.DC, PipelineStage.Execute, 1))

        """ 
        ------------------------------------------------------------------------
        Decode:DC is about to get next execute packet dispatched from Decode:DP. 
        ------------------------------------------------------------------------
        """

        # TODO: Multi-cycle NOP happens at DC stage.
        if multi_cycle_nop > 0:
            # A special execute packet with only one single-cycle NOP is generated.
            ep_in_dc = EP_WITH_SINGLE_NOP
        elif fp_in_dp is not None:
            ep_in_dc = fp_in_dp.dispatch()
            behavior_append(pipeline_tracer, (PipelineBehavior.DC_NEW_EP_DISPATCH, fp_in_dp.fp_id, ep_in_dc.ep_id))
            """ If all execute packets are dispatched, then this fetch packet is freed out and waiting next fetch packet. """
            # The free out will take effect immediately.
            # The next fetch packet will be fetched to stage DP later on.
            if fp_in_dp.is_all_dispatched():
                behavior_append(pipeline_tracer, (PipelineBehavior.FP_DISPATCH_FINISH, fp_in_dp.fp_id))
                fp_in_dp = None

            """ Check if multi-cycle NOPs stall happens. """

            inst_id, _, cycle = ep_in_dc.multi_cycle_nop
            if inst_id is not None:
                behavior_append(pipeline_tracer, (PipelineBehavior.MULTI_CYCLE_NOP_STALL, ep_in_dc.ep_id, inst_id, cycle))
                """ Assigning to next_stage_multi_cycle_nop instead of multi_cycle_nop first ensures that 
                stall will not take effect until the next cycle. """
                next_stage_multi_cycle_nop = cycle
                total_multi_cycle_nop += cycle

        else:
            ep_in_dc = None  # DP stage has no EP to dispatch.

        """
        If the program is currently in SPLOOP, then pass the necessary information to SPLoopSimulator. 
        Otherwise, check whether the current instruction is a SPLOOP-related instruction, and if so, throw an exception.
        """
        if ep_in_dc is not None:
            if sp_looping:
                sp_simulator.new_ep()
                """ Check if SPLOOP finished. """
                for inst_id in range(len(ep_in_dc)):
                    if ep_in_dc[inst_id].is_sp_loop_tail:
                        """ The inst-miss is checked before this. So this finishing can take effect immediately. """
                        sp_loop_extra_cycles = sp_simulator.finish()
                        sp_looping = False
                        behavior_append(pipeline_tracer, (PipelineBehavior.SPLOOP_FINISH, ep_in_dc.ep_id,
                                                          sp_simulator.dynlen, sp_simulator.ii, sp_simulator.max_iter, sp_loop_extra_cycles))
                        break
                else:
                    """ SOLoop not finished. """
                    pass
            else:
                for inst_id in range(len(ep_in_dc)):
                    if ep_in_dc[inst_id].type == InstType.SP_LOOP and not ep_in_dc[inst_id].is_sp_loop_head:
                        inst = ep_in_dc[inst_id]
                        raise RuntimeError("Unexpected instruction flow. An SPLoop-related instruction got without SPLooping. "
                                           "Instruction {} with address {} in EP {}.".format(inst.name, inst.addr, ep_in_dc.ep_id))

        """ 
        -----------------------------------------------------------------------------------------------------------------------
        If fetch packet is finish its dispatch (or is just available), then get next fetch packet, or a pipeline stall happens.
        This leads to advances of all DECODE stages.
        ----------------------------------------------------------------------------------------------------------------------- 
        """

        if multi_cycle_nop > 0:
            pass  # So it is! If multi-cycle NOPs stall happens, then nothing is to do.
        elif fp_in_dp is None:  # The free out (of fetch packet) takes effect here!
            " PR -> DP "
            fp_in_dp = FPDispatch(fp_in_pr.fp_id, fp_in_pr.eps) if fp_in_pr is not None else None
            if fp_in_pr is not None:
                behavior_append(pipeline_tracer, (PipelineBehavior.FP_TO_NEXT_STAGE, fp_in_pr.fp_id,
                                                  PipelineStage.Fetch, PipelineStage.PR, PipelineStage.Decode, PipelineStage.DP))

            " PW -> PR "
            fp_in_pr = fp_in_pw
            if fp_in_pw is not None:
                behavior_append(pipeline_tracer, (PipelineBehavior.FP_TO_NEXT_STAGE, fp_in_pw.fp_id,
                                                  PipelineStage.Fetch, PipelineStage.PW, PipelineStage.Fetch, PipelineStage.PR))

            " PS -> PW "
            fp_in_pw = fp_in_ps
            if fp_in_ps is not None:
                behavior_append(pipeline_tracer, (PipelineBehavior.FP_TO_NEXT_STAGE, fp_in_ps.fp_id,
                                                  PipelineStage.Fetch, PipelineStage.PS, PipelineStage.Fetch, PipelineStage.PW))

                """ A memory access happens in stage PW, so a program memory stall may happen. """
                # inst_penalty <= 0 means memory stalls never happen.
                if inst_cache_config.penalty > 0:
                    fp_id = fp_in_pw.fp_id
                    if fps_is_line_head[fp_id]:
                        block_to_fetch: MemoryBlock = fps_line_addr[fp_id]
                        if block_to_fetch not in hit_blocks:
                            behavior_append(pipeline_tracer, (PipelineBehavior.INST_CACHE_MISS_STALL, fp_id,
                                                              inst_cache_config.penalty, current_cycle + 1,
                                                              current_cycle + inst_cache_config.penalty))
                            # Choose the longest stall.
                            next_stage_penalty = max(next_stage_penalty, inst_cache_config.penalty)

            " PG -> PS "
            fp_in_ps = fp_in_pg
            if fp_in_pg is not None:
                behavior_append(pipeline_tracer, (PipelineBehavior.FP_TO_NEXT_STAGE, fp_in_pg.fp_id,
                                                  PipelineStage.Fetch, PipelineStage.PG, PipelineStage.Fetch, PipelineStage.PS))

            " PG get next fetch packet "
            if next_fp_idx == num_fp:
                fp_in_pg = None  # All fetch packets have been moved to pipeline.
            else:
                fp_in_pg = fps[next_fp_idx]
                behavior_append(pipeline_tracer, (PipelineBehavior.PG_NEW_FP_FETCH, fp_in_pg.fp_id))
                next_fp_idx += 1
                if next_fp_idx == num_fp:
                    behavior_append(pipeline_tracer, (PipelineBehavior.FP_FETCH_FINISH,))
        else:
            # If current fetch packet is the last one, then no pipeline stall happens.
            if fp_in_pr is not None:
                behavior_append(pipeline_tracer, (PipelineBehavior.PIPELINE_STALL, fp_in_dp.fp_id))

        """
        -------------------------------------------------------------------------------- 
        At end of stage, assign multi_cycle_nop_cycle or subtract multi_cycle_nop_cycle.
        --------------------------------------------------------------------------------
        """

        if next_stage_multi_cycle_nop > 0 and multi_cycle_nop > 0:
            raise RuntimeError("Assign to multi_cycle_nop and subtract from multi_cycle_nop is not allowed in one stage.")
        if next_stage_multi_cycle_nop > 0:
            multi_cycle_nop = next_stage_multi_cycle_nop
            next_stage_multi_cycle_nop = 0
        else:
            """ If no multi-cycle NOPs stall happens, then this statement do not cause any side-effect. """
            multi_cycle_nop = multi_cycle_nop - 1 if multi_cycle_nop > 0 else 0

        # Simulation of current stage is finished :)
        """ ========================================================================================================================= """
        """ ========================================================================================================================= """

        """ Print out pipeline status of the end of current stage. """

        if log and status_log:
            status_fetch_decode = tabulate.tabulate([["FP_{}".format(fp_in_pg.fp_id) if fp_in_pg is not None else ".",
                                                      "FP_{}".format(fp_in_ps.fp_id) if fp_in_ps is not None else ".",
                                                      "FP_{}".format(fp_in_pw.fp_id) if fp_in_pw is not None else ".",
                                                      "FP_{}".format(fp_in_pr.fp_id) if fp_in_pr is not None else ".",
                                                      "FP_{}".format(fp_in_dp.fp_id) if fp_in_dp is not None else ".",
                                                      "EP_{}".format(ep_in_dc.ep_id) if ep_in_dc is not None else "."]],
                                                    headers=["PG", "PS", "PW", "PR", "DP", "DC"],
                                                    tablefmt='psql')
            status_execute = tabulate.tabulate([["EP_{}".format(ep.ep_id) if ep is not None else "." for ep in ep_in_ei[: 10]]],
                                               headers=["E{}".format(i) for i in range(1, 11)],
                                               tablefmt='psql')

            behavior_append(pipeline_tracer, (PipelineBehavior.PIPELINE_STATUS, "\n".join([status_fetch_decode, status_execute])))

        """ Check if the execution of this block finishes. """

        fetch_free = fp_in_pg is None and fp_in_ps is None and fp_in_pw is None and fp_in_pr is None
        decode_free = fp_in_dp is None and ep_in_dc is None
        execute_free = all([o is None for o in ep_in_ei])
        if next_fp_idx == num_fp and fetch_free and decode_free and execute_free:
            break

    """ End of current block sim """
    current_cycle += sp_loop_extra_cycles  # Extra cycles due to SPLoop is added at the end of current block simulation.
    current_cycle += hazard_extra_cycles  # Extra cycles due to use-after-load hazard is added at the end of current block simulation.
    overlap_cycle = cpu_cycle -len(all_eps) - total_multi_cycle_nop
    behavior_append(pipeline_tracer, (PipelineBehavior.DO_PIPELINE_SIMULATION_FINISH, block_id))
    return current_cycle, overlap_cycle, pipeline_tracer
