import os.path
import re
import warnings
from enum import Enum, auto
from typing import Tuple, Optional


class StatementType(Enum):
    Instruction = auto()
    InlineData = auto()
    Symbol = auto()
    Section = auto()


class LexicalAutomation:

    instruction_pat = r"^[\s]*([0-9a-f]{8})[\s]+((?:[0-9a-f]{8})|(?:[0-9a-f]{4}))[\s]+" \
                      r"(\|\|)?[\s]*(\^)?[\s]*(?:\[[\s]?(\!?[AB]{1}[012]{1})?\])?[\s]+" \
                      r"((?:[A-Z0-9]{1,10})|(?:\.fphead))(?:\.([LSMD]{1}[12]{1}X?(?:T[12]{1})?))?[\s]+(.+\S)?[\s]*$"
    inline_data_pat = r"^[\s]*([0-9a-f]+)[\s]+([0-9a-f]+)[\s]+(\|\|)?[\s]+(?:\.((?:u?int)|(?:u?long)|(?:u?word)))[\s]+(.+\S)[\s]*$"
    symbol_pat = r"^\s*([0-9a-f]{8})[\s]+(.+):\s*$"
    section_pat = r"^(.+)[\s]+Section[\s]+(\..+)[\s]+\((.+)[\s]+Endian\)\,[\s]+0x([0-9a-fA-F]+)[\s]+bytes[\s]+at[\s]+0x([0-9a-fA-F]+)[\s]*$"


class ASMFileReader:

    __Strict = False
    __instruction_cpat = re.compile(LexicalAutomation.instruction_pat)
    __inline_data_cpat = re.compile(LexicalAutomation.inline_data_pat)
    __symbol_cpat = re.compile(LexicalAutomation.symbol_pat)
    __section_cpat = re.compile(LexicalAutomation.section_pat)

    def __init__(self, file_path: str):

        if not os.path.isfile(file_path):
            raise IOError("Cannot find file {}, abstract path {}.".format(file_path, os.path.abspath(file_path)))
        self.__fp = file_path

        self.__stat_tokens: Tuple[Tuple[StatementType, Tuple[Optional[str], ...]]] = tuple()
        with open(file_path, 'rt', encoding='utf-8') as f:
            tokens = list()
            for stat in f.readlines():
                if len(stat.strip()) == 0:
                    continue
                is_instruction = re.match(self.__instruction_cpat, stat)
                is_inline_data = re.match(self.__inline_data_cpat, stat)
                is_symbol = re.match(self.__symbol_cpat, stat)
                is_section = re.match(self.__section_cpat, stat)

                ty = [is_instruction is not None, is_inline_data is not None, is_symbol is not None, is_section is not None]
                if ty.count(True) > 1:
                    raise RuntimeError("More than one patterns match statement {}, matching list: {}.".format(stat.strip(), ty))
                if ty.count(True) == 0:
                    if self.__Strict:
                        raise RuntimeError("Cannot find one pattern that matches statement '{}'".format(stat.strip()))
                    else:
                        warnings.warn("Unknown statement: '{}'. Skipped.".format(stat.strip()))
                        continue

                if is_instruction:
                    tokens.append((StatementType.Instruction, is_instruction.groups()))
                elif is_inline_data:
                    tokens.append((StatementType.InlineData, is_inline_data.groups()))
                elif is_symbol:
                    tokens.append((StatementType.Symbol, is_symbol.groups()))
                elif is_section:
                    tokens.append((StatementType.Section, is_section.groups()))

            self.__stat_tokens = tuple(tokens)

        self.__symbol_tabl = None
        self.__section_tabl = None

    @property
    def file_path(self):
        return self.__fp

    @property
    def statements(self):
        return self.__stat_tokens

    def __build_section_table(self):
        """ """
        entries = list()
        stat_idx, stat_sum = 0, len(self.__stat_tokens)
        while stat_idx < stat_sum:
            ty, details = self.__stat_tokens[stat_idx]
            if ty == StatementType.Section:
                new_section, section_begin, section_len = details, stat_idx + 1, 0
                stat_idx += 1
                while stat_idx < stat_sum:
                    ty, _ = self.__stat_tokens[stat_idx]
                    if ty == StatementType.Section:
                        break
                    section_len += 1
                    stat_idx += 1
                if section_len == 0:
                    raise RuntimeError("The length of section {} is 0.".format(new_section))
                entries.append((new_section, section_begin, section_len))
            elif ty == StatementType.Symbol or ty == StatementType.Instruction or ty == StatementType.InlineData:
                raise RuntimeError("Invalid asm file for no section description lying before symbol statement or instruction statement.")

        self.__section_tabl = tuple(entries)

    @property
    def section_table(self) -> Tuple[tuple, int, int]:
        if self.__section_tabl is None:
            self.__build_section_table()
        return self.__section_tabl

    def __build_symbol_table(self):
        """ """
        entries = list()
        stat_idx, stat_sum = 0, len(self.__stat_tokens)
        while stat_idx < stat_sum:
            ty, details = self.__stat_tokens[stat_idx]
            if ty == StatementType.Section:
                stat_idx += 1
            elif ty == StatementType.Symbol:
                paralleled_symbol = list()
                while stat_idx < stat_sum:
                    ty, details = self.__stat_tokens[stat_idx]
                    if ty == StatementType.Symbol:
                        paralleled_symbol.append(details)
                        stat_idx += 1
                    elif ty == StatementType.Instruction or ty == StatementType.Section or ty == StatementType.InlineData:
                        break
                symbol_begin, symbol_len = stat_idx, 0
                while stat_idx < stat_sum:
                    ty, _ = self.__stat_tokens[stat_idx]
                    if ty == StatementType.Symbol or ty == StatementType.Section:
                        break
                    symbol_len += 1
                    stat_idx += 1
                if symbol_len == 0:
                    raise RuntimeError("The length of section(s) {} is(are) 0.".format(paralleled_symbol))
                entries.extend([(s, symbol_begin, symbol_len) for s in paralleled_symbol])
            elif ty == StatementType.Instruction or ty == StatementType.InlineData:
                raise RuntimeError("Invalid asm file for no symbol definition lying before instruction statement.")

        self.__symbol_tabl = tuple(entries)

    @property
    def symbol_table(self) -> Tuple[tuple, int, int]:
        if self.__symbol_tabl is None:
            self.__build_symbol_table()
        return self.__symbol_tabl

    @property
    def instructions(self):
        return [o[1] for o in self.__stat_tokens if o[0] == StatementType.Instruction]

    @property
    def sections(self):
        return [o[1] for o in self.__stat_tokens if o[0] == StatementType.Section]

    @property
    def symbols(self):
        return [o[1] for o in self.__stat_tokens if o[0] == StatementType.Symbol]

    @property
    def inline_data(self):
        return [o[1] for o in self.__stat_tokens if o[0] == StatementType.InlineData]
