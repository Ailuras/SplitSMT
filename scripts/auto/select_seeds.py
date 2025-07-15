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
    检查所有求解器是否都能成功求解，并且结果一致
    """
    solvers = ['cvc5', 'z3', 'SLIA-z3-noodler', 'SLIA-ostrich']
    
    # 检查所有求解器是否都返回SUCCESS
    for solver in solvers:
        result_col = f'res_{solver}_result'
        if pd.isna(row[result_col]) or row[result_col] != 'SUCCESS':
            return False
    
    # 获取所有求解器的推理结果
    solver_reasons = []
    for solver in solvers:
        reason_col = f'res_{solver}_reason'
        reason = row[reason_col]
        if pd.isna(reason):
            return False
        solver_reasons.append(reason)
    
    # 检查所有求解器的结果是否一致
    if len(set(solver_reasons)) != 1:
        return False  # 结果不一致
    
    return True

def get_file_source(path):
    """
    根据文件路径获取文件来源，用于确保多样性
    """
    path_parts = path.split('/')
    if len(path_parts) >= 3:
        # 通常格式是 .../QF_SLIA/year-source/...
        return path_parts[-2]  # 返回倒数第二个路径部分作为来源
    return 'unknown'

def select_seeds(input_file, output_dir, num_seeds, max_file_size, max_vars, max_clauses, 
                min_file_size, min_vars, min_clauses):
    try:
        print(f"正在读取Excel文件: {input_file}")
        df = pd.read_excel(input_file)
        print(f"成功读取 {len(df)} 行数据")
        
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

    print(f"\n=== 开始高效筛选过程 ===")
    
    # 创建输出目录（如果存在则先清空）
    if os.path.exists(output_dir):
        print(f"清空现有目录: {output_dir}")
        shutil.rmtree(output_dir)
    
    os.makedirs(output_dir, exist_ok=True)
    print(f"输出目录: {output_dir}")
    
    # 分步骤分析筛选过程
    print(f"=== 分步骤筛选分析 ===")
    
    # 步骤1：基本数值条件筛选
    basic_filter = (
        (df['file_size'] >= min_file_size) & (df['file_size'] <= max_file_size) &
        (df['var_count'] >= min_vars) & (df['var_count'] <= max_vars) &
        (df['clause_count'] >= min_clauses) & (df['clause_count'] <= max_clauses)
    )
    basic_candidates = df[basic_filter].copy()
    print(f"1. 基本数值筛选后: {len(basic_candidates)} 个文件 ({len(basic_candidates)/len(df)*100:.2f}%)")
    
    # 步骤2：求解器结果筛选
    solver_filter = basic_candidates.apply(verify_solver_results, axis=1)
    all_candidates = basic_candidates[solver_filter].copy()
    print(f"2. 求解器结果筛选后: {len(all_candidates)} 个文件 ({len(all_candidates)/len(df)*100:.2f}%)")
    
    if len(all_candidates) == 0:
        print("错误: 没有文件满足筛选条件!")
        print("建议: 放宽筛选条件，比如增大文件大小限制或减少求解器要求")
        return
    
    # 分析候选文件的结果分布
    all_candidates['solver_result'] = all_candidates['res_cvc5_reason']  # 使用第一个求解器的结果（已验证一致性）
    result_counts = all_candidates['solver_result'].value_counts()
    
    print(f"\n=== 候选文件求解结果分布 ===")
    for result, count in result_counts.items():
        print(f"{result}: {count} 个文件 ({count/len(all_candidates)*100:.1f}%)")
    
    # 检查是否有足够的sat和unsat文件
    sat_files = all_candidates[all_candidates['solver_result'] == 'sat']
    unsat_files = all_candidates[all_candidates['solver_result'] == 'unsat']
    unknown_files = all_candidates[all_candidates['solver_result'] == 'unknown']
    
    print(f"\nSAT文件数量: {len(sat_files)}")
    print(f"UNSAT文件数量: {len(unsat_files)}")
    print(f"UNKNOWN文件数量: {len(unknown_files)}")
    
    # 分析候选文件的来源分布
    all_candidates['source'] = all_candidates['path'].apply(get_file_source)
    source_counts = all_candidates['source'].value_counts()
    
    print(f"\n=== 候选文件来源分布 ===")
    for source, count in source_counts.head(10).items():
        print(f"{source}: {count} 个文件 ({count/len(all_candidates)*100:.1f}%)")
    
    if len(source_counts) > 10:
        print(f"... 还有 {len(source_counts)-10} 个其他来源")
    
    # 分析status分布
    status_counts = all_candidates['status'].value_counts()
    print(f"\n候选文件Status分布:")
    for status, count in status_counts.items():
        print(f"  {status}: {count} ({count/len(all_candidates)*100:.1f}%)")
    
    # 50%/50% SAT/UNSAT 分层选择策略
    if len(all_candidates) < num_seeds:
        print(f"\n警告: 候选文件数量 ({len(all_candidates)}) 少于需要的种子数量 ({num_seeds})")
        num_seeds = len(all_candidates)
        selected_candidates = all_candidates
    else:
        print(f"\n=== SAT/UNSAT 50%/50% 分层选择策略 ===")
        
        # 计算每种结果需要选择的数量
        target_sat = num_seeds // 2
        target_unsat = num_seeds - target_sat
        
        print(f"目标选择: SAT {target_sat} 个, UNSAT {target_unsat} 个")
        
        selected_list = []
        
        # 选择SAT文件
        if len(sat_files) >= target_sat:
            selected_sat = sat_files.sample(n=target_sat, random_state=42)
            selected_list.append(selected_sat)
            print(f"成功选择 {target_sat} 个SAT文件")
        else:
            selected_list.append(sat_files)
            print(f"SAT文件不足，只能选择 {len(sat_files)} 个")
        
        # 选择UNSAT文件
        if len(unsat_files) >= target_unsat:
            selected_unsat = unsat_files.sample(n=target_unsat, random_state=43)
            selected_list.append(selected_unsat)
            print(f"成功选择 {target_unsat} 个UNSAT文件")
        else:
            selected_list.append(unsat_files)
            print(f"UNSAT文件不足，只能选择 {len(unsat_files)} 个")
        
        # 合并选择的文件
        if selected_list:
            selected_candidates = pd.concat(selected_list, ignore_index=True)
        else:
            selected_candidates = pd.DataFrame()
        
        # 如果SAT和UNSAT文件都不够，从UNKNOWN文件中补充
        if len(selected_candidates) < num_seeds and len(unknown_files) > 0:
            remaining_needed = num_seeds - len(selected_candidates)
            additional_unknown = unknown_files.sample(
                n=min(remaining_needed, len(unknown_files)),
                random_state=44
            )
            selected_candidates = pd.concat([selected_candidates, additional_unknown], ignore_index=True)
            print(f"从UNKNOWN文件中补充选择 {len(additional_unknown)} 个文件")
        
        # 如果仍然不够，从所有候选中随机补充
        if len(selected_candidates) < num_seeds:
            remaining_needed = num_seeds - len(selected_candidates)
            selected_paths = set(selected_candidates['path'])
            remaining_candidates = all_candidates[~all_candidates['path'].isin(selected_paths)]
            
            if len(remaining_candidates) > 0:
                additional = remaining_candidates.sample(
                    n=min(remaining_needed, len(remaining_candidates)),
                    random_state=45
                )
                selected_candidates = pd.concat([selected_candidates, additional], ignore_index=True)
                print(f"随机补充选择 {len(additional)} 个文件")
    
    print(f"\n最终选择了 {len(selected_candidates)} 个种子文件")
    
    # 复制选中的文件
    print(f"开始复制文件...")
    success_count = 0
    failed_files = []
    
    for idx, (_, row) in enumerate(selected_candidates.iterrows()):
        source_path = row['path']
        
        if not os.path.exists(source_path):
            print(f"警告: 源文件不存在: {source_path}")
            failed_files.append(source_path)
            continue
        
        filename = os.path.basename(source_path)
        target_path = os.path.join(output_dir, filename)
        
        try:
            shutil.copy2(source_path, target_path)
            success_count += 1
            
            if (idx + 1) % 20 == 0:
                print(f"已复制 {idx + 1}/{len(selected_candidates)} 个文件...")
                
        except Exception as e:
            print(f"复制文件时出错 {source_path}: {e}")
            failed_files.append(source_path)
    
    # 打印最终总结
    print(f"\n=== 选择总结 ===")
    print(f"输入文件总数: {len(df)}")
    print(f"符合条件的候选文件: {len(all_candidates)} ({len(all_candidates)/len(df)*100:.2f}%)")
    print(f"成功复制种子文件: {success_count}/{len(selected_candidates)}")
    
    if failed_files:
        print(f"失败文件数: {len(failed_files)}")
        if len(failed_files) <= 5:
            print("失败文件列表:")
            for f in failed_files:
                print(f"  {os.path.basename(f)}")
    
    if success_count > 0:
        # 分析最终选择的分布
        print(f"\n=== 最终选择分析 ===")
        
        # 求解结果分布
        final_result_counts = selected_candidates['solver_result'].value_counts()
        print(f"求解结果分布:")
        for result, count in final_result_counts.items():
            print(f"  {result}: {count} ({count/len(selected_candidates)*100:.1f}%)")
        
        # 来源分布（确保source列存在）
        if 'source' in selected_candidates.columns:
            final_source_counts = selected_candidates['source'].value_counts()
            print(f"\n来源分布 (前10个):")
            for source, count in final_source_counts.head(10).items():
                print(f"  {source}: {count} ({count/len(selected_candidates)*100:.1f}%)")
        else:
            # 重新计算source列
            selected_candidates['source'] = selected_candidates['path'].apply(get_file_source)
            final_source_counts = selected_candidates['source'].value_counts()
            print(f"\n来源分布 (前10个):")
            for source, count in final_source_counts.head(10).items():
                print(f"  {source}: {count} ({count/len(selected_candidates)*100:.1f}%)")
        
        # Status分布
        final_status_counts = selected_candidates['status'].value_counts()
        print(f"\nStatus分布:")
        for status, count in final_status_counts.items():
            print(f"  {status}: {count} ({count/len(selected_candidates)*100:.1f}%)")
        
        # 数值分布
        print(f"\n数值分布:")
        print(f"文件大小: {selected_candidates['file_size'].min()}-{selected_candidates['file_size'].max()} bytes (平均: {selected_candidates['file_size'].mean():.0f})")
        print(f"变量数: {selected_candidates['var_count'].min()}-{selected_candidates['var_count'].max()} (平均: {selected_candidates['var_count'].mean():.1f})")
        print(f"子句数: {selected_candidates['clause_count'].min()}-{selected_candidates['clause_count'].max()} (平均: {selected_candidates['clause_count'].mean():.1f})")
        
        # 验证求解器结果一致性
        print(f"\n求解器结果一致性验证:")
        for solver in ['cvc5', 'z3', 'SLIA-z3-noodler', 'SLIA-ostrich']:
            reason_col = f'res_{solver}_reason'
            valid_count = 0
            for _, row in selected_candidates.iterrows():
                if not pd.isna(row[reason_col]) and row[reason_col] != 'unknown':
                    valid_count += 1
            print(f"  {solver}: {valid_count}/{len(selected_candidates)} 有效结果")
        
        # 验证所有求解器结果一致性
        consistent_results = 0
        for _, row in selected_candidates.iterrows():
            solver_reasons = []
            for solver in ['cvc5', 'z3', 'SLIA-z3-noodler', 'SLIA-ostrich']:
                reason_col = f'res_{solver}_reason'
                solver_reasons.append(row[reason_col])
            if len(set(solver_reasons)) == 1:
                consistent_results += 1
        print(f"  所有求解器结果一致: {consistent_results}/{len(selected_candidates)}")
        
        # 显示求解器结果分布
        if len(selected_candidates) > 0:
            first_solver_results = selected_candidates['res_cvc5_reason'].value_counts()
            print(f"\n求解器结果分布:")
            for result, count in first_solver_results.items():
                print(f"  {result}: {count} ({count/len(selected_candidates)*100:.1f}%)")
        
        # 显示一些选中文件的示例
        if 'file_name' in df.columns:
            sample_names = selected_candidates['file_name'].head(10).tolist()
            print(f"\n选中文件示例:")
            for name in sample_names:
                print(f"  {name}")
    
    print(f"\n筛选效率: 在 {len(df)} 行中找到 {len(all_candidates)} 个候选，选择了 {success_count} 个种子")

if __name__ == "__main__":
    args = parse_args()
    print(f"=== SMT2 种子选择工具 ===")
    print(f"从 {args.input_file} 选择 {args.num_seeds} 个种子")
    print(f"筛选条件:")
    print(f"- 文件大小: {args.min_file_size} - {args.max_file_size} bytes")
    print(f"- 变量数: {args.min_vars} - {args.max_vars}")
    print(f"- 子句数: {args.min_clauses} - {args.max_clauses}")
    print(f"- 所有求解器必须返回SUCCESS")
    print(f"- 所有求解器结果必须一致")
    print(f"- 选择策略: SAT和UNSAT各占50%")
    
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

# python scripts/select_seeds.py --input-file charts/QF_SLIA_updated.xlsx --num-seeds 100 --output-dir benchmarks/seeds