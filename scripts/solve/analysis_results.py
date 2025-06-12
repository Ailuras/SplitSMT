#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Multi-Solver Mutation Results Analysis Script
This script analyzes mutation results across different solvers and mutation types.

Usage:
    python analysis_results.py --results-dir <results_dir> --seeds-dir <seeds_dir> --mutated-dirs <mutated_dir1> [<mutated_dir2> ...] --output-file <output_file>
    
Example:
    python scripts/solve/analysis_results.py --results-dir results --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek benchmarks/seeds_mutate_openai --output-file charts/multi_solver_analysis.xlsx

Features:
- Analyzes results across multiple solvers (ext-z3, ext-cvc5, ext-ostrich, ext-z3-noodler)
- Compares mutation types (auto, deepseek, openai, claude)
- Generates comprehensive Excel reports with multiple sheets
- Provides solver performance comparison
- Detects correctness changes across solvers and mutations
"""

import os
import re
import sys
import pandas as pd
import argparse
from pathlib import Path
import glob

def parse_args():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(description='Analyze multi-solver mutation results.')
    parser.add_argument('--results-dir', required=True, help='Directory containing result log files')
    parser.add_argument('--seeds-dir', required=True, help='Directory containing original seed files')
    parser.add_argument('--mutated-dirs', nargs='+', required=True, help='One or more directories containing mutated files')
    parser.add_argument('--output-file', required=True, help='Output Excel file to save results')
    
    return parser.parse_args()

def extract_file_info_from_log_name(log_filename):
    """Extract mutation type and solver type from log filename."""
    # Remove .log extension
    name = log_filename.replace('.log', '')
    
    # Parse patterns like: results_seeds_ext_z3, results_auto_ext_cvc5, etc.
    parts = name.split('_')
    
    if len(parts) < 3:
        return None, None
    
    # Find mutation type
    mutation_type = None
    solver_type = None
    
    if 'seeds' in parts:
        mutation_type = 'seeds'
    elif 'auto' in parts:
        mutation_type = 'auto'
    elif 'deepseek' in parts:
        mutation_type = 'deepseek'
    elif 'openai' in parts:
        mutation_type = 'openai'
    elif 'claude' in parts:
        mutation_type = 'claude'
    
    # Find solver type (look for ext-xxx pattern)
    for i, part in enumerate(parts):
        if part == 'ext' and i + 1 < len(parts):
            # Handle compound names like z3-noodler
            remaining_parts = parts[i + 1:]
            if len(remaining_parts) >= 2 and remaining_parts[1] == 'noodler':
                solver_type = f"ext-{remaining_parts[0]}-noodler"
            else:
                solver_type = f"ext-{remaining_parts[0]}"
            break
    
    return mutation_type, solver_type

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
    solver_type = None
    
    try:
        for line in file_content:
            line = line.strip()
            
            if not line or line.startswith('=='):
                continue
            
            # Extract solver type from header
            if line.startswith('Solver Type:'):
                solver_type = line.split(':', 1)[1].strip()
                continue
            elif line.startswith('SOLVER_TYPE:'):
                solver_type = line.split(':', 1)[1].strip()
                continue
            
            if line.startswith('FILE:'):
                if current_file and current_result:
                    current_result['solver_output'] = '\n'.join(solver_output)
                    current_result['solver_type'] = solver_type
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
        current_result['solver_type'] = solver_type
        results[current_file] = current_result
    
    return results

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

def extract_base_name_from_filename(filename):
    """Extract base name from any filename (seeds or mutated)."""
    if filename.endswith('.smt2'):
        return filename.replace('.smt2', '')
    else:
        return filename

def process_result_files(results_dir):
    """Process all result log files in the results directory."""
    all_results = {}
    
    # Find all .log files
    log_files = glob.glob(os.path.join(results_dir, "*.log"))
    
    if not log_files:
        print(f"No .log files found in {results_dir}")
        return {}
    
    print(f"Found {len(log_files)} result log files")
    
    for log_file in log_files:
        log_filename = os.path.basename(log_file)
        mutation_type, solver_type = extract_file_info_from_log_name(log_filename)
        
        if not mutation_type or not solver_type:
            print(f"Warning: Could not parse filename {log_filename}, skipping")
            continue
        
        print(f"Processing {log_filename}: {mutation_type} + {solver_type}")
        
        results = parse_result_log(log_file)
        
        for file_name, result in results.items():
            base_name = extract_base_name_from_filename(file_name)
            
            if base_name not in all_results:
                all_results[base_name] = {}
            
            if mutation_type not in all_results[base_name]:
                all_results[base_name][mutation_type] = {}
            
            all_results[base_name][mutation_type][solver_type] = result
    
    return all_results

def analyze_correctness_changes(result1, result2):
    """Analyze correctness changes between two results."""
    if not result1 or not result2:
        return ""
    
    sat1 = result1.get('sat_result', '').upper()
    sat2 = result2.get('sat_result', '').upper()
    
    if sat1 == 'SAT' and sat2 == 'UNSAT':
        return "SAT->UNSAT"
    elif sat1 == 'UNSAT' and sat2 == 'SAT':
        return "UNSAT->SAT"
    elif sat1 == 'SAT' and sat2 == 'UNKNOWN':
        return "SAT->UNKNOWN"
    elif sat1 == 'UNSAT' and sat2 == 'UNKNOWN':
        return "UNSAT->UNKNOWN"
    elif sat1 == 'UNKNOWN' and sat2 == 'SAT':
        return "UNKNOWN->SAT"
    elif sat1 == 'UNKNOWN' and sat2 == 'UNSAT':
        return "UNKNOWN->UNSAT"
    elif sat1 == sat2 and sat1 in ['SAT', 'UNSAT']:
        return "CONSISTENT"
    else:
        return ""

def analyze_solver_consistency(results_dict, solver_types):
    """Analyze consistency across different solvers for the same problem."""
    # Collect all non-unknown results
    definitive_results = []
    
    for solver_type in solver_types:
        result = results_dict.get(solver_type, {})
        sat_result = result.get('sat_result', '')
        if not sat_result:
            sat_result = result.get('result', '')
        
        # Only consider definitive results (SAT/UNSAT), ignore UNKNOWN
        if sat_result.upper() in ['SAT', 'UNSAT']:
            definitive_results.append(sat_result.upper())
    
    if not definitive_results:
        return "NO_DEFINITIVE_RESULTS"
    
    # Check for serious inconsistency (both SAT and UNSAT present)
    unique_results = set(definitive_results)
    if 'SAT' in unique_results and 'UNSAT' in unique_results:
        return "⚠️ SERIOUS_INCONSISTENCY"
    elif len(unique_results) == 1:
        return "CONSISTENT"
    else:
        return "MINOR_INCONSISTENCY"

def create_solver_comparison_report(seeds_data, all_results, output_file):
    """Create comprehensive Excel report with solver comparison."""
    
    # Determine available mutation types and solvers
    mutation_types = set()
    solver_types = set()
    
    for base_name, data in all_results.items():
        for mut_type, solvers in data.items():
            mutation_types.add(mut_type)
            for solver_type in solvers.keys():
                solver_types.add(solver_type)
    
    mutation_types = sorted(list(mutation_types))
    solver_types = sorted(list(solver_types))
    
    print(f"Found mutation types: {mutation_types}")
    print(f"Found solver types: {solver_types}")
    
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    
    with pd.ExcelWriter(output_file, engine='openpyxl') as writer:
        
        # Sheet 1: Overview - All combinations
        overview_data = []
        for base_name in sorted(seeds_data.keys()):
            orig_data = seeds_data.get(base_name, {})
            
            row = {
                'filename': base_name + '.smt2',
                'variables': orig_data.get('var_count', 0),
                'clauses': orig_data.get('clause_count', 0),
                'theory': orig_data.get('theory', ''),
            }
            
            # Add all mutation+solver combinations
            for mut_type in mutation_types:
                for solver_type in solver_types:
                    result = all_results.get(base_name, {}).get(mut_type, {}).get(solver_type, {})
                    
                    # Result
                    sat_result = result.get('sat_result', '')
                    if not sat_result:
                        sat_result = result.get('result', '')
                    row[f'{mut_type}_{solver_type}_result'] = sat_result
                    
                    # Time
                    solving_time = result.get('solving_time', '')
                    if isinstance(solving_time, (int, float)):
                        time_str = f"{solving_time:.2f}s"
                    else:
                        time_str = str(solving_time) if solving_time else ''
                    row[f'{mut_type}_{solver_type}_time'] = time_str
                
                # Add solver consistency check for this mutation type
                mut_results = all_results.get(base_name, {}).get(mut_type, {})
                consistency = analyze_solver_consistency(mut_results, solver_types)
                row[f'{mut_type}_solver_consistency'] = consistency
            
            overview_data.append(row)
        
        df_overview = pd.DataFrame(overview_data)
        df_overview.to_excel(writer, index=False, sheet_name='Overview')
        
        # Sheet 2: Solver Performance Comparison
        perf_data = []
        for solver_type in solver_types:
            for mut_type in mutation_types:
                results_for_combo = []
                times_for_combo = []
                
                for base_name in seeds_data.keys():
                    result = all_results.get(base_name, {}).get(mut_type, {}).get(solver_type, {})
                    if result:
                        sat_result = result.get('sat_result', '')
                        if sat_result:
                            results_for_combo.append(sat_result)
                        
                        solving_time = result.get('solving_time', '')
                        if isinstance(solving_time, (int, float)):
                            times_for_combo.append(solving_time)
                
                # Calculate statistics
                total_results = len(results_for_combo)
                sat_count = len([r for r in results_for_combo if 'sat' in r.lower() and 'unsat' not in r.lower()])
                unsat_count = len([r for r in results_for_combo if 'unsat' in r.lower()])
                unknown_count = len([r for r in results_for_combo if 'unknown' in r.lower()])
                
                avg_time = sum(times_for_combo) / len(times_for_combo) if times_for_combo else 0
                
                perf_data.append({
                    'mutation_type': mut_type,
                    'solver_type': solver_type,
                    'total_solved': total_results,
                    'sat_count': sat_count,
                    'unsat_count': unsat_count,
                    'unknown_count': unknown_count,
                    'avg_time': f"{avg_time:.3f}s" if avg_time > 0 else '',
                    'sat_rate': f"{sat_count/total_results:.1%}" if total_results > 0 else '0%',
                    'unsat_rate': f"{unsat_count/total_results:.1%}" if total_results > 0 else '0%'
                })
        
        df_perf = pd.DataFrame(perf_data)
        df_perf.to_excel(writer, index=False, sheet_name='Solver_Performance')
        
        # Sheet 3: Cross-Solver Correctness Analysis for seeds
        if 'seeds' in mutation_types and len(solver_types) > 1:
            correctness_data = []
            
            for base_name in sorted(seeds_data.keys()):
                row = {'filename': base_name + '.smt2'}
                
                seed_results = all_results.get(base_name, {}).get('seeds', {})
                
                # Add results for each solver
                for solver_type in solver_types:
                    result = seed_results.get(solver_type, {})
                    sat_result = result.get('sat_result', '')
                    if not sat_result:
                        sat_result = result.get('result', '')
                    row[f'seeds_{solver_type}'] = sat_result
                
                # Check for inconsistencies
                results_values = [row.get(f'seeds_{s}', '') for s in solver_types]
                non_empty_results = [r for r in results_values if r and r.strip()]
                
                if len(set(non_empty_results)) > 1:
                    row['consistency'] = 'INCONSISTENT'
                elif len(non_empty_results) > 0:
                    row['consistency'] = 'CONSISTENT'
                else:
                    row['consistency'] = 'NO_RESULTS'
                
                correctness_data.append(row)
            
            df_correctness = pd.DataFrame(correctness_data)
            df_correctness.to_excel(writer, index=False, sheet_name='Seeds_Cross_Solver')
        
        # Sheet 4-N: One sheet per mutation type (excluding seeds)
        for mut_type in mutation_types:
            if mut_type == 'seeds':
                continue
                
            mut_data = []
            for base_name in sorted(seeds_data.keys()):
                orig_data = seeds_data.get(base_name, {})
                
                row = {
                    'filename': base_name + '.smt2',
                    'variables': orig_data.get('var_count', 0),
                    'clauses': orig_data.get('clause_count', 0),
                }
                
                # Original result (from seeds)
                seeds_results = all_results.get(base_name, {}).get('seeds', {})
                if seeds_results:
                    # Use first available solver for seeds as reference
                    for solver_type in sorted(solver_types):
                        if solver_type in seeds_results:
                            orig_result = seeds_results[solver_type]
                            sat_result = orig_result.get('sat_result', '')
                            if not sat_result:
                                sat_result = orig_result.get('result', '')
                            row['original_result'] = sat_result
                            break
                
                # Results for this mutation type across all solvers
                mut_results = all_results.get(base_name, {}).get(mut_type, {})
                
                for solver_type in solver_types:
                    result = mut_results.get(solver_type, {})
                    
                    # Result
                    sat_result = result.get('sat_result', '')
                    if not sat_result:
                        sat_result = result.get('result', '')
                    row[f'{solver_type}_result'] = sat_result
                    
                    # Time
                    solving_time = result.get('solving_time', '')
                    if isinstance(solving_time, (int, float)):
                        time_str = f"{solving_time:.2f}s"
                    else:
                        time_str = str(solving_time) if solving_time else ''
                    row[f'{solver_type}_time'] = time_str
                    
                    # Correctness change vs original
                    if 'original_result' in row:
                        orig_dummy = {'sat_result': row['original_result']}
                        change = analyze_correctness_changes(orig_dummy, result)
                        row[f'{solver_type}_correctness'] = change
                
                # Cross-solver consistency for this mutation (serious inconsistency check)
                mut_results = all_results.get(base_name, {}).get(mut_type, {})
                consistency = analyze_solver_consistency(mut_results, solver_types)
                row['solver_consistency'] = consistency
                
                mut_data.append(row)
            
            df_mut = pd.DataFrame(mut_data)
            sheet_name = f'{mut_type.capitalize()}_Analysis'
            df_mut.to_excel(writer, index=False, sheet_name=sheet_name)
    
    print(f"Multi-solver analysis report saved to: {output_file}")
    
    # Print summary statistics
    print(f"\nSummary:")
    print(f"  Total files analyzed: {len(seeds_data)}")
    print(f"  Mutation types: {len(mutation_types)} ({', '.join(mutation_types)})")
    print(f"  Solver types: {len(solver_types)} ({', '.join(solver_types)})")
    
    # Count results per combination
    for mut_type in mutation_types:
        for solver_type in solver_types:
            count = 0
            for base_name in seeds_data.keys():
                if all_results.get(base_name, {}).get(mut_type, {}).get(solver_type):
                    count += 1
            print(f"  {mut_type} + {solver_type}: {count} results")
    
    # Count serious inconsistencies
    print(f"\n🔍 Solver Consistency Analysis:")
    for mut_type in mutation_types:
        serious_inconsistencies = 0
        total_with_results = 0
        
        for base_name in seeds_data.keys():
            mut_results = all_results.get(base_name, {}).get(mut_type, {})
            if mut_results:  # If there are any results for this mutation type
                consistency = analyze_solver_consistency(mut_results, solver_types)
                if consistency != "NO_DEFINITIVE_RESULTS":
                    total_with_results += 1
                    if "SERIOUS_INCONSISTENCY" in consistency:
                        serious_inconsistencies += 1
        
        if total_with_results > 0:
            percentage = (serious_inconsistencies / total_with_results) * 100
            print(f"  {mut_type}: {serious_inconsistencies}/{total_with_results} files with serious inconsistency ({percentage:.1f}%)")
            if serious_inconsistencies > 0:
                print(f"    ⚠️  Found {serious_inconsistencies} cases where different solvers gave SAT vs UNSAT!")
        else:
            print(f"  {mut_type}: No results to analyze")
    
    # Generate statistics for LaTeX table
    print(f"\n📊 Statistics for LaTeX Table:")
    print("=" * 80)
    
    mutation_display_names = {
        'seeds': 'seed',
        'auto': 'mutation-auto', 
        'deepseek': 'mutation-deepseek',
        'openai': 'mutation-openai'
    }
    
    solver_display_names = {
        'ext-z3': 'Z3',
        'ext-cvc5': 'CVC5', 
        'ext-ostrich': 'Ostrich',
        'ext-z3-noodler': 'Z3-Noodler'
    }
    
    ordered_mutation_types = ['seeds', 'auto', 'deepseek', 'openai']
    ordered_solver_types = ['ext-z3', 'ext-cvc5', 'ext-ostrich', 'ext-z3-noodler']
    
    print(f"{'Dataset':<15} | {'Origin':<6} | ", end="")
    for solver_type in ordered_solver_types:
        solver_name = solver_display_names.get(solver_type, solver_type)
        print(f"{solver_name:<12} | ", end="")
    print()
    
    print(f"{'':15} | {'#':<6} | ", end="")
    for _ in ordered_solver_types:
        print(f"{'SUC':<3} {'time':<5} {'UNK':<3} | ", end="")
    print()
    
    print("-" * 80)
    
    total_files = 0
    total_stats = {}
    for solver_type in ordered_solver_types:
        total_stats[solver_type] = {'suc': 0, 'total_time': 0, 'total_suc_time': 0, 'unk': 0, 'total': 0}
    
    for mut_type in ordered_mutation_types:
        if mut_type not in mutation_types:
            continue
            
        mut_display_name = mutation_display_names.get(mut_type, mut_type)
        
        mut_total_files = len([base_name for base_name in seeds_data.keys() 
                              if all_results.get(base_name, {}).get(mut_type)])
        if mut_total_files == 0:
            mut_total_files = len(seeds_data)
        
        total_files += mut_total_files
        print(f"{mut_display_name:<15} | {mut_total_files:<6} | ", end="")
        
        for solver_type in ordered_solver_types:
            suc_count = 0
            unk_count = 0
            suc_times = []
            
            for base_name in seeds_data.keys():
                result = all_results.get(base_name, {}).get(mut_type, {}).get(solver_type, {})
                if result:
                    sat_result = result.get('sat_result', '')
                    if not sat_result:
                        sat_result = result.get('result', '')
                    
                    solving_time = result.get('solving_time', '')
                    
                    if sat_result.upper() in ['SAT', 'UNSAT']:
                        suc_count += 1
                        if isinstance(solving_time, (int, float)):
                            suc_times.append(solving_time)
                    elif sat_result.upper() == 'UNKNOWN':
                        unk_count += 1
            
            avg_time = sum(suc_times) / len(suc_times) if suc_times else 0
            
            total_stats[solver_type]['suc'] += suc_count
            total_stats[solver_type]['unk'] += unk_count
            total_stats[solver_type]['total'] += mut_total_files
            if suc_times:
                total_stats[solver_type]['total_suc_time'] += sum(suc_times)
                total_stats[solver_type]['total_time'] += len(suc_times)
            
            print(f"{suc_count:<3} {avg_time:<5.2f} {unk_count:<3} | ", end="")
        
        print()
    
    print("-" * 80)
    print(f"{'总计':<15} | {total_files:<6} | ", end="")
    
    for solver_type in ordered_solver_types:
        stats = total_stats[solver_type]
        total_suc = stats['suc']
        total_unk = stats['unk']
        avg_total_time = stats['total_suc_time'] / stats['total_time'] if stats['total_time'] > 0 else 0
        
        print(f"{total_suc:<3} {avg_total_time:<5.2f} {total_unk:<3} | ", end="")
    
    print()
    print("=" * 80)
    
    print(f"\n📋 Detailed Statistics for Table:")
    for mut_type in ordered_mutation_types:
        if mut_type not in mutation_types:
            continue
            
        mut_display_name = mutation_display_names.get(mut_type, mut_type)
        print(f"\n{mut_display_name}:")
        
        for solver_type in ordered_solver_types:
            solver_name = solver_display_names.get(solver_type, solver_type)
            
            suc_count = 0
            unk_count = 0
            suc_times = []
            
            for base_name in seeds_data.keys():
                result = all_results.get(base_name, {}).get(mut_type, {}).get(solver_type, {})
                if result:
                    sat_result = result.get('sat_result', '')
                    if not sat_result:
                        sat_result = result.get('result', '')
                    
                    solving_time = result.get('solving_time', '')
                    
                    if sat_result.upper() in ['SAT', 'UNSAT']:
                        suc_count += 1
                        if isinstance(solving_time, (int, float)):
                            suc_times.append(solving_time)
                    elif sat_result.upper() == 'UNKNOWN':
                        unk_count += 1
            
            avg_time = sum(suc_times) / len(suc_times) if suc_times else 0
            print(f"  {solver_name}: SUC={suc_count}, time={avg_time:.2f}s, UNK={unk_count}")
    
    print(f"\n总计:")
    for solver_type in ordered_solver_types:
        solver_name = solver_display_names.get(solver_type, solver_type)
        stats = total_stats[solver_type]
        total_suc = stats['suc']
        total_unk = stats['unk']
        avg_total_time = stats['total_suc_time'] / stats['total_time'] if stats['total_time'] > 0 else 0
        print(f"  {solver_name}: SUC={total_suc}, time={avg_total_time:.2f}s, UNK={total_unk}")

def main():
    args = parse_args()
    
    if not os.path.exists(args.results_dir):
        print(f"Error: Results directory not found: {args.results_dir}")
        sys.exit(1)
        
    if not os.path.exists(args.seeds_dir):
        print(f"Error: Seeds directory not found: {args.seeds_dir}")
        sys.exit(1)
    
    print(f"Processing configuration:")
    print(f"  Results directory: {args.results_dir}")
    print(f"  Seeds directory: {args.seeds_dir}")
    print(f"  Mutated directories: {', '.join(args.mutated_dirs)}")
    print(f"  Output file: {args.output_file}")
    
    try:
        print("\n1. Processing original seed files...")
        seeds_data = process_seeds_directory(args.seeds_dir)
        
        print("\n2. Processing result log files...")
        all_results = process_result_files(args.results_dir)
        
        print("\n3. Creating multi-solver analysis report...")
        create_solver_comparison_report(seeds_data, all_results, args.output_file)
        
        print("\nMulti-solver analysis complete!")
        
    except Exception as e:
        print(f"Error during processing: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
