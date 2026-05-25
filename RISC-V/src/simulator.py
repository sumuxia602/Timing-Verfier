from src.isa import RISC_V_Instruction
from src.cache.cache_config import CacheConfig, MultiLevelCacheConfig
from src.cache.constants import CacheHierarchy, CHMC
from typing import List, Dict, Any
import sys
#2025.6.18 这个文件是模拟器的核心部分，主要负责模拟RISC-V指令流水线的执行过程
#2025.6.18 目前的模拟器是面向ts800的，ts800是一个双发乱序流水线的处理器
#2025.6.18 目前的模拟器并没有实现分支预测功能，因此在模拟过程中，所有的分支指令都被认为是
#预测成功的，这样可以简化模拟器的实现
#2025.6.18 目前的模拟器只支持RISC-V G64指令集的子集，主要包括整数指令、乘法指令、除法指令、
#单精度浮点指令、双精度浮点指令、原子指令和访存指令
#2025.6.18 目前的模拟器只支持访存指令的加载和存储，不支持其他类型的访存指令
#2025.6.18 然而ts800由于各种指令的执行周期的缺失，实际的指令运行周期是使用的C906的手册的配置


#2025.6.19 cache分析中，我们已经能得到以涉及到memref的指令的地址为Dict的索引，获得cache的hit/miss信息
#这就需要访问生成chmtable的数据结构node_ichmc_must，可以在一次运行时，截取部分将要用到的chmtable表
#这个表会作为参数传入do_simulation函数中，这个表的作用在于对于访存指令的cache分析，如果标注为AH或者PS，则认为命中
#否则认为未命中

#2025.6.25 更新为，需要生成两个最坏时间估计，分别对应着must分析和persistent分析的情况，前者适用于
#循环第一次运行时的cache分析，后者适用于多次运行时的cache分析
#overlap_cycle 在目前没有考虑分支预测功能的前提下，是一个可以删除的变量，不需要生成

#用于报错信息
class PipelineError(RuntimeError):
    def __init__(self, block_id, message):
        super().__init__(f"在基本块{block_id}中，{message}")
        self.block_id = block_id

class SimulatorContext:
    def __init__(self):
        self.current_block_id = None

sim_context = SimulatorContext()
#报错信息结束

class InstInPipeline(RISC_V_Instruction):
    def __init__(self, instruction, inst_id):
        # 直接复制父类的所有属性
        self.rs1 = instruction.rs1
        self.rs2 = instruction.rs2  
        self.rs3 = instruction.rs3
        self.rd = instruction.rd
        reg_alias_map = {
            'zero': 'x0',
            'ra': 'x1',
            'sp': 'x2',
            'gp': 'x3',
            'tp': 'x4',
            't0': 'x5',
            't1': 'x6',
            't2': 'x7',
            's0': 'x8',   # 或 'fp': 'x8'
            's1': 'x9',
            'a0': 'x10',
            'a1': 'x11',
            'a2': 'x12',
            'a3': 'x13',
            'a4': 'x14',
            'a5': 'x15',
            'a6': 'x16',
            'a7': 'x17',
            's2': 'x18',
            's3': 'x19',
            's4': 'x20',
            's5': 'x21',
            's6': 'x22',
            's7': 'x23',
            's8': 'x24',
            's9': 'x25',
            's10': 'x26',
            's11': 'x27',
            't3': 'x28',
            't4': 'x29',
            't5': 'x30',
            't6': 'x31',
            # 如果需要 'fp' 也指向 'x8'，可以加上
            'fp': 'x8',
        }
        self.transform_to_physical_register(reg_alias_map)
        self._addr = instruction.addr
        self._l_type = instruction.l_type
        self._finish_cycle = instruction.finish_cycle   #指令的执行周期
        self.inst_id = inst_id
        self.executing_cycle = 0
        #通过l_type来判断指令要进入的流水线器件
        #INTERGER,JUMP,BRANCH进入整数流水器件
        #MULTIPLY,DIVISION进入乘法器和除法器流水器件
        #MEMORY进入访存流水器件
        #SINGLE_FLOAT进入单精度浮点流水器件

        self.dispatched = False

    def transform_to_physical_register(self, reg_alias_map):
        # 将寄存器别名转换为物理寄存器
        if self.rs1 in reg_alias_map:
            self.rs1 = reg_alias_map[self.rs1]
        if self.rs2 in reg_alias_map:
            self.rs2 = reg_alias_map[self.rs2]
        if self.rs3 in reg_alias_map:
            self.rs3 = reg_alias_map[self.rs3]
        if self.rd in reg_alias_map:
            self.rd = reg_alias_map[self.rd]

    def is_integer_inst(self):
        return self._l_type in ('INTEGER', 'JUMP', 'BRANCH')
    
    def is_multiply_inst(self):
        return self._l_type == 'MULTIPLY'
    
    def is_division_inst(self): 
        return self._l_type == 'DIVISION'
    
    def is_memory_inst(self):
        return self._l_type == 'MEMORY'
    
    def is_floating_point_inst(self):
        return self._l_type == 'SINGLE_FLOAT'
    
    def is_vector_inst(self):
        return self._l_type == 'VECTOR'
    
    def is_jump_inst(self):
        return self._l_type == 'JUMP'



#以下所有器件使用到的instruction都是指代instInPipeline类型
class RegisterGroup:
    def __init__(self):
        self.registers = {
            **{f'x{i}': None for i in range(64)},  # 整数寄存器 x0-x63
            **{f'f{i}': None for i in range(64)},  # 浮点寄存器 f0-f63
            **{f'v{i}': None for i in range(64)}   # 向量寄存器 v0-v63
        }

    def check_read_free(self, register_name):
        """检查寄存器是否可以被读取"""
        return self.registers.get(register_name) is None

    def check_write_free(self, register_name, inst_id):
        """检查寄存器是否可以被写入，并考虑inst_id的优先级"""
        current_inst_id = self.registers.get(register_name)
        return current_inst_id is None or inst_id > current_inst_id

    def reserve_register(self, register_name, inst_id):
        if register_name in self.registers:
            self.registers[register_name] = inst_id
            return True
        return False

    def release_register(self, register_name):
        if register_name in self.registers:
            self.registers[register_name] = None
            return True
        return False
           
class InstBuffer:
    MAX_SIZE = 13

    def __init__(self):
        self.buffer = []

    def add_instruction(self, instruction, inst_id):
        if len(self.buffer) < self.MAX_SIZE:
            self.buffer.append(InstInPipeline(instruction, inst_id))
            return True
        return False

    def decode_and_dispatch(self, execute_units, register_group, rob):
        if not self.buffer:
            return

        # 尝试分发最老的一条指令
        for i, inst in enumerate(self.buffer):
            if not inst.dispatched and self.dispatch_instruction(inst, execute_units, register_group, rob):
                inst.dispatched = True
                del self.buffer[i]  # 删除已分发的指令
                break

    def check_free(self, instruction: InstInPipeline, register_group: RegisterGroup):
        """检查所有需要的寄存器是否空闲或可访问"""
        #2025.6.23 需要对4寄存器的rs3进行检查
        # 检查读权限的寄存器
        if instruction.rs1 is not None and not register_group.check_read_free(instruction.rs1):
            return False
        
        if instruction.rs2 is not None and not register_group.check_read_free(instruction.rs2):
            return False

        if instruction.rs3 is not None and not register_group.check_read_free(instruction.rs3):
            return False

        # 检查写权限的寄存器
        if instruction.rd is not None and not register_group.check_write_free(instruction.rd, instruction.inst_id):
            return False
        
        return True

    def dispatch_instruction(self, instruction, execute_units, register_group, rob):
        if not self.check_free(instruction, register_group):
            return False
        
        # 尝试分发指令
        if not execute_units.dispatch(instruction):
            return False
        
        # 分发成功后更新寄存器状态（仅对目标寄存器）
        if instruction.rd is not None:
            register_group.reserve_register(instruction.rd, instruction.inst_id)
        
        # 添加到ROB
        rob.add_entry(instruction)
        
        return True

class ROB:
    MAX_SIZE = 13

    def __init__(self):
        self.entries = []

    def add_entry(self, inst_in_pipeline):
        if len(self.entries) < self.MAX_SIZE:
            self.entries.append((inst_in_pipeline, False))  # (instruction, finished)
            return True
        return False

    def commit(self, completed_instructions, register_group):
        #2025.6.22 提交全部的完成指令，这是基于假设的，因为手册里根本就没提
        # 回忆起来，本模拟器并不是完全面向C906的，而是面向ts800的，届时再修改逻辑吧，
        # C906是5级按序单发流水线，而ts800是双发乱序流水线
        # 只要头部元素存在且已完成，则尝试提交它
        while self.entries and self.entries[0][1]:
            entry, _ = self.entries.pop(0)  # 提交最老的可提交指令
                
            # 提交指令并释放相关寄存器
            if entry.rd is not None:
                register_group.release_register(entry.rd)

            # TODO：2025.7.3 这个地方预留出来可能是为了数据旁路的存在
            # 然而目前的模拟器并没有实现数据旁路功能
                

        # 标记所有已完成但尚未提交的指令为 finished
        for i, (entry, finished) in enumerate(self.entries):
            if entry in completed_instructions and not finished:
                self.entries[i] = (entry, True)

    def is_full(self):
        return len(self.entries) >= self.MAX_SIZE


class ExecuteUnits:
    def __init__(self, node_data_chmc=None):
        #分类貌似有点问题，需要检查ts800手册对乘法器和除法器的描述
        #2025.7.3 后续考虑使用一个配置类，来对不同架构的执行单元进行配置
        #2025.6.23 l_type也在父类中被初始化，目前的做法是，通过l_type来判断指令要进入的流水线器件
        #INTERGER,JUMP,BRANCH进入整数流水器件
        #MULTIPLY,DIVISION进入乘法器和除法器流水器件
        #MEMORY进入访存流水器件
        #SINGLE_FLOAT进入单精度浮点流水器件
        self.integer_units = 1
        self.multiply_units = 1
        self.division_units = 1
        self.memory_units = 1
        self.floating_point_units = 1
        self.vector_units = 1
        self.jump_units = 1
        self.executing_instructions = []
        self.node_data_chmc = node_data_chmc
        self.waiting_penalty_insts = [] # [(inst, penalty_cycles), ...]

    def dispatch(self, instruction):
        if instruction.is_integer_inst() and self.integer_units > 0:
            self.integer_units -= 1
            self.executing_instructions.append(instruction)
            return True
        elif instruction.is_multiply_inst() and self.multiply_units > 0:
            self.multiply_units -= 1
            self.executing_instructions.append(instruction)
            return True
        elif instruction.is_division_inst() and self.division_units > 0:
            self.division_units -= 1
            self.executing_instructions.append(instruction)
            return True
        elif instruction.is_memory_inst() and self.memory_units > 0:
            self.memory_units -= 1
            self.executing_instructions.append(instruction)
            return True
        elif instruction.is_floating_point_inst() and self.floating_point_units > 0:
            self.floating_point_units -= 1
            self.executing_instructions.append(instruction)
            return True
        elif instruction.is_vector_inst() and self.vector_units > 0:
            self.vector_units -= 1
            self.executing_instructions.append(instruction)
            return True
        elif instruction.is_jump_inst():  # Add handling for JUMP instructions
            self.executing_instructions.append(instruction)
            return True
        raise PipelineError(sim_context.current_block_id,f"存在未处理类型指令，其类型为{instruction._l_type}")
        return False
    
    # def execute(self, is_persistent: bool, data_cache_penalty = 10):
    #     to_remove = []

    #     for inst in self.executing_instructions:
    #         inst.executing_cycle += 1
    #         if inst.is_memory_inst():
    #         # 检查是否在等待惩罚
    #             found = False
    #             for w_inst, penalty_cycles in self.waiting_penalty_insts:
    #                 if w_inst is inst:
    #                     found = True
    #                     if inst.executing_cycle >= inst.finish_cycle + penalty_cycles:
    #                         self.waiting_penalty_insts = []  # [(inst, penalty_cycles), ...]waiting_penalty_insts.remove(inst)
    #                         self.memory_units += 1
    #                         to_remove.append(inst)
    #                     break
    #             if not found:
    #                 # 首次执行，判断cache
    #                 if inst.addr.to_dec() in self.node_data_chmc:
    #                     cacheHitOrMiss = self.node_data_chmc[inst.addr.to_dec()]
    #                     l1_status = cacheHitOrMiss[0][1]
    #                     if l1_status == CHMC.AH or (is_persistent and l1_status == CHMC.PS):
    #                         #print("L1D HIT")
    #                         self.memory_units += 1
    #                         to_remove.append(inst)
    #                     else:
    #                         #print("D MISS")
    #                         # miss，加入惩罚队列
    #                         self.waiting_penalty_insts.append((inst, data_cache_penalty))
    #                 else:
    #                     raise PipelineError(sim_context.current_block_id,f"其 Data_CHMC 缺少对指令地址 {inst.addr} 的分析") 
    #         elif inst.is_integer_inst():
    #             if inst.executing_cycle >= inst.finish_cycle:
    #                 self.integer_units += 1
    #                 to_remove.append(inst)
    #         elif inst.is_floating_point_inst():
    #             if inst.executing_cycle >= inst.finish_cycle:
    #                 self.floating_point_units += 1
    #                 to_remove.append(inst)
    #         elif inst.is_vector_inst():
    #             if inst.executing_cycle >= inst.finish_cycle:
    #                 self.vector_units += 1
    #                 to_remove.append(inst)
    #     completed_instructions = [inst for inst in self.executing_instructions if inst in to_remove]
    #     self.executing_instructions = [inst for inst in self.executing_instructions if inst not in to_remove]
    #     return completed_instructions
    def execute(self, is_persistent: bool, data_cache_penalty=370):
        """
        执行当前周期的所有指令。支持访存惩罚与其他指令的完成检测。
        修复内容：
        1. 不再写 inst.finish_cycle（因为是只读属性）
        2. waiting_penalty_insts 改为 (inst, start_cycle, penalty)
        3. 对未分类指令（例如 JUMP/BRANCH/NOP）加入兜底退出
        4. 加调试打印 + 死循环保护
        """
        to_remove = []
        current_cycle_snapshot = getattr(self, "_cycle_counter", 0)
        self._cycle_counter = current_cycle_snapshot + 1

        # 每 1000 周期打印一次，防止卡死调试用
        if self._cycle_counter % 1000 == 0:
            print(f"[DEBUG] cycle={self._cycle_counter}, exec={len(self.executing_instructions)}, wait={len(self.waiting_penalty_insts)}")

        for inst in list(self.executing_instructions):
            inst.executing_cycle += 1
            handled = False

            # ============ 访存指令 ============
            if inst.is_memory_inst():
                handled = True
                found = False
                for w_inst, start_cycle, penalty_cycles in list(self.waiting_penalty_insts):
                    if w_inst is inst:
                        found = True
                        # 惩罚结束
                        if inst.executing_cycle - start_cycle >= penalty_cycles:
                            self.waiting_penalty_insts = [
                                (wi, sc, pc) for (wi, sc, pc) in self.waiting_penalty_insts
                                if wi is not inst
                            ]
                            self.memory_units += 1
                            to_remove.append(inst)
                        break

                # 首次进入等待队列
                if not found:
                    if inst.addr.to_dec() in self.node_data_chmc:
                        cacheHitOrMiss = self.node_data_chmc[inst.addr.to_dec()]
                        l1_status = cacheHitOrMiss[0][1]
                        if l1_status == CHMC.AH or (is_persistent and l1_status == CHMC.PS):
                            # 命中
                            self.memory_units += 1
                            to_remove.append(inst)
                        else:
                            # miss → 开始等待惩罚
                            start_cycle = inst.executing_cycle
                            self.waiting_penalty_insts.append((inst, start_cycle, data_cache_penalty))
                    else:
                        raise PipelineError(sim_context.current_block_id,
                            f"其 Data_CHMC 缺少对指令地址 {inst.addr} 的分析")
            # ============ 整数指令 ============
            elif inst.is_integer_inst():
                handled = True
                if inst.executing_cycle >= inst._finish_cycle:
                    self.integer_units += 1
                    to_remove.append(inst)

            # ============ 浮点指令 ============
            elif inst.is_floating_point_inst():
                handled = True
                if inst.executing_cycle >= inst._finish_cycle:
                    self.floating_point_units += 1
                    to_remove.append(inst)

            # ============ 向量指令 ============
            elif inst.is_vector_inst():
                handled = True
                if inst.executing_cycle >= inst._finish_cycle:
                    self.vector_units += 1
                    to_remove.append(inst)

            # ============ 未分类指令兜底 ============
            if not handled:
                # print(f"[WARN] 未分类指令 {_l_type} 自动完成")
                to_remove.append(inst)

        # 从执行队列中移除已完成指令
        completed_instructions = [inst for inst in self.executing_instructions if inst in to_remove]
        self.executing_instructions = [inst for inst in self.executing_instructions if inst not in to_remove]

        # 死循环保护：超过 1e6 周期强制中断
        if self._cycle_counter > 1_000_000:
            print(f"[FATAL] pipeline timeout: block={sim_context.current_block_id}, still executing={len(self.executing_instructions)}")
            for i, stuck in enumerate(self.executing_instructions[:5]):
                print(f"  stuck inst {i}: {stuck._l_type}, addr={stuck.addr}")
            self.executing_instructions.clear()
            self.waiting_penalty_insts.clear()

        return completed_instructions





def do_pipeline_simulation(current_block_id, instructions: list, 
                                    node_inst_chmc, node_data_chmc, is_persistent:bool,
                                    cache_config:MultiLevelCacheConfig
                                    ) -> int:
    #print(f"/**********************{current_block_id}******************************/")
    sim_context.current_block_id = current_block_id#报错信息
    cycle = 0
    stall_cycles = 0
    inst_buffer = InstBuffer()
    rob = ROB()
    register_group = RegisterGroup()
    execute_units = ExecuteUnits(node_data_chmc)

    #data cache miss只需要延长该指令的运行时间
    # 2025.6.26 cache这块儿只需要获取cache的惩罚周期即可
    # Cache的具体配置应该是在Analyser中进行的
    inst_cache_penalty = 370
    if cache_config[CacheHierarchy.L1I]:
        inst_cache_penalty = cache_config[CacheHierarchy.L1I].penalty
    data_cache_penalty = 370
    if cache_config[CacheHierarchy.L1D]:
        data_cache_penalty = cache_config[CacheHierarchy.L1D].penalty
    inst_id_counter = 0
    completed_instructions = []
    waiting_penalty_instructions = []

    while instructions or inst_buffer.buffer or execute_units.executing_instructions or rob.entries:
        rob.commit(completed_instructions, register_group)  # 确保这里传递了 register_group
        
        completed_instructions = execute_units.execute(is_persistent, data_cache_penalty)

        inst_buffer.decode_and_dispatch(execute_units, register_group, rob)

        if stall_cycles == 0:
            for _ in range(2):
                if not instructions:
                    break
                
                if len(waiting_penalty_instructions) == 0:
                    # 要考虑一个waiting_penalty_instructions能否超过2个内容物的情况
                    #不会，因为指令在惩罚的时候并没有释放memory_units，所以根本不会有第二条指令进来
                    instruction = instructions[0]
                    # 2025.7.2 判断instcache的命中与否
                    #如果命中，则直接使用指令，否则需要停滞前端流水
                    if instruction.addr.to_dec() in node_inst_chmc:
                        cacheHitOrMiss = node_inst_chmc[instruction.addr.to_dec()]
                        L1_Status = cacheHitOrMiss[0][1]
                        if L1_Status == CHMC.AH or (is_persistent and L1_Status == CHMC.PS):
                            #print("L1I Hit")
                            #命中
                            '''命中就指令成功取指，不影响流水的进行'''
                            new_inst = InstInPipeline(instruction, inst_id_counter)
                        else:
                            #print("I MISS")
                            #未命中，要引起前端的stall, 同时在惩罚结束要记得读取该指令
                            #并使得流水线继续进行
                            stall_cycles = inst_cache_penalty
                            new_inst = InstInPipeline(instruction, inst_id_counter)
                            #这个变量不是流水线特性，而是用于暂存从instructions中排出
                            #但是由于cache未命中，需要等待cache的惩罚周期也没有加入
                            #instbuffer里的指令的
                            waiting_penalty_instructions.append(new_inst)
                            break
                    else:
                    # 异常，inst_chmc漏掉了对某个内存引用的分析
                        raise PipelineError(sim_context.current_block_id,f"其Inst_CHMC 缺少对指令地址 {instruction.addr} 的分析")

                else:
                    # 如果waiting_penalty_instructions不为空，则从中取出指令
                    new_inst = waiting_penalty_instructions[0]
                    waiting_penalty_instructions.pop(0)      
                
                if inst_buffer.add_instruction(new_inst, inst_id_counter):
                    inst_id_counter += 1
                    instructions.pop(0)
                else:
                    stall_cycles = max(stall_cycles, 1)
                    break

                if len(inst_buffer.buffer) >= inst_buffer.MAX_SIZE or len(rob.entries) >= rob.MAX_SIZE:
                    stall_cycles = max(stall_cycles, 1)
                    break
        else:
            stall_cycles -= 1

        cycle += 1
    #2025.6.23 overlap cycle计算的是，该基本块最后一条指令提交完成，
    # 到下一个连续执行的基本块第一条指令准备好（即开始解码还是进入inst_buffer？我没思考清楚）
    # 但是要注意到，这是基于分支预测成功的假设的，如果分支预测不成功，在analyser中要有对不成功的处理
    # behaviors 是一个pipeline_tracer类的一个对象，但是tracer和behaviors这两个类还没有仔细研究
    # 这俩类在旧版本里有描述，如果将来需要添加，可以参考旧版本的设定
    # 目前就先把他返回一个空的pipeline_tracer对象就好
    # cycle是一个list，[0]项是must分析，[1]项是persistent分析
    return cycle#, behaviors


def summarize_pipeline_block(block_id: int, cycles: List[int], instruction_count: int) -> Dict[str, Any]:
    """Return a compact summary for one basic block pipeline result."""
    must_cycle = cycles[0] if cycles else 0
    persistent_cycle = cycles[1] if len(cycles) > 1 else must_cycle
    return {
        "block_id": block_id,
        "instruction_count": instruction_count,
        "cycle_must": must_cycle,
        "cycle_persistent": persistent_cycle,
        "cycle_gap": max(0, must_cycle - persistent_cycle),
        "ipc_must": round(instruction_count / must_cycle, 4) if must_cycle else 0.0,
        "ipc_persistent": round(instruction_count / persistent_cycle, 4) if persistent_cycle else 0.0,
    }


def do_pipeline_simulation_in_block(current_block_id, instructions: list, 
                                    node_inst_chmc, node_data_chmc, is_persistent:bool,
                                    cache_config:MultiLevelCacheConfig
                                    ) -> List[int]:
    #做must分析
    cycles = []
    cycles.append(do_pipeline_simulation(current_block_id, instructions.copy(), 
                                    node_inst_chmc, node_data_chmc, 0,
                                    cache_config))
    #做persistent分析
    if is_persistent:
        cycles.append(do_pipeline_simulation(current_block_id, instructions.copy(), 
                                    node_inst_chmc, node_data_chmc, is_persistent,
                                    cache_config))
    return cycles
