# WCET (Worst Case Execution Time) 分析
面向DSP芯片TI C6678，C6713的最坏时间分析实现。

## 安装和使用
本项目需要使用Python 3.8或以上版本，<u>[Graphviz](https://graphviz.org/)<u>，
[TI C6000系列编译器](https://www.ti.com/tool/C6000-CGT)</u>和
线性规划求解器 <u>[lpsolve](https://sourceforge.net/projects/lpsolve/files/lpsolve/5.5.2.11/lp_solve_5.5.2.11_exe_win64.zip/download)</u>。

### Python依赖
安装本项目使用的依赖：`python -m pip install -r requirements.txt`。

### 安装Graphviz
（注意：为了显示控制流图，本项目使用了可视化软件<u>[Graphviz](https://graphviz.org/)</u>，请根据操作系统<u>[下载](https://graphviz.org/download/)</u>相应的版本并将其`bin`文件夹加入到系统环境变量中）


### TI C6000系列编译器
在编译器下载完成后，请将压缩文件解压并将其中的`bin`文件夹加入到系统变量中。

在C6000编译器安装完成后，可以通过`script.py`来生成C语言文件的反汇编代码和Dwarf信息等，具体方法如下：
1. 将`./script.py`中的`include_path`和`lib_path`更改为相应的路径：
   - `include_path`：修改为`your/compiler/path/include`
   - `lib_path`：修改为`your/compiler/path/lib`
2. 运行`python script.py -h`可以查看该脚本的使用方法。

### lpsolve
请根据此[网页](https://sites.math.washington.edu/~conroy/m381-general/lpsolveHowToPC/runningLPsolveCommandLineWindows.htm)
的方法安装lpsolve软件。


## 运行测试
所有单元测试文件在`./tests/*_test.py`中。可以使用以下代码运行测试：

`python -m unittest tests.*_test`

其中`*_test`为测试文件名称，例如`python -m unittest tests.cfg_test`会运行`tests\cfg_test.py`中的全部测试。

用于测试的C语言文件和反汇编代码在文件夹`./tests/inputs`中，其中
- `./tests/inputs/main`中的C文件只包含`main`函数；
- `./tests/inputs/fcall`中的文件涉及函数调用。


## 类型检查（可选）
为提升代码可靠性，本项目使用类型检查器<u>[`mypy`](http://mypy-lang.org/)</u>对代码进行静态类型检查。

安装：`python -m pip install mypy`。

类型检查：将终端切换到根目录后，运行命令`mypy .`。

## 文件夹结构
- `pa`：汇编代码分析
  - `cfg`：控制流图
  - `isa`：指令类型
  - `loops`：循环分析

- `cache`：Cache行为分析
  - `memory_block`：Cache访问的抽象表示
  - `abstract_state`：Abstract Cache State

- `ilp`：整数线性规划建模

