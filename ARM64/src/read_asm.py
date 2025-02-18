# -*- coding: utf-8 -*-
"""
@Time       : 2023/3/23 19:21
@Author     : Juxin Niu (juxin.niu@outlook.com)
@FileName   : read_asm.py
@Description: 
"""
import os.path
import re
from enum import Enum, auto
from typing import List

class StatementType(Enum):

    Instruction = auto()
    SubProcedure = auto()
    Other = auto()


class AsmFileReader:
    # Use to match instructions in asm file.
    restr_inst = r"^\s*([0-9a-fA-F]*):\s*([00-9a-fA-F]{8})\s*([A-Za-z0-9]+)(?:\.([A-Za-z0-9]+))?\s*(.*?)(?://.*)?$"
    re_inst = re.compile(restr_inst)

    # Use to match sub-procedure label in asm file.
    restr_subproc = r"^\s*([0-9a-fA-F]*)\s*<(.*?)>:\s*$"
    re_subproc = re.compile(restr_subproc)

    def __init__(self, file_path: str):
        self.__fpath = file_path
        self.__statements: List[str] = list()
        self.__parsed_statements: list = list()

        if not (os.path.isfile(self.__fpath)):
            raise FileNotFoundError("Unexpected file path {}.".format(self.__fpath))

        with open(self.__fpath, 'rt', encoding='utf-8') as fp:
            self.__statements = [s.strip() for s in fp.readlines() if len(s.strip()) != 0]
        
        for s in self.__statements:
            is_instruction = re.match(self.re_inst, s)
            is_subproc = re.match(self.re_subproc, s)
            if is_instruction:
                self.__parsed_statements.append((StatementType.Instruction, is_instruction.groups()))
            elif is_subproc:
                self.__parsed_statements.append((StatementType.SubProcedure, is_subproc.groups()))
            # 实验性，之前并未考虑到不只有ins和subpro两种情况，
            else:
                self.__parsed_statements.append((StatementType.Other, ""))


    @property
    def fpath(self):
        return self.__fpath

    @property
    def statements(self):
        return self.__statements
    
    @property
    def parsed_statements(self):
        return self.__parsed_statements
