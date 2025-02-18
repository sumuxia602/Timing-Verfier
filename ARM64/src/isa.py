
import re
from typing import Sequence
from src.isa_base import Address, InstructionType, AddrMode, InstNameTable, InstMatchPattern


class  LSTarget:
    def __init__(self,pm,target_name):
        self.re_hex_addr = re.compile(r"[0-9a-fA-F]{1,}")
        self.pm = pm
        if pm is None or pm == "":
            self.pm = "+"
        
        self.target_name = target_name
        self.base = 0
        self.offset_int = 0

        self.is_sp = False
        self.is_find = False
        self.is_base = False
        self.is_num = False

    def set_new_target(self,target_name):
        self.target_name = target_name

    def set_base(self,base):
        self.base = base

    def add_offset(self,offset):
        temp = 0
        if isinstance(offset, int):
            temp = offset
        else:
            is_hex_addr = re.match(self.re_hex_addr,offset)
            if is_hex_addr:
                temp = int(offset,16)

        self.offset_int += temp

    
    def set_is_sp(self):
        self.is_find = True
        self.is_sp = True

    # isfind只表示终止查找
    def set_is_find(self):
        self.is_find = True

    def set_is_num(self):
        self.is_num = True
        self.is_find = True
    
    def set_is_base(self):
        self.is_base = True
        self.is_num = True
        self.is_find = True


class Instruction:

    def __init__(self, expr: str, tokens: Sequence[str]):
        self.__expr = expr
        self.__tokens = tuple(tokens)
        # print(expr,tokens)
        self.__addr = Address(tokens[0])
        self.__opcode = tokens[1]
        self.__name, self.__sub_name = tokens[2], tokens[3]
        
        self.__operands = tokens[4]
        self.__type = InstructionType.Unknown

        self.__branch_identify()
        self.__load_store_identify()
        self.__adrp_identify()
        self.__mov_identity()
        self.__add_identity()

    def __str__(self):
        return self.__expr
    
    def __repr__(self):
        return self.__expr
    
    @property
    def tokens(self):
        return self.__tokens

    @property
    def addr(self):
        return self.__addr

    @property
    def opcode(self):
        return self.__opcode

    @property
    def name(self):
        return self.__name
    
    @property
    def sub_name(self):
        return self.__sub_name

    @property
    def operands(self):
        return self.__operands

    @property
    def inst_type(self):
        return self.__type
    
    def __branch_identify(self):
        self.__is_b = False
        self.__b_conditional = False
        self.__b_imm_target_label = None
        self.__b_imm_target_offset = None
        self.__b_imm_target_addr = None

        if self.__name in InstNameTable.Branch:
            self.__operands = [o.strip() for o in self.tokens[4].split(',')]
            self.__type = InstructionType.Branch
            self.__is_b = True
            if self.__name in ('cbnz', 'cbz') or self.__sub_name is not None:
                self.__b_conditional = True
            # TODO: Not all branch instructions is immediate-addressing.
            addr, label, offset = re.match(InstMatchPattern.branch_imm_target, 
                                           self.__operands[-1]).groups()
            self.__b_imm_target_addr = Address(addr)
            self.__b_imm_target_label, self.__b_imm_target_offset = label, offset

        # 用于识别是否跳到了malloc
        self.__is_b_malloc = False
        self.__is_b_mmap = False
        if self.b_imm_target_label =="malloc@plt":
            self.__is_b_malloc = True
        elif self.b_imm_target_label == "__wrap_malloc":
            self.__is_b_mmap = True
    
    @property
    def is_branch(self):
        return self.__is_b
    
    @property
    def b_imm_target_label(self):
        return self.__b_imm_target_label
    
    @property
    def is_b_malloc(self):
        return self.__is_b_malloc
    
    @property
    def is_b_mmap(self):
        return self.__is_b_mmap

    @property
    def branch_info(self):
        """ Return [bool] if is branch instruction, [bool] if is conditional,
        [None|str] immediate-addressing target label, [None|str] immediate-addressing target offset,
        [None|Address] immediate-addressing target address. """
        return (self.__is_b, self.__b_conditional,
                self.__b_imm_target_label, self.__b_imm_target_offset, self.__b_imm_target_addr)
    

    def __load_store_identify(self):
        self.__is_ls = False
        self.__is_nsp = False # 用于判断是否是sp寄存器
        self.__ls_handle = False
        self.is_data_group = False # 用于判断是否需要读入一个数组

        self.__ls_addr_mode = None
        self.__ls_data_width = 32

        # 这部分是给ls地址分析留的
        self.__ls_first_opperand = None # 第一个操作数，也就是实际上存入/读取的地方
        self.__ls_reg_target_list = list() # 所有的regtarget都存在list中，除非是sp
        self.__ls_addr_offset = 0 # 在第一遍指令对象化的时候会将基本的地址偏移算出来
        

        is_loadstore = self.__name in (InstNameTable.Load + InstNameTable.Store)
        if is_loadstore:

            # print("here",self,self.__name,self.__name in (InstNameTable.Load + InstNameTable.Store))
            self.__type = InstructionType.LoadStore
            self.__is_ls = True
            
            is_lsp = self.__name in (InstNameTable.LoadPair + InstNameTable.StorePair)
            if is_lsp:
                pass
            else:
                self.__ls_handle = True

                ls_op_slip = re.match(InstMatchPattern.ls_split, self.tokens[4])
                temp_op = ls_op_slip.groups()
                self.__ls_first_opperand = temp_op[0] # 第一个操作数，实际上存取的地方
                self.addrmode = temp_op[1] # 这里的表述有点问题，这边实际上是addr_mode的字段

                is_base = re.match(InstMatchPattern.ls_reg_ad, self.addrmode)
                is_bracket = re.match(InstMatchPattern.ls_bracket_op, self.addrmode)
                is_bracket_upgrade = re.match(InstMatchPattern.ls_bracket_update_op, self.addrmode)
                is_bracket_upgrade_aft = re.match(InstMatchPattern.ls_bracket_update_aft_op, self.addrmode)
                
                if is_base:
                    self.__ls_addr_mode = AddrMode.Base

                    temp = is_base.groups()
                    temp_target = LSTarget("+",temp[0])
                    self.__ls_reg_target_list.append(temp_target)

                    if temp_target.target_name == "sp":
                        self.__is_nsp = False
                    else:
                        self.__is_nsp = True
                
                elif is_bracket_upgrade_aft:
                    
                    is_immAft = re.match(InstMatchPattern.ls_aft_imm_off_ad, self.addrmode)
                    is_regAft = re.match(InstMatchPattern.ls_aft_reg_off_ad, self.addrmode)
                    is_regShiftAft = re.match(InstMatchPattern.ls_aft_reg_shift_off_ad, self.addrmode)
                    
                    if is_immAft:
                        self.__ls_addr_mode = AddrMode.ImmeAft

                        temp = is_immAft.groups()
                        target_reg = temp[0]
                        pm = temp[1]#正负号
                        strOffset = temp[2]

                        self.__immOffsetTypeProc(target_reg,pm,strOffset)
                    
                    elif is_regAft:
                        self.__ls_addr_mode = AddrMode.RegAft

                        temp = is_regAft.groups()
                        target_reg1 = temp[0]
                        target_reg2 = temp[2]
                        target_reg2_pm = temp[1]

                        self.__regOffsetPorc(target_reg1,target_reg2,target_reg2_pm)

                    
                    elif is_regShiftAft:
                        self.__ls_addr_mode = AddrMode.RegShiftAft

                        temp = is_regShiftAft.groups()
                        target_reg1 = temp[0]
                        target_reg2 = temp[2]
                        target_reg2_pm = temp[1]

                        self.__regOffsetPorc(target_reg1,target_reg2,target_reg2_pm)

                        
                
                elif is_bracket_upgrade:

                    is_immBef = re.match(InstMatchPattern.ls_bef_imm_off_ad, self.addrmode)
                    is_regBef = re.match(InstMatchPattern.ls_bef_reg_off_ad, self.addrmode)
                    is_regShiftBef = re.match(InstMatchPattern.ls_bef_reg_shift_off_ad, self.addrmode)

                    if is_immBef:
                        self.__ls_addr_mode = AddrMode.ImmBef

                        temp = is_immBef.groups()
                        target_reg = temp[0]
                        pm = temp[1]
                        strOffset = temp[2]

                        self.__immOffsetTypeProc(target_reg,pm,strOffset)

                    elif is_regBef:
                        self.__ls_addr_mode = AddrMode.RegBef

                        temp = is_regBef.groups()
                        target_reg1 = temp[0]
                        target_reg2 = temp[2]
                        target_reg2_pm = temp[1]

                        self.__regOffsetPorc(target_reg1,target_reg2,target_reg2_pm)

                    elif is_regShiftBef:
                        self.__ls_addr_mode = AddrMode.RegShiftBef

                        temp = is_regShiftBef.groups()
                        target_reg1 = temp[0]
                        target_reg2 = temp[2]
                        target_reg2_pm = temp[1]

                        self.__regOffsetPorc(target_reg1,target_reg2,target_reg2_pm)
                
                elif is_bracket:

                    is_immOffset = re.match(InstMatchPattern.ls_imm_off_ad,self.addrmode)
                    is_regOffset = re.match(InstMatchPattern.ls_reg_off_ad,self.addrmode)
                    is_regShift = re.match(InstMatchPattern.ls_reg_shift_off_ad,self.addrmode)

                    if is_immOffset:
                        self.__ls_addr_mode = AddrMode.ImmOffset

                        temp = is_immOffset.groups()
                        target_reg = temp[0]
                        pm = temp[1]
                        strOffset = temp[2]

                        self.__immOffsetTypeProc(target_reg,pm,strOffset)

                    elif is_regOffset:
                        self.__ls_addr_mode = AddrMode.RegOffset

                        temp = is_regOffset.groups()
                        target_reg1 = temp[0]
                        target_reg2 = temp[2]
                        target_reg2_pm = temp[1]

                        self.__regOffsetPorc(target_reg1,target_reg2,target_reg2_pm)

                    elif is_regShift:
                        self.__ls_addr_mode = AddrMode.RegShift

                        temp = is_regShift.groups()
                        target_reg1 = temp[0]
                        target_reg2 = temp[2]
                        target_reg2_pm = temp[1]

                        self.__regOffsetPorc(target_reg1,target_reg2,target_reg2_pm)
                  
    def __immOffsetTypeProc(self,reg_target,offset_pm,offset_str):
        temp_target = LSTarget("+",reg_target)
        self.__ls_reg_target_list.append(temp_target)

        if reg_target == "sp":
            self.__is_nsp = False
        else:
            self.__is_nsp = True

        pm = offset_pm
        strOffset = offset_str

        if pm == '':
            if strOffset[0:2] == "0x":
                self.__ls_addr_offset = int(strOffset,16)
            else:
                self.__ls_addr_offset = int(strOffset)
        else:
            if strOffset[0:2] == "0x":
                self.__ls_addr_offset = -int(strOffset,16)
            else:
                self.__ls_addr_offset = -int(strOffset)

        

    def __regOffsetPorc(self,reg_target1,reg_target2,reg_target2_pm):
        temp_target_1 = LSTarget("+",reg_target1)
        self.__ls_reg_target_list.append(temp_target_1)
        temp_target_2 = LSTarget(reg_target2_pm,reg_target2)
        self.__ls_reg_target_list.append(temp_target_2)

        if reg_target1 == "sp":
            self.__is_nsp = False
        else:
            self.__is_nsp = True
        if reg_target2 == "sp":
            self.__is_nsp = False
        else:
            self.__is_nsp = True


    def __regShiftPorc(self,reg_target1,reg_target2,reg_target2_pm):
        temp_target_1 = LSTarget("+",reg_target1)
        self.__ls_reg_target_list.append(temp_target_1)
        temp_target_2 = LSTarget(reg_target2_pm,reg_target2)
        self.__ls_reg_target_list.append(temp_target_2)

        if reg_target1 == "sp":
            self.__is_nsp = False
        else:
            self.__is_nsp = True
        if reg_target2 == "sp":
            self.__is_nsp = False
        else:
            self.__is_nsp = True

    @property
    def is_ls(self):
        return self.__is_ls
    
    @property
    def is_nsp(self):
        return self.__is_nsp

    @property
    def ls_handle(self):
        return self.__ls_handle  
    

    @property
    def ls_addr_mode(self):
        return self.__ls_addr_mode
    
    @property
    def ls_data_width(self):
        return self.__ls_data_width
    
    @property
    def ls_first_opperand(self):
        return self.__ls_first_opperand
    
    @property
    def ls_reg_target_list(self):
        return self.__ls_reg_target_list
    
    @property
    def ls_addr_offset(self):
        return self.__ls_addr_offset


    def __adrp_identify(self):

        self.__is_adrp = False
        self.__adrp_addr = None
        self.__adrp_label = None
        self.__adrp_first_opperand = None

        if self.__name == "adrp":
            self.__type = InstructionType.Adrp
            self.__is_adrp = True

            ls_op_slip = re.match(InstMatchPattern.ls_split, self.tokens[4])
            temp_op = ls_op_slip.groups()
            self.__adrp_first_opperand = temp_op[0]
            addr = temp_op[1]

            re_adrp_addr = re.match(InstMatchPattern.adrp_op, addr)
            temp = re_adrp_addr.groups()
            self.__adrp_addr = temp[0]
            self.__adrp_label = temp[1]
            
    @property
    def is_adrp(self):
        return self.__is_adrp
    
    @property
    def adrp_addr(self):
        return self.__adrp_addr
    
    @property
    def adrp_label(self):
        return self.__adrp_label
    
    @property
    def adrp_first_opperand(self):
        return self.__adrp_first_opperand

    def __mov_identity(self):

        self.__is_mov = False
        self.__mov_first_opperand = None
        self.__mov_target = None

        if self.__name in ('mov'):
            self.__type = InstructionType.Mov
            self.__is_mov = True

            temp = [o.strip() for o in self.tokens[4].split(',')]
            self.__mov_first_opperand = temp[0]
            self.__mov_target = temp[1]
    
    @property
    def is_mov(self):
        return self.__is_mov
    
    @property
    def mov_first_opperand(self):
        return self.__mov_first_opperand
    
    @property
    def mov_target(self):
        return self.__mov_target
    
    def __add_identity(self):
        self.__is_add = False
        self.__add_same = False
        self.__add_imm = False
        self.__add_1op = None
        self.__add_2op = None
        self.__add_3op = None

        is_add = self.__name in InstNameTable.AddSub

        if is_add:
            self.__type = InstructionType.Add
            self.__is_add = True

            temp = [o.strip() for o in self.tokens[4].split(',')]
            self.__add_1op = temp[0]
            self.__add_2op = temp[1]
            self.__add_3op = temp[2]

            if self.__add_1op == self.__add_2op:
                self.__add_same = True

            re_imm = re.match(InstMatchPattern.imm_offset, self.__add_3op)
            if re_imm:
                self.__add_imm = True
                temp = re_imm.groups()[0]
                if temp[0:2] == "0x":
                    self.__add_3op = int(temp,16)
                else:
                    self.__add_3op = int(temp)
    
    @property
    def is_add(self):
        return self.__is_add
    
    @property
    def add_same(self):
        return self.__add_same
    
    @property
    def add_imm(self):
        return self.__add_imm
    
    @property
    def add_1op(self):
        return self.__add_1op
    
    @property
    def add_2op(self):
        return self.__add_2op

    @property
    def add_3op(self):
        return self.__add_3op

