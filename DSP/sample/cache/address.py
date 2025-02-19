from sample.isa.stream_proc import ASMFileReader
from sample.isa.operand_syntax import OperandTyEnum
from sample.frontend.cfg import Prog
from sample.isa.isa_syntax import Instruction, RegModificationEnum
from sample.cache.cache_config import CacheConfig
from sample.cache.cache_cfg import CacheCFG
from typing import Optional, List, Dict, Hashable
from sample.isa.isa_type import InstType
from sample.cache.memory_block import MemoryBlock, MemoryBlockWithScope, ScopeTy
from sample.cache.constants import MemoryModel
from z3 import z3, z3util
from typing import Set
import re
import warnings

Implemented_inst = {
    "ADD",
    "ADDAW",
    "ADDAD",
    "ADDK",
    "SUB",
    "MV",
    "MVKH",
    "MPY32",
    "SHL",
    "SHR",
    "MVK",
    "LDNW", "LDDW", "LDNDW", "LDW", "LDB", "LDBU", "LDH", "LDHU",
    "STH", "STB", "STW", "STNDW", "STDW", "STNW"
}


def Reg(reg):
    return z3.BitVec(reg, 32)


def RegVal(reg_value):
    return z3.BitVecVal(reg_value, 32)


def inst_semantics(inst: Instruction):
    # print(inst)
    if inst.name == "ADD":
        l_op = inst.operands[0].imm if inst.operands[0].ty == OperandTyEnum.Immediate \
            else Reg(inst.operands[0].reg)
        r_op = inst.operands[1].imm if inst.operands[1].ty == OperandTyEnum.Immediate \
            else Reg(inst.operands[1].reg)
        return l_op + r_op

    elif inst.name == "ADDK":
        l_op = RegVal(inst.operands[0].imm)
        r_op = Reg(inst.operands[1].reg)
        return l_op + r_op

    elif inst.name == "ADDAW":
        l_op = inst.operands[0].imm if inst.operands[0].ty == OperandTyEnum.Immediate \
            else Reg(inst.operands[0].reg)
        r_op = inst.operands[1].imm if inst.operands[1].ty == OperandTyEnum.Immediate \
            else Reg(inst.operands[1].reg)
        return l_op + r_op * 4
        
    elif inst.name == "ADDAD":
        l_op = inst.operands[0].imm if inst.operands[0].ty == OperandTyEnum.Immediate \
            else Reg(inst.operands[0].reg)
        r_op = inst.operands[1].imm if inst.operands[1].ty == OperandTyEnum.Immediate \
            else Reg(inst.operands[1].reg)
        return l_op + r_op * 8

    elif inst.name == "SUB":
        l_op = inst.operands[0].imm if inst.operands[0].ty == OperandTyEnum.Immediate \
            else Reg(inst.operands[0].reg)
        r_op = inst.operands[1].imm if inst.operands[1].ty == OperandTyEnum.Immediate \
            else Reg(inst.operands[1].reg)
        return l_op - r_op
        
    elif inst.name == "SHL":
        l_op = inst.operands[0].imm if inst.operands[0].ty == OperandTyEnum.Immediate \
            else Reg(inst.operands[0].reg)
        r_op = inst.operands[1].imm if inst.operands[1].ty == OperandTyEnum.Immediate \
            else Reg(inst.operands[1].reg)
        if inst.operands[1].ty != OperandTyEnum.Immediate:  # z3 doesnt support non-immediate exponent such as 2**B1
            return l_op * r_op
        return l_op * (2 ** r_op)
        
    elif inst.name == "MV":
        return Reg(inst.operands[0].reg)
        
    elif inst.name == "MVK":
        return RegVal(inst.operands[0].imm)
        
    elif inst.name == "MPY32":
        return Reg(inst.operands[0].reg) * Reg(inst.operands[1].reg)
        
    elif inst.is_load:
        return Reg(str(inst.operands[0]))
        
    else:
        return z3.BitVec(str(inst.operands[0]), 32)


def MVKH_handler(mvkh: Instruction, considered_inst: List[Instruction]):
    assert (mvkh.name == "MVKH")

    index = considered_inst.index(mvkh)

    while (considered_inst[index].is_ep_paralleled):
        index += 1

    for inst in considered_inst[index + 1:]:
        if inst.ty == InstType.FP_HEAD:
            continue
        if inst.name == "MVK" and inst.operands[-1].reg == mvkh.operands[-1].reg:
            value = inst.operands[0].imm & 0xffff | mvkh.operands[0].imm & 0xffff0000
            return z3.BitVecVal(value, 32)

    raise NotImplementedError(mvkh)


def get_regs_in_z3_expr(expr: z3.ArithRef):
    '''Extracting variables from a z3 expression'''
    regs = set()
    variables = z3util.get_vars(expr)

    for var in variables:
        if str(var).startswith('A') or str(var).startswith('B'):
            regs.add(str(var))

    return regs


def get_const_item(expr):
    expr = z3.simplify(expr)

    if z3util.is_expr_val(expr):
        return expr.as_signed_long()

    for item in expr.children():
        if z3util.is_expr_val(item):
            return item.as_signed_long()


def addr_mb_map(start_addr: int, b_size: int, cache_config: CacheConfig) -> Set[MemoryBlock]:
    '''Map address to MemoryBlock'''
    blocks: List[MemoryBlock] = list()
    if not b_size:
        addr = start_addr >> cache_config.line_bitlen
        blocks.append(MemoryBlock(tag=addr >> cache_config.set_bitlen,
                                  set_index=addr & ((1 << cache_config.set_bitlen) - 1)))
        return set(blocks)
        
    s_cache_addr = start_addr >> cache_config.line_bitlen
    e_cache_addr = (start_addr + b_size - 1) >> cache_config.line_bitlen
    for addr in range(s_cache_addr, e_cache_addr + 1):
        set_index = addr & ((1 << cache_config.set_bitlen) - 1)
        tag = addr >> cache_config.set_bitlen
        blocks.append(MemoryBlock(tag=tag, set_index=set_index))
        
    return set(blocks)


def get_most_common_prefix(lists):
    '''Get the common part of paths'''
    common_prefix = []

    for _, elements in enumerate(zip(*lists)):
        if len(set(elements)) == 1:
            common_prefix.append(elements[0])
        else:
            break

    modified_lists = list(set(tuple(sublist) for sublist in lists))

    return common_prefix, list(modified_lists)


def gen_addr(inst: Instruction):
    if not inst.is_memory_access:
        raise TypeError("Only memory access instruction supports address generation")
    data_refer = inst.inda_gen_operand
    if data_refer.inda_pre in ('+', '++') or (data_refer.inda_pre is None and data_refer.inda_post is None):
        if data_refer.inda_is_offset_reg:
            return z3.simplify(
                Reg(data_refer.inda_base_reg) + Reg(data_refer.inda_offset) * (2 ** inst.inda_left_shift))
        else:
            return z3.simplify(Reg(data_refer.inda_base_reg) + data_refer.inda_offset * (2 ** inst.inda_left_shift))
    elif data_refer.inda_pre in ('-', '--'):
        if data_refer.inda_is_offset_reg:
            return z3.simplify(
                Reg(data_refer.inda_base_reg) - Reg(data_refer.inda_offset) * (2 ** inst.inda_left_shift))
        else:
            return z3.simplify(Reg(data_refer.inda_base_reg) - data_refer.inda_offset * (2 ** inst.inda_left_shift))
    elif data_refer.inda_post in ('++', '--'):
        return z3.simplify(Reg(data_refer.inda_base_reg))
    else:
        raise RuntimeError("Unknown address generation {}".format(inst))


class Address_analyser():

    def __init__(self, file: str, slist: str, prog: Prog, cache_config: CacheConfig,
                 cache_cfg: CacheCFG, memory_model: MemoryModel):
        prefix = file.split('.')[0]
        reader = ASMFileReader(file)
        self.__section_table: Dict[str, Section_info] = parse_section_table('%s.dline' % prefix)
        self.instructions = [Instruction(inst) for inst in reader.instructions]
        self.__prog = prog
        self.__cache_cfg = cache_cfg
        self.__cache_config = cache_config
        self.__slist_dir = slist
        self.__symbol_list = SymbolList(self.__slist_dir)
        self.__memory_model = memory_model
        if memory_model == MemoryModel.SMALL_MEMORY_MODEL:
            self.__base_stack_pointer, self.__base_global_pointer = self.init_pointer()

    def init_pointer(self):
        init_function = self.__prog.get_proc("_c_int00")

        for inst in self.instructions:
            if inst.address == init_function.start_addr.to_dec():
                inst_index = self.instructions.index(inst)

        '''generate stack pointer'''
        # base_stack_pointer = self.instructions[inst_index].operands[0].imm & 0xffff | \
        #                 self.instructions[inst_index + 1].operands[0].imm & 0xffff0000
        # base_stack_pointer &= self.instructions[inst_index + 2].operands[0].imm

        base_stack_pointer = self.__section_table["stack"].load_addr

        '''generate global pointer'''
        base_global_pointer = self.instructions[inst_index + 3].operands[0].imm & 0xffff | \
                              self.instructions[inst_index + 4].operands[0].imm & 0xffff0000

        return base_stack_pointer, base_global_pointer

    def get_expand_regs(self, expr: z3.ArithRef):

        regs = get_regs_in_z3_expr(expr)

        # No expansion for global pointer(based on memory model) and stack pointer
        if self.__memory_model == MemoryModel.SMALL_MEMORY_MODEL:
            regs.discard("B14")
        regs.discard("B15")

        return regs

    def expansion(self, inst: Instruction, considered_insts: List[Instruction],
                  linear_expression: Optional[z3.ArithRef] = None):
        '''
        There are three types of expressions: constants, registers, and indirect address; 
          indirect address is not extended for now
        '''
        debug = True
        if linear_expression is None:
            ''' Generate address'''
            linear_expression = gen_addr(inst)

        if debug:
            print("Starting expand (%s)" % inst)
            # print("    considered insts")
            # for inst in considered_insts:
            #     print("        ",inst)
            print("    Data reference = %s" % (linear_expression))

        skip_remaining = 0

        for index, update_inst in enumerate(considered_insts):
            target_registers = self.get_expand_regs(linear_expression)
            if not target_registers:
                break

            if skip_remaining > 0:  # ignore the instructions in the same execute packet
                skip_remaining -= 1
                continue

                # TODO Handle RegisterPair and RegisterQuadruplet
            if (update_inst.is_load and update_inst.operands[-1].ty in (
            OperandTyEnum.RegisterPair, OperandTyEnum.RegisterQuadruplet) \
                and set(update_inst.operands[-1].reg_pair).intersection(target_registers)) \
                    or (update_inst.is_store and update_inst.operands[0].ty in (
            OperandTyEnum.RegisterPair, OperandTyEnum.RegisterQuadruplet) \
                        and set(update_inst.operands[0].reg_pair).intersection(target_registers)):
                break

            if update_inst.is_memory_access and \
                    not inst.base_reg_modification == RegModificationEnum.NoMod and \
                    update_inst.inda_gen_operand.inda_base_reg in target_registers:
                indir_addr = update_inst.inda_gen_operand
                if indir_addr.inda_post == "++" or indir_addr.inda_pre == "++":
                    if update_inst.condition:
                        break
                    if indir_addr.inda_is_offset_imm:
                        update_info = Reg(indir_addr.inda_base_reg) + \
                                      indir_addr.inda_offset * (2 ** update_inst.inda_left_shift)
                    else:
                        update_info = Reg(indir_addr.inda_base_reg) + \
                                      Reg(indir_addr.inda_offset) * (2 ** update_inst.inda_left_shift)
                    linear_expression = z3.substitute(linear_expression, (Reg(indir_addr.inda_base_reg), update_info))
                    if debug:
                        print("                   = %s      # expand  %s by (%s)" %
                              (linear_expression, indir_addr.inda_base_reg, update_inst))

            if update_inst.operand_num and update_inst.operands[-1].ty == OperandTyEnum.Register:
                reg = update_inst.operands[-1].reg
                if reg not in target_registers:
                    continue
                # TODO handle conditional instruction
                if update_inst.condition:
                    break
                if update_inst.name in Implemented_inst:
                    update_info = inst_semantics(update_inst) if update_inst.name != "MVKH" \
                        else MVKH_handler(update_inst, considered_insts)
                    linear_expression = z3.substitute(linear_expression, (Reg(reg), update_info))
                    while (considered_insts[index].is_ep_paralleled and
                           considered_insts[index + 1].operands[-1].ty == OperandTyEnum.Register and
                           considered_insts[index + 1].operands[-1].reg == reg):
                        skip_remaining += 1
                        index += 1
                    if debug:
                        print(
                            "                   = %s      # expand  %s by (%s)" % (linear_expression, reg, update_inst))


                else:
                    warnings.warn("The instruction {} has not been implemented".format(update_inst.name))
                    break
                    # raise NotImplementedError(update_inst)

        if debug:
            print("expansion finished\n")
        return z3.simplify(linear_expression)

    def expand_success(self, expr: z3.ArithRef, expand_complete=False):
        """
        When expand_complete is activated, the expression will be expanded until 
        there is no reg in the expression except for "B15" and "B14"(based on memory model)
        """
        if expand_complete:
            if self.get_expand_regs(expr):
                return False
            else:
                return True
        else:
            vars = z3util.get_vars(expr)
            regs = get_regs_in_z3_expr(expr)
            const_term = get_const_item(expr)

            except_regs = {"B15", "B14"} if self.__memory_model == MemoryModel.SMALL_MEMORY_MODEL \
                else {"B15"}

            if except_regs.intersection(regs) \
                    or const_term and self.__symbol_list.get_array_size(const_term) \
                    or const_term and not vars:
                return True
            else:
                return False

    def get_mb_from_linear_expr(self, linear_expression):

        regs = get_regs_in_z3_expr(linear_expression)
        vars = z3util.get_vars(linear_expression)
        const_item = get_const_item(linear_expression)

        if not vars and const_item is not None:  # Only constant terms
            return addr_mb_map(const_item, 0, self.__cache_config)
        elif "B15" in regs:  # local variable, including local array
            return self.gen_mb_for_local_var()

        elif self.__memory_model == MemoryModel.SMALL_MEMORY_MODEL and regs == set(["B14"]):  #   global vraiable
            linear_expression = z3.substitute(linear_expression,
                                              (Reg("B14"), RegVal(self.__base_global_pointer)))
            linear_expression = z3.simplify(linear_expression)
            return addr_mb_map(linear_expression.as_signed_long(), 0, self.__cache_config)
        elif const_item is not None and self.__symbol_list.get_array_size(const_item):
            base_addr, array_size = self.__symbol_list.get_array_size(const_item)
            return addr_mb_map(base_addr, array_size, self.__cache_config)
        else:
            return set()

    def collect_path_insts(self, path: List[int]) -> List[Instruction]:
        insts = list()
        for node in path:
            insts.extend(reversed(self.__cache_cfg.get_node(node).insts))

        return insts

    def gen_mb_for_local_var(self):

        start_addr = self.__section_table["stack"].load_addr
        stack_size = self.__section_table["stack"].size

        return addr_mb_map(start_addr, stack_size, self.__cache_config)

    def do_address_analysis(self) -> Dict[Hashable, Dict[Instruction, Set[MemoryBlock]]]:

        data_memory_ref: Dict[Hashable, Dict[Instruction, Set(MemoryBlock)]] = dict()

        for node_id in self.__cache_cfg.node_idents:
            try:
                loops = self.__cache_cfg.get_node_map_loop(node_id)
            except:
                loops = list()
            # node in loop,considering all path in loop
            if loops:
                paths = self.__cache_cfg.get_all_paths_loop_node(node_id, loops[0].ident)
            # node not in loop,considering up to 'depth' pre node 
            else:
                paths = self.__cache_cfg.get_all_paths_node(node_id)
            if not paths:
                warnings.warn("The path corresponding to the node{} in the loop{} not found \
                                Consider loop{} has more than one tail ".format(node_id, loops[0].ident,
                                                                                loops[0].ident))
                paths = [[node_id, ]]
            current_node_map: Dict[Instruction, Set[MemoryBlock]] = dict()
            for inst in self.__cache_cfg.get_node(node_id).insts:
                if inst.is_memory_access:
                    common_path, _ = get_most_common_prefix(paths)
                    insts = self.collect_path_insts(common_path)
                    expr = self.expansion(inst, get_considered_insts(insts, inst))
                    blocks: Set[MemoryBlock] = set()
                    if self.expand_success(expr):
                        blocks = self.get_mb_from_linear_expr(expr)
                    else:
                        expr_list = set()
                        for path in paths:
                            uknown_expr = False
                            insts = self.collect_path_insts(path)
                            expr = self.expansion(inst, get_considered_insts(insts, inst))
                            if not self.get_mb_from_linear_expr(expr):
                                uknown_expr = True
                                break
                            expr_list.add(expr)

                        if uknown_expr:
                            blocks = set()
                        else:
                            for _expr in list(expr_list):
                                blocks = blocks.union(self.get_mb_from_linear_expr(_expr))

                    current_node_map[inst] = blocks

            data_memory_ref[node_id] = current_node_map

        return data_memory_ref

    @property
    def base_stack_pointer(self):
        return "0x%08x" % (self.__base_stack_pointer)

    @property
    def base_global_pointer(self):
        return "0x%08x" % (self.__base_global_pointer)


class Section_info:
    def __init__(self, section_id, name, load_addr, run_addr, size, align, alloc):
        self.section_id: int = section_id
        self.name: str = name
        self.load_addr: int = load_addr
        self.run_addr: int = run_addr
        self.size: int = size
        self.align: int = align
        self.alloc: bool = alloc


def parse_section_table(filename):
    section_table = {}
    with open(filename, 'r') as file:
        lines = file.readlines()
        start_index = None
        for i, line in enumerate(lines):
            if "Section Information" in line:
                start_index = i + 5  # Start of the table, add 5 to skip the header 
                break
        if start_index is not None:
            table_lines = lines[start_index:]
            for line in table_lines:
                match = re.match(
                    r'\s+(\d+)\s+\.(\S+)\s+(0x[0-9a-fA-F]+)\s+(0x[0-9a-fA-F]+)\s+(0x[0-9a-fA-F]+)\s+(\d+)\s+(N|Y)',
                    line)
                if match:
                    section_id = int(match.group(1))
                    name = match.group(2)
                    load_addr = int(match.group(3), 16)
                    run_addr = int(match.group(4), 16)
                    size = int(match.group(5), 16)
                    align = int(match.group(6))
                    alloc = True if (match.group(7)) == "Y" else False
                    section = Section_info(section_id, name, load_addr, run_addr, size, align, alloc)
                    section_table[name] = section
                    continue
                if line == "\n":
                    break  # Stop parsing if encountering an empty line
    return section_table


class Symbol:
    def __init__(self, index, value, size, bind, type, vis, shndx, name):
        self.index = index
        self.value = value
        self.size = size
        self.bind = bind
        self.type = type
        self.vis = vis
        self.shndx = shndx
        self.name = name

    def __str__(self):
        return f"Symbol(index={self.index}, value={self.value}, size={self.size}, bind={self.bind},\
                 type={self.type}, vis={self.vis}, shndx={self.shndx}, name={self.name})"


class SymbolList:
    def __init__(self, file_path):
        self.__symbols: List[Symbol] = self.parse_table(file_path)
        self.__search_list: List[Symbol] = [symbol for symbol in self.__symbols if symbol.size]

    def parse_table(self, file_path):
        symbols: List[Symbol] = list()
        with open(file_path, 'r') as file:
            for _ in range(3):
                next(file)  # Skip the header line
            for line in file:
                parts = line.strip().split('|')
                index = int(parts[0].strip()[1:-1])
                value = int(parts[1].strip(), 16)
                size = int(parts[2].strip())
                bind = parts[3].strip()
                type = parts[4].strip()
                vis = parts[5].strip()
                shndx = parts[6].strip()
                name = parts[7].strip()
                symbol = Symbol(index, value, size, bind, type, vis, shndx, name)
                symbols.append(symbol)
        return symbols

    def get_array_size(self, addr):
        """
        Returns the starting address of the array corresponding to addr and the size of the array
        """
        for symbol in self.__search_list:
            if symbol.size and symbol.value <= addr < (symbol.value + symbol.size):
                return symbol.value, symbol.size

    def __str__(self):
        symbol_str = ""
        for symbol in self.__symbols:
            symbol_str += str(symbol) + "\n"
        return symbol_str


def get_considered_insts(insts: tuple[Instruction, ...],
                         inst: Instruction) -> tuple[Instruction, ...]:
    index = insts.index(inst)
    while (insts[index].is_ep_paralleled):
        index += 1

    exec_inst = tuple(insts[index + 1:])
    return (exec_inst)
