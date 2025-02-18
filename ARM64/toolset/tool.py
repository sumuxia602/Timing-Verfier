import os
import shutil

def organize_files():
    # 获取当前目录下所有的 .c 文件
    current_dir = os.getcwd()
    c_files = [f for f in os.listdir(current_dir) if f.endswith('.c')]
    print(c_files)
    
    for c_file in c_files:
        
        # 获取文件名（不包括扩展名）
        base_name = os.path.splitext(c_file)[0]
        
        # 生成相关文件名
        binary_file = f"{base_name}"
        asm_file = f"{base_name}.asm"
        extra_asm_file = f"{base_name}D.asm"
        
        # 创建以文件名命名的文件夹
        file_name = base_name+"F"
        target_dir = os.path.join(current_dir, file_name)
        os.makedirs(target_dir, exist_ok=True)
        
        # 移动文件
        files_to_move = [c_file, binary_file, asm_file, extra_asm_file]
        for file in files_to_move:
            if os.path.exists(file):
                shutil.move(file, target_dir)
                print(f"Moved {file} to {target_dir}")
        new_name = file_name[:-1]
        os.rename(file_name, new_name)
        

if __name__ == "__main__":
    organize_files()

