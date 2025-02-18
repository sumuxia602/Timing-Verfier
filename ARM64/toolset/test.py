import os
import subprocess

def compile_and_disassemble():
    # 获取当前目录下所有的 .c 文件
    current_dir = os.getcwd()
    c_files = [f for f in os.listdir(current_dir) if f.endswith('.c')]
    
    for c_file in c_files:
        # 获取文件名（不包括扩展名）
        base_name = os.path.splitext(c_file)[0]
        
        # 生成带调试信息的二进制文件
        binary_file = f"{base_name}"
        compile_command = ["gcc", "-g", "-o", binary_file, c_file]
        print(f"Compiling {c_file} to {binary_file}...")
        subprocess.run(compile_command, check=True)
        
        # 生成反汇编文件
        asm_file = f"{base_name}.asm"
        disassemble_command = ["objdump", "-d", binary_file, "-o", asm_file]
        print(f"Disassembling {binary_file} to {asm_file}...")
        with open(asm_file, "w") as asm_output:
            subprocess.run(["objdump", "-d", binary_file], stdout=asm_output, check=True)

        # 生成反汇编文件
        asmD_file = f"{base_name}D.asm"
        disassemble_command = ["objdump", "-D", binary_file, "-o", asmD_file]
        print(f"Disassembling {binary_file} to {asmD_file}...")
        with open(asmD_file, "w") as asm_output:
            subprocess.run(["objdump", "-D", binary_file], stdout=asm_output, check=True)
        
        print(f"Finished processing {c_file}")

if __name__ == "__main__":
    compile_and_disassemble()
