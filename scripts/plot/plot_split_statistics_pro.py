#!/usr/bin/env python3
"""
Split Statistics Plotting Script
Creates comprehensive charts showing split operation characteristics and solver performance in a single 3x3 grid.
"""

import os
import sys
import pandas as pd
import matplotlib
matplotlib.use('Agg')  # Use non-interactive backend
import matplotlib.pyplot as plt
import numpy as np
import argparse
from pathlib import Path

# Set font to handle special characters and increase font sizes
plt.rcParams['font.family'] = 'DejaVu Sans'
plt.rcParams['axes.unicode_minus'] = False
plt.rcParams['font.size'] = 16          # Base font size
plt.rcParams['axes.labelsize'] = 18     # Axis label font size
plt.rcParams['axes.titlesize'] = 20     # Title font size
plt.rcParams['xtick.labelsize'] = 16    # X-axis tick labels
plt.rcParams['ytick.labelsize'] = 16    # Y-axis tick labels
plt.rcParams['legend.fontsize'] = 16    # Legend font size

# Add the solve script path
sys.path.append('scripts/solve')
from analysis_results import analyze_smt2_file

def collect_data_from_benchmarks(benchmark_dirs):
    """Collect split statistics from benchmark directories."""
    data = []
    
    for benchmark_dir in benchmark_dirs:
        if not os.path.exists(benchmark_dir):
            print(f"Warning: Directory {benchmark_dir} not found")
            continue
            
        print(f"Processing directory: {benchmark_dir}")
        smt_files = list(Path(benchmark_dir).glob("*.smt2"))
        
        for smt_file in smt_files:
            try:
                result = analyze_smt2_file(str(smt_file))
                
                # Only include files that have split operations
                if result['get_split_length_count'] > 0 or result['get_split_element_count'] > 0:
                    data.append({
                        'filename': smt_file.name,
                        'dataset': smt_file.parent.name,
                        'split_groups_count': result['split_groups_count'],
                        'separator_VAR': result['separator_VAR'],
                        'separator_RE': result['separator_RE'],
                        'separator_MUL': result['separator_MUL'], 
                        'separator_SIN': result['separator_SIN'],
                        'api_Normal': result['api_Normal'],
                        'api_Limit': result['api_Limit']
                    })
            except Exception as e:
                print(f"Error processing {smt_file}: {e}")
    
    return pd.DataFrame(data)

def load_solver_results(excel_file):
    """Load solver results from Excel file."""
    if not os.path.exists(excel_file):
        print(f"Warning: Excel file {excel_file} not found")
        return None
    
    try:
        df = pd.read_excel(excel_file, sheet_name='Analysis')
        return df
    except Exception as e:
        print(f"Error loading Excel file: {e}")
        return None

def categorize_split_groups(count):
    """Categorize split groups count into bins."""
    if count == 1:
        return "1"
    elif count == 2:
        return "2"
    else:
        return "≥3"

def get_separator_type(row):
    """Get the primary separator type based on priority: VAR > RE > MUL > SIN."""
    if row.get('separator_VAR', 0):
        return 'VAR'
    elif row.get('separator_RE', 0):
        return 'RE'
    elif row.get('separator_MUL', 0):
        return 'MUL'
    elif row.get('separator_SIN', 0):
        return 'SIN'
    else:
        return 'None'

def get_api_type(row):
    """Get the primary API type."""
    if row.get('api_Limit', 0):
        return 'Limit'
    elif row.get('api_Normal', 0):
        return 'Normal'
    else:
        return 'None'

def count_solved_by_solver(solver_df, filenames, solver_name):
    """Count how many files were solved by a specific solver."""
    if solver_df is None or not filenames:
        return 0
    
    # Filter for files in our split data
    filtered_df = solver_df[solver_df['filename'].isin(filenames)]
    
    # Count successful results for this solver
    result_col = f'{solver_name}_result'
    if result_col in filtered_df.columns:
        solved_count = len(filtered_df[
            (filtered_df[result_col] == 'SAT') | 
            (filtered_df[result_col] == 'UNSAT')
        ])
        return solved_count
    else:
        return 0

def get_average_solving_time(solver_df, filenames, solver_name):
    """Calculate average solving time for successfully solved files by a specific solver."""
    if solver_df is None or not filenames:
        return 0.1  # Small positive value for log scale
    
    # Filter for files in our split data
    filtered_df = solver_df[solver_df['filename'].isin(filenames)]
    
    # Get result and time columns
    result_col = f'{solver_name}_result'
    time_col = f'{solver_name}_time'
    
    if result_col in filtered_df.columns and time_col in filtered_df.columns:
        # Filter for successful results (SAT or UNSAT)
        successful_df = filtered_df[
            (filtered_df[result_col] == 'SAT') | 
            (filtered_df[result_col] == 'UNSAT')
        ]
        
        if len(successful_df) > 0:
            # Calculate average time, handling potential string/numeric conversion issues
            times = []
            for time_val in successful_df[time_col]:
                try:
                    if pd.notna(time_val) and time_val != '' and time_val != 'N/A':
                        times.append(float(time_val))
                except (ValueError, TypeError):
                    continue
            
            if times:
                return (sum(times) / len(times)) * 1000  # Convert to milliseconds
    
    return 0.1  # Small positive value for log scale to handle zero/empty cases

def create_combined_charts(split_df, solver_df, output_file, font_offset=0):
    """Create a 3x3 grid with pie charts in the left column and performance line plots in the middle/right columns."""
    import matplotlib.ticker as mtick

    # Create 3x3 grid with custom width ratios (1:1.5:1.5 for ~25%:37.5%:37.5%)
    fig, axes = plt.subplots(3, 3, figsize=(28, 22), gridspec_kw={'width_ratios': [1, 1.5, 1.5]})
    plt.subplots_adjust(wspace=0.4, hspace=0.5)  # Increased spacing for alignment

    # Base setup for line plots
    solver_colors = {
        'ext-cvc5': '#e74c3c',
        'ext-ostrich': '#2ecc71',
        'ext-z3': '#f39c12',
        'ext-z3-noodler': '#9b59b6'
    }
    solver_markers = {'ext-cvc5': 'o', 'ext-ostrich': 's', 'ext-z3': '^', 'ext-z3-noodler': 'D'}
    solvers = list(solver_colors.keys())

    # Data preprocessing
    split_df['split_groups_category'] = split_df['split_groups_count'].apply(categorize_split_groups)
    split_df['primary_separator_type'] = split_df.apply(get_separator_type, axis=1)
    split_df['primary_api_type'] = split_df.apply(get_api_type, axis=1)
    split_df['primary_separator_merged'] = split_df['primary_separator_type'].replace({'RE': 'MUL/REG', 'MUL': 'MUL/REG'})

    # Categories for plots
    line_data = {
        0: ("Partition", ['1', '2', '≥3'], 'split_groups_category'),
        1: ("Separator", ['VAR', 'MUL/REG', 'SIN'], 'primary_separator_merged'),
        2: ("API", ['Normal', 'Limit'], 'primary_api_type')
    }

    # Pie charts (left column)
    pie_data = {
        0: ("Partition", split_df['split_groups_category'].value_counts().reindex(['1', '2', '≥3'], fill_value=0)),
        1: ("Separator", split_df['primary_separator_merged'].value_counts().reindex(['VAR', 'MUL/REG', 'SIN'], fill_value=0)),
        2: ("API", split_df['primary_api_type'].value_counts().reindex(['Normal', 'Limit'], fill_value=0))
    }

    for idx, (title, counts) in pie_data.items():
        ax = axes[idx, 0]
        labels = [f"{cat} ({n})" for cat, n in counts.items()]
        wedges, texts, autotexts = ax.pie(
            counts, labels=labels, autopct='%1.1f%%',
            startangle=140, colors=plt.cm.tab20.colors[:len(counts)]
        )
        ax.set_title(f"{title} Distribution", fontweight='bold', fontsize=20+font_offset)
        for t in autotexts:
            t.set_fontsize(14+font_offset)

    # Performance plots (middle and right columns)
    for idx, (title, categories, category_col) in line_data.items():
        # Middle: Success Ratio
        ax_ratio = axes[idx, 1]
        for solver in solvers:
            ratios = []
            for cat in categories:
                cat_files = split_df[split_df[category_col] == cat]['filename'].tolist()
                solved = count_solved_by_solver(solver_df, cat_files, solver)
                ratio = solved / len(cat_files) * 100 if len(cat_files) > 0 else np.nan
                ratios.append(ratio)
            ax_ratio.plot(
                categories, ratios,
                color=solver_colors[solver],
                marker=solver_markers[solver],
                linewidth=3,
                markersize=10,
                alpha=0.8,  # Slight transparency
                label=solver.replace('ext-', '')
            )
        ax_ratio.set_title(f"{title}: Solver Success Ratio", fontweight='bold', fontsize=20+font_offset)
        ax_ratio.set_xlabel("Category", fontsize=18+font_offset)
        ax_ratio.set_ylabel("Solved Ratio (%)", fontsize=18+font_offset)
        ax_ratio.yaxis.set_major_formatter(mtick.PercentFormatter())
        ax_ratio.grid(True, alpha=0.3, linestyle='--')
        ax_ratio.set_ylim(-5, 105)  # Padding to prevent clipping
        ax_ratio.legend(fontsize=14+font_offset, bbox_to_anchor=(1.05, 1), loc='upper left')

        # Right: Avg Time (log)
        ax_time = axes[idx, 2]
        max_time = 0
        for solver in solvers:
            times = []
            for cat in categories:
                cat_files = split_df[split_df[category_col] == cat]['filename'].tolist()
                avg_time = get_average_solving_time(solver_df, cat_files, solver)
                times.append(avg_time)
                max_time = max(max_time, avg_time)
            ax_time.plot(
                categories, times,
                color=solver_colors[solver],
                marker=solver_markers[solver],
                linewidth=3,
                markersize=10,
                alpha=0.8,
                label=solver.replace('ext-', '')
            )
        ax_time.set_title(f"{title}: Avg Solve Time (log)", fontweight='bold', fontsize=20+font_offset)
        ax_time.set_xlabel("Category", fontsize=18+font_offset)
        ax_time.set_ylabel("Time (milliseconds)", fontsize=18+font_offset)
        ax_time.set_yscale('log')
        ax_time.set_ylim(0.1, max_time * 2 or 1000)  # Dynamic upper limit with padding
        ax_time.grid(True, alpha=0.3, linestyle='--')
        ax_time.legend(fontsize=14+font_offset, bbox_to_anchor=(1.05, 1), loc='upper left')

    plt.tight_layout()
    if not output_file.endswith('.pdf'):
        output_file = output_file.replace('.png', '.pdf')
    plt.savefig(output_file, format='pdf', dpi=300, bbox_inches='tight')
    print(f"Combined chart saved to: {output_file}")

def print_summary_statistics(split_df, solver_df):
    """Print summary statistics."""
    print("\n" + "="*60)
    print("SUMMARY STATISTICS")
    print("="*60)
    
    print(f"Total files with split operations: {len(split_df)}")
    
    # Split groups distribution
    split_df['split_groups_category'] = split_df['split_groups_count'].apply(categorize_split_groups)
    groups_dist = split_df['split_groups_category'].value_counts().reindex(['1', '2', '≥3'], fill_value=0)
    print(f"\nSplit Groups Distribution:")
    for category, count in groups_dist.items():
        print(f"  {category}: {count} files")
    
    # Separator type distribution
    split_df['primary_separator_type'] = split_df.apply(get_separator_type, axis=1)
    sep_dist = split_df['primary_separator_type'].value_counts()
    print(f"\nSeparator Type Distribution:")
    for sep_type, count in sep_dist.items():
        print(f"  {sep_type}: {count} files")
    
    # Check for overlaps in separator types
    print(f"\nSeparator Type Overlaps (files can have multiple types):")
    var_count = len(split_df[split_df['separator_VAR'] == 1])
    re_count = len(split_df[split_df['separator_RE'] == 1])
    mul_count = len(split_df[split_df['separator_MUL'] == 1])
    sin_count = len(split_df[split_df['separator_SIN'] == 1])
    print(f"  VAR: {var_count} files")
    print(f"  RE: {re_count} files")
    print(f"  MUL: {mul_count} files")
    print(f"  SIN: {sin_count} files")
    print(f"  Total: {var_count + re_count + mul_count + sin_count} (may exceed {len(split_df)} due to overlaps)")
    
    # API type distribution
    split_df['primary_api_type'] = split_df.apply(get_api_type, axis=1)
    api_dist = split_df['primary_api_type'].value_counts()
    print(f"\nAPI Type Distribution:")
    for api_type, count in api_dist.items():
        print(f"  {api_type}: {count} files")
    
    # Solver performance summary
    if solver_df is not None:
        print(f"\nSolver Performance Summary:")
        solvers = ['ext-cvc5', 'ext-ostrich', 'ext-z3', 'ext-z3-noodler']
        all_files = split_df['filename'].tolist()
        
        for solver in solvers:
            solved_count = count_solved_by_solver(solver_df, all_files, solver)
            solve_rate = (solved_count / len(all_files)) * 100 if len(all_files) > 0 else 0
            print(f"  {solver}: {solved_count}/{len(all_files)} ({solve_rate:.1f}%)")
        
        # Detailed breakdown by category
        print(f"\nDetailed Solver Performance by Category:")
        
        # By split groups
        print(f"\nBy Split Groups:")
        for category in ['1', '2', '≥3']:
            category_files = split_df[split_df['split_groups_category'] == category]['filename'].tolist()
            print(f"  {category} ({len(category_files)} files):")
            for solver in solvers:
                solved_count = count_solved_by_solver(solver_df, category_files, solver)
                print(f"    {solver}: {solved_count}")
        
        # By separator type (primary)
        print(f"\nBy Separator Type (Primary):")
        for sep_type in ['VAR', 'RE', 'MUL', 'SIN']:
            sep_files = split_df[split_df['primary_separator_type'] == sep_type]['filename'].tolist()
            if sep_files:
                print(f"  {sep_type} ({len(sep_files)} files):")
                for solver in solvers:
                    solved_count = count_solved_by_solver(solver_df, sep_files, solver)
                    print(f"    {solver}: {solved_count}")
        
        # By API type
        print(f"\nBy API Type:")
        for api_type in ['Normal', 'Limit']:
            api_files = split_df[split_df['primary_api_type'] == api_type]['filename'].tolist()
            if api_files:
                print(f"  {api_type} ({len(api_files)} files):")
                for solver in solvers:
                    solved_count = count_solved_by_solver(solver_df, api_files, solver)
                    print(f"    {solver}: {solved_count}")

def main():
    parser = argparse.ArgumentParser(description='Plot split operation statistics and solver performance')
    parser.add_argument('--benchmark-dirs', nargs='+', 
                       default=['benchmarks/Java/awesome', 'benchmarks/Java/top20_gh', 'benchmarks/Java/top20_maven'],
                       help='Benchmark directories to analyze')
    parser.add_argument('--solver-results', 
                       default='charts/Excel/all_analysis.xlsx',
                       help='Excel file with solver results')
    parser.add_argument('--output', 
                       default='charts/PDF/split_statistics_pro_plot.pdf',
                       help='Output plot file')
    parser.add_argument('--font-offset', type=int, default=0,
                       help='Font size offset (default: 0, positive for larger fonts)')
    
    args = parser.parse_args()
    
    print("Loading solver results...")
    solver_df = load_solver_results(args.solver_results)
    
    if solver_df is None:
        print(f"Error: Could not load solver results from {args.solver_results}")
        print("Please run: python scripts/solve/analysis_results.py --task ext --results-dir results --output-file charts/all_analysis.xlsx")
        return
    
    print("Extracting split statistics from solver results...")
    # Filter for files that have split operations
    split_files = solver_df[
        (solver_df['get_split_length_count'] > 0) | 
        (solver_df['get_split_element_count'] > 0)
    ].copy()
    
    if split_files.empty:
        print("No files with split operations found in the solver results.")
        return
    
    print(f"Found {len(split_files)} files with split operations")
    
    print("Creating combined charts...")
    os.makedirs(os.path.dirname(args.output), exist_ok=True)
    create_combined_charts(split_files, solver_df, args.output, font_offset=args.font_offset)
    
    print_summary_statistics(split_files, solver_df)
    
    print(f"\nCombined chart saved to: {args.output}")

if __name__ == "__main__":
    main()