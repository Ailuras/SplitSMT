#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Process Solver Results Script
This script processes solver results from log files and updates the Excel report.

Usage:
    python analysis_solve.py --input-excel <excel_file> --log-dir <log_dir1> [<log_dir2> ...] --output-file <output_file>
    
Example:
    python experiments/analysis_solve.py --input-excel charts/Norn.xlsx --log-dir results/cvc5 --output-file charts/Norn_cvc5.xlsx
    python experiments/analysis_solve.py --input-excel charts/Norn.xlsx --log-dir results/cvc5 results/z3 --output-file charts/Norn_cvc5_z3.xlsx
"""

import os
import re
import sys
import pandas as pd
import argparse
from pathlib import Path
from tqdm import tqdm
import openpyxl.styles

def parse_args():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(description='Process solver results and update Excel report.')
    parser.add_argument('--input-excel', required=True, help='Input Excel file containing benchmark information')
    parser.add_argument('--log-dir', nargs='+', required=True, help='One or more directories containing solver result log files')
    parser.add_argument('--output-file', required=True, help='Output Excel file to save updated results')
    
    return parser.parse_args()

def extract_task_name(log_file):
    """Extract task name from a log file."""
    try:
        with open(log_file, 'r', encoding='utf-8') as f:
            for line in f:
                if line.startswith('TASK:'):
                    return line.split(':', 1)[1].strip()
    except Exception as e:
        print(f"Error reading task name from {log_file}: {e}")
    return None

def parse_log_file(log_file):
    """Parse a log file and extract results for each file."""
    results = {}
    current_file = None
    current_path = None
    current_result = {}
    solver_output = []
    collecting_output = False
    
    try:
        with open(log_file, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                
                # Skip empty lines and double separators
                if not line or line.startswith('='):
                    continue
                
                # Parse file information
                if line.startswith('FILE:'):
                    if current_path and current_result:
                        current_result['solver_output'] = '\n'.join(solver_output)
                        results[current_path] = current_result
                    current_file = line.split(':', 1)[1].strip()
                    current_path = None
                    current_result = {}
                    solver_output = []
                    collecting_output = False
                
                # Parse path information
                elif line.startswith('PATH:'):
                    current_path = line.split(':', 1)[1].strip()
                
                # Parse result information
                elif line.startswith('RESULT:'):
                    current_result['result'] = line.split(':', 1)[1].strip()
                elif line.startswith('SOLVING_TIME:'):
                    current_result['time'] = float(line.split(':', 1)[1].strip())
                elif line.startswith('TASK:'):
                    current_result['task'] = line.split(':', 1)[1].strip()
                # Handle single separator
                elif line.startswith('-'):
                    collecting_output = not collecting_output
                    continue
                # Collect solver output (only between single separators)
                elif collecting_output and line:
                    solver_output.append(line)
    
    except Exception as e:
        print(f"Error parsing log file {log_file}: {e}")
    
    # Add the last result
    if current_path and current_result:
        current_result['solver_output'] = '\n'.join(solver_output)
        results[current_path] = current_result
    
    return results

def update_excel(excel_file, results, task_name, output_file):
    """Update Excel file with solver results."""
    try:
        # Read the Excel file
        df = pd.read_excel(excel_file)
        
        # Add new columns if they don't exist
        result_col = f'res_{task_name}_result'
        time_col = f'res_{task_name}_time'
        reason_col = f'res_{task_name}_reason'
        
        if result_col not in df.columns:
            df[result_col] = ''
        if time_col not in df.columns:
            df[time_col] = ''
        if reason_col not in df.columns:
            df[reason_col] = ''
        
        # Update results for each file
        for index, row in df.iterrows():
            file_path = row['path']
            
            # Try exact path match first
            if file_path in results:
                result = results[file_path]
                df.at[index, result_col] = result.get('result', '')
                df.at[index, time_col] = result.get('time', '')
                df.at[index, reason_col] = result.get('solver_output', '')
            else:
                # Try matching by converting original path to preprocessed path
                # E.g., /path/2015-Norn/file.smt2 -> /path/2015-Norn-preprocessed/file.smt2
                if '2015-Norn/' in file_path and '2015-Norn-preprocessed/' not in file_path:
                    preprocessed_path = file_path.replace('2015-Norn/', '2015-Norn-preprocessed/')
                    if preprocessed_path in results:
                        result = results[preprocessed_path]
                        df.at[index, result_col] = result.get('result', '')
                        df.at[index, time_col] = result.get('time', '')
                        df.at[index, reason_col] = result.get('solver_output', '')
                # Try the reverse conversion as well
                elif '2015-Norn-preprocessed/' in file_path:
                    original_path = file_path.replace('2015-Norn-preprocessed/', '2015-Norn/')
                    if original_path in results:
                        result = results[original_path]
                        df.at[index, result_col] = result.get('result', '')
                        df.at[index, time_col] = result.get('time', '')
                        df.at[index, reason_col] = result.get('solver_output', '')
        
        # Create output directory if it doesn't exist
        os.makedirs(os.path.dirname(output_file), exist_ok=True)
        
        # Save updated Excel file
        with pd.ExcelWriter(output_file, engine='openpyxl', mode='w') as writer:
            df.to_excel(writer, index=False, sheet_name='SMT2 Analysis')
            
            # Adjust column widths and enable text wrapping
            worksheet = writer.sheets['SMT2 Analysis']
            for i, col in enumerate(df.columns):
                # Calculate column width with a maximum limit
                column_width = min(max(df[col].astype(str).map(len).max(), len(col)) * 1.2 + 10, 100)
                worksheet.column_dimensions[chr(65 + i)].width = column_width
                
                # Enable text wrapping for the reason column
                if col == reason_col:
                    for cell in worksheet[chr(65 + i)][1:]:  # Skip header row
                        cell.alignment = openpyxl.styles.Alignment(wrap_text=True)
        
        print(f"Excel file updated successfully: {output_file}")
        
    except Exception as e:
        print(f"Error updating Excel file: {e}")

def process_log_directory(log_dir):
    """Process a single log directory and return results and task name."""
    results = {}
    task_name = None
    
    # Get all log files
    log_files = [f for f in os.listdir(log_dir) if f.startswith('batch_') and f.endswith('_results.log')]
    
    # Process each log file with progress bar
    for log_file in tqdm(log_files, desc="Processing log files", unit="file"):
        log_path = os.path.join(log_dir, log_file)
        
        # Extract task name from the first log file
        if task_name is None:
            task_name = extract_task_name(log_path)
            if not task_name:
                print(f"Error: Could not determine task name from log files in {log_dir}")
                continue
        
        batch_results = parse_log_file(log_path)
        results.update(batch_results)
    
    return results, task_name

def main():
    # Parse command line arguments
    args = parse_args()
    
    # Validate input file exists
    if not os.path.exists(args.input_excel):
        print(f"Error: Excel file not found: {args.input_excel}")
        sys.exit(1)
    
    print(f"Processing configuration:")
    print(f"  Input Excel: {args.input_excel}")
    print(f"  Log directories: {', '.join(args.log_dir)}")
    print(f"  Output file: {args.output_file}")
    
    # Process all log directories
    all_results = {}
    all_task_names = set()
    
    for log_dir in args.log_dir:
        # Validate log directory exists
        if not os.path.exists(log_dir):
            print(f"Warning: Log directory not found: {log_dir}")
            continue
            
        results, task_name = process_log_directory(log_dir)
        
        if results and task_name:
            all_results.update(results)
            all_task_names.add(task_name)
    
    # Update Excel file for each task
    if all_results and all_task_names:
        for task_name in all_task_names:
            # Filter results for this task
            task_results = {k: v for k, v in all_results.items() if v.get('task') == task_name}
            if task_results:
                print(f"\nUpdating Excel for task: {task_name}")
                update_excel(args.input_excel, task_results, task_name, args.output_file)
                print(f"Processed {len(task_results)} results for task {task_name}")
    else:
        print("No results found to process")

if __name__ == "__main__":
    main() 