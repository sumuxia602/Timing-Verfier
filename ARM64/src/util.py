import os
import sys
import datetime

import json
import dataclasses
from typing import Tuple, Optional, List


@dataclasses.dataclass
class TestbenchConfig:
    benchmark_name: str = ""
    asm_path: str = ""
    asm_d_path: str = ""
    gen_procedure_cfg: bool = False
    procedure_cfg: list = None
    skip_user_plt: bool = False
    user_plt: list = None
    target_range: Optional[Tuple[int, int]] = None
    execution_intervals: Optional[List[dict[str, int]]] = None


def read_config(tbf, **kwargs):

    config_path = os.path.join(tbf, 'config.json')
    with open(config_path, 'r') as f:
        data = json.load(f)

    instruction_data_path = os.path.join(tbf, 'instruction_data.json')
    if not os.path.exists(instruction_data_path):
        target_range = None
        execution_intervals = None
    else:
        with open(instruction_data_path, 'r') as f:
            instruction_data = json.load(f)
        target_range = (
            int(instruction_data['target_range']['start_address'], 16),
            int(instruction_data['target_range']['end_address'], 16)
        )

        execution_intervals = [
            {
                'start_address': int(interval['start_address'], 16),
                'end_address': int(interval['end_address'], 16),
                'execution_count': interval['execution_count']
            }
            for interval in instruction_data['execution_intervals']
        ]

    config = TestbenchConfig(
        benchmark_name=data['benchmark'],
        asm_path=os.path.join(tbf, data['asm']),
        asm_d_path=os.path.join(tbf, data['asm_detailed']),
        procedure_cfg=data['procedure_cfg'],
        user_plt=data['skip_as_plt'],
        target_range = target_range,
        execution_intervals = execution_intervals
    )
    # config.skip_user_plt = True
    config.gen_procedure_cfg = kwargs.get('gen_procedure_cfg', False)
    config.skip_user_plt = kwargs.get('skip_user_plt', False)
    return config


class Logger:
    RED = "\033[1;31m"
    GREEN = "\033[1;32m"
    BLUE = "\033[1;34m"
    RESET = "\033[0m"

    def __init__(self, verbose: int):
        self.verbose = verbose

    def log(self, msg, verbose: int, color=None):
        if verbose < self.verbose:
            # Skip all messages that are filtered by verbose option.
            return

        timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        if color == "red":
            msg = self.RED + msg + self.RESET
        elif color == "green":
            msg = self.GREEN + msg + self.RESET
        elif color == "blue":
            msg = self.BLUE + msg + self.RESET

        print(f"[{timestamp}] {msg}")

    def log2C(self, msg, msg2, verbose: int, color, color2, msg3="."):
        """
        打印带有颜色和时间戳的日志消息。

        :param msg: 第一部分消息。
        :param msg2: 第二部分消息。
        :param verbose: 当前消息的详细级别。
        :param color: 第一部分消息的颜色。
        :param color2: 第二部分消息的颜色。
        :param msg3: 第三部分消息（默认为"."）。
        """
        if verbose < self.verbose:
            # Skip all messages that are filtered by verbose option.
            return

        timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        if color == "red":
            msg = self.RED + msg + self.RESET
            msg3 = self.RED + msg3 + self.RESET
        elif color == "green":
            msg = self.GREEN + msg + self.RESET
            msg3 = self.GREEN + msg3 + self.RESET
        elif color == "blue":
            msg = self.BLUE + msg + self.RESET
            msg3 = self.BLUE + msg3 + self.RESET

        if color2 == "red":
            msg2 = self.RED + msg2 + self.RESET
        elif color2 == "green":
            msg2 = self.GREEN + msg2 + self.RESET
        elif color2 == "blue":
            msg2 = self.BLUE + msg2 + self.RESET

        print(f"[{timestamp}] {msg + msg2 + msg3}")
