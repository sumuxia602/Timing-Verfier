import os
import warnings
import argparse
import json
import sys

from src.util import read_config, Logger
from core import end2end_run

warnings.filterwarnings('ignore', category=UserWarning)


def parse_args():
    parser = argparse.ArgumentParser()

    # args.tbpath
    parser.add_argument('-f', '--folder', dest='tbpath', required=True,
                        help='The folder where the testbench to be analyzed is located.')
    # args.verbose
    parser.add_argument('--verbose', type=int, choices=[0, 1, 2], default=1,
                        help='The level of detail in the output, default is 1.')
    # args.gen_procedure_cfg
    parser.add_argument('--gen_procedure_cfg', action='store_true',
                        help="Whether to gen procedure cfg. If not provided, the default is false.")
    # args.skip_user_plt
    parser.add_argument('--skip_user_plt', action='store_true',
                        help="Whether to skip the user's plt. If not provided, the default is false.")
    raw_command_line = ' '.join(sys.argv)
    args = parser.parse_args()
    return args, raw_command_line


if __name__ == "__main__":
    args, raw_command_line = parse_args()

    tb_config = read_config(args.tbpath, gen_procedure_cfg=args.gen_procedure_cfg, skip_user_plt=args.skip_user_plt)
    logger = Logger(verbose=args.verbose)

    # 调用TCFG的早期分析方法
    # end2end_run(
    #     config=tb_config,
    #     logger=logger
    # )

    # 使用CFG的更新方法
    end2end_run(
        config=tb_config,
        logger=logger,
        command=raw_command_line
    )
