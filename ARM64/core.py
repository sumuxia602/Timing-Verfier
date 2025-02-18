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
    # ======================================================== Debug Config =====================================================
 
    debug_path = os.path.join('debug', benchmark_name)
    
    # 如果debug_path已存在，先删除
    if os.path.exists(debug_path):
        shutil.rmtree(debug_path)
        
    # 创建debug_path目录
    os.makedirs(debug_path, exist_ok=True)
    
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

    node_name2obj = {}
    ins_name2obj = {}
    for proc in procedures:
        for node in proc.nodes:
            node_name2obj[node.name] = node
            for ins in node.instructions:
                ins_name2obj[ins.addr.val()] = ins

    related_procs = cfg.find_related_procs()  # 拓扑排序找到 Relate_Procs
    related_loops = cfg.find_related_loops()  # 拓扑排序 Loop

    irregular_loops = set()
    for loop in related_loops:
        if loop.name is None:
            irregular_loops.add(loop)
    regular_loops = related_loops - irregular_loops

    # ================================================ L3 Cache Config Init ===============================================================

    logger.log("Cache Config Init.", verbose=1, color='blue')

    # inst_cache_config = CacheConfig(CacheHierarchy.L1I, capacity_size=65536, associativity=1, line_size=64)  # 64KB
    # data_cache_config = CacheConfig(CacheHierarchy.L1D, capacity_size=65536, associativity=2, line_size=64)  # 64KB
    # unified_cache_config = CacheConfig(CacheHierarchy.L2, capacity_size=524288, associativity=4, line_size=64)  # 512KB
    # LL_cache_config = CacheConfig(CacheHierarchy.L3, capacity_size=67108864, associativity=16, line_size=64)  # 64M
    # multilevel_cache_config = MultiLevelCacheConfig({CacheHierarchy.L1I: inst_cache_config,
    #                                                  CacheHierarchy.L1D: data_cache_config,
    #                                                  CacheHierarchy.L2: unified_cache_config,
    #                                                  CacheHierarchy.L3: LL_cache_config
    #                                                  })

    # ================================================ L2 Cache Config Init ===============================================================
    inst_cache_config = CacheConfig(CacheHierarchy.L1I, capacity_size=65536, associativity=1, line_size=64)  # 64KB
    data_cache_config = CacheConfig(CacheHierarchy.L1D, capacity_size=65536, associativity=2, line_size=64)  # 64KB
    unified_cache_config = CacheConfig(CacheHierarchy.L2, capacity_size=524288, associativity=4, line_size=64)  # 512KB
    multilevel_cache_config = MultiLevelCacheConfig({CacheHierarchy.L1I: inst_cache_config,
                                                     CacheHierarchy.L1D: data_cache_config,
                                                     CacheHierarchy.L2: unified_cache_config
                                                     })

    # ======================================================= Cache Refs ====================================================================
    logger.log("Find addr.", verbose=1, color='blue')
    addr_finder = Addr_Finder(proc_network, seg_reader, output_path, node_name2obj, ins_name2obj)

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
                                   regular_loops, debug_path, debug=True)
    cache_analyser.do_analysis()
    cache_analyser.persistent_analysis()

    # ==================================================== Categorize ==================================================================

    cache_analyser.Categorize()

    # ===================================================== Statistical ================================================================

    analysis_output_path = os.path.join(output_path, 'cache-analysis')
    cache_analyser.output_chmc(analysis_output_path)
    if config.target_range is not None and config.execution_intervals is not None:
        cache_analyser.Statistical(config.target_range, config.execution_intervals, analysis_output_path)
    logger.log("Finished.", verbose=1, color='green')

