#!/usr/bin/env python3
"""
SMT文件清理脚本
功能：
1. 对于push/pop的例子只保留第一个check-sat之前的约束
2. 删除(push)、(pop)、(get-model)、(get-unsat-core)等命令
3. 将(set-logic QF_S)改为(set-logic QF_SLIA)
"""

import sys
import re
import argparse
from pathlib import Path


def clean_smt_file(input_file, output_file):
    """清理单个SMT文件"""
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()
    except Exception as e:
        print(f"错误：无法读取文件 {input_file}: {e}", file=sys.stderr)
        return False
    
    cleaned_lines = []
    found_first_check_sat = False
    in_push_pop_block = False
    push_count = 0
    
    for line in lines:
        stripped = line.strip()
        
        # 跳过空行
        if not stripped:
            cleaned_lines.append(line)
            continue
        
        # 替换 set-logic QF_S 为 QF_SLIA
        if re.match(r'^\(set-logic\s+QF_S\)', stripped):
            line = line.replace('QF_S', 'QF_SLIA')
            cleaned_lines.append(line)
            continue
        
        # 检查是否是第一个 check-sat
        if re.match(r'^\(check-sat\)', stripped) and not found_first_check_sat:
            found_first_check_sat = True
            cleaned_lines.append(line)
            continue
        
        # 如果已经找到第一个 check-sat，检查是否进入 push/pop 块
        if found_first_check_sat:
            # 检查是否是 push
            if re.match(r'^\(push\)', stripped):
                in_push_pop_block = True
                push_count = 1
                continue
            
            # 如果在 push/pop 块中
            if in_push_pop_block:
                # 检查是否是 pop
                if re.match(r'^\(pop\)', stripped):
                    push_count -= 1
                    if push_count == 0:
                        in_push_pop_block = False
                # 检查是否是 push（嵌套）
                elif re.match(r'^\(push\)', stripped):
                    push_count += 1
                continue
        
        # 跳过不需要的命令
        if (re.match(r'^\(pop\)', stripped) or
            re.match(r'^\(get-model\)', stripped) or
            re.match(r'^\(get-unsat-core\)', stripped) or
            re.match(r'^\(push\)', stripped)):
            continue
        
        # 如果已经找到第一个 check-sat 且不在 push/pop 块中，跳过后续内容
        if found_first_check_sat and not in_push_pop_block:
            # 只保留 exit 命令
            if re.match(r'^\(exit\)', stripped):
                cleaned_lines.append(line)
            continue
        
        # 保留其他行
        cleaned_lines.append(line)
    
    # 写入输出文件
    try:
        # 确保输出目录存在
        output_path = Path(output_file)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        with open(output_file, 'w', encoding='utf-8') as f:
            f.writelines(cleaned_lines)
        
        print(f"处理完成: {Path(input_file).name} ({len(lines)} -> {len(cleaned_lines)} 行)")
        return True
        
    except Exception as e:
        print(f"错误：无法写入文件 {output_file}: {e}", file=sys.stderr)
        return False


def main():
    parser = argparse.ArgumentParser(description='清理SMT文件')
    parser.add_argument('input_file', help='输入文件路径')
    parser.add_argument('output_file', help='输出文件路径')
    parser.add_argument('-v', '--verbose', action='store_true', help='显示详细信息')
    
    args = parser.parse_args()
    
    # 检查输入文件
    if not Path(args.input_file).exists():
        print(f"错误：输入文件不存在: {args.input_file}", file=sys.stderr)
        sys.exit(1)
    
    # 清理文件
    success = clean_smt_file(args.input_file, args.output_file)
    
    if not success:
        sys.exit(1)


if __name__ == '__main__':
    main() 