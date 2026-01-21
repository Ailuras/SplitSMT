#!/usr/bin/env python3
import argparse
import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path
from openpyxl import load_workbook

# Styling for paper
plt.rcParams.update({
    "font.family": "serif",
    "font.size": 13,        # 13
    "axes.labelsize": 13,   # 13
    "axes.titlesize": 13,   # 13
    "xtick.labelsize": 11,  # 11
    "ytick.labelsize": 11,  # 11
    "legend.fontsize": 11,  # 11
    "lines.linewidth": 1.5,
})

def parse_args():
    parser = argparse.ArgumentParser(description="Plot ECDF for Real-World Benchmarks")
    parser.add_argument("--summary", type=Path, default=Path("results/summary.xlsx"))
    parser.add_argument("--output", type=Path, default=Path("scripts/experiment/figure.pdf"))
    return parser.parse_args()

def load_data(path: Path, filter_func):
    if not path.exists():
        raise FileNotFoundError(f"Summary file not found: {path}")
    
    wb = load_workbook(path, data_only=True)
    ws = wb["z3-noodler"] # Using the same sheet as tables.py default
    
    headers = [c.value for c in ws[1]]
    header_map = {str(h).strip(): idx for idx, h in enumerate(headers) if h is not None}
    
    data = []
    for row in ws.iter_rows(min_row=2, values_only=True):
        if row is None or all(v is None for v in row):
            continue
        
        # Filter 
        if not filter_func(row, header_map):
            continue
            
        record = {}
        for key, idx in header_map.items():
            record[key] = row[idx] if idx < len(row) else None
        data.append(record)
        
    return data

def get_method_times(data, prefix):
    times = []
    for row in data:
        res = str(row.get(f"{prefix}_result", "")).strip().upper()
        t = row.get(f"{prefix}_time")
        
        if res in ("SAT", "UNSAT") and isinstance(t, (int, float)):
            times.append(float(t))
        else:
            times.append(None) # Not solved
    return times

def generate_plot(data, output_path: Path, y_max=None):
    # Mapping from method name to extracted prefix
    methods = {
        "SplitSMT": "splitsmt",
        "RALen": "RA",
        "RecLen": "REC",
        "UF-split": "UF"
    }
    
    colors = {
        "SplitSMT": "#d62728", # Red
        "RALen": "#1f77b4",    # Blue
        "RecLen": "#ff7f0e",   # Orange
        "UF-split": "#2ca02c"  # Green
    }
    
    styles = {
        "SplitSMT": "-", 
        "RALen": "--",
        "RecLen": "-.",
        "UF-split": ":"
    }

    # Extract times for all methods
    n_instances = len(data)
    
    # Calculate VBS solved count
    solved_by_any_count = 0
    for i in range(n_instances):
        solved = False
        for name, prefix in methods.items():
            res = str(data[i].get(f"{prefix}_result", "")).strip().upper()
            if res in ("SAT", "UNSAT"):
                solved = True
                break
        if solved:
            solved_by_any_count += 1
            
    fig, ax = plt.subplots(figsize=(5, 3.5)) # 5:3.5 ratio
    
    for name, prefix in methods.items():
        times = get_method_times(data, prefix)
        # Filter solved instances and sort them
        solved_times = sorted([t for t in times if t is not None])
        count = len(solved_times)
        
        # X-axis: Time (sorted)
        x = solved_times
        # Y-axis: Number of solved instances (1, 2, ... k)
        y = list(range(1, len(solved_times) + 1))
        
        # Prepend (0,0) for better visualization if needed, or start from first point
        # For ECDF style, it's nice to start at 0 count.
        if x:
            x = [0] + x
            y = [0] + y
            
            # Extend to max x limit (1200) to show flat line?
            # ECDF usually does this.
            x.append(1200)
            y.append(y[-1])
        else:
            x = [0, 1200]
            y = [0, 0]
        
        label = f"{name} ({count})"
        # Markers removed as requested
        
        ax.plot(x, y, label=label, color=colors[name], linestyle=styles[name])

    # Add VBS line (Horizontal line at the max number of instances solved by VBS)
    # Remove label from legend, add text instead
    ax.axhline(y=solved_by_any_count, color='gray', linestyle='--', linewidth=1)
    
    # Add text "Virtual Best Method" near the line
    ax.text(0.1, solved_by_any_count + (1 if y_max is None or solved_by_any_count < y_max * 0.9 else -5), 
            "Virtual Best Method", 
            color='gray', fontsize=11, va='bottom' if (y_max is None or solved_by_any_count < y_max * 0.9) else 'top', ha='left')
    
    # Set X-axis to symlog to handle small times (0-10s) and large timeouts (1200s) better
    ax.set_xscale('symlog', linthresh=1.0) # Linthresh 1.0 is standard for 1+ values
    
    # Set limits
    # X-axis: 0.05 to 1500 to comfortably fit 0.1 and 1000 ticks
    ax.set_xlim(0.05, 1500) 
    
    # Y-axis
    if y_max is not None:
        ax.set_ylim(0, y_max)
    else:
        # Auto limit
        ax.set_ylim(0, n_instances * 1.05)

    ax.set_xlabel("Time (s)")
    ax.set_ylabel("Number of Solved Instances")
    
    # Custom X-ticks as requested
    xticks = [0.1, 1, 10, 100, 1000]
    ax.set_xticks(xticks)
    ax.set_xticklabels([str(x) for x in xticks])

    ax.grid(True, linestyle=':', alpha=0.6)
    ax.legend(loc="lower right")
    
    # Square aspect removed as requested
    # ax.set_box_aspect(1) 
    
    plt.tight_layout()
    plt.savefig(output_path, bbox_inches='tight')
    print(f"Plot saved to {output_path}")

def main():
    args = parse_args()
    
    # 1. RealWorld Plot
    def is_realworld(row, header_map):
        suite_idx = header_map.get("suite")
        if suite_idx is None: return False
        return str(row[suite_idx]).strip() == "RealWorld"

    realworld_data = load_data(args.summary, is_realworld)
    if realworld_data:
        print(f"Found {len(realworld_data)} RealWorld instances.")
        generate_plot(realworld_data, args.output, y_max=120)
    else:
        print("No RealWorld data found.")

    # 2. Synthetic Plot
    def is_synthetic(row, header_map):
        suite_idx = header_map.get("suite")
        if suite_idx is None: return False
        return str(row[suite_idx]).strip() != "RealWorld"
        
    synthetic_data = load_data(args.summary, is_synthetic)
    if synthetic_data:
        print(f"Found {len(synthetic_data)} Synthetic instances.")
        # Synthetic output path
        syn_output = args.output.parent / "figure_synthetic.pdf"
        generate_plot(synthetic_data, syn_output, y_max=400) # User requested max 400
    else:
        print("No Synthetic data found.")
        
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
