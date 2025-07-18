#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
General Solver Results Analysis Script
This script analyzes solver results based on task names and generates comprehensive reports.

Usage:
    python analysis_results.py --task <task_name> --results-dir <results_dir> --output-file <output_file>
    
Examples:
    # Analyze specific task datasets
    python scripts/solve/analysis_results.py --task top20_gh --results-dir results --output-file charts/top20_gh_analysis.xlsx
    python scripts/solve/analysis_results.py --task awesome --results-dir results --output-file charts/awesome_analysis.xlsx
    
    # Analyze all log files
    python scripts/solve/analysis_results.py --task ext --results-dir results --output-file charts/all_analysis.xlsx

Features:
- Automatically finds log files based on task name (use 'log' to match all .log files)
- Extracts solver type from SOLVER_TYPE field in log content (not filename)
- Analyzes SMT2 formula properties (defines, declares, asserts)
- Generates comprehensive Excel reports with solver comparisons
- Includes log file source information for each result
- Supports both solver-specific and dataset-specific analysis
- Handles ANSI color codes in solver output
- Split operation analysis with separator type classification:
  * VAR: Variable separators (highest priority)
  * RE: Regular expression separators (contains regex characters)
  * MUL: Multi-character string separators
  * SIN: Single-character string separators

Changes from previous version:
- Removed 'status' column, added 'log' column showing source log file
- Solver type detection now uses SOLVER_TYPE field from log content
- Task matching: use 'log' to analyze all log files, or specific task name for subset
- Fixed ANSI character handling for Excel compatibility
- Added comprehensive split operation analysis
- Added VAR separator type for variable delimiters (priority: VAR > RE > MUL > SIN)
"""

import os
import re
import sys
import pandas as pd
import argparse
import glob
from pathlib import Path

def clean_ansi_sequences(text):
    """Remove ANSI color codes and control sequences from text."""
    if not isinstance(text, str):
        return text
    # Remove ANSI escape sequences
    ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
    return ansi_escape.sub('', text)

def parse_args():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(description='Analyze solver results based on task name.')
    parser.add_argument('--task', required=True, help='Task name to analyze (e.g., top20_gh, z3-noodler, or "log" for all .log files)')
    parser.add_argument('--results-dir', default='results', help='Directory containing result log files')
    parser.add_argument('--output-file', required=True, help='Output Excel file to save results')
    
    return parser.parse_args()

def find_log_files_by_task(results_dir, task_name):
    """Find all log files related to the given task name."""
    log_files = []
    
    if task_name.lower() == 'log':
        # Match all .log files
        pattern = os.path.join(results_dir, "*.log")
    else:
        # Match files containing the task name
        pattern = os.path.join(results_dir, f"*{task_name}*.log")
    
    for log_file in glob.glob(pattern):
        log_files.append(log_file)
    
    return sorted(log_files)

def extract_solver_type_from_log_content(log_content):
    """Extract solver type from log file content by reading SOLVER_TYPE field."""
    solver_types = set()
    
    for line in log_content:
        line = line.strip()
        if line.startswith('SOLVER_TYPE:'):
            solver_type = line.split(':', 1)[1].strip()
            solver_types.add(solver_type)
    
    # Return the most common solver type or 'mixed' if multiple types found
    if len(solver_types) == 1:
        return list(solver_types)[0]
    elif len(solver_types) > 1:
        return 'mixed'
    else:
        return 'unknown'

def extract_solver_info_from_filename(filename):
    """Extract solver information from log filename (kept for backward compatibility)."""
    # Remove .log extension and path
    name = os.path.basename(filename).replace('.log', '')
    
    # Extract solver type (look for ext-xxx pattern or built-in solvers)
    if 'ext-z3-noodler' in name:
        return 'ext-z3-noodler'
    elif 'ext-z3' in name:
        return 'ext-z3'
    elif 'ext-cvc5' in name:
        return 'ext-cvc5'
    elif 'ext-ostrich' in name:
        return 'ext-ostrich'
    elif 'z3-noodler' in name:
        return 'z3-noodler'
    elif 'z3' in name:
        return 'z3'
    elif 'cvc5' in name:
        return 'cvc5'
    elif 'ostrich' in name:
        return 'ostrich'
    else:
        return 'unknown'

def parse_result_log(log_file):
    """Parse a result log file and extract solving results."""
    results = {}
    current_file = None
    log_filename = os.path.basename(log_file)
    
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
    solver_type = None
    
    try:
        for line in file_content:
            line = line.strip()
            
            if not line or line.startswith('=='):
                continue
            
            # Extract solver type from header
            if line.startswith('Solver Type:') or line.startswith('SOLVER_TYPE:'):
                solver_type = line.split(':', 1)[1].strip()
                continue
            
            if line.startswith('FILE:'):
                if current_file and current_result:
                    current_result['solver_output'] = clean_ansi_sequences('\n'.join(solver_output))
                    current_result['solver_type'] = solver_type
                    current_result['log_file'] = log_filename
                    results[current_file] = current_result
                
                current_file = line.split(':', 1)[1].strip()
                current_result = {}
                solver_output = []
                in_output_section = False
                
            elif line.startswith('PATH:'):
                current_result['path'] = line.split(':', 1)[1].strip()
                
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
                    solver_output.append(clean_ansi_sequences(line))
                    
    except Exception as e:
        print(f"Error parsing log file {log_file}: {e}")
    
    if current_file and current_result:
        current_result['solver_output'] = clean_ansi_sequences('\n'.join(solver_output))
        current_result['solver_type'] = solver_type
        current_result['log_file'] = log_filename
        results[current_file] = current_result
    
    return results

def analyze_split_operations(content):
    """Analyze split operations in SMT2 file."""
    import re
    
    split_info = {
        "get_split_length_count": 0,
        "get_split_element_count": 0,
        "split_groups": {},  # {(var, delimiter): count}
        # Separator types (can have multiple 1s)
        "separator_VAR": 0,
        "separator_RE": 0,
        "separator_MUL": 0,
        "separator_SIN": 0,
        # Index types (can have multiple 1s)
        "index_VAR": 0,
        "index_CONST": 0,
        # API types (can have multiple 1s)
        "api_Normal": 0,
        "api_Limit": 0,
        "max_const_index": -1
    }
    
    # Find all get_split_length calls (support both string literals and variables as delimiters)
    length_pattern = r'\(get_split_length\s+(\S+)\s+("([^"]+)"|([a-zA-Z_]\w*))\s+(-?\d+|[a-zA-Z_]\w*)\)'
    length_matches = re.findall(length_pattern, content)
    split_info["get_split_length_count"] = len(length_matches)
    
    # Find all get_split_element calls (support both string literals and variables as delimiters)
    element_pattern = r'\(get_split_element\s+(\S+)\s+("([^"]+)"|([a-zA-Z_]\w*))\s+(-?\d+|[a-zA-Z_]\w*)\s+(-?\d+|[a-zA-Z_]\w*)\)'
    element_matches = re.findall(element_pattern, content)
    split_info["get_split_element_count"] = len(element_matches)
    
    # Collect split groups and analyze separators
    all_separators = []
    api_types = []
    
    for var, delimiter_full, delimiter_str, delimiter_var, limit in length_matches:
        # Determine actual delimiter value
        if delimiter_str:  # String literal
            delimiter = delimiter_str
        else:  # Variable
            delimiter = delimiter_var
        
        key = (var, delimiter)
        split_info["split_groups"][key] = split_info["split_groups"].get(key, 0) + 1
        all_separators.append((delimiter, delimiter_var is not None and delimiter_var != ''))
        
        # Analyze API type
        try:
            limit_val = int(limit)
            if limit_val == -1:
                api_types.append("Normal")
            else:  # limit_val >= 0, any non-negative value other than -1
                api_types.append("Limit")
        except ValueError:
            api_types.append("Limit")  # Variable limit is considered as Limit
    
    for var, delimiter_full, delimiter_str, delimiter_var, limit, index in element_matches:
        # Determine actual delimiter value
        if delimiter_str:  # String literal
            delimiter = delimiter_str
        else:  # Variable
            delimiter = delimiter_var
            
        key = (var, delimiter)
        split_info["split_groups"][key] = split_info["split_groups"].get(key, 0) + 1
        all_separators.append((delimiter, delimiter_var is not None and delimiter_var != ''))
        
        # Analyze API type
        try:
            limit_val = int(limit)
            if limit_val == -1:
                api_types.append("Normal")
            else:  # limit_val >= 0, any non-negative value other than -1
                api_types.append("Limit")
        except ValueError:
            api_types.append("Limit")
    
    # Analyze separator types (set flags for each type found)
    if all_separators:
        for sep_value, is_var in all_separators:
            if is_var:
                split_info["separator_VAR"] = 1
            else:
                # Check for regex characters
                regex_chars = ['|', '*', '+', '?', '^', '$', '[', ']', '(', ')', '{', '}', '.', '\\']
                if any(char in sep_value for char in regex_chars):
                    split_info["separator_RE"] = 1
                if len(sep_value) > 1:
                    split_info["separator_MUL"] = 1
                if len(sep_value) == 1:
                    split_info["separator_SIN"] = 1
    
    # Analyze index types and find max constant index
    const_indices = []
    
    for var, delimiter_full, delimiter_str, delimiter_var, limit, index in element_matches:
        try:
            index_val = int(index)
            split_info["index_CONST"] = 1
            const_indices.append(index_val)
        except ValueError:
            split_info["index_VAR"] = 1
    
    # Find max constant index
    if const_indices:
        split_info["max_const_index"] = max(const_indices)
    
    # Analyze API types (set flags for each type found)
    if api_types:
        if "Normal" in api_types:
            split_info["api_Normal"] = 1
        if "Limit" in api_types:
            split_info["api_Limit"] = 1
    
    return split_info

def analyze_smt2_file(file_path):
    """Analyze SMT2 file and extract formula properties."""
    properties = {
        "defines": 0,
        "declares": 0,
        "asserts": 0,
        "theory": "",
        "file_size": 0,
        # Split operation statistics
        "get_split_length_count": 0,
        "get_split_element_count": 0,
        "split_groups_count": 0,
        # Separator types (can have multiple 1s)
        "separator_VAR": 0,
        "separator_RE": 0,
        "separator_MUL": 0,
        "separator_SIN": 0,
        # Index types (can have multiple 1s)
        "index_VAR": 0,
        "index_CONST": 0,
        # API types (can have multiple 1s)
        "api_Normal": 0,
        "api_Limit": 0,
        "max_const_index": -1
    }
    
    try:
        if not os.path.exists(file_path):
            return properties
            
        file_size = os.path.getsize(file_path)
        properties["file_size"] = file_size
        
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
            # Count different types of declarations
            properties["defines"] = len(re.findall(r'\(define-', content))
            properties["declares"] = len(re.findall(r'\(declare-', content))
            properties["asserts"] = len(re.findall(r'\(assert\s+', content))
            
            # Extract logic
            logic_match = re.search(r'\(set-logic\s+([^\)]+)\)', content)
            if logic_match:
                properties["theory"] = logic_match.group(1).strip()
            
            # Analyze split operations
            split_info = analyze_split_operations(content)
            properties.update(split_info)
            properties["split_groups_count"] = len(split_info["split_groups"])
            
    except Exception as e:
        print(f"Error analyzing {file_path}: {e}")
    
    return properties

def create_analysis_report(task_name, log_files, output_file):
    """Create comprehensive analysis report."""
    print(f"Creating analysis report for task: {task_name}")
    print(f"Log files: {[os.path.basename(f) for f in log_files]}")
    
    # Parse all log files
    all_results = {}
    solvers = []
    
    for log_file in log_files:
        print(f"Processing {os.path.basename(log_file)}")
        
        results = parse_result_log(log_file)
        
        # Extract solver type from log content
        with open(log_file, 'r', encoding='utf-8') as f:
            log_content = f.readlines()
        solver_name = extract_solver_type_from_log_content(log_content)
        solvers.append(solver_name)
        print(f"  -> {solver_name}")
        
        for file_name, result in results.items():
            if file_name not in all_results:
                all_results[file_name] = {}
            # Use a unique key that includes log filename to handle multiple logs with same solver type
            unique_key = f"{solver_name}_{os.path.basename(log_file)}"
            all_results[file_name][unique_key] = result
    
    # Get unique solver types
    unique_solvers = sorted(list(set(solvers)))
    print(f"Found solver types: {unique_solvers}")
    
    # Create Excel report
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    
    with pd.ExcelWriter(output_file, engine='openpyxl') as writer:
        
        # Main analysis sheet
        analysis_data = []
        
        for file_name in sorted(all_results.keys()):
            # Get file path from any solver result
            file_path = None
            log_file = None
            for unique_key in all_results[file_name]:
                result = all_results[file_name][unique_key]
                file_path = result.get('path', '')
                log_file = result.get('log_file', '')
                if file_path:
                    break
            
            # Analyze SMT2 file properties
            if file_path and os.path.exists(file_path):
                properties = analyze_smt2_file(file_path)
            else:
                properties = analyze_smt2_file(f"benchmarks/{task_name}/{file_name}")
            
            row = {
                'filename': file_name,
                'path': file_path or f"benchmarks/{task_name}/{file_name}",
                'log': log_file,
                'defines': properties['defines'],
                'declares': properties['declares'],
                'asserts': properties['asserts'],
                'theory': properties['theory'],
                'file_size': properties['file_size'],
                # Split statistics
                'get_split_length_count': properties['get_split_length_count'],
                'get_split_element_count': properties['get_split_element_count'],
                'split_groups_count': properties['split_groups_count'],
                # Separator types (multiple columns)
                'separator_VAR': properties['separator_VAR'],
                'separator_RE': properties['separator_RE'],
                'separator_MUL': properties['separator_MUL'],
                'separator_SIN': properties['separator_SIN'],
                # Index types (multiple columns)
                'index_VAR': properties['index_VAR'],
                'index_CONST': properties['index_CONST'],
                # API types (multiple columns)
                'api_Normal': properties['api_Normal'],
                'api_Limit': properties['api_Limit'],
                'max_const_index': properties['max_const_index']
            }
            
            # Add solver results
            for unique_key in all_results[file_name]:
                result = all_results[file_name][unique_key]
                solver_type = result.get('solver_type', 'unknown')
                
                # Solving time
                solving_time = result.get('solving_time', '')
                if isinstance(solving_time, (int, float)):
                    row[f'{solver_type}_time'] = solving_time
                else:
                    row[f'{solver_type}_time'] = ''
                
                # SAT result
                sat_result = result.get('sat_result', '')
                row[f'{solver_type}_result'] = sat_result
                
                # Solver output (truncated)
                solver_output = result.get('solver_output', '')
                solver_output = clean_ansi_sequences(solver_output)
                if solver_output and len(solver_output) > 100:
                    solver_output = solver_output[:100] + "..."
                row[f'{solver_type}_output'] = solver_output
            
            analysis_data.append(row)
        
        # Create main analysis DataFrame
        df_analysis = pd.DataFrame(analysis_data)
        df_analysis.to_excel(writer, index=False, sheet_name='Analysis')
        
        # Create solver comparison sheet
        comparison_data = []
        
        for solver_type in unique_solvers:
            solver_results = []
            solver_times = []
            
            for file_name in all_results.keys():
                for unique_key in all_results[file_name]:
                    result = all_results[file_name][unique_key]
                    if result.get('solver_type') == solver_type:
                        sat_result = result.get('sat_result', '')
                        solving_time = result.get('solving_time', '')
                        
                        if sat_result:
                            solver_results.append(sat_result)
                        
                        if isinstance(solving_time, (int, float)):
                            solver_times.append(solving_time)
            
            # Calculate statistics
            total_files = len(solver_results)
            sat_count = len([r for r in solver_results if r.upper() == 'SAT'])
            unsat_count = len([r for r in solver_results if r.upper() == 'UNSAT'])
            unknown_count = len([r for r in solver_results if r.upper() == 'UNKNOWN'])
            error_count = len([r for r in solver_results if r.upper() == 'ERROR'])
            
            avg_time = sum(solver_times) / len(solver_times) if solver_times else 0
            max_time = max(solver_times) if solver_times else 0
            min_time = min(solver_times) if solver_times else 0
            
            comparison_data.append({
                'solver': solver_type,
                'total_files': total_files,
                'sat_count': sat_count,
                'unsat_count': unsat_count,
                'unknown_count': unknown_count,
                'error_count': error_count,
                'sat_rate': f"{sat_count/total_files:.1%}" if total_files > 0 else '0%',
                'unsat_rate': f"{unsat_count/total_files:.1%}" if total_files > 0 else '0%',
                'unknown_rate': f"{unknown_count/total_files:.1%}" if total_files > 0 else '0%',
                'error_rate': f"{error_count/total_files:.1%}" if total_files > 0 else '0%',
                'avg_time': f"{avg_time:.3f}s" if avg_time > 0 else '',
                'max_time': f"{max_time:.3f}s" if max_time > 0 else '',
                'min_time': f"{min_time:.3f}s" if min_time > 0 else ''
            })
        
        df_comparison = pd.DataFrame(comparison_data)
        df_comparison.to_excel(writer, index=False, sheet_name='Solver_Comparison')
        
        # Create detailed results sheet for each solver type
        for solver_type in unique_solvers:
            solver_data = []
            
            for file_name in sorted(all_results.keys()):
                for unique_key in all_results[file_name]:
                    result = all_results[file_name][unique_key]
                    if result.get('solver_type') == solver_type:
                        solver_data.append({
                            'filename': file_name,
                            'path': result.get('path', ''),
                            'log_file': result.get('log_file', ''),
                            'solving_time': result.get('solving_time', ''),
                            'sat_result': result.get('sat_result', ''),
                            'result': result.get('result', ''),
                            'solver_output': clean_ansi_sequences(result.get('solver_output', ''))
                        })
            
            if solver_data:
                df_solver = pd.DataFrame(solver_data)
                sheet_name = f'{solver_type}_Details'[:31]  # Excel sheet name limit
                df_solver.to_excel(writer, index=False, sheet_name=sheet_name)
    
    print(f"Analysis report saved to: {output_file}")
    
    # Print summary
    print(f"\nSummary:")
    print(f"  Task: {task_name}")
    print(f"  Total files analyzed: {len(all_results)}")
    print(f"  Solver types: {len(unique_solvers)} ({', '.join(unique_solvers)})")
    
    for solver_type in unique_solvers:
        count = 0
        for file_name in all_results.keys():
            for unique_key in all_results[file_name]:
                if all_results[file_name][unique_key].get('solver_type') == solver_type:
                    count += 1
        print(f"  {solver_type}: {count} results")

def main():
    args = parse_args()
    
    if not os.path.exists(args.results_dir):
        print(f"Error: Results directory not found: {args.results_dir}")
        sys.exit(1)
    
    print(f"Analyzing task: {args.task}")
    print(f"Results directory: {args.results_dir}")
    print(f"Output file: {args.output_file}")
    
    # Find log files for the task
    log_files = find_log_files_by_task(args.results_dir, args.task)
    
    if not log_files:
        print(f"No log files found for task: {args.task}")
        print(f"Searched pattern: {args.results_dir}/*{args.task}*.log")
        sys.exit(1)
    
    try:
        create_analysis_report(args.task, log_files, args.output_file)
        print("\nAnalysis complete!")
        
    except Exception as e:
        print(f"Error during analysis: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
