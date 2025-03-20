import argparse
import json
import os.path
import subprocess
import time
import traceback
from sys import stdout
from typing import TextIO, List
import alive_progress
from sample.analyser import WCETAnalyser
from sample.cache.cache_config import CacheConfig, read_cache_config_from_json
from sample.frontend.isa import Addr
from sample.pipeline.tracer import PipelineTracer
from sample.cache.constants import MemoryModel
from copy import deepcopy


class ColorfulConsole:
    __current_task: str = ""
    __start_time: float = 0.

    @staticmethod
    def time_stamp():
        return time.strftime("%H:%M:%S", time.localtime(time.time()))

    @classmethod
    def log(cls, contents: str, des: TextIO = stdout, stamp: bool = False):
        if stamp:
            print("{}: {}".format(cls.time_stamp(), contents), file=des)
        else:
            print(contents, file=des)

    @classmethod
    def new_task(cls, contents: str, des: TextIO = stdout, stamp: bool = True):
        cls.__current_task = contents
        cls.__start_time = time.time()
        if stamp:
            print("\033[1;32;40m{}: {}\033[0m".format(cls.time_stamp(), contents), file=des)
        else:
            print("\033[1;32;40m{}\033[0m".format(contents), file=des)

    @classmethod
    def task_finish(cls, des: TextIO = stdout):
        print("\033[0;37;40m{} finish successfully in {:.3} seconds.\033[0m \n".format(cls.__current_task,
                                                                                       time.time() - cls.__start_time),
              file=des)

    @classmethod
    def info(cls, contents: str, des: TextIO = stdout, stamp: bool = False):
        if stamp:
            print("\033[0;36;40m{}: {}\033[0m".format(cls.time_stamp(), contents), file=des)
        else:
            print("\033[0;36;40m{}\033[0m".format(contents), file=des)

    @classmethod
    def error(cls, contents: str, des: TextIO = stdout):
        print("\033[1;31;40m\n{}\033[0m".format(contents), file=des)

    @classmethod
    def success(cls, contents: str, des: TextIO = stdout):
        print("\033[7;32;40m\n{}\n\033[0m".format(contents), file=des)

    @classmethod
    def fail(cls, contents: str, des: TextIO = stdout):
        print("\033[7;31;40m\n{}\n\033[0m".format(contents), file=des)


class CLI:

    @staticmethod
    def __abs_path(d: str):
        d_abs = None if d is None else os.path.abspath(d).replace("\\", "/")
        return d_abs

    @staticmethod
    def __dump(contents: str, base_dir: str, file_name: str, dump: bool = True) -> str:
        d = os.path.join(base_dir, file_name).replace("\\", "/")
        if dump:
            with open(d, 'w') as f:
                f.write(contents)
        return d

    def __init__(self, arg_space: argparse.Namespace):
        """"""
        self.__arg_space = arg_space
        self.__f = self.__abs_path(arg_space.file)
        self.__solver_loc = arg_space.solver
        self.__output_dir = self.__abs_path(arg_space.output_dir)
        if not os.path.isdir(self.__output_dir):
            os.mkdir(self.__output_dir)
            ColorfulConsole.log("Create output directory {} because it does not exist.".format(self.__output_dir))

        """ Output options """
        self.__cfg_json = True
        self.__tcfg_json = True
        self.__tcfg_graphviz: bool = self.__arg_space.graphviz
        self.__in_block_cycle = True
        self.__in_block_trace: bool = self.__arg_space.tracer
        self.__ilp_cons = True
        self.__ilp_solver = True

        """ WCET analyser initiation """
        ColorfulConsole.new_task("WCET analyser initialization")

        # Cache
        if arg_space.cache_config is None:
            ColorfulConsole.log("Use default cache config.")
            inst_cache_config = CacheConfig(capacity_size=32768, associativity=1, line_size=32, penalty=12.5)
            data_cache_config = CacheConfig(capacity_size=32768, associativity=2, line_size=64, penalty=12.5)
        else:
            ColorfulConsole.log("Read cache config from {}".format(arg_space.cache_config))
            inst_cache_config, data_cache_config = read_cache_config_from_json(arg_space.cache_config)

        _memory_model = MemoryModel.SMALL_MEMORY_MODEL if arg_space.memory_model == "small" \
            else MemoryModel.LARGE_MEMORY_MODEL

        # Analyser
        self.__analyser = WCETAnalyser(self.__f, inst_cache_config, data_cache_config,
                                       memory_model=_memory_model,
                                       jump_table_dir=arg_space.jump_table,
                                       dline_dir=arg_space.dline,
                                       cons_dir=arg_space.loop_cons,
                                       slist_dir=arg_space.slist,
                                       start_name=arg_space.start_symbol,
                                       finish_addr=Addr(
                                           arg_space.finish_address) if arg_space.finish_address is not None else None)

        ColorfulConsole.log("Analysis file: {}".format(self.__f))
        ColorfulConsole.log("Jump table: {}".format(arg_space.jump_table))
        ColorfulConsole.log("DLine table: {}".format(arg_space.dline))
        ColorfulConsole.log("symbol List: {}".format(arg_space.slist))
        ColorfulConsole.log("Loop constraint table: {}".format(arg_space.loop_cons))
        ColorfulConsole.log("Output directory: {}".format(self.__output_dir))
        ColorfulConsole.log("Inst cache: {}".format(inst_cache_config.dump()))
        ColorfulConsole.log("Data cache: {}".format(data_cache_config.dump()))
        ColorfulConsole.task_finish()

        self.__cons_dict = dict()
        self.__tracer_dict = dict()

    def __frontend(self):
        ColorfulConsole.new_task("Front-end analysis")

        self.__analyser.frontend_analysis()

        if self.__cfg_json:
            cfg: dict = self.__analyser.prog.dump_cfg_json(dump=False)
            dump_dir = self.__dump("", base_dir=self.__output_dir, file_name='cfg.json', dump=False)
            with open(dump_dir, "w") as f:
                json.dump(cfg, f, indent=4)
            ColorfulConsole.info("CFG json repr. dump to file {}".format(dump_dir))

        if self.__tcfg_json:
            tcfg: dict = self.__analyser.prog.dump_tcfg_json(dump=False)
            dump_dir = self.__dump("", base_dir=self.__output_dir, file_name='tcfg.json', dump=False)
            with open(dump_dir, "w") as f:
                json.dump(tcfg, f, indent=4)
            ColorfulConsole.info("T-CFG json repr. dump to file {}".format(dump_dir))

        if self.__tcfg_graphviz:
            self.__analyser.prog.dump_fig(to_svg=True, directory=self.__output_dir)
            ColorfulConsole.info("T-CFG graphviz graph dump to path {}".format(self.__output_dir))

        ColorfulConsole.task_finish()

    def __in_block(self):
        ColorfulConsole.new_task("In-block WCET analysis")

        ColorfulConsole.log("Do global cache analysis for instruction cache.")
        self.__analyser.inst_cache_analysis_global()

        ColorfulConsole.log("Do global cache analysis for data cache.")
        self.__analyser.data_cache_analysis_global()

        ColorfulConsole.log("Scan the program for SPLoops.")
        self.__analyser.sp_loop_analysis_global()

        ColorfulConsole.log("Do in-block analysis for each basic block.")
        with alive_progress.alive_bar(len(self.__analyser.blocks)) as bar:
            for idx in range(len(self.__analyser.blocks)):
                self.__analyser.move_block_cursor_to(idx)
                self.__analyser.abstract_interpretation_gen()
                self.__analyser.sp_loop_analysis_bb()
                self.__analyser.inst_cache_analysis_bb()
                self.__analyser.data_cache_analysis_bb()
                self.__analyser.in_block_wcet_analysis(log=self.__in_block_trace, status_log=False)

                # TODO: set the value as a copy, otherwise all values are pointers to the same list.
                # TODO: This list-based implementation has a huge danger.

                # self.__cons_dict[idx] = self.__analyser.cycle.copy()
                # print('In-block cycle: ', idx, self.__cons_dict[idx])  # TODO: remove it.
                self.__analyser.cycle_constrain[idx] = self.__analyser.cycle.copy()
                self.__tracer_dict[idx] = self.__analyser.behaviors.copy()
                bar()
        self.__analyser.inter_block_analysis()
        self.__cons_dict = self.__analyser.cycle_constrain.copy()
        if self.__in_block_trace:
            ColorfulConsole.log("Dump pipeline simulation traces.")
            base_dir = os.path.join(self.__output_dir, "traces").replace("\\", "/")
            if not os.path.isdir(base_dir):
                os.mkdir(base_dir)

            with alive_progress.alive_bar(len(self.__analyser.blocks)) as bar:
                for idx, tracer in self.__tracer_dict.items():
                    tracer: List[
                        PipelineTracer]  # TODO: two tracers, one for MUST-analysis, one for Persistent-analysis.
                    dump_dir = self.__dump("", base_dir=base_dir, file_name="{}.json".format(idx), dump=False)
                    tracer[1].dump(output_dir=dump_dir)
                    bar()
            ColorfulConsole.info("Traces of in-block pipeline simulation dump into path {}".format(base_dir))

        ColorfulConsole.task_finish()

    def __ilp_gen(self, solve: bool):
        ColorfulConsole.new_task("ILP constraint generation")
        self.__analyser.block_cycle_cons_gen(cons=self.__cons_dict)
        self.__analyser.ilp_gen()
        ilp_cons_dir = self.__dump(self.__analyser.ilp_str, base_dir=self.__output_dir, file_name="ilp.cons")
        ColorfulConsole.info("ILP constraints dump to file {}".format(ilp_cons_dir))
        ColorfulConsole.task_finish()

        if solve:
            ColorfulConsole.new_task("ILP solving")
            p_args = ['-stat', '-rxli', 'xli_CPLEX', ilp_cons_dir]
            with subprocess.Popen("{} {}".format(self.__solver_loc, " ".join(p_args)),
                                  stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=False, encoding="UTF-8") as p:
                out, error_msg = p.communicate()
            if len(error_msg):
                raise RuntimeError("Error when solving ILP: {}".format(error_msg))
            dump_dir = self.__dump(out, base_dir=self.__output_dir, file_name="ilp.solve")
            ColorfulConsole.info("ILP solve result dump to file {}".format(dump_dir))
            ColorfulConsole.task_finish()

    def run(self):
        if self.__arg_space.frontend:
            self.__frontend()
        elif self.__arg_space.no_ilp:
            self.__frontend()
            self.__in_block()
        else:
            self.__frontend()
            self.__in_block()
            self.__ilp_gen(solve=not self.__arg_space.no_solve)


if __name__ == '__main__':
    CLI_DESCRIPTION = "WCET analysis tool.\n\r" \
                      "[DEFAULT] The program accepts the asm file, cache configuration (optional), loop constraint file, jump table, symbol list" \
                      "dline file (if necessary) provided by the user, and performs WCET analysis. " \
                      "The solution results of ILP will be output to the OUTPUT_DIR path.\n\r" \
                      "[FRONTEND] Only the front-end analysis of the program is performed.\n\r" \
                      "[NO-ILP] Only in-block analysis is performed, and no ILP constraints are generated for the program.\n\r" \
                      "[NO-SOLVE] Generates an ILP constraint file but does not solve it."

    arg_parser = argparse.ArgumentParser(description=CLI_DESCRIPTION)
    arg_parser.add_argument('file', help="The asm file to be analyzed.")
    arg_parser.add_argument('-o', dest="output_dir", required=False,
                            default="output",
                            help="The folder path for output results. If the folder does not exist, the program will create it.")
    arg_parser.add_argument('--solver', required=False, default="lp_solve.exe",
                            help="The location of LPSolver. If LPSolver has been added to the system PATH, it does not need to be specified.")

    group = arg_parser.add_mutually_exclusive_group()
    group.add_argument("--frontend", action='store_true', help="Only front-end analysis.")
    group.add_argument("--no_ilp", action='store_true', help='Do not perform ILP constraint generation.')
    group.add_argument("--no_solve", action='store_true', help="Do not solve the ILP constrains.")

    arg_parser.add_argument('-j', '--jtable', dest="jump_table", required=False,
                            help="Specifies the jump table corresponding to the file.")
    arg_parser.add_argument('-d', '--dline', dest="dline", required=False,
                            help="Specifies the dline file corresponding to the file. This option is required when generating ILP constraints.")
    arg_parser.add_argument('-l', '--lpcons', dest="loop_cons", required=False,
                            help="Specifies the loop constraint file corresponding to the file. If the program contains loops, "
                                 "an unspecified constraint file will result in no solution for the ILP constraints.")
    arg_parser.add_argument('-s', '--slist', dest="slist", required=True,
                            help="Specifies the symbol list file corresponding to the file."
                            )
    arg_parser.add_argument('-c', '--cache', dest="cache_config", required=False,
                            help="Specifies the config of the data cache and instruction cache. "
                                 "If not specified, the default configuration will be used.")
    arg_parser.add_argument('-m', '--memmodel', dest="memory_model", choices=['small', 'large'], default='small',
                            help='Specifies the Memory Model,small for SMALL MEMORY MODEL and large for LARGE MEMORY MODEL')

    arg_parser.add_argument('--start_symbol', dest='start_symbol', required=False, default='main', help='')  # TODO.
    arg_parser.add_argument('--finish_address', dest='finish_address', required=False, default=None, help='')  # TODO.

    arg_parser.add_argument("--graphviz", required=False, action='store_true',
                            help="Use graphviz to generate the control flow graph of TCFG.")
    arg_parser.add_argument("--tracer", required=False, action='store_true',
                            help="Record and output specific information of in-block analysis.")

    args = arg_parser.parse_args()

    try:
        cli = CLI(args)
        cli.run()
    except Exception as e:
        error_msg = traceback.format_exc()
        ColorfulConsole.error(error_msg)
        ColorfulConsole.fail("  WCET analysis failed.  ")
        exit(-1)
    else:
        ColorfulConsole.success("  WCET analysis success.  ")
