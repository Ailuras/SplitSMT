#!/usr/bin/env python3
"""Compare two aggregate Excel reports and highlight per-example differences.

Features:
1. Compares ALL examples (SAT, UNSAT, UNKNOWN, TIMEOUT, ERROR).
2. Missing examples are marked as 'Miss'.
3. Comparison Labels:
   - Conflict: Result differs (e.g., SAT vs UNSAT).
   - Improvement: Time reduced or Status improved (Timeout -> Solved).
   - Descent: Time increased or Status degraded (Solved -> Timeout).
   - Others: Mixed results or insignificant changes.
4. Per-solver columns showing status change and time difference.
5. Statistics sheet summarizing overall and per-solver changes (Rich Format).
"""

from __future__ import annotations

import argparse
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Set, Tuple, Optional, Any

from openpyxl import Workbook, load_workbook
from openpyxl.styles import PatternFill, Font, Alignment, Border, Side
from openpyxl.utils import get_column_letter

# Types
ExampleKey = Tuple[str, str, str]  # filename, suite, category

@dataclass
class SolverResult:
    result: str
    time: float
    output: str = ""

@dataclass
class ExampleResult:
    filename: str
    suite: str
    category: str
    path: str
    solvers: Dict[str, SolverResult] = field(default_factory=dict)

def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Compare two aggregate.xlsx files and summarize per-example differences."
    )
    parser.add_argument("xlsx_a", type=Path, help="First Excel report (Base)")
    parser.add_argument("xlsx_b", type=Path, help="Second Excel report (Comparison)")
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("charts/compare.xlsx"),
        help="Output Excel path (default: charts/compare.xlsx)",
    )
    parser.add_argument(
        "--soft",
        action="store_true",
        help="Match only by filename (ignores suite/category mismatches).",
    )
    return parser.parse_args()

def load_results(xlsx_path: Path, soft: bool) -> Tuple[Dict[ExampleKey, ExampleResult], List[str]]:
    """Load all examples from the report."""
    if not xlsx_path.exists():
        print(f"error: Excel file not found: {xlsx_path}", file=sys.stderr)
        sys.exit(1)

    wb = load_workbook(xlsx_path, read_only=True, data_only=True)
    try:
        if "Results" not in wb.sheetnames:
            print(f"error: 'Results' sheet not found in {xlsx_path}", file=sys.stderr)
            sys.exit(1)
        ws = wb["Results"]

        headers = {
            str(cell.value).strip().lower(): idx
            for idx, cell in enumerate(ws[1], start=1)
            if cell.value
        }

        filename_col = headers.get("filename") or headers.get("file")
        suite_col = headers.get("suite")
        category_col = headers.get("category")
        path_col = headers.get("path")
        file_col = headers.get("file") 

        if not filename_col:
             print(f"error: 'filename' or 'file' column missing in {xlsx_path}", file=sys.stderr)
             sys.exit(1)

        solver_names = set()
        for h in headers:
            if h.endswith("_result"):
                solver_names.add(h[:-7])
        
        sorted_solvers = sorted(list(solver_names))
        
        data: Dict[ExampleKey, ExampleResult] = {}
        duplicates: Set[ExampleKey] = set()

        for row in ws.iter_rows(min_row=2):
            fname_val = row[filename_col - 1].value if filename_col else None
            filename = str(fname_val).strip() if fname_val else ""
            
            if filename:
                 filename_only = Path(filename).name
            else:
                 filename_only = ""
            
            suite = str(row[suite_col-1].value).strip() if suite_col and row[suite_col-1].value else ""
            category = str(row[category_col-1].value).strip() if category_col and row[category_col-1].value else ""
            
            path_val = row[path_col-1].value if path_col and row[path_col-1].value else ""
            file_val = row[file_col-1].value if file_col and row[file_col-1].value else ""
            
            if path_val:
                path_str = path_val
            elif file_val:
                path_str = str(Path(file_val).parent)
                if path_str == ".": path_str = ""
            else:
                path_str = ""
            
            if not filename_only:
                continue

            if soft:
                key = (filename_only, "", "") 
            else:
                key = (filename_only, suite, category)

            if key in data:
                duplicates.add(key)
                continue
            
            solvers_res = {}
            for s in sorted_solvers:
                res_idx = headers.get(f"{s}_result")
                time_idx = headers.get(f"{s}_time")
                
                r_val = row[res_idx-1].value if res_idx else ""
                t_val = row[time_idx-1].value if time_idx else 0
                
                res_str = str(r_val).strip().upper() if r_val else "MISSING"
                
                try:
                    time_float = float(t_val) if t_val is not None else 0.0
                except (ValueError, TypeError):
                    time_float = 0.0
                
                solvers_res[s] = SolverResult(result=res_str, time=time_float)

            data[key] = ExampleResult(
                filename=filename_only,
                suite=suite,
                category=category,
                path=path_str,
                solvers=solvers_res
            )
        
        for d in duplicates:
            if d in data:
                del data[d]
                
        return data, sorted_solvers
    finally:
        wb.close()

def compare_single_solver(res_a: SolverResult, res_b: SolverResult) -> Tuple[str, float]:
    r_a = res_a.result
    r_b = res_b.result
    t_a = res_a.time
    t_b = res_b.time
    
    if r_a == "MISSING" or r_b == "MISSING":
        return "Missing", 0.0
        
    if r_a in ("SAT", "UNSAT") and r_b in ("SAT", "UNSAT") and r_a != r_b:
        return "Conflict", t_b - t_a

    is_solved_a = r_a in ("SAT", "UNSAT")
    is_solved_b = r_b in ("SAT", "UNSAT")
    
    epsilon = 0.01
    
    if is_solved_b and not is_solved_a:
        return "Improvement", t_b - t_a
    
    if is_solved_a and not is_solved_b:
        return "Descent", t_b - t_a
        
    if is_solved_a and is_solved_b:
        diff = t_b - t_a
        if diff < -epsilon:
            return "Improvement", diff
        elif diff > epsilon:
            return "Descent", diff
        else:
            return "Unchanged", diff
            
    return "Unchanged", t_b - t_a

def determine_row_label(solver_comparisons: Dict[str, str]) -> str:
    labels = set(solver_comparisons.values())
    
    if "Conflict" in labels:
        return "Conflict"
    
    has_imp = "Improvement" in labels
    has_desc = "Descent" in labels
    has_unch = "Unchanged" in labels
    has_miss = "Missing" in labels
    
    if has_imp and not has_desc and not has_miss:
        return "Improvement"
    
    if has_desc and not has_imp and not has_miss:
        return "Descent"
    
    if has_imp and has_desc:
        return "Others" 
        
    if has_miss:
         return "Others"

    return "Others" 

def write_statistics_sheet(wb: Workbook, stats: Dict[str, Any], solvers: List[str]) -> None:
    ws = wb.create_sheet("Statistics")
    
    # Styles
    header_fill = PatternFill(start_color="4472C4", end_color="4472C4", fill_type="solid")
    header_font = Font(bold=True, color="FFFFFF")
    section_fill = PatternFill(start_color="D9E1F2", end_color="D9E1F2", fill_type="solid")
    section_font = Font(bold=True)
    
    label_fills = {
        "Improvement": PatternFill(start_color="C6EFCE", end_color="C6EFCE", fill_type="solid"),
        "Descent": PatternFill(start_color="FFC7CE", end_color="FFC7CE", fill_type="solid"),
        "Conflict": PatternFill(start_color="FF6B6B", end_color="FF6B6B", fill_type="solid"),
        "Miss": PatternFill(start_color="FFFF00", end_color="FFFF00", fill_type="solid"),
        "Others": PatternFill(start_color="D9D9D9", end_color="D9D9D9", fill_type="solid"),
        "Unchanged": PatternFill(start_color="FFFFFF", end_color="FFFFFF", fill_type="solid"),
    }

    descriptions = {
        "Improvement": "Status improved (e.g., Timeout->SAT) or Time reduced.",
        "Descent": "Status degraded (e.g., SAT->Timeout) or Time increased.",
        "Conflict": "CRITICAL: Solvers disagree on SAT/UNSAT.",
        "Miss": "Example only exists in one report.",
        "Others": "Mixed improvements/regressions or no significant change.",
        "Unchanged": "Identical results and similar time.",
    }
    
    row_idx = 1
    
    # 1. Overall Statistics
    ws.cell(row_idx, 1, "Overall Statistics").font = section_font
    ws.cell(row_idx, 1).fill = section_fill
    row_idx += 1
    
    headers = ["Label", "Count", "Percentage", "Description"]
    for col_idx, header in enumerate(headers, 1):
        cell = ws.cell(row_idx, col_idx, header)
        cell.fill = header_fill
        cell.font = header_font
    row_idx += 1
    
    overall = stats["overall"]
    total = sum(overall.values())
    
    for lbl in ["Improvement", "Descent", "Conflict", "Miss", "Others"]:
        count = overall.get(lbl, 0)
        percentage = (count / total * 100) if total > 0 else 0
        desc = descriptions.get(lbl, "")
        
        ws.cell(row_idx, 1, lbl).fill = label_fills.get(lbl)
        ws.cell(row_idx, 2, count)
        ws.cell(row_idx, 3, f"{percentage:.2f}%")
        ws.cell(row_idx, 4, desc)
        row_idx += 1
        
    row_idx += 1
    
    # 2. Per-Solver Statistics
    ws.cell(row_idx, 1, "Per-Solver Changes").font = section_font
    ws.cell(row_idx, 1).fill = section_fill
    row_idx += 1
    
    sub_headers = ["Solver", "Improvement", "Descent", "Conflict", "Miss", "Others", "Unchanged"]
    for col_idx, header in enumerate(sub_headers, 1):
        cell = ws.cell(row_idx, col_idx, header)
        cell.fill = header_fill
        cell.font = header_font
    row_idx += 1
    
    per_solver = stats["per_solver"]
    for s in solvers:
        s_stats = per_solver.get(s, {})
        ws.cell(row_idx, 1, s).font = Font(bold=True)
        for i, lbl in enumerate(["Improvement", "Descent", "Conflict", "Miss", "Others", "Unchanged"]):
            val = s_stats.get(lbl, 0)
            ws.cell(row_idx, i + 2, val)
        row_idx += 1
        
    row_idx += 1
    
    # 3. Detailed Breakdown by Suite/Category
    ws.cell(row_idx, 1, "Detailed Breakdown (Top Impact Areas)").font = section_font
    ws.cell(row_idx, 1).fill = section_fill
    row_idx += 1
    
    breakdown = stats["breakdown"]
    
    for target_label in ["Conflict", "Improvement", "Descent"]:
        label_data = breakdown.get(target_label, {})
        if not label_data:
            continue
            
        count = overall.get(target_label, 0)
        ws.cell(row_idx, 1, f"{target_label} ({count} cases)").font = Font(bold=True)
        ws.cell(row_idx, 1).fill = label_fills.get(target_label)
        row_idx += 1
        
        # By Suite
        ws.cell(row_idx, 1, "By Suite:").font = Font(italic=True)
        row_idx += 1
        
        suites = label_data.get("suite", {})
        sorted_suites = sorted(suites.items(), key=lambda x: -x[1])[:5] # Top 5
        for s, c in sorted_suites:
            ws.cell(row_idx, 2, f"{s}: {c}")
            row_idx += 1
            
        # By Category
        ws.cell(row_idx, 1, "By Category:").font = Font(italic=True)
        row_idx += 1
        
        cats = label_data.get("category", {})
        sorted_cats = sorted(cats.items(), key=lambda x: -x[1])[:5] # Top 5
        for c, n in sorted_cats:
            ws.cell(row_idx, 2, f"{c}: {n}")
            row_idx += 1
            
        row_idx += 1

    # Auto-width
    for col in ws.columns:
        max_len = 0
        column = col[0].column_letter
        for cell in col:
            if cell.value:
                lines = str(cell.value).split('\n')
                for line in lines:
                    max_len = max(max_len, len(line))
        adjusted_width = (max_len + 2) * 1.2
        ws.column_dimensions[column].width = min(adjusted_width, 60)

def write_output(
    output_path: Path,
    rows: List[Dict[str, Any]],
    solvers: List[str],
    stats: Dict[str, Any],
    label_a: str,
    label_b: str
) -> None:
    wb = Workbook()
    
    # 1. Comparison Sheet
    ws = wb.active
    ws.title = "Comparison"
    
    header_fill = PatternFill(start_color="4472C4", end_color="4472C4", fill_type="solid")
    header_font = Font(bold=True, color="FFFFFF")
    
    label_fills = {
        "Improvement": PatternFill(start_color="C6EFCE", end_color="C6EFCE", fill_type="solid"), # Green
        "Descent": PatternFill(start_color="FFC7CE", end_color="FFC7CE", fill_type="solid"), # Red
        "Conflict": PatternFill(start_color="FF6B6B", end_color="FF6B6B", fill_type="solid"), # Bright Red
        "Miss": PatternFill(start_color="FFFF00", end_color="FFFF00", fill_type="solid"), # Yellow
        "Others": PatternFill(start_color="D9D9D9", end_color="D9D9D9", fill_type="solid"), # Grey
        "Unchanged": PatternFill(start_color="FFFFFF", end_color="FFFFFF", fill_type="solid"), # White
    }
    
    headers = ["filename", "suite", "category", "path", "Label"]
    for s in solvers:
        headers.extend([f"{s}_Change", f"{s}_TimeDiff", f"{s}_{label_a}", f"{s}_{label_b}"])
        
    ws.append(headers)
    for cell in ws[1]:
        cell.fill = header_fill
        cell.font = header_font
        
    for r in rows:
        row_vals = [
            r["filename"],
            r["suite"],
            r["category"],
            r["path"],
            r["label"]
        ]
        
        label = r["label"]
        
        for s in solvers:
            s_data = r["solvers"].get(s, {})
            row_vals.extend([
                s_data.get("comp_label", ""),
                s_data.get("time_diff", 0.0),
                s_data.get("res_a", ""),
                s_data.get("res_b", "")
            ])
            
        ws.append(row_vals)
        cur_row = ws.max_row
        
        if label in label_fills:
            ws.cell(row=cur_row, column=5).fill = label_fills[label]
            
        for i, s in enumerate(solvers):
            col_idx = 6 + (i * 4)
            val = row_vals[col_idx-1]
            if val in label_fills:
                ws.cell(row=cur_row, column=col_idx).fill = label_fills[val]
                
    for col in ws.columns:
        max_len = 0
        column = col[0].column_letter
        for cell in col:
            if cell.value:
                lines = str(cell.value).split('\n')
                for line in lines:
                    max_len = max(max_len, len(line))
        adjusted_width = (max_len + 2) * 1.2
        ws.column_dimensions[column].width = min(adjusted_width, 60)

    # 2. Statistics Sheet
    write_statistics_sheet(wb, stats, solvers)
        
    output_path.parent.mkdir(parents=True, exist_ok=True)
    wb.save(output_path)

def main() -> int:
    args = parse_args()
    
    data_a, solvers_a = load_results(args.xlsx_a, args.soft)
    data_b, solvers_b = load_results(args.xlsx_b, args.soft)
    
    all_solvers = sorted(list(set(solvers_a) | set(solvers_b)))
    all_keys = sorted(list(set(data_a.keys()) | set(data_b.keys())))
    
    rows = []
    
    stats = {
        "overall": {"Improvement": 0, "Descent": 0, "Conflict": 0, "Miss": 0, "Others": 0, "Unchanged": 0},
        "per_solver": {s: {"Improvement": 0, "Descent": 0, "Conflict": 0, "Miss": 0, "Missing": 0, "Others": 0, "Unchanged": 0} for s in all_solvers},
        "breakdown": {
            "Conflict": {"suite": {}, "category": {}},
            "Improvement": {"suite": {}, "category": {}},
            "Descent": {"suite": {}, "category": {}},
        }
    }
    
    for key in all_keys:
        in_a = key in data_a
        in_b = key in data_b
        
        ex_a = data_a.get(key)
        ex_b = data_b.get(key)
        
        filename = key[0] if args.soft else key[0]
        suite = ex_a.suite if ex_a else (ex_b.suite if ex_b else "")
        category = ex_a.category if ex_a else (ex_b.category if ex_b else "")
        path_str = ex_a.path if ex_a else (ex_b.path if ex_b else "")
        
        row_data = {
            "filename": filename,
            "suite": suite,
            "category": category,
            "path": path_str,
            "solvers": {}
        }
        
        if not in_a or not in_b:
            label = "Miss"
        else:
            label = None 
            
        solver_comparisons = {}
        
        for s in all_solvers:
            res_a = ex_a.solvers.get(s) if ex_a else SolverResult("MISSING", 0)
            res_b = ex_b.solvers.get(s) if ex_b else SolverResult("MISSING", 0)
            
            if not res_a: res_a = SolverResult("MISSING", 0)
            if not res_b: res_b = SolverResult("MISSING", 0)
            
            comp_label, time_diff = compare_single_solver(res_a, res_b)
            
            solver_comparisons[s] = comp_label
            stats["per_solver"][s][comp_label] += 1
            
            row_data["solvers"][s] = {
                "comp_label": comp_label,
                "time_diff": time_diff,
                "res_a": res_a.result + (f" ({res_a.time:.2f}s)" if res_a.result not in ["MISSING", "UNKNOWN", "ERROR", "TIMEOUT"] else ""),
                "res_b": res_b.result + (f" ({res_b.time:.2f}s)" if res_b.result not in ["MISSING", "UNKNOWN", "ERROR", "TIMEOUT"] else "")
            }
            
        if label is None:
            label = determine_row_label(solver_comparisons)
            
        if label == "Improvement" and all(v == "Unchanged" for v in solver_comparisons.values()):
             label = "Unchanged"
             
        if not in_a or not in_b:
             label = "Miss"
             
        stats["overall"][label] = stats["overall"].get(label, 0) + 1
        row_data["label"] = label
        rows.append(row_data)
        
        # Populate Breakdown
        if label in ["Conflict", "Improvement", "Descent"]:
            bd = stats["breakdown"][label]
            bd["suite"][suite] = bd["suite"].get(suite, 0) + 1
            bd["category"][category] = bd["category"].get(category, 0) + 1
        
    label_a = args.xlsx_a.stem
    label_b = args.xlsx_b.stem
    
    write_output(args.output, rows, all_solvers, stats, label_a, label_b)
    print(f"Comparison written to: {args.output}")
    print(f"Total rows: {len(rows)}")
    
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
