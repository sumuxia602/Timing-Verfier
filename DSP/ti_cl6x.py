"""Compiling and linking C file with cl6x."""
import subprocess
import os
from typing import List
import sys
import argparse

# header file path
include_path = "D:/ti/ccs613/ccsv6/tools/compiler/c6000_7.4.4/include"
# library path
lib_path = "D:/ti/ccs613/ccsv6/tools/compiler/c6000_7.4.4/lib"


class Cl6xException(Exception):
    def __init__(self, msg) -> None:
        self.msg = msg


def cl6x_compile(c_file_path: str) -> None:
    assert c_file_path.endswith(".c")
    args = [
        "-mv6600",
        "-i %s" % include_path,
        "--no_warnings",
        "-g",
        "--output_file=%s.obj" % c_file_path[:-2]
    ]
    with subprocess.Popen("cl6x %s %s" % (" ".join(args), c_file_path),
                          stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True) as p:
        _, err_msg = p.communicate()
        if err_msg != b'':
            raise Cl6xException(err_msg.decode("UTF-8"))


def cl6x_link(obj_path: str) -> None:
    args = [
        "-mv6600",  # ISA
        "-g",  # debug information
        "-k",  # keeping assembly file
        "-z",  # enables linking
        "-i %s" % lib_path,
        "-i %s" % include_path,
        "--reread_libs",  # Forces rereading of libraries, which resolves back references.
        "--rom_model",
        "--output_file=%s.out" % obj_path[:-4]
    ]

    with subprocess.Popen("cl6x %s %s" % (" ".join(args), obj_path),
                          stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True) as p:
        _, err_msg = p.communicate()
        if err_msg != b"":
            raise Cl6xException(err_msg.decode("UTF-8"))


def dis6x(file_name: str) -> None:
    """Disassemble a.out and write it to file_name.asm"""
    assert file_name.endswith(".out")
    with subprocess.Popen("dis6x -d %s %s.asm" % (file_name, file_name[:-4]),
                          stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True) as p:
        _, err_msg = p.communicate()
        if err_msg != b"":
            raise Cl6xException(err_msg.decode("UTF-8"))


def compile_and_link(src: str) -> str:
    assert src.endswith(".c"), src
    cl6x_compile(src)
    obj_path = "%s.obj" % src[:-2]
    cl6x_link(obj_path)
    os.remove(obj_path)
    return "%s.out" % src[:-2]


def ofd6x(out_path: str, dump_what: str) -> None:
    """Dump the content of section .debug_line from the binary file."""
    assert out_path.endswith(".out")
    args = [
        '-g',
        '--dwarf_display=none,%s' % dump_what,
        '--output=%s.%s' % (out_path[:-4], dump_what)
    ]
    with subprocess.Popen("ofd6x %s %s" % (" ".join(args), out_path),
                          stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True) as p:
        _, err_msg = p.communicate()
        if err_msg != b"":
            raise Cl6xException(err_msg.decode("UTF-8"))


def cl_dis6x(src: str, dump_file: bool = True, dump_dwarf=True) -> List[str]:
    """Given a .c file, compiling and disassembling it."""
    out_path = compile_and_link(src)
    args = [
        "-d",  # do not display DATA section
        out_path,  # output path
        "-L",
    ]
    if dump_file:
        args.append("%s.asm" % src[:-2])

    with subprocess.Popen("dis6x %s" % " ".join(args),
                          stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True) as p:
        out, err_msg = p.communicate()
        if err_msg != b"":
            raise Cl6xException(err_msg.decode("UTF-8"))
        if dump_dwarf:
            ofd6x(out_path, dump_what="dline")
        doutput = out.decode("UTF-8")
        return doutput.split("\r\n")


def nm6x(out_path: str, dump_what: str) -> None:
    """ dump the symbol list from binary file. """
    assert out_path.endswith(".out")
    args = [
        '--output=%s.%s' % (out_path[:-4], dump_what),
        "-l",
    ]
    with subprocess.Popen("nm6x %s %s" % (" ".join(args), out_path),
                          stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True) as p:
        _, err_msg = p.communicate()
        if err_msg != b"":
            raise Cl6xException(err_msg.decode("UTF-8"))


def get_machine_code(c_file_path) -> None:
    """Compiling and linking a .c file and disassembling the machine code.
    The disassembly would be stored in `a.asm`.
    """
    file_name = c_file_path.split("/")[-1][:-2]
    cl6x_compile(c_file_path)
    cl6x_link("./%s.obj" % file_name)
    dis6x(file_name)
    os.remove("./%s.obj" % file_name)  # delete object file
    os.remove("./a.out")  # delete binary file


SCRIPT_DESCRIPTION = "Interface of C6000 compiler (ti-cgt-c6000_8.1.0)."


def main():
    argparser = argparse.ArgumentParser(
        description=SCRIPT_DESCRIPTION,
        usage="python %(prog)s [options] <file>"
    )
    argparser.add_argument('file',
                           nargs='?', default=None,
                           help='file to process')
    argparser.add_argument('--dis-out',
                           action='store_true', dest='dis_out',
                           help='dump the machine code from binary file')
    argparser.add_argument('-o', action='store_true', dest='compile',
                           help='compiling')
    argparser.add_argument('--dis-src',
                           action='store_true', dest='dis_src',
                           help='dump the machine code from source code')
    argparser.add_argument('--dump-dline',
                           action='store_true', dest='dump_dline',
                           help='dump the .dline section from DWARF format debug information.')
    argparser.add_argument('--dump-slist',
                           action='store_true', dest='dump_slist',
                           help='dump the symbol list from binary file.')

    args = argparser.parse_args()
    if not args.file:
        argparser.print_help()
        sys.exit(0)

    if args.dis_out:
        dis6x(args.file)
    if args.compile:
        compile_and_link(args.file)
    if args.dis_src:
        cl_dis6x(args.file, dump_file=True)
    if args.dump_dline:
        ofd6x(args.file, 'dline')
    if args.dump_slist:
        nm6x(args.file, 'slist')


if __name__ == "__main__":
    main()
