import os

os.chdir("..")
import warnings
import time
from typing import Tuple, Sequence, Hashable, Optional, List, Dict
from collections import defaultdict

from sample.analyser import WCETAnalyser, TCFGNode, Prog
from sample.cache.cache_config import CacheConfig, read_cache_config_from_json
from sample.ilp.ilp import ILPModel, MPS, LPSolve, ILPException
from sample.ilp.inf_path import InfPath
from sample.frontend.critical_cfg import CriticalCfg
from sample.cache.constants import MemoryModel

test_cases = [
    ("tests/inputs/main/adpcm", 1193500),
    ("tests/inputs/main/bs", 557),
    ("tests/inputs/main/bsort100", 53545303),
    ("tests/inputs/main/insertsort", 55532818),
    ("tests/inputs/main/edn", 3669718),
    ("tests/inputs/main/expint", 188958),
    ("tests/inputs/main/fir", 161006),
    ("tests/inputs/main/jfdctint", 4246108),
    ("tests/inputs/main/matmult", 527282),
    ("tests/inputs/main/cnt", 1005638),
    ("tests/inputs/fcall/bsort100", 658159),
    ("tests/inputs/fcall/dijkstra", 12314),
    ("tests/inputs/fcall/edn", 896885),
    ("tests/inputs/fcall/fdct", 14624),
    ("tests/inputs/fcall/fibcall", 1411),
    ("tests/inputs/fcall/fir", 1832690),
    ("tests/inputs/fcall/floyd", 12605),
    ("tests/inputs/fcall/matmult", 550293),
    ("tests/inputs/fcall/ns", 38355),
    ("tests/inputs/fcall/expint", 191465),
    ("tests/inputs/fcall/sqrt", 191465),
    ("tests/inputs/fcall/qurt", 191465),
    ("tests/inputs/fcall/ndes", 191465),
    ("tests/inputs/fcall/ludcmp", 191465),
    ("tests/inputs/fcall/duff", 191465),
    ("tests/inputs/fcall/nsichneu", 191465),
    ("tests/inputs/main/lms", 191465),
]

for test_case, res in test_cases:
    print(test_case)
    f = test_case.split("/")[-1]
    prefix = "%s/%s" % (test_case, f)
    _analysis_file = "%s.asm" % prefix
    _jtable_dir = r"./tests/inputs/jtable/v7.json"
    _loop_cons_dir = "%s/loop_cons.json" % test_case
    _dline_dir = "%s.dline" % prefix
    _slist_dir = "%s.slist" % prefix
    start_time = time.time()
    inst_cache_config = CacheConfig(capacity_size=32768, associativity=1, line_size=32, penalty=12.5)  # 内存块数量为 1024
    data_cache_config = CacheConfig(capacity_size=32768, associativity=2, line_size=64, penalty=6)

    analyser = WCETAnalyser(_analysis_file, inst_cache_config, data_cache_config,
                            jump_table_dir=_jtable_dir,
                            cons_dir=_loop_cons_dir,
                            memory_model=MemoryModel.SMALL_MEMORY_MODEL,
                            dline_dir=_dline_dir,
                            slist_dir=_slist_dir,
                            start_name="main",
                            )

    analyser.frontend_analysis()
    analyser.inst_cache_analysis_global()
    analyser.data_cache_analysis_global()
    analyser.sp_loop_analysis_global()
    cycle_cons = dict()
    for idx in range(len(analyser.blocks)):
        analyser.move_block_cursor_to(idx)
        analyser.abstract_interpretation_gen()
        analyser.sp_loop_analysis_bb()
        analyser.inst_cache_analysis_bb()
        analyser.data_cache_analysis_bb()
        analyser.in_block_wcet_analysis()
        cycle_cons[idx] = analyser.cycle.copy()
        analyser.cycle_constrain[idx] = analyser.cycle.copy()
    analyser.inter_block_analysis()

    ilp_model = ILPModel(analyser.loop_hierarchy,
                         "%s.dline" % prefix,
                         analyser.inst_cache_cons,
                         analyser.data_cache_cons,
                         inst_cache_config,
                         data_cache_config,
                         loop_cons_file=_loop_cons_dir,
                         pred_cycle=analyser.cycle_constrain)
    lp_str = ilp_model.gen_ilp_model()
    
    with open("%s.lp" % prefix, "w", encoding="UTF-8") as f:
        f.write(lp_str)
    infpath = InfPath(analyser.loop_hierarchy, "%s.lp" % prefix)
    infpath.iterative_solve()
    lp_solve = LPSolve("%s.lp" % prefix)
    elapse_time = lp_solve.solve()
    
    assert lp_solve.is_bound
    end_time = time.time()
    elapsed_time = end_time - start_time
    print("Result %d" % int(float(lp_solve.obj_max_val)))
    print(f"Elapsed_time: {elapsed_time:.6f} s")
