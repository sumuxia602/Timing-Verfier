import psutil
import datetime


def memory_usage(debug_path: str, input_name=None):
    # 指定要查找的命令（可执行文件名）
    target_command = "run_benchmark_cli.py"

    # 获取当前日期和时间
    current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # 打开文件进行写入（如果文件不存在，则创建；如果文件存在，则追加）
    with open(debug_path + "/htop.txt", 'a') as file:
        # 遍历系统中所有进程
        for proc in psutil.process_iter(['pid', 'name', 'cmdline', 'cpu_percent', 'memory_info']):
            try:
                # for k,v in proc.info.items():
                #     print(k,v)
                if proc.info['cmdline'] is None:
                    continue
                cmdline = ' '.join(proc.info['cmdline'])  # 命令行参数列表转为字符串
                # 检查进程的命令行是否包含指定的命令
                if target_command in cmdline:
                    # 获取进程ID、名称、命令行参数
                    pid = proc.info['pid']
                    name = proc.info['name']
                    cpu_percent = proc.info['cpu_percent']
                    memory_info = proc.info['memory_info']
                    memory_usage = memory_info.rss  # 使用 RSS（常驻集大小）表示实际内存使用

                    # 将内存占用转换为 GB
                    memory_usage_mb = memory_info.rss / (1024 * 1024 * 1024)  # rss: 常驻集大小
                    # txt = f"PID: {pid}, Name: {name},cpu_percent: {cpu_percent}, Memory Usage: {memory_usage_mb:.2f} MB, Command: {cmdline}"

                    if input_name:
                        input_name = input_name.ljust(50)
                        txt = input_name + f"Time: {current_time}  Memory: {memory_usage_mb:.2f} GB\n"
                    else:
                        input_name = " ".ljust(50)
                        txt = input_name + f"Time: {current_time}  Memory: {memory_usage_mb:.2f} GB\n"
                    # 写入文件
                    file.write(txt)
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                continue

        file.write("\n")  # 换行分隔不同的记录


def memory_usage_v2(debug_path):
    # 指定用户名
    user_name = "guguji"
    # 定义CPU使用率阈值
    cpu_threshold = 50.0

    # 遍历系统中的所有进程
    for proc in psutil.process_iter(['pid', 'name', 'username', 'cpu_percent', 'memory_info']):
        user_name = "guguji"
        # 获取当前日期和时间
        current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        try:
            # 获取进程信息
            if proc.info['username'] == user_name:
                # 获取 CPU 使用率
                cpu_usage = proc.info['cpu_percent']

                # # 检查 CPU 使用率是否超过阈值
                # if cpu_usage > cpu_threshold:
                pid = proc.info['pid']
                name = proc.info['name']
                cmdline = ' '.join(proc.cmdline())  # 获取完整的命令行参数
                memory_info = proc.info['memory_info']  # 获取内存占用信息

                # 将内存占用转换为 MB
                memory_usage_mb = memory_info.rss / (1024 * 1024)  # rss: 常驻集大小
                txt = f"PID: {pid}, Name: {name}, CPU Usage: {cpu_usage}%, Memory Usage: {memory_usage_mb:.2f} MB, Command: {cmdline}"

                # 输出满足条件的进程信息
                with open(debug_path + "/htop.txt", 'a') as file:
                    # 写入当前时间
                    file.write(f"Timestamp: {current_time}\n")
                    file.write(txt)
                    file.write("\n")

        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            continue
