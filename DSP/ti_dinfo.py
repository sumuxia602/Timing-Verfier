import argparse
import json
import os.path
import traceback
from typing import List

DW_BEGIN_FILE_FIELD = "DW_AT_TI_begin_file"
DW_BEGIN_LN_FIELD = "DW_AT_TI_begin_line"
DW_END_LN_FIELD = "DW_AT_TI_end_line"

DW_TAG_BOUNDARY = "DW_TAG_TI_reserved_2"
DW_TAG_LOW_PC_FIELD = "DW_AT_low_pc"
DW_TAG_HIGH_PC_FIELD = "DW_AT_high_pc"


def main_file(f_path) -> list:
    with open(f_path, 'r') as f:
        file_lines = f.readlines()

    rtn_list = list()

    total_ln, ln_idx = len(file_lines), 0
    while ln_idx < total_ln:
        tokens = file_lines[ln_idx].split()  # split the line into several tokens.

        """ Step 1, find Begin file field. """
        try:
            begin_file_field_pos = tokens.index(DW_BEGIN_FILE_FIELD)
        except ValueError:
            # Do not find DW_BEGIN_FILE_FIELD, goto next line.
            ln_idx += 1
            continue

        # A DW_BEGIN_FILE_FIELD found.

        """ Line number in .dinfo file and begin/src file """
        line_in_dinfo: int = ln_idx
        begin_file: str = tokens[begin_file_field_pos + 1]

        """ Begin line and end line in begin/src file """
        ln_idx += 1
        tokens_begin, tokens_end = file_lines[ln_idx].split(), file_lines[ln_idx + 1].split()
        try:
            begin_ln_field_pos, end_ln_field_pos = tokens_begin.index(DW_BEGIN_LN_FIELD), tokens_end.index(DW_END_LN_FIELD)
        except ValueError:
            continue
        ln_range: List[int, int] = [int(tokens_begin[begin_ln_field_pos + 1]), int(tokens_end[end_ln_field_pos + 1])]

        """ All tag pc ranges """
        ln_idx += 2
        tag_pc_range: List[List[int, int]] = []
        while True:
            tokens_pre = file_lines[ln_idx].split()
            tokens_low, tokens_high = file_lines[ln_idx + 1].split(), file_lines[ln_idx + 2].split()

            try:
                _ = tokens_pre.index(DW_TAG_BOUNDARY)
            except ValueError:
                # All tag pc ranges finished. break.
                break

            low_pos, high_pos = tokens_low.index(DW_TAG_LOW_PC_FIELD), tokens_high.index(DW_TAG_HIGH_PC_FIELD)
            pc_low, pc_high = int(tokens_low[low_pos + 1], 16), int(tokens_high[high_pos + 1], 16)
            tag_pc_range.append([pc_low, pc_high])
            ln_idx += 3

        loop_item = {'line_in_dinfo': line_in_dinfo, 'src_file': begin_file.replace('\\', '/'), 'line_range': ln_range, 'tag_pc_range': tag_pc_range}
        rtn_list.append(loop_item)

    return rtn_list


def main(arg):
    for f_path in arg.file:
        print(f_path)

        f_split = os.path.splitext(os.path.basename(f_path))
        f_name, f_suffix = "".join(f_split[: -1]), f_split[-1]
        f_dir = os.path.dirname(f_path)

        if f_suffix != ".dinfo":
            raise ValueError("Unhandled type {} of file {}.".format(f_suffix, f_path))

        loop_list = main_file(f_path)
        rlt = {"file": f_path.replace('\\', '/'), "loops": loop_list}

        output_name = "{}.loop".format(f_name)
        output_path = os.path.join(arg.output_path if arg.output_path is not None else f_dir, output_name)
        with open(output_path, 'w') as f:
            json.dump(rlt, f, indent=4)


if __name__ == '__main__':
    arg_parser = argparse.ArgumentParser(description=".dinfo file interpreter.")
    arg_parser.add_argument('file', nargs='+', help="The dinfo file to be analyzed.")
    arg_parser.add_argument('--walk', action='store_true', help='If walking through all files under dir.')
    arg_parser.add_argument('-o', dest="output_path", required=False,
                            default=None,
                            help="The folder path for output results. By default, it is kept in the same path as the file.")
    _args = arg_parser.parse_args()

    try:
        if _args.walk:
            all_files = [os.path.join(filepath, filename)
                         for dir_path in _args.file for filepath, _, filenames in os.walk(dir_path) for filename in filenames]
            all_files = [f for f in all_files if os.path.splitext(os.path.basename(f))[-1] == '.dinfo']
            _args.file = all_files
            
        main(_args)

    except Exception as _:
        print("\033[1;31;40m\n{}\033[0m".format(traceback.format_exc()))
