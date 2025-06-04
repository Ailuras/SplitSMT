#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Mutation Results Analysis Script
This script analyzes original files, mutated files, and solver results to create a comprehensive report.

Usage:
    python analysis_results.py --seeds-dir <seeds_dir> --mutated-dirs <mutated_dir1> [<mutated_dir2> ...] --result-logs <log1> [<log2> ...] --output-file <output_file>
    
Example:
    python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek --result-logs results/results_mutate_auto.log results/results_mutate_deepseek.log --output-file charts/mutation_analysis.xlsx
"""

import os
import re
import sys
import pandas as pd
import argparse
from pathlib import Path

def parse_args():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(description='Analyze mutation results and create comprehensive report.')
    parser.add_argument('--seeds-dir', required=True, help='Directory containing original seed files')
    parser.add_argument('--mutated-dirs', nargs='+', required=True, help='One or more directories containing mutated files')
    parser.add_argument('--result-logs', nargs='+', required=True, help='One or more result log files')
    parser.add_argument('--output-file', required=True, help='Output Excel file to save results')
    parser.add_argument('--output-dir', default='charts', help='Directory to save the Excel report')
    
    return parser.parse_args()

def extract_metadata(file_path):
    """Extract metadata from an SMT2 file."""
    metadata = {
        "theory": "",
        "category": "",
        "status": "",
        "target": "",
        "var_count": 0,
        "clause_count": 0,
        "file_size": 0
    }
    
    try:
        file_size = os.path.getsize(file_path)
        metadata["file_size"] = file_size
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
            logic_match = re.search(r'\(set-logic\s+([^\)]+)\)', content)
            if logic_match:
                metadata["theory"] = logic_match.group(1).strip()
            
            category_match = re.search(r'\(set-info\s+:category\s+"([^"]+)"\)', content)
            if category_match:
                metadata["category"] = category_match.group(1).strip()
            
            status_match = re.search(r'\(set-info\s+:status\s+([^\)]+)\)', content)
            if status_match:
                metadata["status"] = status_match.group(1).strip()
            
            target_match = re.search(r'Target solver:\s*([^\n\r,.]+)', content)
            if target_match:
                metadata["target"] = target_match.group(1).strip()
            
            var_count = len(re.findall(r'\(declare-(?:fun|const)\s+', content))
            metadata["var_count"] = var_count
            clause_count = len(re.findall(r'\(assert\s+', content))
            metadata["clause_count"] = clause_count
            
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
    
    return metadata

def process_seeds_directory(seeds_dir):
    """Process original seed files and extract metadata."""
    seeds_data = {}
    
    try:
        smt2_files = []
        for file in os.listdir(seeds_dir):
            if file.endswith('.smt2'):
                smt2_files.append(file)
        smt2_files = sorted(smt2_files)
        print(f"Found {len(smt2_files)} seed files")
    except FileNotFoundError:
        print(f"Seeds directory {seeds_dir} not found!")
        return {}
    
    for file_name in smt2_files:
        file_path = os.path.join(seeds_dir, file_name)
        base_name = file_name.replace('.smt2', '')
        
        metadata = extract_metadata(file_path)
        metadata.update({
            "original_file": file_name,
            "original_path": file_path,
            "base_name": base_name
        })
        
        seeds_data[base_name] = metadata
    
    return seeds_data

def get_mutation_type_from_dir(dir_path):
    """Determine mutation type from directory name."""
    dir_name = os.path.basename(dir_path)
    if 'auto' in dir_name.lower():
        return 'auto'
    elif 'deepseek' in dir_name.lower() or 'llm' in dir_name.lower():
        return 'deepseek'
    else:
        return 'unknown'

def process_mutated_directories(mutated_dirs):
    """Process mutated files from multiple directories."""
    mutated_data = {}
    
    for mutated_dir in mutated_dirs:
        if not os.path.exists(mutated_dir):
            print(f"Warning: Mutated directory not found: {mutated_dir}")
            continue
            
        mutation_type = get_mutation_type_from_dir(mutated_dir)
        print(f"Processing {mutation_type} mutations from: {mutated_dir}")
        
        try:
            smt2_files = []
            for file in os.listdir(mutated_dir):
                if file.endswith('.smt2'):
                    smt2_files.append(file)
            smt2_files = sorted(smt2_files)
            print(f"Found {len(smt2_files)} mutated files")
        except Exception as e:
            print(f"Error reading directory {mutated_dir}: {e}")
            continue
        
        for file_name in smt2_files:
            file_path = os.path.join(mutated_dir, file_name)
            
            base_name = extract_base_name_from_mutated(file_name)
            if not base_name:
                continue
                
            if base_name not in mutated_data:
                mutated_data[base_name] = {}
            
            metadata = extract_metadata(file_path)
            mutated_data[base_name][mutation_type] = {
                "file_name": file_name,
                "file_path": file_path,
                "theory": metadata["theory"],
                "category": metadata["category"],
                "status": metadata["status"],
                "target": metadata["target"],
                "var_count": metadata["var_count"],
                "clause_count": metadata["clause_count"],
                "file_size": metadata["file_size"]
            }
    
    return mutated_data

def extract_base_name_from_mutated(mutated_filename):
    """Extract base name from mutated filename."""
    if mutated_filename.endswith('.smt2'):
        return mutated_filename.replace('.smt2', '')
    else:
        return None

def parse_result_log(log_file):
    """Parse a result log file and extract solving results."""
    results = {}
    current_file = None
    
    encodings = ['utf-8', 'latin-1', 'cp1252']
    file_content = None
    
    for encoding in encodings:
        try:
            with open(log_file, 'r', encoding=encoding) as f:
                file_content = f.readlines()
            break
        except UnicodeDecodeError:
            continue
        except Exception as e:
            print(f"Error opening log file {log_file} with encoding {encoding}: {e}")
            
    if file_content is None:
        print(f"Could not read log file {log_file} with any encoding")
        return results
    
    current_result = {}
    solver_output = []
    in_output_section = False
    
    try:
        for line in file_content:
            line = line.strip()
            
            if not line or line.startswith('=='):
                continue
            
            if line.startswith('FILE:'):
                if current_file and current_result:
                    current_result['solver_output'] = '\n'.join(solver_output)
                    results[current_file] = current_result
                
                current_file = line.split(':', 1)[1].strip()
                current_result = {}
                solver_output = []
                in_output_section = False
                
            elif line.startswith('SOLVING_TIME:'):
                try:
                    current_result['solving_time'] = float(line.split(':', 1)[1].strip())
                except:
                    current_result['solving_time'] = line.split(':', 1)[1].strip()
                    
            elif line.startswith('RESULT:'):
                current_result['result'] = line.split(':', 1)[1].strip()
                
            elif line.startswith('SAT_RESULT:'):
                current_result['sat_result'] = line.split(':', 1)[1].strip()
                
            elif line.startswith('-'):
                if in_output_section:
                    in_output_section = False
                else:
                    in_output_section = True
                    
            elif in_output_section:
                if not any(skip in line.lower() for skip in ['copyright', '(c)', 'with contributions', 'for more information']):
                    solver_output.append(line)
                    
    except Exception as e:
        print(f"Error parsing log file {log_file}: {e}")
    
    if current_file and current_result:
        current_result['solver_output'] = '\n'.join(solver_output)
        results[current_file] = current_result
    
    return results

def process_result_logs(result_logs):
    """Process all result log files."""
    all_results = {}
    
    for log_file in result_logs:
        if not os.path.exists(log_file):
            print(f"Warning: Result log file not found: {log_file}")
            continue
            
        print(f"Processing result log: {log_file}")
        
        log_name = os.path.basename(log_file)
        # 改进mutation_type检测逻辑
        if 'auto' in log_name.lower():
            mutation_type = 'auto'
        elif 'deepseek' in log_name.lower():
            mutation_type = 'deepseek'
        elif 'openai' in log_name.lower():
            mutation_type = 'openai'
        elif 'claude' in log_name.lower():
            mutation_type = 'claude'
        else:
            mutation_type = 'unknown'
            print(f"Warning: Could not determine mutation type from log file name: {log_name}")
        
        print(f"Detected mutation type: {mutation_type}")
        
        results = parse_result_log(log_file)
        print(f"Raw results from {log_file}: {len(results)} entries")
        
        processed_count = 0
        for file_name, result in results.items():
            base_name = extract_base_name_from_mutated(file_name)
            if not base_name:
                print(f"Warning: Could not extract base name from: {file_name}")
                continue
                
            if base_name not in all_results:
                all_results[base_name] = {}
                
            all_results[base_name][mutation_type] = result
            processed_count += 1
            
        print(f"Processed {processed_count} results from {log_file} (mutation_type: {mutation_type})")
        
        # 调试信息：显示一些样例结果
        if processed_count > 0:
            sample_results = list(results.items())[:3]
            for file_name, result in sample_results:
                sat_result = result.get('sat_result', 'N/A')
                print(f"  Sample: {file_name} -> {sat_result}")
    
    print(f"Total unique base files processed: {len(all_results)}")
    return all_results

def clean_text_for_excel(text):
    """Clean text by removing illegal characters for Excel."""
    if not isinstance(text, str):
        return str(text)
    try:
        cleaned = ''.join(char for char in text if 32 <= ord(char) <= 126 or char in '\n\r\t')
        cleaned = cleaned.replace('\n', ' ').replace('\r', ' ').replace('\t', ' ')
        return cleaned[:100]
    except Exception as e:
        return ""

def create_comprehensive_report(seeds_data, mutated_data, results_data, output_file):
    """Create comprehensive Excel report with simplified column format."""
    report_data = []
    
    # 基于原始种子文件生成报告，确保每个原始文件一行
    for base_name in sorted(seeds_data.keys()):
        orig_data = seeds_data.get(base_name, {})
        
        row = {
            'filename': base_name + '.smt2',
            'variables': orig_data.get('var_count', 0),
            'original_clauses': orig_data.get('clause_count', 0),
        }
        
        # Auto变异信息
        auto_mutated_info = mutated_data.get(base_name, {}).get('auto', {})
        auto_result_info = results_data.get(base_name, {}).get('auto', {})
        
        # Auto子句数
        auto_clause_count = auto_mutated_info.get('clause_count', 0)
        if auto_clause_count == 0 and orig_data.get('clause_count', 0) > 0:
            auto_clause_count = orig_data.get('clause_count', 0)
        row['mutate_auto_clauses'] = auto_clause_count
        
        # Auto结果
        auto_sat_result = auto_result_info.get('sat_result', '')
        if not auto_sat_result:
            auto_sat_result = auto_result_info.get('result', '')
        row['mutate_auto_result'] = auto_sat_result
        
        # Auto原因/时间
        auto_solving_time = auto_result_info.get('solving_time', '')
        if isinstance(auto_solving_time, (int, float)):
            auto_reason = f"{auto_solving_time:.2f}s"
        elif auto_solving_time:
            auto_reason = str(auto_solving_time)
        else:
            auto_solver_output = auto_result_info.get('solver_output', '')
            if 'timeout' in auto_solver_output.lower():
                auto_reason = 'timeout'
            elif 'error' in auto_solver_output.lower():
                auto_reason = 'error'
            elif auto_solver_output and len(auto_solver_output.strip()) > 0:
                auto_reason = 'completed'
            else:
                auto_reason = ''
        row['mutate_auto_reason'] = auto_reason
        
        # DeepSeek变异信息
        deepseek_mutated_info = mutated_data.get(base_name, {}).get('deepseek', {})
        deepseek_result_info = results_data.get(base_name, {}).get('deepseek', {})
        
        # DeepSeek子句数
        deepseek_clause_count = deepseek_mutated_info.get('clause_count', 0)
        if deepseek_clause_count == 0 and orig_data.get('clause_count', 0) > 0:
            deepseek_clause_count = orig_data.get('clause_count', 0)
        row['mutate_deepseek_clauses'] = deepseek_clause_count
        
        # DeepSeek结果
        deepseek_sat_result = deepseek_result_info.get('sat_result', '')
        if not deepseek_sat_result:
            deepseek_sat_result = deepseek_result_info.get('result', '')
        row['mutate_deepseek_result'] = deepseek_sat_result
        
        # DeepSeek原因/时间
        deepseek_solving_time = deepseek_result_info.get('solving_time', '')
        if isinstance(deepseek_solving_time, (int, float)):
            deepseek_reason = f"{deepseek_solving_time:.2f}s"
        elif deepseek_solving_time:
            deepseek_reason = str(deepseek_solving_time)
        else:
            deepseek_solver_output = deepseek_result_info.get('solver_output', '')
            if 'timeout' in deepseek_solver_output.lower():
                deepseek_reason = 'timeout'
            elif 'error' in deepseek_solver_output.lower():
                deepseek_reason = 'error'
            elif deepseek_solver_output and len(deepseek_solver_output.strip()) > 0:
                deepseek_reason = 'completed'
            else:
                deepseek_reason = ''
        row['mutate_deepseek_reason'] = deepseek_reason
        
        # OpenAI变异信息
        openai_mutated_info = mutated_data.get(base_name, {}).get('openai', {})
        openai_result_info = results_data.get(base_name, {}).get('openai', {})
        
        # OpenAI子句数
        openai_clause_count = openai_mutated_info.get('clause_count', 0)
        if openai_clause_count == 0 and orig_data.get('clause_count', 0) > 0:
            openai_clause_count = orig_data.get('clause_count', 0)
        row['mutate_openai_clauses'] = openai_clause_count
        
        # OpenAI结果
        openai_sat_result = openai_result_info.get('sat_result', '')
        if not openai_sat_result:
            openai_sat_result = openai_result_info.get('result', '')
        row['mutate_openai_result'] = openai_sat_result
        
        # OpenAI原因/时间
        openai_solving_time = openai_result_info.get('solving_time', '')
        if isinstance(openai_solving_time, (int, float)):
            openai_reason = f"{openai_solving_time:.2f}s"
        elif openai_solving_time:
            openai_reason = str(openai_solving_time)
        else:
            openai_solver_output = openai_result_info.get('solver_output', '')
            if 'timeout' in openai_solver_output.lower():
                openai_reason = 'timeout'
            elif 'error' in openai_solver_output.lower():
                openai_reason = 'error'
            elif openai_solver_output and len(openai_solver_output.strip()) > 0:
                openai_reason = 'completed'
            else:
                openai_reason = ''
        row['mutate_openai_reason'] = openai_reason
        
        report_data.append(row)
    
    df = pd.DataFrame(report_data)
    
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    
    try:
        with pd.ExcelWriter(output_file, engine='openpyxl') as writer:
            df.to_excel(writer, index=False, sheet_name='变异分析')
            
            worksheet = writer.sheets['变异分析']
            
            # 设置列宽
            column_widths = {
                'filename': 100,
                'variables': 30,
                'original_clauses': 30,
                'mutate_auto_clauses': 40,
                'mutate_auto_result': 40,
                'mutate_auto_reason': 40,
                'mutate_deepseek_clauses': 40,
                'mutate_deepseek_result': 40,
                'mutate_deepseek_reason': 40,
                'mutate_openai_clauses': 40,
                'mutate_openai_result': 40,
                'mutate_openai_reason': 40,
            }
            
            for i, col in enumerate(df.columns):
                column_letter = chr(65 + i) if i < 26 else chr(65 + i // 26 - 1) + chr(65 + i % 26)
                width = column_widths.get(col, 15)
                try:
                    worksheet.column_dimensions[column_letter].width = width
                except:
                    pass
        
        print(f"变异分析报告已保存到: {output_file}")
        print(f"总条目数: {len(df)}")
        
        # 统计信息
        auto_results = len([x for x in df['mutate_auto_result'] if x])
        deepseek_results = len([x for x in df['mutate_deepseek_result'] if x])
        openai_results = len([x for x in df['mutate_openai_result'] if x]) if 'mutate_openai_result' in df.columns else 0
        
        print(f"\n统计:")
        print(f"  原始文件数: {len(df)}")
        print(f"  mutate_auto有结果: {auto_results}")
        print(f"  mutate_deepseek有结果: {deepseek_results}")
        if openai_results > 0:
            print(f"  mutate_openai有结果: {openai_results}")
        
        # 结果分布统计
        if auto_results > 0:
            auto_sat = len([x for x in df['mutate_auto_result'] if x and 'sat' in str(x).lower() and 'unsat' not in str(x).lower()])
            auto_unsat = len([x for x in df['mutate_auto_result'] if x and 'unsat' in str(x).lower()])
            auto_unknown = len([x for x in df['mutate_auto_result'] if x and 'unknown' in str(x).lower()])
            auto_unclear = len([x for x in df['mutate_auto_result'] if x and 'unclear' in str(x).lower()])
            auto_timeout = len([x for x in df['mutate_auto_result'] if x and 'timeout' in str(x).lower()])
            auto_error = len([x for x in df['mutate_auto_result'] if x and 'error' in str(x).lower()])
            auto_empty = len([x for x in df['mutate_auto_result'] if not x or str(x).strip() == ''])
            print(f"  mutate_auto结果分布: sat={auto_sat}, unsat={auto_unsat}, unknown={auto_unknown}, unclear={auto_unclear}, timeout={auto_timeout}, error={auto_error}, empty={auto_empty}")
        
        if deepseek_results > 0:
            deepseek_sat = len([x for x in df['mutate_deepseek_result'] if x and 'sat' in str(x).lower() and 'unsat' not in str(x).lower()])
            deepseek_unsat = len([x for x in df['mutate_deepseek_result'] if x and 'unsat' in str(x).lower()])
            deepseek_unknown = len([x for x in df['mutate_deepseek_result'] if x and 'unknown' in str(x).lower()])
            deepseek_unclear = len([x for x in df['mutate_deepseek_result'] if x and 'unclear' in str(x).lower()])
            deepseek_timeout = len([x for x in df['mutate_deepseek_result'] if x and 'timeout' in str(x).lower()])
            deepseek_error = len([x for x in df['mutate_deepseek_result'] if x and 'error' in str(x).lower()])
            deepseek_empty = len([x for x in df['mutate_deepseek_result'] if not x or str(x).strip() == ''])
            print(f"  mutate_deepseek结果分布: sat={deepseek_sat}, unsat={deepseek_unsat}, unknown={deepseek_unknown}, unclear={deepseek_unclear}, timeout={deepseek_timeout}, error={deepseek_error}, empty={deepseek_empty}")
        
        if openai_results > 0:
            openai_sat = len([x for x in df['mutate_openai_result'] if x and 'sat' in str(x).lower() and 'unsat' not in str(x).lower()])
            openai_unsat = len([x for x in df['mutate_openai_result'] if x and 'unsat' in str(x).lower()])
            openai_unknown = len([x for x in df['mutate_openai_result'] if x and 'unknown' in str(x).lower()])
            openai_unclear = len([x for x in df['mutate_openai_result'] if x and 'unclear' in str(x).lower()])
            openai_timeout = len([x for x in df['mutate_openai_result'] if x and 'timeout' in str(x).lower()])
            openai_error = len([x for x in df['mutate_openai_result'] if x and 'error' in str(x).lower()])
            openai_empty = len([x for x in df['mutate_openai_result'] if not x or str(x).strip() == ''])
            print(f"  mutate_openai结果分布: sat={openai_sat}, unsat={openai_unsat}, unknown={openai_unknown}, unclear={openai_unclear}, timeout={openai_timeout}, error={openai_error}, empty={openai_empty}")
        
    except Exception as e:
        print(f"创建Excel文件时出错: {e}")
        import traceback
        traceback.print_exc()

def main():
    args = parse_args()
    
    if not os.path.exists(args.seeds_dir):
        print(f"Error: Seeds directory not found: {args.seeds_dir}")
        sys.exit(1)
    
    print(f"Processing configuration:")
    print(f"  Seeds directory: {args.seeds_dir}")
    print(f"  Mutated directories: {', '.join(args.mutated_dirs)}")
    print(f"  Result logs: {', '.join(args.result_logs)}")
    print(f"  Output file: {args.output_file}")
    
    try:
        print("\n1. Processing original seed files...")
        seeds_data = process_seeds_directory(args.seeds_dir)
        
        print("\n2. Processing mutated files...")
        mutated_data = process_mutated_directories(args.mutated_dirs)
        
        print("\n3. Processing result logs...")
        results_data = process_result_logs(args.result_logs)
        
        print("\n4. Creating comprehensive report...")
        create_comprehensive_report(seeds_data, mutated_data, results_data, args.output_file)
        
        print("\nAnalysis complete!")
        
    except Exception as e:
        print(f"Error during processing: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
