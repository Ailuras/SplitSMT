#!/usr/bin/env python3
"""
Split Statistics Plotting Script
Creates comprehensive charts showing split operation characteristics and solver performance.
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
    
    # Filter for files in our split data (only the specific filenames we're interested in)
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

def create_comprehensive_plot(split_df, solver_df, output_file, font_offset=0):
    """Create comprehensive plot with bar charts and line plots."""
    
    # Set up the figure with one horizontal subplot
    fig, ax = plt.subplots(1, 1, figsize=(20, 12))
    
    # Apply font offset
    base_font = 16 + font_offset
    label_font = 20 + font_offset
    tick_font = 16 + font_offset
    legend_font = 16 + font_offset
    bar_label_font = 18 + font_offset
    
    # Define colors for consistency
    bar_colors = ['#3498db', '#e67e22', '#2ecc71']  # Different colors for each category group
    bar_labels = ['#Partition', 'Separator', 'API']  # Labels for bar categories
    solver_colors = {
        'ext-cvc5': '#e74c3c',
        'ext-ostrich': '#2ecc71', 
        'ext-z3': '#f39c12',
        'ext-z3-noodler': '#9b59b6'
    }
    
    # Define different markers for each solver
    solver_markers = {
        'ext-cvc5': 'o',        # circle
        'ext-ostrich': 's',     # square  
        'ext-z3': '^',          # triangle up
        'ext-z3-noodler': 'D'   # diamond
    }
    
    # Get list of all split files for verification
    all_split_files = set(split_df['filename'].tolist())
    
    # Prepare data for all three categories
    split_df['split_groups_category'] = split_df['split_groups_count'].apply(categorize_split_groups)
    split_df['primary_separator_type'] = split_df.apply(get_separator_type, axis=1)
    split_df['primary_api_type'] = split_df.apply(get_api_type, axis=1)
    
    # Collect all data
    all_categories = []
    all_values = []
    all_colors = []
    all_solver_data = {solver.replace('ext-', ''): [] for solver in solver_colors.keys()}
    
    # 1. Split Groups Count
    groups_stats = split_df['split_groups_category'].value_counts().reindex(['1', '2', '≥3'], fill_value=0)
    for i, (category, count) in enumerate(groups_stats.items()):
        all_categories.append(category)
        all_values.append(count)
        all_colors.append(bar_colors[0])
        
        # Collect solver data
        for solver_full in solver_colors.keys():
            solver_short = solver_full.replace('ext-', '')
            category_files = split_df[split_df['split_groups_category'] == category]['filename'].tolist()
            category_files = [f for f in category_files if f in all_split_files]
            solved_count = count_solved_by_solver(solver_df, category_files, solver_full)
            all_solver_data[solver_short].append(solved_count)
    
    # 2. Separator Type (reordered: SIN, MUL, REG, VAR)
    separator_stats = split_df['primary_separator_type'].value_counts().reindex(['SIN', 'MUL', 'RE', 'VAR'], fill_value=0)
    for i, (sep_type, count) in enumerate(separator_stats.items()):
        # Change RE to REG for display
        display_type = 'REG' if sep_type == 'RE' else sep_type
        all_categories.append(display_type)
        all_values.append(count)
        all_colors.append(bar_colors[1])
        
        # Collect solver data
        for solver_full in solver_colors.keys():
            solver_short = solver_full.replace('ext-', '')
            sep_files = split_df[split_df['primary_separator_type'] == sep_type]['filename'].tolist()
            sep_files = [f for f in sep_files if f in all_split_files]
            solved_count = count_solved_by_solver(solver_df, sep_files, solver_full)
            all_solver_data[solver_short].append(solved_count)
    
    # 3. API Type
    api_stats = split_df['primary_api_type'].value_counts().reindex(['Normal', 'Limit'], fill_value=0)
    for i, (api_type, count) in enumerate(api_stats.items()):
        all_categories.append(api_type)
        all_values.append(count)
        all_colors.append(bar_colors[2])
        
        # Collect solver data
        for solver_full in solver_colors.keys():
            solver_short = solver_full.replace('ext-', '')
            api_files = split_df[split_df['primary_api_type'] == api_type]['filename'].tolist()
            api_files = [f for f in api_files if f in all_split_files]
            solved_count = count_solved_by_solver(solver_df, api_files, solver_full)
            all_solver_data[solver_short].append(solved_count)
    
    # Create the combined bar chart with category labels
    x_positions = range(len(all_categories))
    bars = []
    
    # Create bars for each category group with proper labels
    start_idx = 0
    for group_idx, (color, label) in enumerate(zip(bar_colors, bar_labels)):
        if group_idx == 0:  #Partition group (3 bars)
            end_idx = start_idx + 3
        elif group_idx == 1:  # Separator group (4 bars)
            end_idx = start_idx + 4
        else:  # API group (2 bars)
            end_idx = start_idx + 2
        
        group_bars = ax.bar(x_positions[start_idx:end_idx], 
                           all_values[start_idx:end_idx], 
                           color=color, alpha=0.7, label=label)
        bars.extend(group_bars)
        start_idx = end_idx
    
    # Add value labels on bars
    for bar in bars:
        height = bar.get_height()
        if height > 0:
            ax.text(bar.get_x() + bar.get_width()/2., height + 0.5,
                    f'{int(height)}', ha='center', va='bottom', fontweight='bold', fontsize=bar_label_font)
    
    # Set up the primary y-axis
    ax.set_xlabel('Categories', fontsize=label_font, fontweight='bold')
    ax.set_ylabel('Number of Files', color='#2c3e50', fontsize=label_font, fontweight='bold')
    ax.set_xticks(x_positions)
    ax.set_xticklabels(all_categories, fontsize=tick_font)
    ax.tick_params(axis='y', labelcolor='#2c3e50')
    ax.grid(True, alpha=0.3, axis='y')
    
    # Add solver performance lines
    ax_twin = ax.twinx()
    if solver_df is not None:
        for solver_short, solver_data in all_solver_data.items():
            solver_full = f'ext-{solver_short}'
            ax_twin.plot(x_positions, solver_data, 
                        color=solver_colors[solver_full], 
                        marker=solver_markers[solver_full], linewidth=3, markersize=8,
                        label=solver_short)
    
    ax_twin.set_ylabel('Solved Count', color='#c0392b', fontsize=label_font, fontweight='bold')
    ax_twin.tick_params(axis='y', labelcolor='#c0392b')
    
    # Try to synchronize y-axis ranges for better visualization
    try:
        # Get the maximum values from both axes
        left_max = max(all_values) if all_values else 0
        right_max = max([max(solver_data) for solver_data in all_solver_data.values()]) if all_solver_data else 0
        
        # Set similar ranges with some padding
        if left_max > 0 and right_max > 0:
            max_val = max(left_max, right_max)
            ax.set_ylim(0, max_val * 1.1)
            ax_twin.set_ylim(0, max_val * 1.1)
    except:
        pass  # If synchronization fails, use default ranges
    
    # Add separators between category groups
    separator_positions = [2.5, 6.5]  # Between groups/separator and separator/api
    for pos in separator_positions:
        ax.axvline(x=pos, color='gray', linestyle='--', alpha=0.5, linewidth=2)
    
    # Add legends
    ax.legend(loc='upper center', fontsize=legend_font, bbox_to_anchor=(0.25, 1.0))
    if solver_df is not None:
        ax_twin.legend(loc='upper center', fontsize=legend_font, bbox_to_anchor=(0.6, 1.0))
    
    # Adjust layout and save
    plt.tight_layout()
    
    # Change file extension to PDF
    if output_file.endswith('.png'):
        output_file = output_file.replace('.png', '.pdf')
    elif not output_file.endswith('.pdf'):
        output_file += '.pdf'
    
    plt.savefig(output_file, format='pdf', dpi=300, bbox_inches='tight')
    print(f"Plot saved to: {output_file}")
    
    return fig

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
                       default='charts/PDF/split_statistics_plot.pdf',
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
    
    print("Creating comprehensive plot...")
    os.makedirs(os.path.dirname(args.output), exist_ok=True)
    fig = create_comprehensive_plot(split_files, solver_df, args.output, font_offset=args.font_offset)
    
    print_summary_statistics(split_files, solver_df)
    
    print(f"\nPlot saved to: {args.output}")

if __name__ == "__main__":
    main() 