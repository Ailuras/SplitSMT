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
    Check if all solvers can successfully solve and have consistent results
    """
    solvers = ['cvc5', 'z3', 'SLIA-z3-noodler', 'SLIA-ostrich']
    
    # Check if all solvers return SUCCESS
    for solver in solvers:
        result_col = f'res_{solver}_result'
        if pd.isna(row[result_col]) or row[result_col] != 'SUCCESS':
            return False
    
    # Get reasoning results from all solvers
    solver_reasons = []
    for solver in solvers:
        reason_col = f'res_{solver}_reason'
        reason = row[reason_col]
        if pd.isna(reason):
            return False
        solver_reasons.append(reason)
    
    # Check if all solver results are consistent
    if len(set(solver_reasons)) != 1:
        return False  # Results inconsistent
    
    return True

def get_file_source(path):
    """
    Get file source based on file path for ensuring diversity
    """
    path_parts = path.split('/')
    if len(path_parts) >= 3:
        # Usually format is .../QF_SLIA/year-source/...
        return path_parts[-2]  # Return second-to-last path part as source
    return 'unknown'

def select_seeds(input_file, output_dir, num_seeds, max_file_size, max_vars, max_clauses, 
                min_file_size, min_vars, min_clauses):
    try:
        print(f"Reading Excel file: {input_file}")
        df = pd.read_excel(input_file)
        print(f"Successfully read {len(df)} rows of data")
        
    except Exception as e:
        print(f"Error reading input file: {e}")
        return

    # Check if required columns exist
    required_columns = ['path', 'file_size', 'var_count', 'clause_count', 'status']
    solver_columns = ['res_cvc5_result', 'res_z3_result', 'res_SLIA-z3-noodler_result', 'res_SLIA-ostrich_result']
    reason_columns = ['res_cvc5_reason', 'res_z3_reason', 'res_SLIA-z3-noodler_reason', 'res_SLIA-ostrich_reason']
    
    missing_columns = []
    for col in required_columns + solver_columns + reason_columns:
        if col not in df.columns:
            missing_columns.append(col)
    
    if missing_columns:
        print(f"Warning: The following columns do not exist in Excel file: {missing_columns}")
        return

    print(f"\n=== Starting efficient filtering process ===")
    
    # Create output directory (clear if exists)
    if os.path.exists(output_dir):
        print(f"Clearing existing directory: {output_dir}")
        shutil.rmtree(output_dir)
    
    os.makedirs(output_dir, exist_ok=True)
    print(f"Output directory: {output_dir}")
    
    # Step-by-step filtering analysis
    print(f"=== Step-by-step filtering analysis ===")
    
    # Step 1: Basic numerical condition filtering
    basic_filter = (
        (df['file_size'] >= min_file_size) & (df['file_size'] <= max_file_size) &
        (df['var_count'] >= min_vars) & (df['var_count'] <= max_vars) &
        (df['clause_count'] >= min_clauses) & (df['clause_count'] <= max_clauses)
    )
    basic_candidates = df[basic_filter].copy()
    print(f"1. After basic numerical filtering: {len(basic_candidates)} files ({len(basic_candidates)/len(df)*100:.2f}%)")
    
    # Step 2: Solver result filtering
    solver_filter = basic_candidates.apply(verify_solver_results, axis=1)
    all_candidates = basic_candidates[solver_filter].copy()
    print(f"2. After solver result filtering: {len(all_candidates)} files ({len(all_candidates)/len(df)*100:.2f}%)")
    
    if len(all_candidates) == 0:
        print("Error: No files meet the filtering criteria!")
        print("Suggestion: Relax filtering conditions, such as increasing file size limits or reducing solver requirements")
        return
    
    # Analyze result distribution of candidate files
    all_candidates['solver_result'] = all_candidates['res_cvc5_reason']  # Use first solver result (consistency verified)
    result_counts = all_candidates['solver_result'].value_counts()
    
    print(f"\n=== Candidate file solving result distribution ===")
    for result, count in result_counts.items():
        print(f"{result}: {count} files ({count/len(all_candidates)*100:.1f}%)")
    
    # Check if there are enough sat and unsat files
    sat_files = all_candidates[all_candidates['solver_result'] == 'sat']
    unsat_files = all_candidates[all_candidates['solver_result'] == 'unsat']
    unknown_files = all_candidates[all_candidates['solver_result'] == 'unknown']
    
    print(f"\nSAT file count: {len(sat_files)}")
    print(f"UNSAT file count: {len(unsat_files)}")
    print(f"UNKNOWN file count: {len(unknown_files)}")
    
    # Analyze source distribution of candidate files
    all_candidates['source'] = all_candidates['path'].apply(get_file_source)
    source_counts = all_candidates['source'].value_counts()
    
    print(f"\n=== Candidate file source distribution ===")
    for source, count in source_counts.head(10).items():
        print(f"{source}: {count} files ({count/len(all_candidates)*100:.1f}%)")
    
    if len(source_counts) > 10:
        print(f"... and {len(source_counts)-10} other sources")
    
    # Analyze status distribution
    status_counts = all_candidates['status'].value_counts()
    print(f"\nCandidate file Status distribution:")
    for status, count in status_counts.items():
        print(f"  {status}: {count} ({count/len(all_candidates)*100:.1f}%)")
    
    # 50%/50% SAT/UNSAT stratified selection strategy
    if len(all_candidates) < num_seeds:
        print(f"\nWarning: Candidate file count ({len(all_candidates)}) is less than required seed count ({num_seeds})")
        num_seeds = len(all_candidates)
        selected_candidates = all_candidates
    else:
        print(f"\n=== SAT/UNSAT 50%/50% stratified selection strategy ===")
        
        # Calculate number needed for each result type
        target_sat = num_seeds // 2
        target_unsat = num_seeds - target_sat
        
        print(f"Target selection: SAT {target_sat}, UNSAT {target_unsat}")
        
        selected_list = []
        
        # Select SAT files
        if len(sat_files) >= target_sat:
            selected_sat = sat_files.sample(n=target_sat, random_state=42)
            selected_list.append(selected_sat)
            print(f"Successfully selected {target_sat} SAT files")
        else:
            selected_list.append(sat_files)
            print(f"Insufficient SAT files, can only select {len(sat_files)}")
        
        # Select UNSAT files
        if len(unsat_files) >= target_unsat:
            selected_unsat = unsat_files.sample(n=target_unsat, random_state=43)
            selected_list.append(selected_unsat)
            print(f"Successfully selected {target_unsat} UNSAT files")
        else:
            selected_list.append(unsat_files)
            print(f"Insufficient UNSAT files, can only select {len(unsat_files)}")
        
        # Merge selected files
        if selected_list:
            selected_candidates = pd.concat(selected_list, ignore_index=True)
        else:
            selected_candidates = pd.DataFrame()
        
        # If SAT and UNSAT files are insufficient, supplement from UNKNOWN files
        if len(selected_candidates) < num_seeds and len(unknown_files) > 0:
            remaining_needed = num_seeds - len(selected_candidates)
            additional_unknown = unknown_files.sample(
                n=min(remaining_needed, len(unknown_files)),
                random_state=44
            )
            selected_candidates = pd.concat([selected_candidates, additional_unknown], ignore_index=True)
            print(f"Supplemented {len(additional_unknown)} files from UNKNOWN files")
        
        # If still insufficient, randomly supplement from all candidates
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
                print(f"Randomly supplemented {len(additional)} files")
    
    print(f"\nFinally selected {len(selected_candidates)} seed files")
    
    # Copy selected files
    print(f"Starting file copying...")
    success_count = 0
    failed_files = []
    
    for idx, (_, row) in enumerate(selected_candidates.iterrows()):
        source_path = row['path']
        
        if not os.path.exists(source_path):
            print(f"Warning: Source file does not exist: {source_path}")
            failed_files.append(source_path)
            continue
        
        filename = os.path.basename(source_path)
        target_path = os.path.join(output_dir, filename)
        
        try:
            shutil.copy2(source_path, target_path)
            success_count += 1
            
            if (idx + 1) % 20 == 0:
                print(f"Copied {idx + 1}/{len(selected_candidates)} files...")
                
        except Exception as e:
            print(f"Error copying file {source_path}: {e}")
            failed_files.append(source_path)
    
    # Print final summary
    print(f"\n=== Selection Summary ===")
    print(f"Total input files: {len(df)}")
    print(f"Qualified candidate files: {len(all_candidates)} ({len(all_candidates)/len(df)*100:.2f}%)")
    print(f"Successfully copied seed files: {success_count}/{len(selected_candidates)}")
    
    if failed_files:
        print(f"Failed file count: {len(failed_files)}")
        if len(failed_files) <= 5:
            print("Failed file list:")
            for f in failed_files:
                print(f"  {os.path.basename(f)}")
    
    if success_count > 0:
        # Analyze final selection distribution
        print(f"\n=== Final Selection Analysis ===")
        
        # Solving result distribution
        final_result_counts = selected_candidates['solver_result'].value_counts()
        print(f"Solving result distribution:")
        for result, count in final_result_counts.items():
            print(f"  {result}: {count} ({count/len(selected_candidates)*100:.1f}%)")
        
        # Source distribution (ensure source column exists)
        if 'source' in selected_candidates.columns:
            final_source_counts = selected_candidates['source'].value_counts()
            print(f"\nSource distribution (top 10):")
            for source, count in final_source_counts.head(10).items():
                print(f"  {source}: {count} ({count/len(selected_candidates)*100:.1f}%)")
        else:
            # Recalculate source column
            selected_candidates['source'] = selected_candidates['path'].apply(get_file_source)
            final_source_counts = selected_candidates['source'].value_counts()
            print(f"\nSource distribution (top 10):")
            for source, count in final_source_counts.head(10).items():
                print(f"  {source}: {count} ({count/len(selected_candidates)*100:.1f}%)")
        
        # Status distribution
        final_status_counts = selected_candidates['status'].value_counts()
        print(f"\nStatus distribution:")
        for status, count in final_status_counts.items():
            print(f"  {status}: {count} ({count/len(selected_candidates)*100:.1f}%)")
        
        # Numerical distribution
        print(f"\nNumerical distribution:")
        print(f"File size: {selected_candidates['file_size'].min()}-{selected_candidates['file_size'].max()} bytes (avg: {selected_candidates['file_size'].mean():.0f})")
        print(f"Variable count: {selected_candidates['var_count'].min()}-{selected_candidates['var_count'].max()} (avg: {selected_candidates['var_count'].mean():.1f})")
        print(f"Clause count: {selected_candidates['clause_count'].min()}-{selected_candidates['clause_count'].max()} (avg: {selected_candidates['clause_count'].mean():.1f})")
        
        # Verify solver result consistency
        print(f"\nSolver result consistency verification:")
        for solver in ['cvc5', 'z3', 'SLIA-z3-noodler', 'SLIA-ostrich']:
            reason_col = f'res_{solver}_reason'
            valid_count = 0
            for _, row in selected_candidates.iterrows():
                if not pd.isna(row[reason_col]) and row[reason_col] != 'unknown':
                    valid_count += 1
            print(f"  {solver}: {valid_count}/{len(selected_candidates)} valid results")
        
        # Verify all solver result consistency
        consistent_results = 0
        for _, row in selected_candidates.iterrows():
            solver_reasons = []
            for solver in ['cvc5', 'z3', 'SLIA-z3-noodler', 'SLIA-ostrich']:
                reason_col = f'res_{solver}_reason'
                solver_reasons.append(row[reason_col])
            if len(set(solver_reasons)) == 1:
                consistent_results += 1
        print(f"  All solver results consistent: {consistent_results}/{len(selected_candidates)}")
        
        # Show solver result distribution
        if len(selected_candidates) > 0:
            first_solver_results = selected_candidates['res_cvc5_reason'].value_counts()
            print(f"\nSolver result distribution:")
            for result, count in first_solver_results.items():
                print(f"  {result}: {count} ({count/len(selected_candidates)*100:.1f}%)")
        
        # Show examples of selected files
        if 'file_name' in df.columns:
            sample_names = selected_candidates['file_name'].head(10).tolist()
            print(f"\nSelected file examples:")
            for name in sample_names:
                print(f"  {name}")
    
    print(f"\nFiltering efficiency: Found {len(all_candidates)} candidates from {len(df)} rows, selected {success_count} seeds")

if __name__ == "__main__":
    args = parse_args()
    print(f"=== SMT2 Seed Selection Tool ===")
    print(f"Select {args.num_seeds} seeds from {args.input_file}")
    print(f"Filtering conditions:")
    print(f"- File size: {args.min_file_size} - {args.max_file_size} bytes")
    print(f"- Variable count: {args.min_vars} - {args.max_vars}")
    print(f"- Clause count: {args.min_clauses} - {args.max_clauses}")
    print(f"- All solvers must return SUCCESS")
    print(f"- All solver results must be consistent")
    print(f"- Selection strategy: 50% SAT and 50% UNSAT")
    
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