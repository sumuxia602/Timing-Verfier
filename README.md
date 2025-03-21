# Timing Verfier 
支持RISC-V、ARM64、DSP三种架构的分析，不同架构的代码被分成三个文件。
## 研究价值
通过研究不同类型汇编指令的执行特性，使用静态分析方法，对缓存、流水线等关键硬件部件进行高精度模拟，开展最坏执行时间（WCET）分析。
可以为操作系统的实时性验证提供支持，通过精准的WCET分析，可便于进行算法优化和数据结构调整。
## 分析流程
由于任务的执行受到程序逻辑、体系结构特性、数据输入、处理器状态等复杂因素的影响，其执行时间通常呈现某种分布，在所有可能的执行时间中，存在客观上的最小值和最大值，分别称为最好情况执行时间(best-case execution time，简称 BCET)和最坏情况执行时间(worst-case execution time，简称 WCET)。实时系统时间行为分析的首要任务就是估计任务的最坏情况执行时间。

静态分析保证它在不实际执行任务的前提下，确保分析能够覆盖任务所有可能的执行情况，包括所有可能的程序执行路径、程序输入以及处理器初始状态等。静态分析得到的最大执行时间称为 WCET 估计值。

静态分析流程：

首先对程序的可执行代码进行控制流分析。在对可执行代码进行反编译后，抽取出程序的控制流程图(control flow graph，简称 CFG)。程序的CFG是一个有向带环图: 图的节点为每一条指令，图的边表示程序的控制流程。程序的 CFG 有唯一的起点和终点，分别表示程序的入口和出口。后续分析步骤都针对程序的 CFG 进行。

然后进行处理器行为分析。指令的执行时间受到流水线、分支预测器、Cache等处理器部件的影响，呈现较大波动。处理器行为分析的目标就是在给定的处理器特性参数下，为 CFG 中的每条指令估计一个 WCET 的上限值。

最后一步工作就是找到导致整个程序执行时间最长的路径，称为 WCET 计算。目前，研究领域最常用的技术是隐式路径枚举(implicit path enumeration)。该技术的基本思想是：将 WCET 求解问题(或最长执行时间路径搜索问题)转化为求每条指令执行次数的问题，并将其建模成一个整数线性规划问题进行求解。
