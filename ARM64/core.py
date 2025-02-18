import os
import shutil
from typing import Set, Union, Dict, List, Optional, Hashable
from src.util import TestbenchConfig, Logger
from src.read_asm import AsmFileReader
from src.read_segment import SegmentReader
from src.cfg import *
from src.find_addr import Addr_Finder
from src.cache.cache_config import CacheConfig, MultiLevelCacheConfig
from src.cache.constants import *
from src.analyser import CacheAnalyser
from src.cache.memory_ref import Reference

def end2end_run(config: TestbenchConfig, logger: Logger):
    logger.log("Starting hw cache analysis v2.", verbose=1, color='blue')
    logger.log2C("Received benchamrk: ", f"{config.benchmark_name}", verbose=1, color='green', color2='red')
    logger.log2C(f"User define skip: ", f"{config.skip_user_plt}", verbose=1, color='green', color2='red')
    logger.log2C(f"Generate Procedure CFG: ", f"{config.gen_procedure_cfg}", verbose=1, color='green', color2='red')
    benchmark_name = config.benchmark_name
    output_path = os.path.join('output', benchmark_name)

    if os.path.exists(output_path):
        pass
    else:
        os.mkdir(output_path)

    logger.log("Read asm file and build instructions...", verbose=1, color='blue')
    reader = AsmFileReader(config.asm_path)
    seg_reader = SegmentReader(config.asm_d_path)

    if config.skip_user_plt:
        logger.log("Use user-defined @plt procedure.", verbose=1, color='red')
        proc_network = ProcedureNetwork(reader, skip_as_plt=config.user_plt)
    else:
        logger.log("Do not use user-defined @plt procedure.", verbose=1, color='red')
        proc_network = ProcedureNetwork(reader, skip_as_plt=[])

    logger.log("Build CFG...", verbose=1, color='blue')
    cfg = InnerProcCFG(proc_network)
    procedures = proc_network.procedures

    if config.gen_procedure_cfg:
        logger.log("Generate Procedure CFG...", verbose=1, color='red')
        if "all" in config.procedure_cfg:
            for i in procedures:
                g = i.draw_inner_cfg()
                g.render(filename=i.name, directory=output_path, format='svg')
        else:
            for i in procedures:
                if i.name in config.gen_procedure_cfg:
                    g = i.draw_inner_cfg()
                    g.render(filename=i.name, directory=output_path, format='svg')
    else:
        logger.log("Skip Procedure CFG.", verbose=1, color='red')

    related_procs = cfg.procs_sort()  # 拓扑排序找到 Relate_Procs
    sorted_loops = cfg.topological_sort()  # 拓扑排序 Loop

    irregular_loops = set()
    for loop in sorted_loops:
        if loop.name is None:
            irregular_loops.add(loop)
    sorted_loops = sorted_loops - irregular_loops

    # =========================================== Cache Config Init ===============================================================

    logger.log("Cache Config Init.", verbose=1, color='blue')
    # inst_cache_config = CacheConfig(CacheHierarchy.L1I, capacity_size=65536, associativity=1, line_size=64)
    # data_cache_config = CacheConfig(CacheHierarchy.L1D, capacity_size=65536, associativity=2, line_size=64)
    # unified_cache_config = CacheConfig(CacheHierarchy.L2, capacity_size=524288, associativity=4, line_size=64)

    inst_cache_config = CacheConfig(CacheHierarchy.L1I, capacity_size=2048, associativity=1, line_size=64)
    data_cache_config = CacheConfig(CacheHierarchy.L1D, capacity_size=2048, associativity=2, line_size=64)
    unified_cache_config = CacheConfig(CacheHierarchy.L2, capacity_size=16384, associativity=4, line_size=64)

    multilevel_cache_config = MultiLevelCacheConfig({CacheHierarchy.L1I: inst_cache_config,
                                                     CacheHierarchy.L1D: data_cache_config,
                                                     CacheHierarchy.L2: unified_cache_config})

    # ================================================== Cache Refs ================================================================
    logger.log("Find addr.", verbose=1, color='blue')
    addr_finder = Addr_Finder(proc_network, seg_reader, output_path)

    logger.log("Collecting Cache Refs Information.", verbose=1, color='blue')

    proc_inst_ref = dict()
    proc_data_ref = dict()

    for proc_cfg in related_procs:  # 以每个proc为一个CFG进行抽象解释及分析。

        inst_ref = dict()
        data_ref = dict()

        for node in proc_cfg.nodes:
            " 虚拟节点 "
            if isinstance(node, InterProcNode):
                inst_ref[node.name] = None
                data_ref[node.name] = None
            " 其他节点 "
            for inst in node.instructions:
                if inst_ref.get(node.name, None) is None:
                    inst_ref[node.name] = dict()
                ref = Reference(inst.addr.val() >> 6, RefType.INST, multilevel_cache_config)
                inst_ref[node.name][inst] = ref

            for ins, ref_addr_val_set in node.data_reference.items():
                if data_ref.get(node.name, None) is None:
                    data_ref[node.name] = dict()
                data_ref[node.name][ins] = set()
                for ref_addr_val in ref_addr_val_set:
                    ref = Reference(ref_addr_val, RefType.DATA, multilevel_cache_config)
                    data_ref[node.name][ins].add(ref)

        proc_inst_ref[proc_cfg] = inst_ref
        proc_data_ref[proc_cfg] = data_ref

    # ================================================= Abstract Interpretation =========================================================

    logger.log("Analysis Cache Behavior", verbose=1, color='blue')
    cache_analyser = CacheAnalyser(cfg, multilevel_cache_config, proc_inst_ref, proc_data_ref, related_procs,
                                   sorted_loops)
    cache_analyser.do_analysis()
    cache_analyser.persistent_analysis()
    # ==================================================== Categorize+Statistical ==================================================================

    cache_analyser.Categorize()
    # cache_analyser.Statistical(config.target_range, config.execution_intervals)
    analysis_output_path = os.path.join(output_path, 'cache-analysis')
    cache_analyser.output_chmc(analysis_output_path)
    logger.log("Finished.", verbose=1, color='green')

    # ============================================================  =====================================================================



