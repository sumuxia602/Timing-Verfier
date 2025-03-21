# RISC-V
## RISC-V生成CFG
面向RISC-V经过C语言经RV64G汇编成汇编代码再生成 CFG。

## 安装和使用
本项目需要使用Python 3.11或以上版本。

###RISC-V编译工具链安装
#linux环境下安装
sudo apt update
sudo apt install build-essential gcc make perl dkms git  gdb-multiarch qemu-system-misc
sudo apt install gcc-riscv64-linux-gnu

#获取反汇编文件
首先生成可执行文件（将example.c编译成可执行文件example）
riscv64-linux-gnu-gcc -o example example.c
将可执行文件反汇编
riscv64-linux-gnu-objdump -d example > example.s


### Python依赖
安装本项目使用的依赖：
python==3.11.9
pandas==2.2.2
networkx==3.3
graphviz==2.50.0

### 安装Graphviz
（注意：为了显示控制流图，本项目使用了可视化软件<u>[Graphviz](https://graphviz.org/)</u>，请根据操作系统<u>[下载](https://graphviz.org/download/)</u>相应的版本并将其`bin`文件夹加入到系统环境变量中）
其中会提示下载pygraphviz包，会给一个网页“http://pygraphviz.github.io/”里面有这个包的下载指南。


## 运行测试
测试文件在`./test`中。可以直接通过命令行运行“python main.py test/test.s”，其中test.s为测试的RISC-V汇编代码指令。

用于测试的C语言文件和反汇编代码在文件夹`./input`中，可直接通过命令行运行main.py后接要构成CFG的.s文件地址，例如：“python main.py input/bs/bs.s”即可运行，
运行完会生成两个文件，一个dot文件也就是文本文件会储存这个控制流图的基本信息，包括每个节点的起止行，以及每个节点的编号和节点之间的相连接信息，另一个png图片则是
通过工具绘制出来的控制流图。
