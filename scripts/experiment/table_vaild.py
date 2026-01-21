#!/usr/bin/env python3
"""
table_vaild.py - Fill template_vaild.tex with model validity statistics.
"""
from __future__ import annotations

import argparse
from pathlib import Path
from typing import Dict, List, Tuple

from openpyxl import load_workbook


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Fill template_vaild.tex")
    parser.add_argument("--summary", type=Path, default=Path("results/summary.xlsx"))
    parser.add_argument("--origin", type=Path, default=Path("results/UF/report_origin.xlsx"))
    parser.add_argument("--template", type=Path, default=Path("scripts/experiment/template_vaild.tex"))
    parser.add_argument("--output", type=Path, default=Path("scripts/experiment/table_vaild.tex"))
    return parser.parse_args()


def read_sheet(path: Path, sheet_name: str = None) -> List[Dict]:
    wb = load_workbook(path, data_only=True)
    ws = wb[sheet_name] if sheet_name else wb.active
    headers = [c.value for c in ws[1]]
    header_map = {str(h).strip(): idx for idx, h in enumerate(headers) if h is not None}
    rows = []
    for row in ws.iter_rows(min_row=2, values_only=True):
        if row is None or all(v is None for v in row):
            continue
        record = {}
        for key, idx in header_map.items():
            record[key] = row[idx] if idx < len(row) else None
        rows.append(record)
    return rows


def normalize_result(value) -> str:
    if value is None:
        return ""
    return str(value).strip().upper()


def fmt_int(value: int) -> str:
    return str(int(value))


def fill_row_placeholders(line: str, values: List[str]) -> Tuple[str, List[str]]:
    output = line
    remaining_values = list(values)
    while "\\EXPtodo{--}" in output and remaining_values:
        output = output.replace("\\EXPtodo{--}", remaining_values.pop(0), 1)
    return output, remaining_values


def main() -> int:
    args = parse_args()

    # Load data
    summary_rows = read_sheet(args.summary, "z3-noodler")
    origin_rows = read_sheet(args.origin, "Results") # Usually 'Results' in report xlsx

    # Index origin data by filename
    origin_map = {}
    for row in origin_rows:
        fname = str(row.get("filename", "")).strip()
        if fname:
            origin_map[fname] = row

    # Stats structure
    # { "RW": { "Ours": {valid, invalid, unsat, unk}, ... }, "Synthetic": ... }
    stats = {
        "RW": {},
        "Synthetic": {}
    }
    methods = ["Ours", "RALen", "RecLen", "UF-split"]
    for dataset in stats:
        for method in methods:
            stats[dataset][method] = {"valid": 0, "invalid": 0, "unsat": 0, "unk": 0}

    # Method mapping to summary columns
    # Ours -> splitsmt_result
    # RALen -> RA_result
    # RecLen -> REC_result
    # UF-split -> UF_result
    method_col_map = {
        "Ours": "splitsmt_result",
        "RALen": "RA_result",
        "RecLen": "REC_result",
        "UF-split": "UF_result"
    }

    for row in summary_rows:
        suite = str(row.get("suite", "")).strip()
        filename = str(row.get("filename", "")).strip()
        
        dataset = "RW" if suite == "RealWorld" else "Synthetic"
        
        for method in methods:
            col_name = method_col_map[method]
            summ_res = normalize_result(row.get(col_name))
            
            # Logic
            is_valid_sat = (summ_res == "SAT")
            is_unsat = (summ_res == "UNSAT")
            is_invalid_sat = False
            
            if method == "UF-split":
                # Check origin for UF
                origin_row = origin_map.get(filename)
                if origin_row:
                    origin_res = normalize_result(origin_row.get("z3-noodler_result"))
                    if origin_res == "SAT" and not is_valid_sat:
                        is_invalid_sat = True
            
            # Update stats
            entry = stats[dataset][method]
            
            if is_valid_sat:
                entry["valid"] += 1
            elif is_invalid_sat:
                entry["invalid"] += 1
            elif is_unsat:
                entry["unsat"] += 1
            else:
                entry["unk"] += 1

    # Fill template
    content = args.template.read_text(encoding="utf-8")
    lines = content.splitlines()
    out_lines = []
    
    current_dataset = None
    
    # We need to handle the multi-line row filling logic statefully across lines
    # But based on the template, each method is on its own line:
    # & Ours ...
    # & RALen ...
    # So we can just detect the method line and fill it.
    
    for line in lines:
        stripped = line.strip()
        
        # Detect dataset block
        if "multirow" in line and "RW" in line:
            current_dataset = "RW"
        elif "multirow" in line and "Synthetic" in line:
            current_dataset = "Synthetic"
            
        # Detect method line
        matched_method = None
        if "& Ours" in line or "& \\textbf{Ours}" in line: matched_method = "Ours"
        elif "& RALen" in line: matched_method = "RALen"
        elif "& RecLen" in line: matched_method = "RecLen"
        elif "& UF-split" in line: matched_method = "UF-split"
        
        if matched_method and current_dataset:
            st = stats[current_dataset][matched_method]
            values = [
                fmt_int(st["valid"]),
                fmt_int(st["invalid"]),
                fmt_int(st["unsat"]),
                fmt_int(st["unk"])
            ]
            line, _ = fill_row_placeholders(line, values)
            
        out_lines.append(line)

    # Save output
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text("\n".join(out_lines) + "\n", encoding="utf-8")
    print(f"Table saved to {args.output}")
    
    # Print summary for verification
    import json
    print("\nCalculated Stats:")
    print(json.dumps(stats, indent=2))
    
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
