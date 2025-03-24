import re
from typing import Dict, Tuple
from sample.frontend.isa import Addr


class DLineException(Exception):
    def __init__(self, err_msg: str) -> None:
        self.err_msg = err_msg

    def __str__(self) -> str:
        return self.err_msg


LINE_NUM_PROG_PAT = r"%s\n    Line Number Program at Offset [0-9a-fA-F]+\n    %s\n\n" % (r"-" * 38, r"-" * 38)

LINE_NUM_PROG_DELIMITERS = r"Header Information\n|Include Directories\n|Files\n|Line Number Program\n"


def parse_files_sect(files_sec: str) -> Dict[int, str]:

    lines = [s.strip() for s in files_sec.split("\n")]
    if len(lines) < 3:
        raise DLineException("Unexpected number of lines in Files section.")

    unknown_line = lines[2].split()
    if unknown_line[1] != "(unknown)":
        raise DLineException("Unexpected content.")

    if len(lines) == 3:
        return dict()

    d = dict()
    for line in lines[3:]:
        cols = line.split()
        d[int(cols[0])] = cols[1]
    return d


def parse_line_num_prog(lnp_sec: str, file_map: Dict[int, str]) -> Dict[str, Dict[int, Tuple[Addr, ...]]]:
    """ Parsing the Line Number Program section. """
    lines = [s.strip() for s in lnp_sec.split("\n")]
    d: Dict[str, Dict[int, Tuple[Addr, ...]]] = dict()
    if len(lines) <= 2:
        return d

    for row in lines[2:]:
        __addr, __file_name, __line_num, *others = row.split()
        addr = Addr(__addr)
        file_name = file_map[int(__file_name)]
        line_num = int(__line_num)

        if file_name not in d:
            d[file_name] = {line_num: (addr,)}
        elif line_num not in d[file_name]:
            d[file_name][line_num] = (addr,)
        else:
            d[file_name][line_num] += (addr,)

    return d


class LNProg:
    """ Representaion of each line number program in .debug_line. """

    def __init__(self, ln_prog_s: str) -> None:
        self.__ln_prog_s: str = ln_prog_s
        sections = [s.strip() for s in
                    re.compile(LINE_NUM_PROG_DELIMITERS).split(self.__ln_prog_s)[1:]]
        assert len(sections) == 4, ln_prog_s
        _, _, self.__files, self.__line_num_prog = sections

        self.src_files: Dict[int, str] = parse_files_sect(self.__files)
        self.src_map: Dict[str, Dict[int, Tuple[Addr, ...]]] \
            = parse_line_num_prog(self.__line_num_prog, self.src_files)

    def __str__(self) -> str:
        return self.__ln_prog_s


class DLine:
    """ Structuring the .debug_line section of DWARF format information. """

    def __init__(self, dline_file_name: str) -> None:
        self.dline_file = dline_file_name

        with open(self.dline_file, mode="r", encoding='UTF-8') as f:
            content = re.compile(r'DWARF Line Number Information in Section [1-9]+ \(".debug_line"\)').split(f.read())[1]

        self.dline_info: Dict[str, Dict[int, Tuple[Addr, ...]]] = dict()
        lnps = []
        for s in re.compile(LINE_NUM_PROG_PAT).split(content)[1:]:
            lnp = LNProg(s)
            lnps.append(lnp)
            for src_file_name, rel in lnp.src_map.items():
                if src_file_name not in self.dline_info:
                    self.dline_info[src_file_name] = rel
                else:
                    for line_num, addrs in rel.items():
                        if line_num not in self.dline_info[src_file_name]:
                            self.dline_info[src_file_name][line_num] = addrs
                        else:
                            self.dline_info[src_file_name][line_num] += addrs

        self.lnps = tuple(lnps)

    def __str__(self) -> str:
        return ("\n%s\n" % "#" * 38).join(str(lnp) for lnp in self.lnps)

    def __getitem__(self, src_name: str) -> Dict[int, Tuple[Addr, ...]]:
        return self.dline_info[src_name]
