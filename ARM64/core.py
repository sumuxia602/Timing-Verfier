# =============================================== 模块导入 ===============================================
import os
import shutil
from typing import Set, Union, Dict, List, Optional, Hashable
from src.util import TestbenchConfig, Logger       # 自定义工具模块
from src.read_asm import AsmFileReader            # 汇编文件读取器
from src.read_segment import SegmentReader        # 段信息读取器
from src.cfg import *                             # 控制流图相关类
from src.find_addr import Addr_Finder             # 地址查找器
from src.cache.cache_config import CacheConfig, MultiLevelCacheConfig  # 缓存配置类
from src.cache.constants import *                # 缓存相关常量
from src.analyser import CacheAnalyser           # 缓存分析器
from src.cache.memory_ref import Reference       # 内存引用类

# ============================================ 端到端运行函数 =============================================
def end2end_run(config: TestbenchConfig, logger: Logger):
    """
    端到端缓存分析主函数
    
    参数:
        config: 测试基准配置对象，包含所有运行时参数
        logger: 日志记录器，用于输出运行信息
    """
    # --------------------------------------- 初始化阶段 ---------------------------------------
    logger.log("Starting hw cache analysis v2.", verbose=1, color='blue')
    logger.log2C("Received benchamrk: ", f"{config.benchmark_name}", verbose=1, color='green', color2='red')
    
    # 创建输出目录
    benchmark_name = config.benchmark_name
    output_path = os.path.join('output', benchmark_name)
    os.makedirs(output_path, exist_ok=True)  # 自动处理目录存在性

    # --------------------------------------- 调试配置 ---------------------------------------
    debug_path = os.path.join('debug', benchmark_name)
    if os.path.exists(debug_path):
        shutil.rmtree(debug_path)  # 清空旧调试目录
    os.makedirs(debug_path, exist_ok=True)

    # ------------------------------------ 汇编文件处理阶段 ------------------------------------
    logger.log("Read asm file and build instructions...", verbose=1, color='blue')
    reader = AsmFileReader(config.asm_path)        # 汇编文件读取器
    seg_reader = SegmentReader(config.asm_d_path)  # 段信息读取器

    # 过程网络构建（控制流分析）
    if config.skip_user_plt:
        logger.log("Use user-defined @plt procedure.", verbose=1, color='red')
        proc_network = ProcedureNetwork(reader, skip_as_plt=config.user_plt)
    else:
        logger.log("Do not use user-defined @plt procedure.", verbose=1, color='red')
        proc_network = ProcedureNetwork(reader, skip_as_plt=[])

    # ------------------------------------ CFG构建阶段 ------------------------------------
    logger.log("Build CFG...", verbose=1, color='blue')
    cfg = InnerProcCFG(proc_network)  # 内部过程控制流图
    procedures = proc_network.procedures  # 获取所有过程对象

    # 生成过程CFG图（可选）
    if config.gen_procedure_cfg:
        logger.log("Generate Procedure CFG...", verbose=1, color='red')
        # 根据配置生成指定或全部过程的CFG图
        target_procs = procedures if "all" in config.procedure_cfg else \
            [p for p in procedures if p.name in config.gen_procedure_cfg]
        for proc in target_procs:
            g = proc.draw_inner_cfg()
            g.render(filename=proc.name, directory=output_path, format='svg')

    # -------------------------------- 缓存配置初始化阶段 --------------------------------
    logger.log("Cache Config Init.", verbose=1, color='blue')
    
    # L1指令缓存配置：64KB，直接映射
    inst_cache_config = CacheConfig(CacheHierarchy.L1I, 
                                   capacity_size=65536, 
                                   associativity=1, 
                                   line_size=64)
    
    # L1数据缓存配置：64KB，2路组相联
    data_cache_config = CacheConfig(CacheHierarchy.L1D,
                                   capacity_size=65536,
                                   associativity=2,
                                   line_size=64)
    
    # L2统一缓存配置：512KB，4路组相联
    unified_cache_config = CacheConfig(CacheHierarchy.L2,
                                      capacity_size=524288,
                                      associativity=4,
                                      line_size=64)
    
    # 构建多级缓存配置（当前使用L1+L2配置）
    multilevel_cache_config = MultiLevelCacheConfig({
        CacheHierarchy.L1I: inst_cache_config,
        CacheHierarchy.L1D: data_cache_config,
        CacheHierarchy.L2: unified_cache_config
    })

    # --------------------------------- 地址查找与引用收集阶段 --------------------------------
    logger.log("Find addr.", verbose=1, color='blue')
    addr_finder = Addr_Finder(proc_network, seg_reader, output_path, node_name2obj, ins_name2obj)
    
    # 收集每个过程的指令和数据引用
    proc_inst_ref = dict()  # 结构：{过程: {节点: {指令: 引用对象}}}
    proc_data_ref = dict()  # 结构：{过程: {节点: {指令: 引用对象集合}}}
    
    for proc_cfg in related_procs:  # 遍历拓扑排序后的相关过程
        # 初始化当前过程的引用存储
        inst_ref = {}
        data_ref = {}
        
        for node in proc_cfg.nodes:
            # 处理跨过程节点
            if isinstance(node, InterProcNode):
                inst_ref[node.name] = None
                data_ref[node.name] = None
                continue
                
            # 收集指令引用（按缓存行地址）
            for inst in node.instructions:
                cache_line = inst.addr.val() >> 6  # 64字节对齐
                ref = Reference(cache_line, RefType.INST, multilevel_cache_config)
                inst_ref.setdefault(node.name, {})[inst] = ref
                
            # 收集数据引用
            for ins, ref_addrs in node.data_reference.items():
                for addr in ref_addrs:
                    ref = Reference(addr, RefType.DATA, multilevel_cache_config)
                    data_ref.setdefault(node.name, {}).setdefault(ins, set()).add(ref)

        # 存储当前过程的引用信息
        proc_inst_ref[proc_cfg] = inst_ref
        proc_data_ref[proc_cfg] = data_ref

    # --------------------------------- 缓存行为分析阶段 ---------------------------------
    logger.log("Analysis Cache Behavior", verbose=1, color='blue')
    cache_analyser = CacheAnalyser(
        cfg, 
        multilevel_cache_config,
        proc_inst_ref,
        proc_data_ref,
        related_procs,
        regular_loops,
        debug_path,
        debug=True
    )
    
    # 执行核心分析流程
    cache_analyser.do_analysis()          # 基础缓存分析
    cache_analyser.persistent_analysis()  # 持久性分析
    cache_analyser.Categorize()           # 结果分类

    # --------------------------------- 结果输出阶段 ---------------------------------
    analysis_output_path = os.path.join(output_path, 'cache-analysis')
    cache_analyser.output_chmc(analysis_output_path)  # 输出CHMC分析结果
    
    # 执行统计输出（如果配置了目标范围和执行间隔）
    if config.target_range and config.execution_intervals:
        cache_analyser.Statistical(
            config.target_range,
            config.execution_intervals,
            analysis_output_path
        )
    
    logger.log("Finished.", verbose=1, color='green') 
