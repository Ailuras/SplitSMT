#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SMT2 Seeds Selection Script
This script selects suitable SMT2 formulas from an Excel analysis file as seeds for mutation.
"""

import os
import pandas as pd
import argparse
import shutil
from pathlib import Path
import random

def parse_args():
    parser = argparse.ArgumentParser(description='Select suitable SMT2 formulas as seeds for mutation.')
    parser.add_argument('--input-file', required=True, help='Excel file containing SMT2 analysis results')
    parser.add_argument('--output-dir', default='benchmarks/seeds', help='Directory to save selected seed files')
    parser.add_argument('--num-seeds', type=int, default=100, help='Number of seeds to select')
    parser.add_argument('--max-file-size', type=int, default=100000, help='Maximum file size in bytes')
    parser.add_argument('--max-vars', type=int, default=100, help='Maximum number of variables')
    parser.add_argument('--max-clauses', type=int, default=500, help='Maximum number of clauses')
    parser.add_argument('--min-file-size', type=int, default=100, help='Minimum file size in bytes')
    parser.add_argument('--min-vars', type=int, default=1, help='Minimum number of variables')
    parser.add_argument('--min-clauses', type=int, default=1, help='Minimum number of clauses')
    return parser.parse_args()

def verify_solver_results(row):
    """
    检查所有求解器是否都能成功求解，并且结果与status一致
    """
    solvers = ['cvc5', 'z3', 'SLIA-z3-noodler', 'SLIA-ostrich']
    
    # 检查所有求解器是否都返回SUCCESS
    for solver in solvers:
        result_col = f'res_{solver}_result'
        if pd.isna(row[result_col]) or row[result_col] != 'SUCCESS':
            return False
    
    # 如果status不是unknown，检查所有求解器的推理结果是否与status一致
    if not pd.isna(row['status']) and row['status'] != 'unknown':
        for solver in solvers:
            reason_col = f'res_{solver}_reason'
            if pd.isna(row[reason_col]) or row[reason_col] != row['status']:
                return False
    
    return True

def analyze_data_distribution(df, filtered_df):
    """
    分析数据分布情况
    """
    print(f"\n=== 数据分布分析 ===")
    print(f"总文件数: {len(df)}")
    print(f"筛选后文件数: {len(filtered_df)}")
    
    if len(df) > 0:
        print(f"\n文件大小分布 (原始数据):")
        print(f"  最小: {df['file_size'].min()} bytes")
        print(f"  最大: {df['file_size'].max()} bytes")
        print(f"  平均: {df['file_size'].mean():.2f} bytes")
        print(f"  中位数: {df['file_size'].median():.2f} bytes")
        
        print(f"\n变量数分布 (原始数据):")
        print(f"  最小: {df['var_count'].min()}")
        print(f"  最大: {df['var_count'].max()}")
        print(f"  平均: {df['var_count'].mean():.2f}")
        
        print(f"\n子句数分布 (原始数据):")
        print(f"  最小: {df['clause_count'].min()}")
        print(f"  最大: {df['clause_count'].max()}")
        print(f"  平均: {df['clause_count'].mean():.2f}")
    
    if len(filtered_df) > 0:
        print(f"\n=== 筛选后数据分布 ===")
        print(f"文件大小分布:")
        print(f"  最小: {filtered_df['file_size'].min()} bytes")
        print(f"  最大: {filtered_df['file_size'].max()} bytes")
        print(f"  平均: {filtered_df['file_size'].mean():.2f} bytes")
        
        print(f"\n变量数分布:")
        print(f"  最小: {filtered_df['var_count'].min()}")
        print(f"  最大: {filtered_df['var_count'].max()}")
        print(f"  平均: {filtered_df['var_count'].mean():.2f}")
        
        print(f"\n子句数分布:")
        print(f"  最小: {filtered_df['clause_count'].min()}")
        print(f"  最大: {filtered_df['clause_count'].max()}")
        print(f"  平均: {filtered_df['clause_count'].mean():.2f}")

def select_seeds(input_file, output_dir, num_seeds, max_file_size, max_vars, max_clauses, 
                min_file_size, min_vars, min_clauses):
    try:
        print(f"正在读取Excel文件: {input_file}")
        df = pd.read_excel(input_file)
        print(f"成功读取 {len(df)} 行数据")
        
        # 显示列名以便调试
        print(f"Excel文件列名: {list(df.columns)}")
        
    except Exception as e:
        print(f"读取输入文件时出错: {e}")
        return

    # 检查必要的列是否存在
    required_columns = ['path', 'file_size', 'var_count', 'clause_count', 'status']
    solver_columns = ['res_cvc5_result', 'res_z3_result', 'res_SLIA-z3-noodler_result', 'res_SLIA-ostrich_result']
    reason_columns = ['res_cvc5_reason', 'res_z3_reason', 'res_SLIA-z3-noodler_reason', 'res_SLIA-ostrich_reason']
    
    missing_columns = []
    for col in required_columns + solver_columns + reason_columns:
        if col not in df.columns:
            missing_columns.append(col)
    
    if missing_columns:
        print(f"警告: 以下列不存在于Excel文件中: {missing_columns}")
        return

    print(f"\n=== 开始筛选过程 ===")
    
    # 第一步：基本数值过滤
    print(f"应用数值过滤条件...")
    size_filter = (df['file_size'] >= min_file_size) & (df['file_size'] <= max_file_size)
    vars_filter = (df['var_count'] >= min_vars) & (df['var_count'] <= max_vars)
    clauses_filter = (df['clause_count'] >= min_clauses) & (df['clause_count'] <= max_clauses)
    
    basic_filtered = df[size_filter & vars_filter & clauses_filter].copy()
    print(f"数值过滤后剩余: {len(basic_filtered)} 个文件")
    
    if len(basic_filtered) == 0:
        print("警告: 没有文件满足基本数值条件!")
        analyze_data_distribution(df, basic_filtered)
        return
    
    # 第二步：求解器结果过滤
    print(f"应用求解器结果过滤...")
    solver_filtered = basic_filtered[basic_filtered.apply(verify_solver_results, axis=1)].copy()
    print(f"求解器过滤后剩余: {len(solver_filtered)} 个文件")
    
    if len(solver_filtered) == 0:
        print("警告: 没有文件满足求解器结果条件!")
        
        # 分析求解器成功率
        print(f"\n=== 求解器成功率分析 ===")
        for solver in ['cvc5', 'z3', 'SLIA-z3-noodler', 'SLIA-ostrich']:
            result_col = f'res_{solver}_result'
            success_count = len(basic_filtered[basic_filtered[result_col] == 'SUCCESS'])
            print(f"{solver}: {success_count}/{len(basic_filtered)} ({success_count/len(basic_filtered)*100:.1f}%) 成功")
        
        # 分析status分布
        print(f"\nStatus分布:")
        status_counts = basic_filtered['status'].value_counts()
        for status, count in status_counts.items():
            print(f"  {status}: {count} ({count/len(basic_filtered)*100:.1f}%)")
        
        analyze_data_distribution(df, solver_filtered)
        return
    
    # 随机选择种子
    num_to_select = min(num_seeds, len(solver_filtered))
    selected_df = solver_filtered.sample(n=num_to_select, random_state=42)
    print(f"随机选择了 {num_to_select} 个种子文件")
    
    # 创建输出目录
    os.makedirs(output_dir, exist_ok=True)
    print(f"输出目录: {output_dir}")
    
    # 复制选中的文件
    success_count = 0
    failed_files = []
    
    for idx, (_, row) in enumerate(selected_df.iterrows()):
        source_path = row['path']
        
        if not os.path.exists(source_path):
            print(f"警告: 源文件不存在: {source_path}")
            failed_files.append(source_path)
            continue
        
        # 使用原始文件名
        filename = os.path.basename(source_path)
        target_path = os.path.join(output_dir, filename)
        
        try:
            shutil.copy2(source_path, target_path)
            success_count += 1
            if (idx + 1) % 20 == 0:  # 每20个文件打印一次进度
                print(f"已复制 {idx + 1}/{num_to_select} 个文件...")
        except Exception as e:
            print(f"复制文件时出错 {source_path}: {e}")
            failed_files.append(source_path)
    
    # 打印最终总结
    print(f"\n=== 选择总结 ===")
    print(f"输入文件总数: {len(df)}")
    print(f"满足数值条件: {len(basic_filtered)}")
    print(f"满足求解器条件: {len(solver_filtered)}")
    print(f"成功复制种子文件: {success_count}/{num_to_select}")
    
    if failed_files:
        print(f"失败文件数: {len(failed_files)}")
        if len(failed_files) <= 5:
            print("失败文件列表:")
            for f in failed_files:
                print(f"  {f}")
    
    print(f"\n=== 求解器结果总结 (筛选后数据) ===")
    for solver in ['cvc5', 'z3', 'SLIA-z3-noodler', 'SLIA-ostrich']:
        result_col = f'res_{solver}_result'
        success_count_solver = len(solver_filtered[solver_filtered[result_col] == 'SUCCESS'])
        print(f"{solver}: {success_count_solver}/{len(solver_filtered)} 成功")
    
    # 分析选中文件的status分布
    print(f"\n=== 选中文件Status分布 ===")
    status_counts = selected_df['status'].value_counts()
    for status, count in status_counts.items():
        print(f"{status}: {count} ({count/len(selected_df)*100:.1f}%)")
    
    analyze_data_distribution(df, solver_filtered)

if __name__ == "__main__":
    args = parse_args()
    print(f"=== SMT2 种子选择工具 ===")
    print(f"从 {args.input_file} 选择 {args.num_seeds} 个种子")
    print(f"筛选条件:")
    print(f"- 文件大小: {args.min_file_size} - {args.max_file_size} bytes")
    print(f"- 变量数: {args.min_vars} - {args.max_vars}")
    print(f"- 子句数: {args.min_clauses} - {args.max_clauses}")
    print(f"- 所有求解器必须返回SUCCESS")
    print(f"- 求解器结果必须与status一致 (当status不为unknown时)")
    
    select_seeds(
        args.input_file,
        args.output_dir,
        args.num_seeds,
        args.max_file_size,
        args.max_vars,
        args.max_clauses,
        args.min_file_size,
        args.min_vars,
        args.min_clauses
    )