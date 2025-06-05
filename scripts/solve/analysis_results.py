#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Mutation Results Analysis Script
This script analyzes original files, mutated files, and solver results to create a comprehensive report.
Includes original results analysis and correctness change detection.

Usage:
    python analysis_results.py --seeds-dir <seeds_dir> --mutated-dirs <mutated_dir1> [<mutated_dir2> ...] --result-logs <log1> [<log2> ...] [--seeds-result-log <seeds_log>] --output-file <output_file>
    
Example:
    python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek benchmarks/seeds_mutate_openai benchmarks/seeds_mutate_claude --result-logs results/results_mutate_auto.log results/results_mutate_deepseek.log results/results_mutate_openai.log results/results_mutate_claude.log --seeds-result-log results/results_seeds.log --output-file charts/mutation_analysis_all.xlsx

Features:
- Analyzes original seed files and their solving results
- Compares mutated files with original results
- Detects correctness changes (SAT->UNSAT, UNSAT->SAT, etc.)
- Identifies serious correctness errors
- Provides comprehensive statistics on mutation effects
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
    parser.add_argument('--seeds-result-log', help='Result log file for original seed files (optional)')
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
    elif 'deepseek' in dir_name.lower():
        return 'deepseek'
    elif 'openai' in dir_name.lower():
        return 'openai'
    elif 'claude' in dir_name.lower():
        return 'claude'
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

def process_seeds_result_log(seeds_result_log):
    """Process the original seeds result log file."""
    if not seeds_result_log or not os.path.exists(seeds_result_log):
        print("No seeds result log provided or file not found")
        return {}
    
    print(f"Processing seeds result log: {seeds_result_log}")
    results = parse_result_log(seeds_result_log)
    
    seeds_results = {}
    for file_name, result in results.items():
        base_name = file_name.replace('.smt2', '') if file_name.endswith('.smt2') else file_name
        seeds_results[base_name] = result
    
    print(f"Processed {len(seeds_results)} original seed results")
    return seeds_results

def analyze_correctness_changes(original_result, mutated_result):
    """Analyze correctness changes between original and mutated results."""
    if not original_result or not mutated_result:
        return ""
    
    orig_sat = original_result.get('sat_result', '').upper()
    mut_sat = mutated_result.get('sat_result', '').upper()
    
    if orig_sat == 'SAT' and mut_sat == 'UNSAT':
        return "SAT->UNSAT"
    elif orig_sat == 'UNSAT' and mut_sat == 'SAT':
        return "UNSAT->SAT"
    elif orig_sat == 'SAT' and mut_sat == 'UNKNOWN':
        return "SAT->UNKNOWN"
    elif orig_sat == 'UNSAT' and mut_sat == 'UNKNOWN':
        return "UNSAT->UNKNOWN"
    elif orig_sat == 'UNKNOWN' and mut_sat == 'SAT':
        return "UNKNOWN->SAT"
    elif orig_sat == 'UNKNOWN' and mut_sat == 'UNSAT':
        return "UNKNOWN->UNSAT"
    elif orig_sat == mut_sat and orig_sat in ['SAT', 'UNSAT']:
        return "CONSISTENT"
    else:
        return ""

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

def create_comprehensive_report(seeds_data, mutated_data, results_data, seeds_results, output_file):
    """Create comprehensive Excel report with original results and correctness analysis."""
    report_data = []
    
    # 基于原始种子文件生成报告，确保每个原始文件一行
    for base_name in sorted(seeds_data.keys()):
        orig_data = seeds_data.get(base_name, {})
        orig_result = seeds_results.get(base_name, {})
        
        row = {
            'filename': base_name + '.smt2',
            'variables': orig_data.get('var_count', 0),
            'original_clauses': orig_data.get('clause_count', 0),
        }
        
        # 原始结果
        orig_sat_result = orig_result.get('sat_result', '')
        if not orig_sat_result:
            orig_sat_result = orig_result.get('result', '')
        row['original_result'] = orig_sat_result
        
        # 原始原因/时间
        orig_solving_time = orig_result.get('solving_time', '')
        if isinstance(orig_solving_time, (int, float)):
            orig_reason = f"{orig_solving_time:.2f}s"
        elif orig_solving_time:
            orig_reason = str(orig_solving_time)
        else:
            orig_solver_output = orig_result.get('solver_output', '')
            if 'timeout' in orig_solver_output.lower():
                orig_reason = 'timeout'
            elif 'error' in orig_solver_output.lower():
                orig_reason = 'error'
            elif orig_solver_output and len(orig_solver_output.strip()) > 0:
                orig_reason = 'completed'
            else:
                orig_reason = ''
        row['original_reason'] = orig_reason
        
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
        
        # Auto正确性分析
        row['mutate_auto_correctness'] = analyze_correctness_changes(orig_result, auto_result_info)
        
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
        
        # DeepSeek正确性分析
        row['mutate_deepseek_correctness'] = analyze_correctness_changes(orig_result, deepseek_result_info)
        
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
        
        # OpenAI正确性分析
        row['mutate_openai_correctness'] = analyze_correctness_changes(orig_result, openai_result_info)
        
        # Claude变异信息
        claude_mutated_info = mutated_data.get(base_name, {}).get('claude', {})
        claude_result_info = results_data.get(base_name, {}).get('claude', {})
        
        # Claude子句数
        claude_clause_count = claude_mutated_info.get('clause_count', 0)
        if claude_clause_count == 0 and orig_data.get('clause_count', 0) > 0:
            claude_clause_count = orig_data.get('clause_count', 0)
        row['mutate_claude_clauses'] = claude_clause_count
        
        # Claude结果
        claude_sat_result = claude_result_info.get('sat_result', '')
        if not claude_sat_result:
            claude_sat_result = claude_result_info.get('result', '')
        row['mutate_claude_result'] = claude_sat_result
        
        # Claude原因/时间
        claude_solving_time = claude_result_info.get('solving_time', '')
        if isinstance(claude_solving_time, (int, float)):
            claude_reason = f"{claude_solving_time:.2f}s"
        elif claude_solving_time:
            claude_reason = str(claude_solving_time)
        else:
            claude_solver_output = claude_result_info.get('solver_output', '')
            if 'timeout' in claude_solver_output.lower():
                claude_reason = 'timeout'
            elif 'error' in claude_solver_output.lower():
                claude_reason = 'error'
            elif claude_solver_output and len(claude_solver_output.strip()) > 0:
                claude_reason = 'completed'
            else:
                claude_reason = ''
        row['mutate_claude_reason'] = claude_reason
        
        # Claude正确性分析
        row['mutate_claude_correctness'] = analyze_correctness_changes(orig_result, claude_result_info)
        
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
                'original_result': 40,
                'original_reason': 40,
                'mutate_auto_clauses': 40,
                'mutate_auto_result': 40,
                'mutate_auto_reason': 40,
                'mutate_auto_correctness': 50,
                'mutate_deepseek_clauses': 40,
                'mutate_deepseek_result': 40,
                'mutate_deepseek_reason': 40,
                'mutate_deepseek_correctness': 50,
                'mutate_openai_clauses': 40,
                'mutate_openai_result': 40,
                'mutate_openai_reason': 40,
                'mutate_openai_correctness': 50,
                'mutate_claude_clauses': 40,
                'mutate_claude_result': 40,
                'mutate_claude_reason': 40,
                'mutate_claude_correctness': 50,
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
        original_results = len([x for x in df['original_result'] if x])
        auto_results = len([x for x in df['mutate_auto_result'] if x])
        deepseek_results = len([x for x in df['mutate_deepseek_result'] if x])
        openai_results = len([x for x in df['mutate_openai_result'] if x]) if 'mutate_openai_result' in df.columns else 0
        claude_results = len([x for x in df['mutate_claude_result'] if x]) if 'mutate_claude_result' in df.columns else 0
        
        print(f"\n统计:")
        print(f"  原始文件数: {len(df)}")
        print(f"  原始结果数: {original_results}")
        print(f"  mutate_auto有结果: {auto_results}")
        print(f"  mutate_deepseek有结果: {deepseek_results}")
        if openai_results > 0:
            print(f"  mutate_openai有结果: {openai_results}")
        if claude_results > 0:
            print(f"  mutate_claude有结果: {claude_results}")
        
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
        
        if claude_results > 0:
            claude_sat = len([x for x in df['mutate_claude_result'] if x and 'sat' in str(x).lower() and 'unsat' not in str(x).lower()])
            claude_unsat = len([x for x in df['mutate_claude_result'] if x and 'unsat' in str(x).lower()])
            claude_unknown = len([x for x in df['mutate_claude_result'] if x and 'unknown' in str(x).lower()])
            claude_unclear = len([x for x in df['mutate_claude_result'] if x and 'unclear' in str(x).lower()])
            claude_timeout = len([x for x in df['mutate_claude_result'] if x and 'timeout' in str(x).lower()])
            claude_error = len([x for x in df['mutate_claude_result'] if x and 'error' in str(x).lower()])
            claude_empty = len([x for x in df['mutate_claude_result'] if not x or str(x).strip() == ''])
            print(f"  mutate_claude结果分布: sat={claude_sat}, unsat={claude_unsat}, unknown={claude_unknown}, unclear={claude_unclear}, timeout={claude_timeout}, error={claude_error}, empty={claude_empty}")
        
        # 正确性分析统计
        print(f"\n正确性分析:")
        for mutation_type in ['auto', 'deepseek', 'openai', 'claude']:
            correctness_col = f'mutate_{mutation_type}_correctness'
            if correctness_col in df.columns:
                # 过滤掉空值和空字符串
                non_empty_values = [x for x in df[correctness_col] if x and str(x).strip()]
                if len(non_empty_values) > 0:
                    correctness_counts = pd.Series(non_empty_values).value_counts()
                    print(f"  {mutation_type}正确性变化:")
                    for change_type, count in correctness_counts.items():
                        print(f"    {change_type}: {count}")
                    
                    # 严重错误统计
                    serious_errors = len([x for x in non_empty_values if 'SAT->UNSAT' in str(x) or 'UNSAT->SAT' in str(x)])
                    if serious_errors > 0:
                        print(f"    ⚠️ 严重正确性错误: {serious_errors}")
        
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
    if args.seeds_result_log:
        print(f"  Seeds result log: {args.seeds_result_log}")
    print(f"  Output file: {args.output_file}")
    
    try:
        print("\n1. Processing original seed files...")
        seeds_data = process_seeds_directory(args.seeds_dir)
        
        print("\n2. Processing original seed results...")
        seeds_results = process_seeds_result_log(args.seeds_result_log)
        
        print("\n3. Processing mutated files...")
        mutated_data = process_mutated_directories(args.mutated_dirs)
        
        print("\n4. Processing result logs...")
        results_data = process_result_logs(args.result_logs)
        
        print("\n5. Creating comprehensive report...")
        create_comprehensive_report(seeds_data, mutated_data, results_data, seeds_results, args.output_file)
        
        print("\nAnalysis complete!")
        
    except Exception as e:
        print(f"Error during processing: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
