#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re
import pandas as pd
import argparse
from pathlib import Path

def parse_args():
    parser = argparse.ArgumentParser(description='Analyze solver results and create Excel report.')
    parser.add_argument('--log-file', required=True, help='Log file containing solver results')
    parser.add_argument('--output-dir', default='results', help='Output directory for Excel file')
    parser.add_argument('--task-name', default='solve', help='Task name for the analysis')
    return parser.parse_args()

def clean_text_for_excel(text):
    """Clean text to make it safe for Excel."""
    if not text:
        return ""
    
    # Convert to string and remove problematic characters
    text = str(text)
    # Remove control characters except tab, newline, carriage return
    import string
    cleaned = ''.join(char for char in text if char in string.printable or char.isprintable())
    # Replace problematic Excel characters
    cleaned = cleaned.replace('\x00', '').replace('\x0b', '').replace('\x0c', '')
    return cleaned[:32767]  # Excel cell limit

def parse_log_file(log_file):
    results = []
    current_result = {}
    solver_output = []
    in_output_section = False
    
    try:
        with open(log_file, 'r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                line = line.strip()
                
                if line.startswith('FILE:'):
                    if current_result:
                        current_result['solver_output'] = clean_text_for_excel('\n'.join(solver_output)[:500])
                        results.append(current_result)
                    current_result = {'file_name': clean_text_for_excel(line.split(':', 1)[1].strip())}
                    solver_output = []
                    in_output_section = False
                elif line.startswith('PATH:'):
                    current_result['path'] = clean_text_for_excel(line.split(':', 1)[1].strip())
                elif line.startswith('RESULT:'):
                    current_result['result'] = clean_text_for_excel(line.split(':', 1)[1].strip())
                elif line.startswith('SOLVING_TIME:'):
                    try:
                        current_result['solving_time'] = float(line.split(':', 1)[1].strip())
                    except:
                        current_result['solving_time'] = 0.0
                elif line.startswith('SAT_RESULT:'):
                    current_result['sat_result'] = clean_text_for_excel(line.split(':', 1)[1].strip())
                elif line.startswith('EXIT_CODE:'):
                    current_result['exit_code'] = clean_text_for_excel(line.split(':', 1)[1].strip())
                elif line.startswith('SOLVER_TYPE:'):
                    current_result['solver_type'] = clean_text_for_excel(line.split(':', 1)[1].strip())
                elif line.startswith('TIMEOUT:'):
                    current_result['timeout'] = clean_text_for_excel(line.split(':', 1)[1].strip())
                elif line.startswith('TASK:'):
                    current_result['task'] = clean_text_for_excel(line.split(':', 1)[1].strip())
                elif line.startswith('INDEX:'):
                    current_result['index'] = clean_text_for_excel(line.split(':', 1)[1].strip())
                elif line.startswith('---'):
                    in_output_section = not in_output_section
                elif in_output_section and line and not line.startswith('==='):
                    # Only collect clean, non-empty lines for solver output
                    clean_line = clean_text_for_excel(line)
                    if clean_line and len(clean_line.strip()) > 0:
                        solver_output.append(clean_line)
    
    except Exception as e:
        print(f"Error parsing log file: {e}")
    
    if current_result:
        current_result['solver_output'] = clean_text_for_excel('\n'.join(solver_output)[:500])
        results.append(current_result)
    
    return results

def create_excel_report(results, output_file, task_name):
    if not results:
        print("No results to write to Excel!")
        return
    
    df = pd.DataFrame(results)
    
    # Fill missing columns (removed 'index')
    for col in ['file_name', 'path', 'result', 'solving_time', 'sat_result', 'exit_code', 'solver_type', 'timeout', 'task', 'solver_output']:
        if col not in df.columns:
            df[col] = ''
    
    # Reorder columns (removed 'index')
    column_order = ['file_name', 'result', 'sat_result', 'solving_time', 'solver_type', 'timeout', 'path', 'task', 'exit_code', 'solver_output']
    df = df.reindex(columns=column_order)
    
    # Sort by file name
    df = df.sort_values('file_name')
    
    try:
        # Clean task name for sheet name (remove invalid characters)
        clean_task_name = re.sub(r'[^\w\s-]', '_', task_name)[:31]  # Excel sheet names max 31 chars
        
        with pd.ExcelWriter(output_file, engine='openpyxl') as writer:
            # Main results sheet
            df.to_excel(writer, index=False, sheet_name=f'{clean_task_name}_results')
            
            # Summary sheet
            summary_data = []
            
            # Overall statistics
            total_files = len(df)
            summary_data.append(['Metric', 'Count', 'Percentage'])
            summary_data.append(['Total Files', total_files, '100.0%'])
            
            if 'result' in df.columns:
                result_counts = df['result'].value_counts()
                for result, count in result_counts.items():
                    percentage = f"{count/total_files*100:.1f}%"
                    summary_data.append([f'Result: {result}', count, percentage])
            
            if 'sat_result' in df.columns:
                sat_counts = df['sat_result'].value_counts()
                for sat_result, count in sat_counts.items():
                    if sat_result and str(sat_result).strip():  # Skip empty/null values
                        percentage = f"{count/total_files*100:.1f}%"
                        summary_data.append([f'SAT Result: {sat_result}', count, percentage])
            
            # Timing statistics
            if 'solving_time' in df.columns and df['solving_time'].dtype in ['float64', 'int64']:
                avg_time = df['solving_time'].mean()
                max_time = df['solving_time'].max()
                min_time = df['solving_time'].min()
                summary_data.append(['Average Solving Time', f'{avg_time:.3f}s', ''])
                summary_data.append(['Max Solving Time', f'{max_time:.3f}s', ''])
                summary_data.append(['Min Solving Time', f'{min_time:.3f}s', ''])
            
            summary_df = pd.DataFrame(summary_data[1:], columns=summary_data[0])
            summary_df.to_excel(writer, index=False, sheet_name='Summary')
            
            # Adjust column widths for both sheets
            for sheet_name in writer.sheets:
                worksheet = writer.sheets[sheet_name]
                for column in worksheet.columns:
                    max_length = 0
                    column_letter = column[0].column_letter
                    for cell in column:
                        try:
                            if len(str(cell.value)) > max_length:
                                max_length = len(str(cell.value))
                        except:
                            pass
                    adjusted_width = min(max_length + 2, 100)
                    worksheet.column_dimensions[column_letter].width = adjusted_width
        
        print(f"Excel report saved to: {output_file}")
        
        # Print summary statistics
        print(f"\nSummary Statistics:")
        print(f"Total files: {len(df)}")
        if 'result' in df.columns:
            print("Results breakdown:")
            print(df['result'].value_counts().to_string())
        if 'sat_result' in df.columns and not df['sat_result'].isna().all():
            print("\nSAT results breakdown:")
            print(df['sat_result'].value_counts().to_string())
        if 'solving_time' in df.columns and df['solving_time'].dtype in ['float64', 'int64']:
            print(f"\nTiming statistics:")
            print(f"Average solving time: {df['solving_time'].mean():.3f}s")
            print(f"Max solving time: {df['solving_time'].max():.3f}s")
            print(f"Min solving time: {df['solving_time'].min():.3f}s")
        
    except Exception as e:
        print(f"Error creating Excel file: {e}")

def main():
    args = parse_args()
    
    if not os.path.exists(args.log_file):
        print(f"Error: Log file not found: {args.log_file}")
        return
    
    print(f"Analyzing log file: {args.log_file}")
    results = parse_log_file(args.log_file)
    
    if not results:
        print("No results found in log file!")
        return
    
    # Generate Excel filename based on log filename
    log_basename = os.path.basename(args.log_file)
    if log_basename.endswith('.log'):
        excel_basename = log_basename[:-4] + '_analysis.xlsx'
    else:
        excel_basename = log_basename + '_analysis.xlsx'
    
    output_file = os.path.join(args.output_dir, excel_basename)
    create_excel_report(results, output_file, args.task_name)

if __name__ == "__main__":
    main() 