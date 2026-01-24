#!/usr/bin/env python3
"""Compare two aggregation reports (v1 vs v2) and generate a difference report."""

import argparse
import sys
import re
from pathlib import Path
from collections import defaultdict
from openpyxl import load_workbook, Workbook
from openpyxl.styles import PatternFill, Font
from openpyxl.cell.cell import TYPE_STRING

def parse_args():
    parser = argparse.ArgumentParser(description="Compare two report.xlsx files.")
    parser.add_argument("file_old", type=Path, help="Path to the first (old) report.xlsx")
    parser.add_argument("file_new", type=Path, help="Path to the second (new) report.xlsx")
    parser.add_argument("--output", type=Path, default=Path("comparison_report.xlsx"), help="Output path")
    return parser.parse_args()

def normalize_result(val):
    if val is None:
        return ""
    s = str(val).strip().upper()
    if s in ["SAT", "UNSAT", "UNKNOWN", "TIMEOUT", "ERROR"]:
        return s
    # If it looks like SAT->UNSAT (already processed), keep it? 
    # But we assume input is raw aggregate output.
    # If empty or 0, treat as ERROR or MISSING? 
    # aggregate.py outputs blank for missing?
    if not s:
        return "MISSING"
    return s

def read_data(path):
    print(f"Reading {path}...")
    try:
        wb = load_workbook(path, read_only=True, data_only=True)
    except Exception as e:
        print(f"Error opening {path}: {e}")
        sys.exit(1)
        
    ws = wb.active
    rows = list(ws.rows)
    if not rows:
        print(f"Error: {path} is empty")
        sys.exit(1)
        
    headers = [str(c.value).strip() if c.value else "" for c in rows[0]]
    
    try:
        idx_suite = headers.index("suite")
        idx_cat = headers.index("category")
        idx_file = headers.index("filename")
        # Try to find path column to keep it if possible
        if "path" in headers:
            idx_path_col = headers.index("path")
        else:
            idx_path_col = None
    except ValueError as e:
        print(f"Error: {path} is missing required metadata columns: {e}")
        print(f"Available headers: {headers}")
        sys.exit(1)

    solver_cols = []
    for i, h in enumerate(headers):
        if h.endswith("_result"):
            solver = h.replace("_result", "")
            solver_cols.append((solver, i))
    
    data = {}
    for row in rows[1:]:
        suite = row[idx_suite].value
        cat = row[idx_cat].value
        fname = row[idx_file].value
        
        # Key: (suite, category, filename)
        # Handle None
        suite = str(suite) if suite else "-"
        cat = str(cat) if cat else "-"
        fname = str(fname) if fname else "-"
        
        key = (suite, cat, fname)
        
        path_val = row[idx_path_col].value if idx_path_col is not None else ""
        
        entry = {
            "path": str(path_val) if path_val else "",
            "results": {}
        }
        for solver, col_idx in solver_cols:
            if col_idx < len(row):
                val = row[col_idx].value
                entry["results"][solver] = normalize_result(val)
            else:
                entry["results"][solver] = "MISSING"
        
        data[key] = entry
        
    return headers, data, [s for s, _ in solver_cols]

def main():
    args = parse_args()
    
    headers1, data1, solvers1 = read_data(args.file_old)
    headers2, data2, solvers2 = read_data(args.file_new)
    
    common_solvers = sorted(list(set(solvers1) & set(solvers2)))
    if not common_solvers:
        print("Warning: No common solvers found between the two files.")
        
    all_keys = sorted(list(set(data1.keys()) | set(data2.keys())))
    
    # Stats: solver -> transition -> count
    stats = defaultdict(lambda: defaultdict(int))
    
    out_rows = []
    
    for key in all_keys:
        d1 = data1.get(key)
        d2 = data2.get(key)
        
        suite, cat, fname = key
        
        # Use path from new file, else old
        fpath = d2["path"] if d2 else (d1["path"] if d1 else "")
        
        row_out = {
            "path": fpath,
            "suite": suite,
            "category": cat,
            "filename": fname
        }
        
        for solver in common_solvers:
            r1 = d1["results"].get(solver, "MISSING") if d1 else "MISSING"
            r2 = d2["results"].get(solver, "MISSING") if d2 else "MISSING"
            
            # Normalize MISSING to empty string if that's preferred, but for diff "MISSING->SAT" is useful
            if r1 == "MISSING" and r2 == "MISSING":
                final = ""
            elif r1 == r2:
                final = r1
                # We don't count 'Same' in "differences statistics" usually, but maybe useful for "Total"
                stats[solver]["SAME"] += 1
            else:
                final = f"{r1}->{r2}"
                stats[solver][final] += 1
            
            row_out[f"{solver}_result"] = final
            
        out_rows.append(row_out)

    # --- Write Excel ---
    wb = Workbook()
    ws = wb.active
    ws.title = "Comparison"
    
    # Define headers
    output_headers = ["path", "suite", "category", "filename"] + [f"{solver}_result" for solver in common_solvers]
    
    # Styles
    header_fill = PatternFill(start_color="4472C4", end_color="4472C4", fill_type="solid")
    header_font = Font(bold=True, color="FFFFFF")
    
    # Result Fills (Base colors)
    base_fills = {
        "SAT": PatternFill(start_color="C6EFCE", end_color="C6EFCE", fill_type="solid"),     # Green
        "UNSAT": PatternFill(start_color="FFC7CE", end_color="FFC7CE", fill_type="solid"),   # Red
        "UNKNOWN": PatternFill(start_color="FFEB9C", end_color="FFEB9C", fill_type="solid"), # Yellow
        "TIMEOUT": PatternFill(start_color="E2EFDA", end_color="E2EFDA", fill_type="solid"), # Light Green
        "ERROR": PatternFill(start_color="D9D9D9", end_color="D9D9D9", fill_type="solid"),   # Grey
        "MISSING": PatternFill(start_color="D9D9D9", end_color="D9D9D9", fill_type="solid"),
    }
    
    # Diff Fills - Highlight changes
    # Significant changes: SAT<->UNSAT, SAT/UNSAT -> UNKNOWN/TIMEOUT/ERROR (Regression), UNKNOWN/TIMEOUT -> SAT/UNSAT (Improvement)
    # We can use a generic "Changed" color, or specific.
    # Let's use a light blue for changes to make them stand out, or keep text indicating change.
    # User said: "Inconsistent use SAT->UNSAT markers" -> Text is already there.
    # Fill logic:
    # If same: use base fill.
    # If diff: use a warning color (e.g. Orange or distinct Blue).
    diff_fill = PatternFill(start_color="BDD7EE", end_color="BDD7EE", fill_type="solid") # Light Blue for diffs
    
    # Header
    ws.append(output_headers)
    for cell in ws[1]:
        cell.fill = header_fill
        cell.font = header_font
        
    # Data Rows
    for row_data in out_rows:
        row_vals = [row_data.get(h, "") for h in output_headers]
        ws.append(row_vals)
        current_row = ws.max_row
        
        # formatting
        # path, suite, cat, filename are cols 1-4
        
        # solver cols start at 5
        solver_start_col = 5
        for i, solver in enumerate(common_solvers):
            col_idx = solver_start_col + i
            cell = ws.cell(row=current_row, column=col_idx)
            val = str(cell.value)
            
            if "->" in val:
                cell.fill = diff_fill
                # Make text bold?
                # cell.font = Font(bold=True)
            elif val in base_fills:
                cell.fill = base_fills[val]
            elif val == "":
                pass
            else:
                # Fallback for weird values
                pass

    # Auto-width
    for col in ws.columns:
        max_length = 0
        column = col[0].column_letter
        for cell in col:
            if cell.value:
                try:
                    if len(str(cell.value)) > max_length:
                        max_length = len(str(cell.value))
                except:
                    pass
        adjusted_width = min(5 + max_length * 1.1, 80)
        ws.column_dimensions[column].width = adjusted_width

    # --- Statistics Sheet ---
    ws_stats = wb.create_sheet("Statistics")
    
    row_idx = 1
    ws_stats.cell(row_idx, 1, "Comparison Statistics").font = Font(bold=True, size=14)
    row_idx += 2
    
    # For each solver, list transitions and counts
    for solver in common_solvers:
        ws_stats.cell(row_idx, 1, f"Solver: {solver}").font = Font(bold=True, size=12)
        row_idx += 1
        
        solver_stats = stats[solver]
        
        # Sort transitions: "SAME" first, then by count descending?
        # Or SAT->UNSAT, etc.
        
        transitions = []
        same_count = solver_stats.get("SAME", 0)
        # remove SAME from dict to sort others
        others = {k: v for k, v in solver_stats.items() if k != "SAME"}
        
        ws_stats.cell(row_idx, 1, "Result").font = header_font
        ws_stats.cell(row_idx, 1).fill = header_fill
        ws_stats.cell(row_idx, 2, "Count").font = header_font
        ws_stats.cell(row_idx, 2).fill = header_fill
        row_idx += 1
        
        ws_stats.cell(row_idx, 1, "Unchanged")
        ws_stats.cell(row_idx, 2, same_count)
        row_idx += 1
        
        # Sort others by count desc
        sorted_others = sorted(others.items(), key=lambda x: -x[1])
        
        for trans, count in sorted_others:
            ws_stats.cell(row_idx, 1, trans)
            ws_stats.cell(row_idx, 2, count)
            # Highlight interesting transitions?
            if "SAT->UNSAT" in trans or "UNSAT->SAT" in trans:
                ws_stats.cell(row_idx, 1).fill = base_fills["UNSAT"] # Red-ish warning?
            elif "->ERROR" in trans or "->TIMEOUT" in trans:
                 pass
            
            row_idx += 1
            
        row_idx += 1 # spacer

    # Adjust stats column widths
    ws_stats.column_dimensions['A'].width = 30
    ws_stats.column_dimensions['B'].width = 15

    print(f"Writing output to {args.output}")
    wb.save(args.output)

if __name__ == "__main__":
    main()
