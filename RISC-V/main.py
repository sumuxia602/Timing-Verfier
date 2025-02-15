from typing import List, Optional
from typing import Dict, Set
import networkx as nx
from networkx.drawing.nx_agraph import graphviz_layout, to_agraph
import re
import time
import pandas as pd
import os
import argparse
# import 
import numpy as np #

start_list = set()   #开始行号集合

end_list:Dict[int, Set] = {}   #结尾行号对应指向的开始行号

fun_list_loc={} #函数位置映射

fun_list_counts={} #函数使用次数

fun_return_stack = []   #函数返回栈

block_start_line = {}   #建立每个基本块初始行与块号的映射

addr_to_location = {}   #指令地址对行号的映射

basicblock_list = []    #基本块集合

edge_list = []     #边集合

# 将16进制字符串转换为int
def convert_to_hex_if_possible(part):
    try:
        # 尝试将字符串作为16进制数字转换
        return int(part, 16)
    except ValueError:
        # 如果转换失败，返回原字符串
        return part

# 分离字符串
def str_split(line):
    line = line.split('#')[0]
    # line = line.strip()
    line = line.strip()
    # 分割字符串
    parts = re.split(r':\t|\t|,|<|>|\(|\)|:|\s+', line)

    # 移除空字符串
    filtered_parts = [part.strip() for part in parts if part.strip()]
    return filtered_parts
    # return filtered_parts

'''
RISC_V_Instruction类
    指令名称：name
    操作数列表：operands
    指令地址：addr（输入为str，储存使用int）
    指令标签：label
    指令原文：instruction
    指令位置：location（在汇编代码中的行号）

'''
class RISC_V_Instruction:
    def __init__(self, name: str, operands: List[str], location: int, opcode: str = '',instruction: str='',addr:str='',
                 label: Optional[str] = None) -> None:
        self._name = name  # 指令名称，例如：'add', 'beq', 'lw'等
        self._operands = tuple(operands)  # 操作数列表
        self._addr = int(addr, 16) if addr else 0  # 指令地址字符串为16进制数
        self._opcode = opcode  # 操作码，RISC-V指令集中可能不直接使用，但可用于额外信息
        self._label = label  # 指令标签，可选
        self._instruction = instruction  #指令原文
        self._location = location  # 指令位置(在汇编代码中的行号)

    @property
    def addr(self) -> int:
        return self._addr

    @property
    def location(self) -> int:
        return self._location

    @property
    def operands(self) -> List[str]:
        return self._operands

    @property
    def name(self) -> str:
        return self._name

    @property
    def opcode(self) -> str:
        return self._opcode

    @property
    def label(self) -> str:
        return self._label

    def __str__(self) -> str:
        return f"{self.location}: {self.name} {' '.join(self.operands)}"

    def is_branch(self) -> bool:
        """判断是否为分支指令
            1：是分支指令
            0：不是分支指令
        """
        return self.name in ['beq', 'bne', 'blt', 'bge', 'bltu', 'bgeu','beqz','bnez','blez','bgez','bltz','bgtz','bgt','ble','bgtu','bleu']

    def is_jump(self) -> bool:
        """判断是否为跳转指令
            1：是跳转指令
            0：不是跳转指令
        """
        return self.name in ['jal', 'jalr','jr','call','j','tail','ret']

    def is_load(self) -> bool:
        """判断是否为加载指令"""
        return self.name.startswith('l') and self.name not in ['lui']

    def is_store(self) -> bool:
        """判断是否为存储指令
        """
        return self.name.startswith('s')

    def is_arithmetic(self) -> bool:
        """判断是否为算术指令
            1：是算数指令
            0：不是算术指令
        """
        arithmetic_ops = ['add', 'sub', 'sll', 'slt', 'sltu', 'xor', 'srl', 'sra', 'or', 'and',
                          'addi', 'slti', 'sltiu', 'xori', 'ori', 'andi', 'slli', 'srli', 'srai']
        return self.name in arithmetic_ops

    def modifies_reg(self, reg_name: str) -> bool:
        """判断指令是否修改指定寄存器"""
        if self.is_store() or self.is_branch() or self.is_jump():
            return False
        return self.operands[-1] == reg_name

    @classmethod
    def from_assembly_line(cls, line: str, location: int) -> 'RISC_V_Instruction':
        """从一行汇编代码创建 RISC_V_Instruction 对象，支持括号中的操作数
        （前提是这个指令是一条指令而不是一个无用语句）
        """
        split_line = str_split(line)
        addr = split_line[0]
        opcode = split_line[1]
        name = split_line[2]
        operands = split_line[3:]
        # 创建并返回 RISC_V_Instruction 对象
        return cls(name=name, operands=operands, location=location ,instruction=line ,addr=addr ,opcode=opcode)


def if_useful_instructions(line):  #判断汇编代码中的语句是否是有用指令
    parts = str_split(line)

    #1为无用指令，可能为空白或别的字符串；0为有用指令，其中包含地址
    if len(parts) == 0:
        return 1
    elif type(convert_to_hex_if_possible(parts[0])) is not int:
        return 1
    else:
        return 0


 #加载汇编文件并构建函数名到行数的映射以及指令地址对行号的映射
def load_useful_assembly_instructions(file_path):
    instructions = []
    instructions.append("")
    with open(file_path, 'r') as file:
        for line in file:
            instructions.append(line)
            parts = str_split(line)
            if if_useful_instructions(line) == 0:
                if len(parts) == 2:
                    temp_parts = parts[1]
                    fun_list_loc[temp_parts] = len(instructions) - 1
                    fun_list_counts[temp_parts] = 0
                else:
                    addr_to_location[parts[0]] = len(instructions) - 1

    return instructions


#从指令集列表instuctions中修改start_list以及end_list的值，从start行开始（一般为main函数的起始行）
def create_cfg_list(start,instructions:List[str]):
    start_list.add(start)
    line_id = start
    instructions_len = len(instructions)

    '''判断当前语句是否是在switch的多重判断语句中（特殊情况）'''
    if_switch = 0
    switch_target_list = set() #switch目标行号
    switch_from_list = []  #switch来源行号

    while(1):
        true_line_id = line_id%instructions_len
        line = instructions[true_line_id]
        if(if_useful_instructions(line) == 1) or len(str_split(line)) == 2: #该语句为无用指令或为函数，直接取下一行
            line_id = line_id + 1
            continue
        else: #该语句为有用指令，继续分析
            tmp_instructions=RISC_V_Instruction.from_assembly_line(line, true_line_id) #读取指令
            if(tmp_instructions.is_jump() or tmp_instructions.is_branch()): #若该指令为分支或跳转则继续分析
                end = line_id          #一般碰到这种跳转或分支指令，当前指令一定为一个基础块的最后一行
                '''分支指令'''
                if(tmp_instructions.is_branch()):
                    start_list.add(line_id + 1)  #下一行加入开始列表
                    target = tmp_instructions.operands[-2]  #目标地址
                    true_target_line = addr_to_location[target]    #目标位置
                    target_line = int(line_id/instructions_len)*instructions_len + true_target_line
                    start_list.add(target_line)   #分支跳转目标行加入开始列表
                    if end not in end_list:
                        end_list[end] = set()
                    end_list[end].add(end+1)
                    end_list[end].add(target_line)

                    '''指向的上一行作为结束'''
                    target_subsequent_line=target_line - 1
                    true_target_subsequent_line = target_subsequent_line % instructions_len
                    target_subsequent_instruction=RISC_V_Instruction.from_assembly_line(instructions[true_target_subsequent_line],true_target_subsequent_line)  #前两行的指令

                    '''如果上一行为跳转或分支指令，则无需操作，否则要将这一行作为结束指向下一行'''
                    if not(target_subsequent_instruction.is_jump() or target_subsequent_instruction.is_branch()):
                        if target_subsequent_line not in end_list:
                            end_list[target_subsequent_line] = set()
                        end_list[target_subsequent_line].add(target_line)

                    line_id = line_id + 1

                    '''直接跳转指令j'''
                elif tmp_instructions.name == "j":
                    target = tmp_instructions.operands[0]  # 目标地址
                    true_target_line = addr_to_location[target]  # 目标位置
                    target_line = int(line_id / instructions_len) * instructions_len + true_target_line
                    start_list.add(target_line)  #直接跳转目标行加入开始列表
                    if end not in end_list:
                        end_list[end] = set()
                    end_list[end].add(target_line)

                    '''指向的上一行作为结束'''
                    target_subsequent_line=target_line - 1
                    true_target_subsequent_line = target_subsequent_line % instructions_len
                    target_subsequent_instruction=RISC_V_Instruction.from_assembly_line(instructions[true_target_subsequent_line],true_target_subsequent_line)  #前两行的指令

                    '''如果上一行为跳转或分支指令，则无需操作，否则要将这一行作为结束指向下一行'''
                    if not(target_subsequent_instruction.is_jump() or target_subsequent_instruction.is_branch()):
                        if target_subsequent_line not in end_list:
                            end_list[target_subsequent_line] = set()
                        end_list[target_subsequent_line].add(target_line)


                    '''如果该跳转是switch的跳转还要处理下一行'''
                    if if_switch == 1:
                        start_list.add(line_id + 1)  # 下一行加入开始列表
                        switch_target_list.add(target_line) #将跳转行号加入switch的目标行号集合
                        end_list[switch_from_list[-1]].add(end + 1)  # 将switch来源行指向下一行

                    line_id = line_id + 1


                    '''间接跳转指令jr'''
                elif tmp_instructions.name == "jr":
                    if tmp_instructions.operands[0] == "ra":
                        if len(fun_return_stack) == 0:
                            if end not in end_list:
                                end_list[end] = set()
                            break
                        else:
                            top_element = fun_return_stack.pop()  # 查询栈顶元素
                            if end not in end_list:
                                end_list[end] = set()
                            end_list[end].add(top_element)
                            line_id = top_element

                    elif tmp_instructions.operands[0] == "a5":
                        if end not in end_list:
                            end_list[end] = set()
                        if_switch = 1 #调整switch
                        switch_from_list.append(end) #将该行加入switch来源列表
                        start_list.add(line_id + 1)  # 下一行加入开始列表
                        end_list[end].add(end + 1)  #该行指向下一行

                        line_id = line_id + 1

                    else:
                        raise Exception("暂不支持跳转并链接到除ra以外的寄存器")

                elif tmp_instructions.name == "ret":     #与“jr ra”一样
                    if len(fun_return_stack) == 0:
                        if end not in end_list:
                            end_list[end] = set()
                        break
                    else:
                        top_element = fun_return_stack.pop()  # 查询栈顶元素
                        if end not in end_list:
                            end_list[end] = set()
                        end_list[end].add(top_element)
                        line_id = top_element

                elif tmp_instructions.name == "call":  #一般为调用远程函数命令
                    start_list.add(line_id + 1)  # 下一行加入开始列表
                    fun_return_stack.append(line_id + 1)  #将下一行作为函数返回的地址塞入栈中
                    target = tmp_instructions.operands[-1]  # 目标名称
                    true_target_line = fun_list_loc[target]  # 目标位置
                    fun_list_counts[target] = fun_list_counts[target] + 1  #该函数调用次数加一
                    target_line = true_target_line + fun_list_counts[target] * instructions_len
                    if end not in end_list:
                        end_list[end] = set()
                    end_list[end].add(target_line)
                    start_list.add(target_line)
                    line_id = target_line

                elif tmp_instructions.name == "jal":
                    if tmp_instructions.operands[0] == "ra":   #一般为调用函数指令,修改ra寄存器
                        start_list.add(line_id + 1)  # 下一行加入开始列表
                        fun_return_stack.append(line_id + 1)  # 将下一行作为函数返回的地址塞入栈中
                        target_addr = tmp_instructions.operands[1]  # 目标地址
                        target_fun = tmp_instructions.operands[-1]  #目标函数名
                        true_target_line = addr_to_location[target_addr]  # 目标位置
                        fun_list_counts[target_fun] = fun_list_counts[target_fun] + 1  # 该函数调用次数加一
                        target_line = true_target_line + fun_list_counts[target_fun] * instructions_len
                        if end not in end_list:
                            end_list[end] = set()
                        end_list[end].add(target_line)
                        start_list.add(target_line)
                        line_id = target_line
                    else:
                        raise Exception("暂不支持跳转的时候修改其他寄存器")




                elif tmp_instructions.name == "jalr":
                    raise Exception("暂不支持jalr")




                '''判断是否离开switch语句'''
            else:     #若该指令不为分支和跳转，则直接跳过该指令或判断是否离开switch语句，分析下一行
                if line_id in switch_target_list:
                    switch_target_list.discard(line_id)
                    switch_from_list.pop()
                    if len(switch_target_list) == 0:
                        if_switch = 0
                line_id = line_id + 1
                continue


'''
基本块类：
    块号：id
    开始行号:start_line
    结尾行号:end_line
    指令列表:instructions
    出边编号列表：to_edge_list
    入边编号列表:from_edge_list

'''
class BasicBlock:
    def __init__(self, id: int, start_line: int, end_line: int):
        self.id = id
        self.start_line = start_line #基本块开始的行号
        self.end_line = end_line #基本块结束的行号
        self.instructions = []  # 储存在这个基本块中的指令列表
        self.to_edge_list = []  # 出边编号列表
        self.from_edge_list = []  #入边编号列表

    def add_instruction(self, instruction: RISC_V_Instruction):
        """向这个基本块中添加指令"""
        self.instructions.append(instruction)

    def add_to_edge(self, id):
        """添加出边"""
        self.to_edge_list.append(id)

    def add_from_edge(self, id):
        """添加入边"""
        self.from_edge_list.append(id)

    def if_start(self):
        """
        判断该节点是否是开始节点
            1:是
            0:不是
        """
        if len(self.from_edge_list) == 0:
            return 1
        else:
            return 0

    def if_end(self):
        """
        判断该节点是否是结束节点
            1:是
            0:不是
        """
        if len(self.to_edge_list) == 0:
            return 1
        else:
            return 0

    def __str__(self):
        return f"Basic Block starting at line {self.start_line} with {len(self.instructions)} instructions"



class Edge:
    def __init__(self, id : int, from_block_id : int , to_block_id: int):
        self.id = id
        self.from_block_id = from_block_id
        self.to_block_id = to_block_id

    def from_block(self):
        """返回该边的源头节点"""
        return basicblock_list[self.from_block_id]

    def to_block(self):
        """返回该边的目标节点"""
        return basicblock_list[self.to_block_id]

    def __str__(self):
        return f"Edge starting from basic_blockid:{self.from_block_id} to basic_blockid:{self.to_block_id} "



def creat_cfg(instructions:List[str]): #构建cfg过程
    #cfg = nx.DiGraph()
    block_id = 0  #初始块id
    # 将start_list和end_list的键排序
    instructions_len = len(instructions)  #汇编代码长度
    sorted_start_list = sorted(start_list)
    sorted_end_keys = sorted(end_list.keys())
    for start_line, end_line in zip(sorted_start_list, sorted_end_keys):
        block_start_line[start_line] = block_id

        block = BasicBlock(block_id, start_line% instructions_len, end_line% instructions_len)

        for i in range(start_line, end_line + 1):
            true_line_id = i % instructions_len
            block_instruction = RISC_V_Instruction.from_assembly_line(instructions[true_line_id],true_line_id)
            block.add_instruction(block_instruction)

        # 将基本块添加到列表中
        basicblock_list.append(block)

        #cfg.add_node(block_id, block=block,label=f"Start: {block.start_line}; End: {block.end_line}")
        block_id += 1

    edge_id = 0
    for start_line, end_line in zip(sorted_start_list, sorted_end_keys):
        # 根据end_list信息添加边
        for target_start_line in end_list[end_line]:
            #通过起始行号找到目标基本块的ID
            target_id = block_start_line[target_start_line]

            '''将边加入边列表'''
            edge = Edge(edge_id,block_start_line[start_line],target_id)
            edge_list.append(edge)

            '''将边相连的两个节点内容补充完整'''
            basicblock_list[block_start_line[start_line]].add_to_edge(edge_id)
            basicblock_list[target_id].add_from_edge(edge_id)

            edge_id += 1
            #cfg.add_edge(block_start_line[start_line], target_id)

    #return cfg

def draw_cfg(tmp_block_list,tmp_edge_list,file_path):

    '''创建一个nx对象用来储存图'''
    pic = nx.DiGraph()
    '''将节点储存到图中'''
    for i in range(0,len(tmp_block_list)):
        block = tmp_block_list[i]
        pic.add_node(block.id, block=block,label=f"Start: {block.start_line}; End: {block.end_line}")

    '''添加边'''
    for i in range(0,len(tmp_edge_list)):
        edge = tmp_edge_list[i]
        pic.add_edge(edge.from_block_id, edge.to_block_id)

    # 将networkx图转换为Agraph对象
    A = to_agraph(pic)

    # 使用Agraph对象输出Graphviz.dot文件或直接渲染图形
    dot_path = file_path.replace('.s', '.dot')
    png_path = file_path.replace('.s', '.png')
    A.write(dot_path)
    A.draw(png_path, format='png', prog='dot')
    print(f"DOT 文件已保存至: {dot_path}")
    print(f"PNG 图片已保存至: {png_path}")


def initialize_globals():
    global start_list, end_list, fun_list_loc, fun_list_counts, fun_return_stack, block_start_line, addr_to_location, basicblock_list, edge_list
    start_list = set()  # 开始行号集合
    end_list = {}  # 结尾行号对应指向的开始行号
    fun_list_loc = {}  # 函数位置映射
    fun_list_counts = {}  # 函数使用次数
    fun_return_stack = []  # 函数返回栈
    block_start_line = {}  # 建立每个基本块初始行与块号的映射
    addr_to_location = {}  # 指令地址对行号的映射
    basicblock_list = []  # 基本块集合
    edge_list = []  # 边集合



def main(file_path):


    # 开始总运行时间计时
    start_time = time.time()


    # 使用用户提供的路径加载指令
    start_assembly = time.time()
    assembly_instructions = load_useful_assembly_instructions(file_path)

    # 根据加载的指令创建CFG
    create_cfg_list(fun_list_loc["main"]+1, assembly_instructions)
    creat_cfg(assembly_instructions)
    creat_cfg_duration = time.time() - start_assembly

    # 绘制CFG图
    start_draw_cfg = time.time()
    draw_cfg(basicblock_list,edge_list,file_path)
    draw_cfg_duration = time.time() - start_draw_cfg


    #总运行时间
    total_duration = time.time() - start_time



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process an input assembly file to create and draw a CFG.")
    parser.add_argument("file_path", type=str, help="Path to the input assembly file")
    args = parser.parse_args()

    main(args.file_path)
