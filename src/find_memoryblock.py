from src.cfg import *
from src.isa_base import InstructionType
from src.read_segment import SegmentReader
import re


class MemoryBlock:
    def __init__(self, ins: Instruction, start: int):
        self.ins = ins
        self.__memory_addr_val = start
        self.__memory_reference = 0

    @property
    def memory_addr_val(self):
        return self.__memory_addr_val

    @property
    def memory_block_val(self):
        self.__memory_reference = self.__memory_addr_val >> 6
        return self.__memory_reference


class Reg_Tracker:
    def __init__(self, orig_reg_list, orig_offload, ins, is_sp):
        """ 该类用于追踪回溯过程中的信息 """
        self.__is_find = False  # 是否找到
        self.__has_sp = is_sp  # 是否是局部变量（无法判断）
        self.__is_range = False  # 是否是数据访问（需要倒入多个地址）
        self.__back_trace_num = 0  # 用来限制回溯的node数量的，方式路径爆炸并且间接防止死循环
        self.__reg_list = orig_reg_list  # 需要找的reg的列表
        self.__offset = orig_offload
        self.__base = 0  # 这个和配合is_base找是否是数组
        self.tracker_list = list()
        self.ins = ins

    def set_is_find(self):
        self.__is_find = True

    @property
    def is_find(self):
        if len(self.__reg_list) == 0:
            self.__is_find = True
        return self.__is_find

    def set_has_sp(self):
        self.__has_sp = True

    @property
    def has_sp(self):
        return self.__has_sp

    def set_range(self):
        self.__is_range = True

    @property
    def is_range(self):
        return self.__is_range

    def add_back_trace_num(self):
        self.__back_trace_num += 1

    def surpass_back_trace_num(self):
        if self.__back_trace_num <= 100:
            return True
        else:
            return False

    @property
    def offset(self):
        return self.__offset

    def add_offset(self, off, pm="+"):
        if pm == "+":
            self.__offset += off
        elif pm == "-":
            self.__offset -= off

    def set_base(self, base):
        temp = int(base, 16)
        self.__base = temp

    @property
    def base_addr(self):
        if isinstance(self.__base, str):
            self.__base = int(self.__base, 16)
        return self.__base

    # 重点，reg的处理，也就是实际上负责符号执行的部分，这部分还需要更大的调整
    @property
    def reg_list(self):
        return self.__reg_list

    def is_in_reg_list(self, reg):
        if reg in self.__reg_list:
            return True
        else:
            return False

    def find_reg(self, orig_reg, new_reg=None):
        self.__reg_list.remove(orig_reg)
        if new_reg is not None:
            self.__reg_list.append(new_reg)

    def add_reg(self, reg):
        self.__reg_list.append(reg)


class memoryblock_finder:
    def __init__(self, tcfg, seg_reader, output_path):
        self.__tcfg_nodes = tcfg.all_tcfg_nodes
        self.re_num = re.compile(r"(((?:#[1-9]\d*)|(?:#0x[0-9a-fA-F]*)|(?:[1-9]\d*)|(?:0x[0-9a-fA-F]*)))")
        self.seg_reader = seg_reader
        self.output_path = output_path

    def find_mb(self):
        self.find_global_ins_mb()
        self.find_global_data_mb()

    def find_global_ins_mb(self):
        """ 找ins cache """
        for node in self.__tcfg_nodes:
            # print(node.name)
            for ins in node.instructions:
                # print(ins.addr.hex_str_pro())
                addr_start_val = ins.addr.val()
                mb = MemoryBlock(ins, addr_start_val)
                node.add_ins_mbs(mb)
                node.add_ins_reference(ins, mb.memory_block_val)

    def find_global_data_mb(self):
        """ 找需要进行符号执行的data cache,也就是找loadstore指令 """
        for node in self.__tcfg_nodes:
            for ins in node.instructions:
                if ins.is_ls:
                    # if ins.addr.hex_str() == "4006c4":
                    #     print("here")
                    reg_str_list = list()
                    is_sp = False
                    offload = 0
                    for lstarget in ins.ls_reg_target_list:
                        if lstarget.is_sp:
                            is_sp = True
                        else:
                            reg_str_list.append(lstarget.target_name)
                            # lstarget.is_sp没起作用，不知道为啥，要修的东西太多了，有时间再修
                            if lstarget.target_name == "sp":
                                is_sp = True
                    reg_tracker = Reg_Tracker(reg_str_list, ins.ls_addr_offset, ins, is_sp)
                    self.find_ins_data_mb(node, ins, reg_tracker)
                    # 在这里对reg_tracker后处理，从reg_tracker提取信息转为memory_block

                    self.tracker2mb(self.seg_reader, reg_tracker, node)

    def find_ins_data_mb(self, node, target_ins, reg_tracker):
        """ 这部分主要是确定了需要符号执行的指令之后用来遍历用的 """
        for ins in reversed(node.instructions):
            if ins.addr.val() < target_ins.addr.val():
                self.compoare_trace_ins(ins, reg_tracker)
        if not reg_tracker.is_find:
            incoming_edges = node.incoming_edge
            src_nodes = list()
            for edge in incoming_edges:
                if edge.src is not None:
                    src_nodes.append(edge.src)
            for tnode in src_nodes:
                src_nodes.pop(0)
                is_continue = reg_tracker.surpass_back_trace_num()
                if is_continue:
                    for ins in reversed(tnode.instructions):
                        if ins.addr.val() < target_ins.addr.val():
                            self.compoare_trace_ins(ins, reg_tracker)
                    if not reg_tracker.is_find:
                        incoming_edges = tnode.incoming_edge
                        for edge in incoming_edges:
                            if edge.src is not None:
                                src_nodes.append(edge.src)
                    reg_tracker.add_back_trace_num()
                else:
                    break

    def compoare_trace_ins(self, trace_ins, reg_tracker):
        """ 用来对比backtrace的指令是否是需符号执行需要的 """
        if trace_ins.inst_type == InstructionType.Branch:
            pass
        elif trace_ins.inst_type == InstructionType.Mov:
            if reg_tracker.is_in_reg_list(trace_ins.mov_first_opperand):
                if trace_ins.mov_target == "sp":
                    reg_tracker.find_reg(trace_ins.mov_first_opperand)
                    reg_tracker.set_has_sp()
                else:
                    is_imm = re.match(self.re_num, trace_ins.mov_target)
                    if is_imm:
                        reg_tracker.find_reg(trace_ins.mov_first_opperand)
                        addrStr = is_imm.groups()[0]
                        offset = self.addrStr2val(addrStr)
                        reg_tracker.add_offset(offset)
                    else:
                        reg_tracker.find_reg(trace_ins.mov_first_opperand, trace_ins.mov_target)
        elif trace_ins.inst_type == InstructionType.Add:
            if reg_tracker.is_in_reg_list(trace_ins.add_1op):
                if trace_ins.add_same:
                    if isinstance(trace_ins.add_3op, int):
                        offset = self.addrStr2val(trace_ins.add_3op)
                        reg_tracker.add_offset(trace_ins.add_3op)
                    else:
                        reg_tracker.add_reg(trace_ins.add_3op)
                elif trace_ins.add_imm:
                    reg_tracker.find_reg(trace_ins.add_1op, trace_ins.add_2op)
                    offset = self.addrStr2val(trace_ins.add_3op)
                    reg_tracker.add_offset(trace_ins.add_3op)
        elif trace_ins.inst_type == InstructionType.LoadStore:
            pass
        elif trace_ins.inst_type == InstructionType.Adrp:
            if reg_tracker.is_in_reg_list(trace_ins.adrp_first_opperand):
                base = trace_ins.adrp_addr
                reg_tracker.set_base(base)
                reg_tracker.find_reg(trace_ins.adrp_first_opperand)

    def addrStr2val(self, addrStr):
        if isinstance(addrStr, int):
            offset = addrStr
        else:
            if addrStr[0:1] == "#":
                temp = addrStr[1:]
                if temp[0:2] == "0x":
                    offset = int(temp, 16)
                else:
                    offset = int(temp)
            elif addrStr[0:2] == "0x":
                offset = int(addrStr, 16)
            elif addrStr[0:1] == "f":
                offset = int(addrStr, 16)
            else:
                offset = int(addrStr)

        return offset

    def tracker2mb(self, seg_reader, reg_tracker, node):
        ins = reg_tracker.ins

        base_addr = reg_tracker.base_addr
        addr_offset = reg_tracker.offset
        addr = addr_offset + base_addr
        cur_node = node
        find_range = reg_tracker.is_range
        if reg_tracker.is_find:

            is_add = False
            bss = seg_reader.get_bss()
            for i in bss:
                addr_lowerer = i[2]
                addr_upper = i[3]
                if addr_lowerer <= addr < addr_upper:
                    if find_range:
                        j = addr_lowerer
                        while j < addr_upper:
                            mb = MemoryBlock(ins, j)
                            node.add_data_mbs(mb)
                            node.add_data_reference(ins, mb.memory_block_val)
                            is_add = True
                    else:
                        mb = MemoryBlock(ins, addr_lowerer)
                        node.add_data_mbs(mb)
                        node.add_data_reference(ins, mb.memory_block_val)
                        is_add = True

                    break

            data = seg_reader.get_data()
            for i in data:
                addr_lowerer = i[2]
                addr_upper = i[3]
                if addr_lowerer <= addr < addr_upper:
                    if find_range:
                        j = addr_lowerer
                        while j < addr_upper:
                            mb = MemoryBlock(ins, j)
                            node.add_data_mbs(mb)
                            node.add_data_reference(ins, mb.memory_block_val)
                            is_add = True
                    else:
                        mb = MemoryBlock(ins, addr_lowerer)
                        node.add_data_mbs(mb)
                        node.add_data_reference(ins, mb.memory_block_val)
                        is_add = True

                    break
            if not is_add:
                mb = MemoryBlock(ins, 0)
                node.add_data_mbs(mb)
                node.add_data_reference(ins, 0)

        else:

            mb = MemoryBlock(ins, 0)
            node.add_data_mbs(mb)
            node.add_data_reference(ins, 0)
            pass
