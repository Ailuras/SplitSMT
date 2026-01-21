#!/usr/bin/env python3
"""
heatmap.py - Generate a 4x7 heatmap showing SplitSMT solved rate
across solvers and factor categories.
"""
from __future__ import annotations

import argparse
from pathlib import Path
from typing import Dict, List

import matplotlib.pyplot as plt
import numpy as np
from openpyxl import load_workbook

# Styling for paper
plt.rcParams.update({
    "font.family": "serif",
    "font.size": 15,
    "axes.labelsize": 15,
    "axes.titlesize": 17,
    "xtick.labelsize": 14,
    "ytick.labelsize": 14,
})


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Generate heatmap for SplitSMT solved rate")
    parser.add_argument("--summary", type=Path, default=Path("results/summary.xlsx"))
    parser.add_argument("--factors", type=Path, default=Path("results/factors.xlsx"))
    parser.add_argument("--output", type=Path, default=Path("scripts/experiment/heatmap.pdf"))
    return parser.parse_args()


def load_factors(path: Path) -> Dict[str, Dict]:
    """Load factor classifications from factors.xlsx."""
    wb = load_workbook(path, data_only=True)
    ws = wb["Factors"]
    
    headers = [c.value for c in ws[1]]
    header_map = {str(h).strip(): idx for idx, h in enumerate(headers) if h is not None}
    
    factors = {}
    for row in ws.iter_rows(min_row=2, values_only=True):
        if row is None or all(v is None for v in row):
            continue
        
        path_val = row[header_map["path"]]
        if path_val is None:
            continue
        
        # Extract filename from path
        filename = Path(path_val).name
        
        factors[filename] = {
            "delimiter_type": row[header_map["delimiter_type"]],
            "api_semantics": row[header_map["api_semantics"]],
            "index_depth": row[header_map["index_depth"]],
        }
    
    return factors


def load_solver_results(path: Path, solver: str) -> Dict[str, str]:
    """Load splitsmt results for a specific solver from summary.xlsx."""
    wb = load_workbook(path, data_only=True)
    ws = wb[solver]
    
    headers = [c.value for c in ws[1]]
    header_map = {str(h).strip(): idx for idx, h in enumerate(headers) if h is not None}
    
    results = {}
    for row in ws.iter_rows(min_row=2, values_only=True):
        if row is None or all(v is None for v in row):
            continue
        
        filename = row[header_map["filename"]]
        if filename is None:
            continue
        
        result = row[header_map.get("splitsmt_result", -1)]
        if result is not None:
            results[filename] = str(result).strip().upper()
    
    return results


def calculate_solved_rate(
    factors: Dict[str, Dict],
    results: Dict[str, str],
    factor_key: str,
    factor_value: str,
) -> tuple[float, int]:
    """Calculate solved rate for a specific factor category.
    
    Returns (solved_rate, total_count).
    """
    total = 0
    solved = 0
    
    for filename, factor_data in factors.items():
        if factor_data.get(factor_key) != factor_value:
            continue
        
        total += 1
        result = results.get(filename, "")
        if result in ("SAT", "UNSAT"):
            solved += 1
    
    if total == 0:
        return 0.0, 0
    return solved / total, total


def main() -> int:
    args = parse_args()
    
    if not args.factors.exists():
        print(f"Error: Factors file not found: {args.factors}")
        return 1
    if not args.summary.exists():
        print(f"Error: Summary file not found: {args.summary}")
        return 1
    
    # Load factors
    factors = load_factors(args.factors)
    print(f"Loaded {len(factors)} factor entries")
    
    # Solvers (rows)
    solvers = ["z3", "cvc5", "ostrich", "z3-noodler"]
    solver_labels = ["Z3", "CVC5", "Ostrich", "Z3-Noodler"]
    
    # Factor categories (columns)
    # Format: (factor_key, factor_value, display_label)
    categories = [
        # Delimiter type
        ("delimiter_type", "CONST", "Const"),
        ("delimiter_type", "REG", "Regex"),
        ("delimiter_type", "VAR", "VarDelim"),
        # API semantics
        ("api_semantics", "Normal", "Normal"),
        ("api_semantics", "Limit", "Limit"),
        # Index depth
        ("index_depth", "not-var", "ConstIdx"),
        ("index_depth", "var", "VarIdx"),
    ]
    
    # Separator positions (after index 2 and 4)
    separator_positions = [3, 5]  # After VarDelim and Limit
    
    # Build data matrix
    data = np.zeros((len(solvers), len(categories)))
    counts = np.zeros(len(categories), dtype=int)
    
    # Pre-calculate counts (same for all solvers for a given category)
    # Just need one pass to get counts
    for j, (factor_key, factor_value, _) in enumerate(categories):
        count = 0
        for factor_data in factors.values():
            if factor_data.get(factor_key) == factor_value:
                count += 1
        counts[j] = count
    
    for i, solver in enumerate(solvers):
        results = load_solver_results(args.summary, solver)
        for j, (factor_key, factor_value, _) in enumerate(categories):
            rate, _ = calculate_solved_rate(factors, results, factor_key, factor_value)
            data[i, j] = rate
    
    # Manual overrides requested by user (Counts converted to rates)
    # Z3 (row 0): ConstIdx (col 5) = 30, VarIdx (col 6) = 2
    # Z3-Noodler (row 3): ConstIdx (col 5) = 83, VarIdx (col 6) = 11
    # Category counts: ConstIdx (not-var) = 145, VarIdx (var) = 23
    
    # Z3
    data[0, 5] = 30 / 145  # Z3 ConstIdx
    data[0, 6] = 2 / 23    # Z3 VarIdx
    
    # Z3-Noodler
    data[3, 5] = 83 / 145  # Z3-Noodler ConstIdx
    data[3, 6] = 11 / 23   # Z3-Noodler VarIdx
    
    # Create figure
    fig, ax = plt.subplots(figsize=(12, 4))
    
    # Create heatmap
    im = ax.imshow(data, cmap="RdYlGn", aspect="auto", vmin=0, vmax=1)
    
    # Set X-axis ticks and labels
    # Combine Category Name and Count (n=xx)
    x_labels = []
    for j, category in enumerate(categories):
        label = category[2]
        count = counts[j]
        x_labels.append(f"{label}\n(n={count})")
        
    ax.set_xticks(range(len(categories)))
    ax.set_xticklabels(x_labels)
    
    # Set Y-axis ticks and labels (Clean solver names)
    ax.set_yticks(range(len(solvers)))
    ax.set_yticklabels(solver_labels)
    
    # Add text annotations with outline for better visibility
    import matplotlib.patheffects as pe
    
    for i in range(len(solvers)):
        for j in range(len(categories)):
            value = data[i, j]
            # Choose text color based on background luminance roughly
            # RdYlGn: Red(low) is dark, Green(high) is dark-ish, Yellow(mid) is bright
            # So white text for low/high values, black for mid values
            text_color = "black" if 0.3 < value < 0.7 else "white"
            
            txt = ax.text(j, i, f"{value:.0%}", ha="center", va="center", 
                         color=text_color, fontsize=13, fontweight="bold")
            # Add thin black outline to white text, white outline to black text
            outline_col = "white" if text_color == "black" else "black"
            txt.set_path_effects([pe.withStroke(linewidth=1.0, foreground=outline_col)])
    
    # Add vertical separator lines
    for pos in separator_positions:
        ax.axvline(x=pos - 0.5, color="black", linewidth=2)
    
    # Add factor group labels at top
    ax.set_xlabel("")
    ax.xaxis.set_label_position("bottom")
    ax.xaxis.tick_bottom()
    
    # Add group headers above columns using text coordinates relative to axes
    # Coordinates need adjustment based on column indices
    # Delimiter: cols 0-2 -> center at 1
    # API: cols 3-4 -> center at 3.5
    # Index: cols 5-6 -> center at 5.5
    group_labels = [
        (1, "Delimiter Type"),
        (3.5, "API Semantics"),
        (5.5, "Accessed Index"),
    ]
    for x, label in group_labels:
        # y position slightly above the top spine
        ax.text(x, -0.6, label, ha="center", va="bottom", fontsize=15, fontweight="bold")
    
    # Colorbar
    cbar = fig.colorbar(im, ax=ax, shrink=0.8)
    cbar.set_label("Solved Rate")
    
    # Adjust layout
    plt.tight_layout()
    # Increase top margin to accommodate group labels
    plt.subplots_adjust(top=0.85)
    
    # Save
    args.output.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(args.output, bbox_inches="tight", dpi=300)
    print(f"Heatmap saved to {args.output}")
    
    # Print summary
    print("\n--- Solved Rate Matrix ---")
    print("Solver\t\t" + "\t".join([f"{c[2]}(n={counts[j]})" for j, c in enumerate(categories)]))
    for i, label in enumerate(solver_labels):
        rates = [f"{data[i, j]:.1%}" for j in range(len(categories))]
        print(f"{label}\t\t" + "\t".join(rates))
    
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
