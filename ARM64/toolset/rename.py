import os
import json

def create_json_files(base_path):
    # 获取base_path目录下所有的子目录
    for folder_name in os.listdir(base_path):
        folder_path = os.path.join(base_path, folder_name)
        if os.path.isdir(folder_path):
            # 构建json内容
            json_content = {
                "benchmark": folder_name,
                "asm": f"{folder_name}.asm",
                "asm_detailed": f"{folder_name}D.asm",
                "skip_as_plt": []
            }
            
            # 创建json文件路径
            json_file_path = os.path.join(folder_path, f"{folder_name}.json")
            
            # 将json内容写入文件
            with open(json_file_path, 'w') as json_file:
                json.dump(json_content, json_file, indent=4)
            
            print(f"Created {json_file_path}")

if __name__ == "__main__":
    base_path = os.getcwd()  # 可以修改为你要处理的路径
    create_json_files(base_path)

