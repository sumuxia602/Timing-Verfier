import re

def analyze_inst(file_path):
    with open(file_path, 'r') as file:
        data = file.read()

    # 改进的正则表达式匹配数据段
    pattern = re.compile(r'"[a-zA-Z0-9]+": {\s*"L1I":\s*"([A-Z]+)",\s*"L2":\s*"([A-Z]+)"\s*}')
    matches = pattern.findall(data)
    
    # 初始化计数器
    count_L1I = {'AH': 0, 'PS': 0, 'NC': 0, 'AM': 0}
    count_L2 = {'AH': 0, 'PS': 0, 'NC': 0, 'AM': 0}
    total_segments = len(matches)

    for match in matches:
        l1d, l2 = match
        
        if l1d in count_L1I:
            count_L1I[l1d] += 1
        if l2 in count_L2:
            count_L2[l2] += 1

    # 计算百分比
    percentage_L1I = {key: (value / total_segments) * 100 for key, value in count_L1I.items()}
    percentage_L2 = {key: (value / total_segments) * 100 for key, value in count_L2.items()}

    # 打印结果
    print(f"Total segments: {total_segments}")
    print(f"L1I counts: {count_L1I}")
    print(f"L2 counts: {count_L2}")
    print(f"L1I percentages: {percentage_L1I}")
    print(f"L2 percentages: {percentage_L2}")

def analyze_data(file_path):
    with open(file_path, 'r') as file:
        data = file.read()

    # 改进的正则表达式匹配数据段
    pattern = re.compile(r'"[a-zA-Z0-9]+": {\s*"L1D":\s*"([A-Z]+)",\s*"L2":\s*"([A-Z]+)"\s*}')
    matches = pattern.findall(data)
    
    # 初始化计数器
    count_L1D = {'AH': 0, 'PS': 0, 'NC': 0, 'AM': 0}
    count_L2 = {'AH': 0, 'PS': 0, 'NC': 0, 'AM': 0}
    total_segments = len(matches)

    for match in matches:
        l1d, l2 = match
        
        if l1d in count_L1D:
            count_L1D[l1d] += 1
        if l2 in count_L2:
            count_L2[l2] += 1

    # 计算百分比
    percentage_L1D = {key: (value / total_segments) * 100 for key, value in count_L1D.items()}
    percentage_L2 = {key: (value / total_segments) * 100 for key, value in count_L2.items()}

    # 打印结果
    print()
    print(f"Total segments: {total_segments}")
    print(f"L1D counts: {count_L1D}")
    print(f"L2 counts: {count_L2}")
    print(f"L1D percentages: {percentage_L1D}")
    print(f"L2 percentages: {percentage_L2}")

def analyze_all(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    # 移除换行符和不必要的空格
    content = re.sub(r'\s+', '', content)
    
    # 提取INST和DATA部分
    inst_data = re.search(r'"INST":{(.+?)},"DATA"', content).group(1)
    data_data = re.search(r'"DATA":{(.+)}', content).group(1)
    # print(re.search(r'"DATA":{(.+)}', content).group(1))

    
    # 函数计算特定段中不同参数的频数
    def count_params(segment):
        counts = {'AH': 0, 'PS': 0, 'NC': 0, 'AM': 0}
        matches = re.finditer(r'("L1I"|"L1D"|"L2"):"(AH|PS|NC|AM)"', segment)
        for match in matches:
            param = match.group(2)
            counts[param] += 1
        return counts

    # 统计INST和DATA中的参数
    inst_counts = count_params(inst_data)
    data_counts = count_params(data_data)

    # 计算总数和百分比
    total_inst = sum(inst_counts.values())
    total_data = sum(data_counts.values())

    inst_percentages = {k: (v / total_inst * 100) if total_inst > 0 else 0 for k, v in inst_counts.items()}
    data_percentages = {k: (v / total_data * 100) if total_data > 0 else 0 for k, v in data_counts.items()}

    return {
        'INST counts': inst_counts,
        'INST percentages': inst_percentages,
        'DATA counts': data_counts,
        'DATA percentages': data_percentages,
    }


if __name__ == "__main__":
    # 调用函数并传递文件路径
    # analyze_inst('/Users/gugujixiao/SyncSpace/workspace/project/HW_Cache/code/hw_cache_analysis/output/hw_test1/cache-analysis-inst.txt')
    # analyze_data('/Users/gugujixiao/SyncSpace/workspace/project/HW_Cache/code/hw_cache_analysis/output/hw_test1/cache-analysis-data.txt')
    # print()
    result = analyze_all('/Users/gugujixiao/SyncSpace/workspace/project/HW_Cache/code/hw_cache_analysis/output/testcase3/cache-analysis-testcase3')
    print("\n指令")
    print(result['INST counts'])
    print(result['INST percentages'])
    print("\n数据")
    print(result['DATA counts'])
    print(result['DATA percentages'])
    print("\n")


