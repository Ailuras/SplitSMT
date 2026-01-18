#!/usr/bin/env python3
from __future__ import annotations

import argparse
from copy import copy
from pathlib import Path

from openpyxl import Workbook, load_workbook
from openpyxl.cell.cell import TYPE_NUMERIC, TYPE_STRING
from openpyxl.styles import Font, PatternFill


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Merge model reports into a single workbook.")
    parser.add_argument("--uf", type=Path, default=Path("results/UF/report.xlsx"))
    parser.add_argument("--ra", type=Path, default=Path("results/RA/report.xlsx"))
    parser.add_argument("--rec", type=Path, default=Path("results/REC/report.xlsx"))
    parser.add_argument("--splitsmt", type=Path, default=Path("results/splitsmt/report.xlsx"))
    parser.add_argument("--output", type=Path, default=Path("results/summary.xlsx"))
    return parser.parse_args()


def load_report(path: Path):
    wb = load_workbook(path, data_only=True)
    ws = wb["Results"] if "Results" in wb.sheetnames else wb.active
    header_row = next(ws.iter_rows(min_row=1, max_row=1, values_only=True))
    headers = [str(h).strip() if h is not None else "" for h in header_row]
    rows = []
    for row in ws.iter_rows(min_row=2, values_only=True):
        if row is None:
            continue
        if all(v is None for v in row):
            continue
        record = {}
        for idx, field in enumerate(headers):
            if not field:
                continue
            record[field] = row[idx] if idx < len(row) else None
        rows.append(record)
    solvers = sorted({field[:-7] for field in headers if field.endswith("_result")})
    return wb, ws, headers, rows, solvers


def copy_sheet(source_ws, target_ws) -> None:
    for row in source_ws.iter_rows():
        for cell in row:
            new_cell = target_ws.cell(row=cell.row, column=cell.column, value=cell.value)
            if cell.has_style:
                new_cell._style = copy(cell._style)
            new_cell.number_format = cell.number_format
            new_cell.data_type = cell.data_type
            new_cell.font = copy(cell.font)
            new_cell.fill = copy(cell.fill)
            new_cell.border = copy(cell.border)
            new_cell.alignment = copy(cell.alignment)
            new_cell.protection = copy(cell.protection)
    for key, dim in source_ws.column_dimensions.items():
        target_ws.column_dimensions[key].width = dim.width
    for key, dim in source_ws.row_dimensions.items():
        target_ws.row_dimensions[key].height = dim.height


def build_index(rows):
    index = {}
    for row in rows:
        filename = str(row.get("filename", "")).strip()
        suite = str(row.get("suite", "")).strip()
        category = str(row.get("category", "")).strip()
        key = (filename, suite, category)
        index[key] = row
    return index


def normalize_solver_name(name: str) -> str:
    if name.startswith("SplitSMT-"):
        return name[len("SplitSMT-") :]
    return name


def resolve_solver_name(model_solvers, base_solver, model_label):
    if model_label == "splitsmt":
        prefixed = f"SplitSMT-{base_solver}"
        if prefixed in model_solvers:
            return prefixed
        if base_solver in model_solvers:
            return base_solver
        return ""
    if base_solver in model_solvers:
        return base_solver
    prefixed = f"SplitSMT-{base_solver}"
    if prefixed in model_solvers:
        return prefixed
    return ""


def normalize_result(value) -> str:
    if value is None:
        return ""
    return str(value).strip().upper()


def classify_consistency(ra_result, rec_result, splitsmt_result) -> str:
    values = {
        "RA": normalize_result(ra_result),
        "REC": normalize_result(rec_result),
        "SplitSMT": normalize_result(splitsmt_result),
    }
    sat_unsat = {k: v for k, v in values.items() if v in ("SAT", "UNSAT")}
    if not sat_unsat:
        return "Hard"
    if len(sat_unsat) == 1:
        only = next(iter(sat_unsat.keys()))
        if only == "SplitSMT":
            return "onlySplitSMT"
        if only == "RA":
            return "onlyRA"
        return "onlyREC"
    if len(sat_unsat) == 3 and len(set(sat_unsat.values())) == 1:
        return "Consistent"
    return "Others"


def style_sheet(ws, fieldnames) -> None:
    header_fill = PatternFill(start_color="4472C4", end_color="4472C4", fill_type="solid")
    header_font = Font(bold=True, color="FFFFFF")
    result_fills = {
        "SAT": PatternFill(start_color="C6EFCE", end_color="C6EFCE", fill_type="solid"),
        "UNSAT": PatternFill(start_color="FFC7CE", end_color="FFC7CE", fill_type="solid"),
        "UNKNOWN": PatternFill(start_color="FFEB9C", end_color="FFEB9C", fill_type="solid"),
        "TIMEOUT": PatternFill(start_color="E2EFDA", end_color="E2EFDA", fill_type="solid"),
        "ERROR": PatternFill(start_color="D9D9D9", end_color="D9D9D9", fill_type="solid"),
    }
    consistency_fills = {
        "Consistent": PatternFill(start_color="A9D08E", end_color="A9D08E", fill_type="solid"),
        "onlySplitSMT": PatternFill(start_color="9DC3E6", end_color="9DC3E6", fill_type="solid"),
        "onlyRA": PatternFill(start_color="F4B084", end_color="F4B084", fill_type="solid"),
        "onlyREC": PatternFill(start_color="FFD966", end_color="FFD966", fill_type="solid"),
        "Hard": PatternFill(start_color="FFD966", end_color="FFD966", fill_type="solid"),
        "Others": PatternFill(start_color="BDD7EE", end_color="BDD7EE", fill_type="solid"),
    }
    for cell in ws[1]:
        cell.fill = header_fill
        cell.font = header_font
    result_col_indices = []
    consistency_col_idx = None
    for idx, field in enumerate(fieldnames, start=1):
        if field.endswith("_result"):
            result_col_indices.append(idx)
        elif field == "consistency":
            consistency_col_idx = idx
    for row_idx in range(2, ws.max_row + 1):
        for col_idx in range(1, len(fieldnames) + 1):
            cell = ws.cell(row=row_idx, column=col_idx)
            if isinstance(cell.value, (int, float)):
                cell.data_type = TYPE_NUMERIC
            elif isinstance(cell.value, str):
                cell.data_type = TYPE_STRING
        for col_idx in result_col_indices:
            cell = ws.cell(row=row_idx, column=col_idx)
            cell_value = str(cell.value).upper().strip() if cell.value else ""
            if cell_value in result_fills:
                cell.fill = result_fills[cell_value]
            elif cell_value:
                cell.fill = result_fills["ERROR"]
        if consistency_col_idx:
            cell = ws.cell(row=row_idx, column=consistency_col_idx)
            cell_value = str(cell.value) if cell.value else ""
            if cell_value in consistency_fills:
                cell.fill = consistency_fills[cell_value]
    for col in ws.columns:
        max_length = 0
        column = col[0].column_letter
        for cell in col:
            if cell.value:
                max_length = max(max_length, len(str(cell.value)))
        adjusted_width = min(5 + max_length * 1.2, 80)
        ws.column_dimensions[column].width = adjusted_width


def main() -> int:
    args = parse_args()

    uf_wb, uf_ws, uf_headers, uf_rows, uf_solvers = load_report(args.uf)
    ra_wb, ra_ws, ra_headers, ra_rows, ra_solvers = load_report(args.ra)
    rec_wb, rec_ws, rec_headers, rec_rows, rec_solvers = load_report(args.rec)
    splitsmt_wb, splitsmt_ws, splitsmt_headers, splitsmt_rows, splitsmt_solvers = load_report(args.splitsmt)

    uf_index = build_index(uf_rows)
    ra_index = build_index(ra_rows)
    rec_index = build_index(rec_rows)
    splitsmt_index = build_index(splitsmt_rows)

    base_solver_set = set()
    for solver in uf_solvers + ra_solvers + rec_solvers:
        base_solver_set.add(normalize_solver_name(solver))
    if not base_solver_set:
        for solver in splitsmt_solvers:
            base_solver_set.add(normalize_solver_name(solver))
    base_solvers = sorted(base_solver_set)

    all_keys = set()
    for index in (uf_index, ra_index, rec_index, splitsmt_index):
        all_keys.update(index.keys())
    sorted_keys = sorted(all_keys, key=lambda k: (k[1], k[2], k[0]))

    workbook = Workbook()
    workbook.remove(workbook.active)

    for title, source_ws in [
        ("UF", uf_ws),
        ("RA", ra_ws),
        ("REC", rec_ws),
        ("SplitSMT", splitsmt_ws),
    ]:
        ws = workbook.create_sheet(title)
        copy_sheet(source_ws, ws)

    for solver in base_solvers:
        ws = workbook.create_sheet(solver)
        header = [
            "filename",
            "suite",
            "category",
            "consistency",
            "UF_result",
            "UF_time",
            "RA_result",
            "RA_time",
            "REC_result",
            "REC_time",
            "splitsmt_result",
            "splitsmt_time",
        ]
        ws.append(header)
        for key in sorted_keys:
            filename, suite, category = key
            uf_row = uf_index.get(key, {})
            ra_row = ra_index.get(key, {})
            rec_row = rec_index.get(key, {})
            splitsmt_row = splitsmt_index.get(key, {})

            uf_solver = resolve_solver_name(uf_solvers, solver, "uf")
            ra_solver = resolve_solver_name(ra_solvers, solver, "ra")
            rec_solver = resolve_solver_name(rec_solvers, solver, "rec")
            splitsmt_solver = resolve_solver_name(splitsmt_solvers, solver, "splitsmt")

            uf_result = uf_row.get(f"{uf_solver}_result", "") if uf_solver else ""
            uf_time = uf_row.get(f"{uf_solver}_time", None) if uf_solver else None
            ra_result = ra_row.get(f"{ra_solver}_result", "") if ra_solver else ""
            ra_time = ra_row.get(f"{ra_solver}_time", None) if ra_solver else None
            rec_result = rec_row.get(f"{rec_solver}_result", "") if rec_solver else ""
            rec_time = rec_row.get(f"{rec_solver}_time", None) if rec_solver else None
            splitsmt_result = splitsmt_row.get(f"{splitsmt_solver}_result", "") if splitsmt_solver else ""
            splitsmt_time = splitsmt_row.get(f"{splitsmt_solver}_time", None) if splitsmt_solver else None

            consistency = classify_consistency(ra_result, rec_result, splitsmt_result)

            ws.append(
                [
                    filename,
                    suite,
                    category,
                    consistency,
                    uf_result,
                    uf_time,
                    ra_result,
                    ra_time,
                    rec_result,
                    rec_time,
                    splitsmt_result,
                    splitsmt_time,
                ]
            )
        style_sheet(ws, header)

    args.output.parent.mkdir(parents=True, exist_ok=True)
    workbook.save(args.output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
