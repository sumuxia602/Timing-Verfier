import re

class SegmentReader:

    def __init__(self, fpath) -> None:
        self.__fpath = fpath
        with open(self.__fpath, 'r', encoding='utf-8') as fp:
            self.content = fp.read()

    def get_bss(self):
        restr = r'Disassembly of section \.bss:(.*?)(?=Disassembly of section)'
        matcher = re.search(restr, self.content, re.DOTALL)
        if not matcher:
            raise RuntimeError("SegmentReader get_bss() no match found.")
        matches = re.findall(r'^([0-9a-fA-F]+)\s+<(.+)>:$', matcher.group(1), re.MULTILINE)

        """
        rlt is a list with each element a 4-long list.
        [address_str, name, address_begin_int, addreess_stop_int]
        """
        rlt = [list(match) for match in matches]
        for i in range(len(rlt) - 1):
            rlt[i].append(int(rlt[i][0], 16))
            rlt[i].append(int(rlt[i + 1][0], 16))
        else:
            rlt[-1].append(tmp := int(rlt[-1][0], 16))
            rlt[-1].append(tmp + 4)

        return rlt

    def get_data(self):
        restr = r'Disassembly of section \.data:(.*?)(?=Disassembly of section .bss:)'
        matcher = re.search(restr, self.content, re.DOTALL)
        if not matcher:
            raise RuntimeError("SegmentReader get_data() no match found.")
        matches = re.findall(r'^([0-9a-fA-F]+)\s+<(.+)>:$', matcher.group(1), re.MULTILINE)
        
        """
        rlt is a list with each element a 4-long list.
        [address_str, name, address_begin_int, addreess_stop_int]
        """
        rlt = [[match[0], match[1].strip()] for match in matches]
        
        for i in range(len(rlt) - 1):
            rlt[i].append(int(rlt[i][0], 16))
            rlt[i].append(int(rlt[i+1][0], 16))
        else:
            rlt[-1].append(tmp := int(rlt[-1][0], 16))
            rlt[-1].append(tmp + 4)

        return rlt
        
