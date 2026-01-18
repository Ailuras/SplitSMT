#!/usr/bin/env python3
"""Fix solver results in report.xlsx based on check_model validation results.

This script reads a report.xlsx file and validation results from check_model,
then corrects SAT results to UNKNOWN when the model is invalid or skipped,
and recalculates consistency.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Dict, List

from openpyxl import load_workbook
from openpyxl.workbook import Workbook


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Fix solver results based on check_model validation"
    )
    parser.add_argument(
        "report",
        type=Path,
        help="Path to report.xlsx (e.g., results/UF/report.xlsx)",
    )
    parser.add_argument(
        "check_folder",
        type=Path,
        help="Path to check results folder (e.g., benchmarks_check_RA)",
    )
    parser.add_argument(
        "--output",
        type=Path,
        help="Output path for corrected report (default: overwrites input)",
    )
    return parser.parse_args()


def read_check_results(check_folder: Path) -> Dict[str, str]:
    """Read validation results from check_folder/ra_result/*.smt2.
    
    Returns a dict mapping file paths to validation status (valid/invalid/skip).
    """
    results = {}
    ra_result_dir = check_folder / "ra_result"
    
    if not ra_result_dir.exists():
        print(f"Warning: {ra_result_dir} does not exist", file=sys.stderr)
        return results
    
    for result_file in ra_result_dir.rglob("*.smt2"):
        try:
            content = result_file.read_text(encoding="utf-8")
            status = None
            for line in content.splitlines():
                if line.startswith("status:"):
                    status = line.split(":", 1)[1].strip()
                    break
            
            if status:
                # Reconstruct the original file path
                rel_path = result_file.relative_to(ra_result_dir)
                results[str(rel_path)] = status
        except Exception as e:
            print(f"Warning: failed to read {result_file}: {e}", file=sys.stderr)
    
    return results


def extract_solvers_from_headers(headers: List[str]) -> List[str]:
    """Extract solver names from header row."""
    solvers = []
    for header in headers:
        if header.endswith("_result"):
            solver = header.replace("_result", "")
            solvers.append(solver)
    return solvers


def classify_consistency(results: List[str]) -> str:
    """Classify consistency based on solver results.
    
    Matches the logic from aggregate.py.
    """
    results_set = set(r for r in results if r)
    
    if not results_set:
        return "Other"
    
    sat_count = sum(1 for r in results_set if r == "SAT")
    unsat_count = sum(1 for r in results_set if r == "UNSAT")
    
    if sat_count > 0 and unsat_count > 0:
        return "Conflict"
    
    if len(results_set) == 1:
        result = list(results_set)[0]
        if result in ["SAT", "UNSAT"]:
            return "Consistent"
        elif result not in ["SAT", "UNSAT", "UNKNOWN", "TIMEOUT"]:
            return "Error"
    
    if sat_count == 0 and unsat_count == 0:
        has_valid_result = any(r in ["UNKNOWN", "TIMEOUT"] for r in results_set)
        has_error = any(r not in ["SAT", "UNSAT", "UNKNOWN", "TIMEOUT"] for r in results_set)
        if has_valid_result or has_error:
            return "Hard"
    
    return "Other"


def fix_report(
    report_path: Path,
    check_results: Dict[str, str],
    output_path: Path,
) -> int:
    """Load report, apply fixes, and save."""
    try:
        wb = load_workbook(report_path)
    except Exception as e:
        print(f"Error: failed to load {report_path}: {e}", file=sys.stderr)
        return 1
    
    ws = wb["Results"]
    
    # Read headers
    headers = [cell.value for cell in ws[1]]
    header_map = {h: idx for idx, h in enumerate(headers, 1) if h}
    
    # Extract solver names
    solvers = extract_solvers_from_headers(headers)
    
    # Get column indices
    path_col = header_map.get("path")
    filename_col = header_map.get("filename")
    consistency_col = header_map.get("consistency")
    
    if not path_col or not filename_col:
        print("Error: 'path' or 'filename' column not found", file=sys.stderr)
        return 1
    
    fixed_count = 0
    skipped_count = 0
    
    # Process each row (skip header)
    for row_idx in range(2, ws.max_row + 1):
        # Get file path
        path_val = ws.cell(row_idx, path_col).value
        filename_val = ws.cell(row_idx, filename_col).value
        
        if not path_val or not filename_val:
            continue
        
        # Try to find validation result
        # The path in Excel might be like "benchmarks_UF/..." 
        # We need to match it with the relative path in check results
        file_path = Path(path_val)
        
        # Try different matching strategies
        validation_status = None
        for check_key in check_results:
            if file_path.name == Path(check_key).name:
                # Match by filename and check if parent dirs also match
                if str(file_path).endswith(check_key) or check_key.endswith(str(file_path.parent / file_path.name)):
                    validation_status = check_results[check_key]
                    break
        
        # If validation is valid or not found, skip
        if validation_status == "valid" or validation_status is None:
            if validation_status is None:
                skipped_count += 1
            continue
        
        # validation_status is "invalid" or "skip"
        # Fix SAT results
        modified = False
        for solver in solvers:
            result_col_name = f"{solver}_result"
            output_col_name = f"{solver}_output"
            
            result_col = header_map.get(result_col_name)
            output_col = header_map.get(output_col_name)
            
            if not result_col:
                continue
            
            result_cell = ws.cell(row_idx, result_col)
            result_value = str(result_cell.value).upper().strip() if result_cell.value else ""
            
            if result_value == "SAT":
                # Change to UNKNOWN
                result_cell.value = "UNKNOWN"
                modified = True
                
                # Update output
                if output_col:
                    output_cell = ws.cell(row_idx, output_col)
                    old_output = str(output_cell.value) if output_cell.value else ""
                    output_cell.value = f"model invalid: {old_output}"
        
        if modified:
            fixed_count += 1
            
            # Recalculate consistency
            if consistency_col:
                results = []
                for solver in solvers:
                    result_col_name = f"{solver}_result"
                    result_col = header_map.get(result_col_name)
                    if result_col:
                        result_val = ws.cell(row_idx, result_col).value
                        results.append(str(result_val).upper().strip() if result_val else "")
                
                new_consistency = classify_consistency(results)
                ws.cell(row_idx, consistency_col).value = new_consistency
    
    # Save
    try:
        wb.save(output_path)
        print(f"Fixed {fixed_count} rows")
        print(f"Skipped {skipped_count} rows (no validation result found)")
        print(f"Saved to {output_path}")
        return 0
    except Exception as e:
        print(f"Error: failed to save {output_path}: {e}", file=sys.stderr)
        return 1


def main() -> int:
    args = parse_args()
    
    if not args.report.exists():
        print(f"Error: {args.report} not found", file=sys.stderr)
        return 1
    
    if not args.check_folder.exists():
        print(f"Error: {args.check_folder} not found", file=sys.stderr)
        return 1
    
    output_path = args.output if args.output else args.report
    
    print(f"Reading validation results from {args.check_folder}...")
    check_results = read_check_results(args.check_folder)
    print(f"Found {len(check_results)} validation results")
    
    print(f"Processing {args.report}...")
    return fix_report(args.report, check_results, output_path)


if __name__ == "__main__":
    sys.exit(main())
