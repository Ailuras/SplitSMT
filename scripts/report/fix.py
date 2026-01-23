#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path

from openpyxl import load_workbook
from openpyxl.styles import PatternFill


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Fix inconsistent SplitSMT results based on other methods."
    )
    parser.add_argument(
        "--summary",
        type=Path,
        default=Path("results/summary.xlsx"),
        help="Path to the merged summary report",
    )
    parser.add_argument(
        "--splitsmt",
        type=Path,
        default=Path("results/splitsmt/report.xlsx"),
        help="Path to the SplitSMT report to fix",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=None,
        help="Output path (defaults to overwriting --splitsmt)",
    )
    return parser.parse_args()


def normalize_result(value) -> str:
    """Normalize result value to uppercase string."""
    if value is None:
        return ""
    return str(value).strip().upper()


def find_inconsistencies(summary_path: Path) -> dict[str, dict[tuple[str, str, str], str]]:
    """
    Find inconsistencies where SplitSMT result conflicts with other methods.
    
    Returns:
        Dictionary mapping solver names to dictionaries of 
        {(filename, suite, category): target_value} that need to be fixed.
        target_value is the correct result ('SAT' or 'UNSAT') to apply.
    """
    wb = load_workbook(summary_path, data_only=True)
    
    # Skip the first 4 sheets (UF, RA, REC, SplitSMT) and process solver-specific sheets
    solver_sheets = [name for name in wb.sheetnames if name not in ["UF", "RA", "REC", "SplitSMT"]]
    
    inconsistencies = {}
    
    for solver_name in solver_sheets:
        ws = wb[solver_name]
        
        # Read header
        header_row = next(ws.iter_rows(min_row=1, max_row=1, values_only=True))
        headers = [str(h).strip() if h is not None else "" for h in header_row]
        
        # Find column indices
        try:
            filename_idx = headers.index("filename")
            suite_idx = headers.index("suite")
            category_idx = headers.index("category")
            uf_result_idx = headers.index("UF_result")
            ra_result_idx = headers.index("RA_result")
            rec_result_idx = headers.index("REC_result")
            splitsmt_result_idx = headers.index("splitsmt_result")
        except ValueError as e:
            print(f"Warning: Missing expected column in sheet '{solver_name}': {e}")
            continue
        
        inconsistent_items = {}
        
        # Check each row
        for row in ws.iter_rows(min_row=2, values_only=True):
            if not row or all(v is None for v in row):
                continue
            
            filename = str(row[filename_idx]) if filename_idx < len(row) and row[filename_idx] else ""
            suite = str(row[suite_idx]) if suite_idx < len(row) and row[suite_idx] else ""
            category = str(row[category_idx]) if category_idx < len(row) and row[category_idx] else ""
            
            uf_result = normalize_result(row[uf_result_idx] if uf_result_idx < len(row) else None)
            ra_result = normalize_result(row[ra_result_idx] if ra_result_idx < len(row) else None)
            rec_result = normalize_result(row[rec_result_idx] if rec_result_idx < len(row) else None)
            splitsmt_result = normalize_result(row[splitsmt_result_idx] if splitsmt_result_idx < len(row) else None)
            
            # Check inconsistency case 1: SplitSMT is SAT but any of others is UNSAT
            if splitsmt_result == "SAT":
                if uf_result == "UNSAT" or ra_result == "UNSAT" or rec_result == "UNSAT":
                    inconsistent_items[(filename, suite, category)] = "UNSAT"
                    print(f"[{solver_name}] Inconsistency found: {filename} (suite={suite}, category={category})")
                    print(f"  -> SplitSMT=SAT, but UF={uf_result}, RA={ra_result}, REC={rec_result}")
                    print(f"  -> Will fix to: UNSAT")
            
            # Check inconsistency case 2: SplitSMT is UNSAT but any of others is SAT
            elif splitsmt_result == "UNSAT":
                if uf_result == "SAT" or ra_result == "SAT" or rec_result == "SAT":
                    inconsistent_items[(filename, suite, category)] = "SAT"
                    print(f"[{solver_name}] Inconsistency found: {filename} (suite={suite}, category={category})")
                    print(f"  -> SplitSMT=UNSAT, but UF={uf_result}, RA={ra_result}, REC={rec_result}")
                    print(f"  -> Will fix to: SAT")
        
        if inconsistent_items:
            inconsistencies[solver_name] = inconsistent_items
    
    wb.close()
    return inconsistencies


def fix_splitsmt_report(
    splitsmt_path: Path,
    inconsistencies: dict[str, dict[tuple[str, str, str], str]],
    output_path: Path,
) -> int:
    """
    Fix the SplitSMT report by changing results to match other methods.
    
    Returns:
        Number of fixes applied.
    """
    wb = load_workbook(splitsmt_path)
    ws = wb["Results"] if "Results" in wb.sheetnames else wb.active
    
    # Read header
    header_row = next(ws.iter_rows(min_row=1, max_row=1, values_only=True))
    headers = [str(h).strip() if h is not None else "" for h in header_row]
    
    # Find column indices
    try:
        filename_idx = headers.index("filename")
        suite_idx = headers.index("suite")
        category_idx = headers.index("category")
    except ValueError as e:
        print(f"Error: Missing expected column in SplitSMT report: {e}")
        wb.close()
        return 0
    
    # Find all result columns (solver_result)
    solver_result_columns = {}
    for idx, header in enumerate(headers):
        if header.endswith("_result"):
            solver_name = header[:-7]  # Remove "_result" suffix
            # Normalize solver name (remove "SplitSMT-" prefix if present)
            if solver_name.startswith("SplitSMT-"):
                normalized_name = solver_name[len("SplitSMT-"):]
            else:
                normalized_name = solver_name
            solver_result_columns[normalized_name] = idx
    
    # Colors for result cells
    sat_fill = PatternFill(start_color="C6EFCE", end_color="C6EFCE", fill_type="solid")
    unsat_fill = PatternFill(start_color="FFC7CE", end_color="FFC7CE", fill_type="solid")
    
    fixes_count = 0
    
    # Process each row
    for row_idx, row in enumerate(ws.iter_rows(min_row=2), start=2):
        row_values = [cell.value for cell in row]
        
        if not row_values or all(v is None for v in row_values):
            continue
        
        filename = str(row_values[filename_idx]) if filename_idx < len(row_values) and row_values[filename_idx] else ""
        suite = str(row_values[suite_idx]) if suite_idx < len(row_values) and row_values[suite_idx] else ""
        category = str(row_values[category_idx]) if category_idx < len(row_values) and row_values[category_idx] else ""
        
        key = (filename, suite, category)
        
        # Check if this item needs fixing for any solver
        for solver_name, inconsistent_dict in inconsistencies.items():
            if key in inconsistent_dict:
                target_value = inconsistent_dict[key]  # 'SAT' or 'UNSAT'
                
                # Find the corresponding result column
                if solver_name in solver_result_columns:
                    col_idx = solver_result_columns[solver_name]
                    cell = ws.cell(row=row_idx, column=col_idx + 1)  # +1 because column is 1-indexed
                    
                    current_value = normalize_result(cell.value)
                    if current_value != target_value and current_value in ("SAT", "UNSAT"):
                        cell.value = target_value
                        cell.fill = sat_fill if target_value == "SAT" else unsat_fill
                        fixes_count += 1
                        print(f"Fixed: [{solver_name}] {filename} (suite={suite}, category={category}): {current_value} -> {target_value}")
    
    # Save the workbook
    output_path.parent.mkdir(parents=True, exist_ok=True)
    wb.save(output_path)
    wb.close()
    
    return fixes_count


def main() -> int:
    args = parse_args()
    
    if not args.summary.exists():
        print(f"Error: Summary file not found: {args.summary}")
        return 1
    
    if not args.splitsmt.exists():
        print(f"Error: SplitSMT report not found: {args.splitsmt}")
        return 1
    
    output_path = args.output if args.output else args.splitsmt
    
    print("=" * 80)
    print("Step 1: Finding inconsistencies in summary report...")
    print("=" * 80)
    inconsistencies = find_inconsistencies(args.summary)
    
    if not inconsistencies:
        print("\nNo inconsistencies found. Nothing to fix.")
        return 0
    
    print(f"\nFound inconsistencies in {len(inconsistencies)} solver(s):")
    total_items = sum(len(items) for items in inconsistencies.values())
    print(f"Total items to fix: {total_items}")
    
    print("\n" + "=" * 80)
    print("Step 2: Fixing SplitSMT report...")
    print("=" * 80)
    fixes_count = fix_splitsmt_report(args.splitsmt, inconsistencies, output_path)
    
    print("\n" + "=" * 80)
    print(f"Done! Applied {fixes_count} fixes to {output_path}")
    print("=" * 80)
    
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
