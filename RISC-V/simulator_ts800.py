import warnings
from typing import Sequence, Tuple, Optional, List, Dict

from constants_ts800 import InstType, InstLookUpTable


# 设计要点（保留原作者注释，纠正过的部分用 [FIX] 标出）：
# - 不需要构造流水器件组，在 simulator 里直接创建变量描述处于 Ex 阶段的指令的行为
#   （完成执行、释放发射槽、E4 释放寄存器锁）
# - 不需要构造 IssinPipeline，在 simulator 里直接创建变量描述每条流水的 2 个指令槽
# - 不需要构造 Inst_buffer，描述 InstBuffer 对取到的指令管理，以及 dispatch 到 ISS 的操作
# - 不需要具体 Icache 实现，留 Cache 接口；默认每次命中以验证流水线主逻辑
# - 不需要 Itag/Idata 专门类，直接在 Address 类切分
# - 需要 ITLB 类，但默认每次命中
# - 不需要 PC 类，基本块内 PC 顺序自增即可
# - Instruction：原始汇编一行的承载；InstInPipeline：进入流水线后的包装
#
# [FIX] 原代码 .lenth → len()
# [FIX] 原代码访问 __execute_cycle / __type 私有属性，已改为公开属性
# [FIX] 原代码 ex_X_insts[i] 应为 ex_X_insts[stage][i]
# [FIX] 原代码 inst.id → inst.inst_id
# [FIX] 原代码 inst_cache.hit(...)/getblock(...) 未定义 → 这里实现接口
# [FIX] 原代码 pc_Reg += 8 → RISC-V 单条指令 4 字节
# [FIX] 原代码 cpu_cycle 未初始化
# [FIX] 原代码 inst_physical_add 在赋值前被使用，已调换 A/B/C 顺序
# [FIX] 原代码 iss_buffer/inst_buffer 在同一循环中混用，已拆开
# [FIX] 原代码 ex_X_insts[j+1] = ex_X_insts[j] 引用共享，已用 list() 复制
# [FIX] 原代码 dict[{'I','F','V'}, List[int]] 非法 → Dict[str, List[int]]


# ====================================================================
# 数据结构
# ====================================================================

class Instruction:
    """ 该类完成对汇编代码的读入，所有汇编代码以条为单位存储记录在该结构体里。
    属性：name 对应 opcode；addr 指令地址；opcode 原始编码；operands 操作数文本列表。
    """
    def __init__(self, name: str, addr: int = 0, opcode: str = '',
                 operands: Optional[List[str]] = None) -> None:
        self.name: str = name.upper()
        self.addr: int = addr
        self.opcode: str = opcode
        self.operands: List[str] = list(operands) if operands else []


class InstInPipeline:
    """ 流水线内部传递的指令包装：查表得到类型与执行周期，同时记录寄存器使用信息。

    属性：
        backend_inst   — 原始 Instruction
        type           — InstType
        execute_cycle  — 执行段需要的周期数
        inst_id        — 全局递增编号，用于寄存器锁判定
        src1/src2      — 源寄存器编号（None 表示无）
        type1/type2    — 源寄存器组 'I'/'F'/'V' 或 'imm'
        dstReg         — 目的寄存器编号（None 表示无）
        typed          — 目的寄存器组 'I'/'F'/'V'
    """

    _next_id: int = 0

    def __init__(self, f_inst: Instruction):
        self.backend_inst: Instruction = f_inst

        # 全局递增的 inst_id，作为顺序发射的"年龄"
        InstInPipeline._next_id += 1
        self.inst_id: int = InstInPipeline._next_id

        # 查表得到类型与执行周期
        matched_type, matched_cycle = InstType.UNKNOWN, InstLookUpTable.cycle[InstType.UNKNOWN]
        for t, inst_set in InstLookUpTable.inst.items():
            if f_inst.name in inst_set:
                matched_type = t
                matched_cycle = InstLookUpTable.cycle[t]
                break
        self.type: InstType = matched_type
        self.execute_cycle: int = matched_cycle

        if self.type == InstType.UNHANDLED:
            raise RuntimeError(
                "Instruction {} in memory address {} is unhandled. "
                "This is because it involves interrupts, exceptions, pipeline blocking, or other behaviors "
                "that cannot be handled by WCET sim.".format(f_inst.name, f_inst.addr)
            )

        if f_inst.name in InstLookUpTable.SPUnhandled:
            raise RuntimeError(
                "SPLOOP related instruction {} in memory address {} is unhandled. "
                "This may because it involves nested SPLOOPs".format(f_inst.name, f_inst.addr)
            )

        # 操作数 / 寄存器信息：由上层指令解析填充；默认空表示"无相关"
        self.src1: Optional[int] = None
        self.src2: Optional[int] = None
        self.type1: str = 'imm'
        self.type2: str = 'imm'
        self.dstReg: Optional[int] = None
        self.typed: str = 'I'


class Address:
    """ 用于检验 cache 是否命中的地址形式，分为 tag 和 data 两部分（32 位高位补零）。
    具体右移多少位本应取决于 cache 配置，先用固定切分，后续可接入 CacheConfig。
    """
    def __init__(self, the_address: int) -> None:
        self._tag = the_address >> 8
        self._data = the_address & 0x000000FF

    @property
    def tag(self) -> int:
        return self._tag

    @property
    def data(self) -> int:
        return self._data

    # 兼容原代码使用的属性名
    @property
    def i_tag(self) -> int:
        return self._tag

    @property
    def i_data(self) -> int:
        return self._data


class CacheConfig:
    """ 需要 penalty 和 group_cnt；其余（容量、替换、相联方式等）暂不考虑。 """
    def __init__(self, the_penalty: int, group_cnt: int = 1) -> None:
        self._penalty = the_penalty
        self._group_cnt = group_cnt

    @property
    def penalty(self) -> int:
        return self._penalty

    @property
    def group_cnt(self) -> int:
        return self._group_cnt


class CacheLine:
    def __init__(self) -> None:
        self.data: List[Optional['InstInPipeline']] = []


class CacheGroup:
    def __init__(self, config: CacheConfig) -> None:
        self.config = config
        self.lines: List[CacheLine] = []


class Cache:
    """ 缓存模型骨架：当前只关心 penalty 与命中查询。
    简化为 cold-miss + warm-hit 模型：首次访问某 tag 触发 miss → penalty；
    之后访问同一 tag 命中。后续可扩展为真实的容量 / 替换策略。
    """
    def __init__(self, config: CacheConfig) -> None:
        self.config = config
        self._cacheData: List[CacheGroup] = [CacheGroup(config) for _ in range(config.group_cnt)]
        self._seen_tags: set = set()

    def is_hit(self, addr: Optional[Address] = None) -> bool:
        if addr is None:
            return True
        tag = addr.tag
        if tag in self._seen_tags:
            return True
        self._seen_tags.add(tag)
        return False

    # 兼容原代码使用的 hit/getblock 接口
    def hit(self, *_args, **_kwargs) -> bool:
        return self.is_hit()

    def getblock(self, *_args, **_kwargs) -> List[Optional[InstInPipeline]]:
        return []


class Memory:
    def __init__(self, insts: Sequence[InstInPipeline]) -> None:
        self._data: List[InstInPipeline] = list(insts)

    @property
    def data(self) -> List[InstInPipeline]:
        return self._data

    def getblock(self, _addr: Optional[Address] = None) -> List[Optional[InstInPipeline]]:
        return []


class Tlb:
    def __init__(self) -> None:
        pass

    def getAddr(self, pc: int) -> Address:
        # 默认快表恒命中：直接把 PC 当作物理地址
        return Address(pc)


# ====================================================================
# 主流水线模拟
# ====================================================================

def do_pipeline_simulation_in_block(
    block_id,
    insts: Sequence[InstInPipeline],
    inst_cache_config: CacheConfig,
    data_cache_config: CacheConfig,
) -> Tuple[int, ...]:
    """ 对单个基本块做流水线模拟。基本块内不存在分支指令。
    返回 (current_cycle,)。
    """

    if inst_cache_config.penalty <= 0:
        warnings.warn("No instruction miss stall occurs during pipeline simulation because inst_penalty <= 0.")
    if data_cache_config.penalty <= 0:
        warnings.warn("No data miss stall occurs during pipeline simulation because data_penalty <= 0.")

    # === 流水线器件 ===
    pc_Reg: int = 0
    inst_now_id: int = 0

    inst_cache: Cache = Cache(inst_cache_config)
    data_cache: Cache = Cache(data_cache_config)
    mem: Memory = Memory(insts)
    Itlb: Tlb = Tlb()

    # 执行段：4 个阶段（E1..E4），各阶段的槽位数代表对应流水线宽度
    # ts800：I 流水线 ×2、M ×1、F ×2、V ×1
    EX_STAGES = 4
    I_WIDTH, M_WIDTH, F_WIDTH, V_WIDTH = 2, 1, 2, 1

    ex_I_insts: List[List[Optional[InstInPipeline]]] = [[None] * I_WIDTH for _ in range(EX_STAGES)]
    ex_M_insts: List[List[Optional[InstInPipeline]]] = [[None] * M_WIDTH for _ in range(EX_STAGES)]
    ex_F_insts: List[List[Optional[InstInPipeline]]] = [[None] * F_WIDTH for _ in range(EX_STAGES)]
    ex_V_insts: List[List[Optional[InstInPipeline]]] = [[None] * V_WIDTH for _ in range(EX_STAGES)]

    # ISS（发射）阶段：每条流水线各 2 个槽
    iss_I_insts: List[Optional[InstInPipeline]] = [None] * 2
    iss_M_insts: List[Optional[InstInPipeline]] = [None] * 2
    iss_F_insts: List[Optional[InstInPipeline]] = [None] * 2
    iss_V_insts: List[Optional[InstInPipeline]] = [None] * 2

    # iss_buffer：发射队列前的二级暂存；inst_buffer：取指阶段的缓冲
    ISS_BUFFER_LEN = 13
    INST_BUFFER_LEN = 13
    iss_buffer: List[Optional[InstInPipeline]] = [None] * ISS_BUFFER_LEN
    inst_buffer: List[Optional[InstInPipeline]] = [None] * INST_BUFFER_LEN

    # 寄存器锁：值为占用该寄存器作为写目标的指令 inst_id；-1 表示空闲
    REG_COUNT = 64
    reg_status_is_free: Dict[str, List[int]] = {
        'I': [-1] * REG_COUNT,
        'F': [-1] * REG_COUNT,
        'V': [-1] * REG_COUNT,
    }

    # 发射槽 / 执行单元空闲状态
    iss_I_status_is_free: List[bool] = [True] * len(iss_I_insts)
    iss_M_status_is_free: List[bool] = [True] * len(iss_M_insts)
    iss_F_status_is_free: List[bool] = [True] * len(iss_F_insts)
    iss_V_status_is_free: List[bool] = [True] * len(iss_V_insts)

    func_I_status_is_free: List[bool] = [True] * I_WIDTH
    func_M_status_is_free: List[bool] = [True] * M_WIDTH
    func_F_status_is_free: List[bool] = [True] * F_WIDTH
    func_V_status_is_free: List[bool] = [True] * V_WIDTH

    # 周期计数与 stall 惩罚
    current_cycle: int = 0  # 总周期数（含 stall）
    cpu_cycle: int = 0      # 不含 stall 的指令推进周期数（辅助统计）
    next_stage_penalty: int = 0
    inst_physical_add: Optional[Address] = None

    # --- 局部辅助函数（用 closure 访问 reg_status_is_free 等局部状态） ---

    def _no_data_hazard(inst: InstInPipeline) -> bool:
        """ 真冲突（RAW）判定：源寄存器锁中若有比自己更早的指令则真相关。 """
        for src, src_type in ((inst.src1, inst.type1), (inst.src2, inst.type2)):
            if src is None or src_type == 'imm':
                continue
            owner = reg_status_is_free[src_type][src]
            if owner != -1 and owner != inst.inst_id:
                return False
        return True

    def _try_issue(iss_slots, iss_free_flags, ex_e1, func_free_flags) -> None:
        """ 把发射队列里的指令试着推到 E1 阶段。 """
        for idx in range(len(iss_slots)):
            inst = iss_slots[idx]
            if inst is None or not _no_data_hazard(inst):
                continue
            for k in range(len(func_free_flags)):
                if func_free_flags[k]:
                    ex_e1[k] = inst
                    if inst.dstReg is not None:
                        reg_status_is_free[inst.typed][inst.dstReg] = inst.inst_id
                    iss_slots[idx] = None
                    iss_free_flags[idx] = True
                    func_free_flags[k] = False
                    break

    def _try_dispatch_to_iss(inst: InstInPipeline) -> bool:
        """ 按指令类型尝试塞入对应 iss 队列；成功返回 True。
        进入 I 流水线的不只是 integer：还有 jump、branch、mul、div。
        """
        if inst.type in (InstType.INTEGER, InstType.JUMP, InstType.BRANCH,
                         InstType.MULTIPLY, InstType.DIVISION):
            target_iss, target_free = iss_I_insts, iss_I_status_is_free
        elif inst.type == InstType.MEMORY:
            target_iss, target_free = iss_M_insts, iss_M_status_is_free
        elif inst.type in (InstType.SINGLE_FLOAT, InstType.DOUBLE_FLOAT):
            target_iss, target_free = iss_F_insts, iss_F_status_is_free
        elif inst.type == InstType.VECTOR:
            target_iss, target_free = iss_V_insts, iss_V_status_is_free
        else:
            return False
        for k in range(len(target_iss)):
            if target_free[k]:
                target_iss[k] = inst
                target_free[k] = False
                return True
        return False

    def _retire_stage_e4(stage_insts, func_free_flags) -> None:
        """ E4 完成：释放执行单元，释放本指令占用的寄存器锁。 """
        for idx in range(len(stage_insts)):
            inst = stage_insts[idx]
            if inst is None:
                continue
            func_free_flags[idx] = True
            if inst.dstReg is not None and reg_status_is_free[inst.typed][inst.dstReg] == inst.inst_id:
                reg_status_is_free[inst.typed][inst.dstReg] = -1
            stage_insts[idx] = None

    # ====================================================================
    # 流水线每个 cycle
    # ====================================================================
    while True:

        # --- 全局 stall：上一周期触发了 cache miss / dispatch 满等惩罚 ---
        if next_stage_penalty != 0:
            current_cycle += next_stage_penalty   # 含 stall 总周期 ++
            # cpu_cycle 不含 stall，故此处不变
            next_stage_penalty = 0
            continue

        current_cycle += 1
        cpu_cycle += 1

        # ----------------------------------------------------------------
        # 1) E4 完成段：释放执行单元和寄存器锁
        # ----------------------------------------------------------------
        _retire_stage_e4(ex_I_insts[3], func_I_status_is_free)
        _retire_stage_e4(ex_M_insts[3], func_M_status_is_free)
        _retire_stage_e4(ex_F_insts[3], func_F_status_is_free)
        _retire_stage_e4(ex_V_insts[3], func_V_status_is_free)

        # ----------------------------------------------------------------
        # 2) E3→E4, E2→E3, E1→E2 推进
        #    反向遍历避免覆盖未读阶段；用 list() 复制避免引用共享
        # ----------------------------------------------------------------
        for j in reversed(range(3)):  # j = 2, 1, 0
            # LSU 在 E2（j==1，即将进入 E3）做 dcache 命中判断。
            # 注意：当前模拟器还没接入访存地址解算，先以指令所在地址作为 tag 的
            # 代用值；指令解析层补全后再换成真正的 load/store target address。
            if j == 1:
                for i in range(len(ex_M_insts[j])):
                    ls_inst = ex_M_insts[j][i]
                    if ls_inst is not None:
                        proxy_addr = Address(ls_inst.backend_inst.addr)
                        if not data_cache.is_hit(proxy_addr):
                            next_stage_penalty = max(next_stage_penalty, data_cache_config.penalty)
            ex_I_insts[j + 1] = list(ex_I_insts[j])
            ex_M_insts[j + 1] = list(ex_M_insts[j])
            ex_F_insts[j + 1] = list(ex_F_insts[j])
            ex_V_insts[j + 1] = list(ex_V_insts[j])
        # 腾空 E1，等待 ISS 发射
        ex_I_insts[0] = [None] * I_WIDTH
        ex_M_insts[0] = [None] * M_WIDTH
        ex_F_insts[0] = [None] * F_WIDTH
        ex_V_insts[0] = [None] * V_WIDTH

        # ----------------------------------------------------------------
        # 3) ISS：检查数据相关，无相关则发射到 E1
        # ----------------------------------------------------------------
        _try_issue(iss_I_insts, iss_I_status_is_free, ex_I_insts[0], func_I_status_is_free)
        _try_issue(iss_M_insts, iss_M_status_is_free, ex_M_insts[0], func_M_status_is_free)
        _try_issue(iss_F_insts, iss_F_status_is_free, ex_F_insts[0], func_F_status_is_free)
        _try_issue(iss_V_insts, iss_V_status_is_free, ex_V_insts[0], func_V_status_is_free)

        # ----------------------------------------------------------------
        # 4) Dispatch：iss_buffer → iss 队列；inst_buffer → iss 队列（满则进 iss_buffer）
        # ----------------------------------------------------------------
        for i in range(ISS_BUFFER_LEN):
            item = iss_buffer[i]
            if item is not None and _try_dispatch_to_iss(item):
                iss_buffer[i] = None

        for i in range(INST_BUFFER_LEN):
            inst = inst_buffer[i]
            if inst is None:
                continue
            if _try_dispatch_to_iss(inst):
                inst_buffer[i] = None
                continue
            # iss 满，塞进 iss_buffer
            placed = False
            for k in range(ISS_BUFFER_LEN):
                if iss_buffer[k] is None:
                    iss_buffer[k] = inst
                    inst_buffer[i] = None
                    placed = True
                    break
            if not placed:
                # iss_buffer 也满了：触发一次 stall
                next_stage_penalty = max(next_stage_penalty, 1)

        # ----------------------------------------------------------------
        # 5) Fetch：A→B→C
        #    A: PC 选择（基本块内顺序，无分支）
        #    B: TLB 查物理地址（默认恒命中）
        #    C: Icache 查命中；未命中产生 penalty
        # ----------------------------------------------------------------
        if inst_now_id < len(insts):
            # B: TLB
            inst_physical_add = Itlb.getAddr(pc_Reg)
            # C: Icache
            if inst_cache_config.penalty > 0 and not inst_cache.is_hit(inst_physical_add):
                next_stage_penalty = max(next_stage_penalty, inst_cache_config.penalty)
            # 顺序放入 inst_buffer 第一个空位
            for k in range(INST_BUFFER_LEN):
                if inst_buffer[k] is None and inst_now_id < len(insts):
                    inst_buffer[k] = insts[inst_now_id]
                    inst_now_id += 1
                    # A: PC 顺序自增 — RISC-V 标准指令 4 字节
                    pc_Reg += 4
                    break

        # ----------------------------------------------------------------
        # 6) 结束判定：所有指令取完且各级流水都空
        # ----------------------------------------------------------------
        decode_free = (all(o is None for o in inst_buffer)
                       and all(o is None for o in iss_buffer))
        iss_free = (all(o is None for o in iss_I_insts)
                    and all(o is None for o in iss_M_insts)
                    and all(o is None for o in iss_F_insts)
                    and all(o is None for o in iss_V_insts))
        execute_free = (all(o is None for x in ex_I_insts for o in x)
                        and all(o is None for x in ex_M_insts for o in x)
                        and all(o is None for x in ex_F_insts for o in x)
                        and all(o is None for x in ex_V_insts for o in x))
        if inst_now_id == len(insts) and decode_free and iss_free and execute_free:
            break

        # 保险：极端配置下流水线可能停滞，避免死循环
        if current_cycle > max(10000, len(insts) * 50):
            warnings.warn("Pipeline simulation aborted: cycle budget exceeded.")
            break

    # End of current block sim
    return (current_cycle,)