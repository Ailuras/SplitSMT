#!/usr/bin/env python3
"""Aggregate solver batch results into a single Excel report.

This version targets the new Norn-style layout produced by
`scripts/batch/batch.sh`, where each log block looks like:

FILE: benchmarks/2015-Norn/<category>/example.smt2
START: ...
END: ...
DURATION_SEC: ...
STATUS: SUCCESS|TIMEOUT|ERROR
EXIT_CODE: <num>
-----------------------------------------------------------
<solver output>

The solver name comes from the log block itself (`Solver:` key). Directory
names are ignored so custom folder layouts are safe. Metadata such as
suite/category are derived from the FILE path; no merging of multiple
converted variants is performed.
"""

from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Set

from openpyxl import Workbook
from openpyxl.cell.cell import TYPE_STRING, TYPE_NUMERIC
from openpyxl.styles import PatternFill, Font

BLOCK_SEPARATOR = "=" * 59  # Standard separator for both batch.sh and batch_splitsmt.sh
OUTPUT_SEPARATOR = "-" * 59

VALID_RESULTS = {"SAT", "UNSAT", "UNKNOWN"}


@dataclass
class LogEntry:
    solver: str
    file_path: Path
    suite: str
    category: str
    status: str
    duration_sec: Optional[float]
    exit_code: Optional[int]
    raw_output: str
    result: str

    @property
    def success(self) -> bool:
        return self.status.upper() == "SUCCESS"

    @property
    def error(self) -> str:
        if self.success:
            return ""
        return self.status.upper()


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Aggregate solver batch results into an Excel table.")
    parser.add_argument(
        "inputs",
        nargs="*",
        type=Path,
        help=(
            "Log files or directories to scan. If omitted, scans the 'results' directory by default."
        ),
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("charts/result.xlsx"),
        help="Path to the output Excel file (default: charts/result.xlsx)",
    )
    parser.add_argument(
        "--solver",
        dest="default_solver",
        help="Default solver name to use when a log block lacks a Solver: field (recommended if logs were produced by batch.sh)",
    )
    parser.add_argument(
        "--encoding",
        default="utf-8",
        help="Encoding used to read logs (default: utf-8)",
    )
    return parser.parse_args()


def iter_log_files(paths: Iterable[Path]) -> Iterable[Path]:
    seen: Set[Path] = set()

    for raw_path in paths:
        path = raw_path.expanduser()
        if not path.exists():
            print(f"warning: input path not found: {path}", file=sys.stderr)
            continue

        if path.is_file():
            target = path.resolve()
            if target in seen:
                continue
            seen.add(target)
            yield target
            continue

        if path.is_dir():
            for log_path in sorted(path.rglob("*.log")):
                target = log_path.resolve()
                if target in seen:
                    continue
                seen.add(target)
                yield target
            continue

        print(f"warning: unsupported input path ignored: {path}", file=sys.stderr)


def parse_log_file(
    log_path: Path,
    encoding: str,
    default_solver: Optional[str] = None,
) -> Iterable[LogEntry]:
    content = log_path.read_text(encoding=encoding, errors="replace")
    blocks = content.split(BLOCK_SEPARATOR)
    for block in blocks:
        block = block.strip()
        if not block:
            continue
        entry = parse_block(block, default_solver=default_solver)
        if entry is None:
            continue
        yield entry


def parse_block(block: str, default_solver: Optional[str]) -> Optional[LogEntry]:
    header: Dict[str, str] = {}
    output_lines: List[str] = []
    reading_output = False
    for raw_line in block.splitlines():
        line = raw_line.rstrip("\n")
        if not reading_output and line.startswith(OUTPUT_SEPARATOR):
            reading_output = True
            continue
        if reading_output:
            output_lines.append(line)
            continue
        if ":" not in line:
            continue
        key, value = line.split(":", 1)
        header[key.strip().lower()] = value.strip()
    solver = header.get("solver") or default_solver
    if not solver:
        return None
    file_str = header.get("file")
    if not file_str:
        return None
    file_path = Path(file_str)
    suite, category = derive_metadata(file_path)
    status = header.get("status", "UNKNOWN").upper()
    duration_str = header.get("duration_sec")
    duration = None
    if duration_str:
        try:
            duration = float(duration_str)
        except ValueError:
            pass
    exit_code = None
    exit_code_str = header.get("exit_code")
    if exit_code_str:
        try:
            exit_code = int(exit_code_str)
        except ValueError:
            pass
    raw_output = "\n".join(output_lines).strip()
    result = classify_result(raw_output, status)
    return LogEntry(
        solver=solver,
        file_path=file_path,
        suite=suite,
        category=category,
        status=status,
        duration_sec=duration,
        exit_code=exit_code,
        raw_output=raw_output,
        result=result,
    )


def derive_metadata(file_path: Path) -> tuple[str, str]:
    """Return (suite, category) extracted from file path.
    
    Handles various path structures:
    - benchmarks/Suite/Category/file.smt2 -> (Suite, Category)
    - test/Category/file.smt2 -> (test, Category)  
    - some/dir/file.smt2 -> (dir, -)
    - file.smt2 -> (-, -)
    """
    parts = file_path.parts
    
    # Need at least a filename
    if len(parts) < 1:
        return "-", "-"
    
    # Single file with no directory: (-, -)
    if len(parts) == 1:
        return "-", "-"
    
    # Only one parent directory: (parent, -)
    if len(parts) == 2:
        return parts[0], "-"
    
    # Two or more parent directories: (grandparent, parent)
    parent = parts[-2]  # Immediate parent directory
    suite = parts[-3]   # Grandparent directory
    
    return suite, parent


def classify_result(raw_output: str, status: str) -> str:
    """
    Classify the result based on solver output.
    Prioritizes explicit SMT-LIB errors starting with '(error'.
    Otherwise, looks for SAT/UNSAT/UNKNOWN.
    """
    if not raw_output:
        return "UNKNOWN"

    found_results = set()

    for line in raw_output.splitlines():
        stripped = line.strip()
        if not stripped:
            continue
            
        # Detect SMT-LIB error
        if stripped.startswith("(error") or stripped.startswith("(error "):
            return "ERROR"
            
        if "Syntax Error" in line or "Unrecoverable Syntax Error" in line:
            return "ERROR"
            
        # Check for standard results
        parts = stripped.split()
        if not parts:
            continue
            
        candidate = parts[0].upper()
        if candidate in ["SAT", "UNSAT"]:
            found_results.add(candidate)
            
    if "SAT" in found_results and "UNSAT" in found_results:
        return "UNKNOWN"
    
    # If we have only one type of result, return it
    if "SAT" in found_results:
        return "SAT"
    if "UNSAT" in found_results:
        return "UNSAT"
        
    return "UNKNOWN"


def classify_consistency(results: List[str]) -> str:
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


def build_rows(entries: Iterable[LogEntry]) -> tuple[List[str], List[Dict[str, object]]]:
    by_file: Dict[str, Dict[str, object]] = {}
    solvers: List[str] = []

    for entry in entries:
        file_key = str(entry.file_path)
        path_str = str(entry.file_path)
        filename = entry.file_path.name
        if file_key not in by_file:
            by_file[file_key] = {
                "path": path_str,
                "filename": filename,
                "suite": entry.suite,
                "category": entry.category,
            }
        record = by_file[file_key]
        if entry.solver not in solvers:
            solvers.append(entry.solver)
        solver_prefix = entry.solver
        
        # Determine the result to show in report
        # Priority:
        # 1. If we detected an explicit error in output (entry.result == "ERROR"), report ERROR
        # 2. If the detailed status is SUCCESS, use the classified result
        # 3. If TIMEOUT, report TIMEOUT
        # 4. Otherwise fall back to status (likely ERROR or unknown)
        
        if entry.result == "ERROR":
            result_value = "ERROR"
        elif entry.success:
            result_value = entry.result
        elif entry.status == "TIMEOUT":
            result_value = "TIMEOUT"
        else:
            result_value = "ERROR" if entry.error == "" else entry.error
        
        record[f"{solver_prefix}_result"] = result_value
        record[f"{solver_prefix}_time"] = entry.duration_sec
        record[f"{solver_prefix}_output"] = entry.raw_output

    solvers = sorted(set(solvers))
    fieldnames = ["path", "filename", "suite", "category", "consistency"]
    for solver in solvers:
        fieldnames.extend(
            [
                f"{solver}_result",
                f"{solver}_time",
                f"{solver}_output",
            ]
        )

    rows = []
    for file_key in sorted(by_file):
        record = by_file[file_key]
        for solver in solvers:
            record.setdefault(f"{solver}_result", "")
            record.setdefault(f"{solver}_time", None)
            record.setdefault(f"{solver}_output", "")

        results = [str(record.get(f"{solver}_result", "")).upper().strip() for solver in solvers]
        record["consistency"] = classify_consistency(results)

        rows.append(record)

    return fieldnames, rows


def build_statistics(fieldnames: List[str], rows: List[Dict[str, object]]) -> Dict[str, object]:
    solvers = []
    for field in fieldnames:
        if field.endswith("_result"):
            solver = field.replace("_result", "")
            solvers.append(solver)

    stats = {
        "solvers": solvers,
        "overall": {},
        "by_suite": {},
        "by_category": {},
        "consistency": {
            "Consistent": 0,
            "Error": 0,
            "Hard": 0,
            "Conflict": 0,
            "Other": 0,
        },
        "consistency_details": {},
    }

    for solver in solvers:
        result_col = f"{solver}_result"
        duration_col = f"{solver}_time"

        results = {"SAT": 0, "UNSAT": 0, "UNKNOWN": 0, "TIMEOUT": 0, "ERROR": 0}
        durations = []

        for row in rows:
            result = str(row.get(result_col, "")).upper().strip()
            if result in results:
                results[result] += 1
            else:
                results["ERROR"] += 1

            duration = row.get(duration_col)
            if duration is not None and isinstance(duration, (int, float)):
                durations.append(float(duration))

        total = sum(results.values())
        stats["overall"][solver] = {
            "total": total,
            "SAT": results["SAT"],
            "UNSAT": results["UNSAT"],
            "UNKNOWN": results["UNKNOWN"],
            "TIMEOUT": results["TIMEOUT"],
            "ERROR": results["ERROR"],
            "avg_time": sum(durations) / len(durations) if durations else 0,
            "min_time": min(durations) if durations else 0,
            "max_time": max(durations) if durations else 0,
        }

    for row in rows:
        suite = row.get("suite", "N/A")
        category = row.get("category", "N/A")

        if suite not in stats["by_suite"]:
            stats["by_suite"][suite] = {
                solver: {"SAT": 0, "UNSAT": 0, "UNKNOWN": 0, "TIMEOUT": 0, "ERROR": 0, "times": []}
                for solver in solvers
            }
        if category not in stats["by_category"]:
            stats["by_category"][category] = {
                solver: {"SAT": 0, "UNSAT": 0, "UNKNOWN": 0, "TIMEOUT": 0, "ERROR": 0, "times": []}
                for solver in solvers
            }

        for solver in solvers:
            result_col = f"{solver}_result"
            duration_col = f"{solver}_time"

            result = str(row.get(result_col, "")).upper().strip()
            if result not in ["SAT", "UNSAT", "UNKNOWN", "TIMEOUT"]:
                result = "ERROR"

            duration = row.get(duration_col)

            stats["by_suite"][suite][solver][result] += 1
            stats["by_category"][category][solver][result] += 1

            if duration is not None and isinstance(duration, (int, float)):
                stats["by_suite"][suite][solver]["times"].append(float(duration))
                stats["by_category"][category][solver]["times"].append(float(duration))

    for row in rows:
        consistency_type = row.get("consistency", "Other")
        stats["consistency"][consistency_type] = stats["consistency"].get(consistency_type, 0) + 1

        if consistency_type not in stats["consistency_details"]:
            stats["consistency_details"][consistency_type] = {
                "count": 0,
                "by_suite": {},
                "by_category": {},
                "examples": [],
            }

        details = stats["consistency_details"][consistency_type]
        details["count"] += 1

        suite = row.get("suite", "N/A")
        category = row.get("category", "N/A")

        details["by_suite"][suite] = details["by_suite"].get(suite, 0) + 1
        details["by_category"][category] = details["by_category"].get(category, 0) + 1

        if len(details["examples"]) < 5:
            example_info = {
                "file": str(Path(str(row.get("path", ""))) / str(row.get("filename", ""))),
                "suite": suite,
                "results": {solver: row.get(f"{solver}_result", "") for solver in solvers},
            }
            details["examples"].append(example_info)

    return stats


def write_excel(output_path: Path, fieldnames: List[str], rows: List[Dict[str, object]]) -> None:
    illegal_chars = re.compile(r"[\x00-\x08\x0B-\x0C\x0E-\x1F\x7F]")

    def sanitize(value: object) -> object:
        if value is None:
            return None
        if isinstance(value, (int, float, bool)):
            return value
        if isinstance(value, str):
            cleaned = illegal_chars.sub("", value)
            if len(cleaned) > 32700:
                cleaned = cleaned[:32700] + "..."
            if cleaned and len(cleaned) > 0 and cleaned[0] in ('=', '+', '-', '@'):
                cleaned = "'" + cleaned
            return cleaned
        return str(value)

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
        "Error": PatternFill(start_color="F4B084", end_color="F4B084", fill_type="solid"),
        "Hard": PatternFill(start_color="FFD966", end_color="FFD966", fill_type="solid"),
        "Conflict": PatternFill(start_color="FF6B6B", end_color="FF6B6B", fill_type="solid"),
        "Other": PatternFill(start_color="BDD7EE", end_color="BDD7EE", fill_type="solid"),
    }

    workbook = Workbook()
    worksheet = workbook.active
    worksheet.title = "Results"

    header_row = [sanitize(name) for name in fieldnames]
    worksheet.append(header_row)
    for cell in worksheet[1]:
        cell.fill = header_fill
        cell.font = header_font

    result_col_indices = []
    consistency_col_idx = None
    for idx, field in enumerate(fieldnames, start=1):
        if field.endswith("_result"):
            result_col_indices.append(idx)
        elif field == "consistency":
            consistency_col_idx = idx

    for row_data in rows:
        row_values = [sanitize(row_data.get(field, None)) for field in fieldnames]
        worksheet.append(row_values)
        current_row = worksheet.max_row
        
        for col_idx in range(1, len(fieldnames) + 1):
            cell = worksheet.cell(row=current_row, column=col_idx)
            if isinstance(cell.value, (int, float)):
                cell.data_type = TYPE_NUMERIC
            elif isinstance(cell.value, str):
                cell.data_type = TYPE_STRING
        
        for col_idx in result_col_indices:
            cell = worksheet.cell(row=current_row, column=col_idx)
            cell_value = str(cell.value).upper().strip() if cell.value else ""
            if cell_value in result_fills:
                cell.fill = result_fills[cell_value]
            elif cell_value.startswith("ERROR") or (cell_value and cell_value not in ["SAT", "UNSAT", "UNKNOWN", "TIMEOUT"]):
                cell.fill = result_fills["ERROR"]
        
        if consistency_col_idx:
            cell = worksheet.cell(row=current_row, column=consistency_col_idx)
            cell_value = str(cell.value) if cell.value else ""
            if cell_value in consistency_fills:
                cell.fill = consistency_fills[cell_value]

    for col in worksheet.columns:
        max_length = 0
        column = col[0].column_letter
        for cell in col:
            if cell.value:
                max_length = max(max_length, len(str(cell.value)))
        adjusted_width = min(5 + max_length * 1.2, 80)
        worksheet.column_dimensions[column].width = adjusted_width
    
    stats = build_statistics(fieldnames, rows)
    write_statistics_sheet(workbook, stats)
    
    workbook.save(output_path)


def write_statistics_sheet(workbook: Workbook, stats: Dict[str, object]) -> None:
    ws = workbook.create_sheet("Statistics")
    
    header_fill = PatternFill(start_color="4472C4", end_color="4472C4", fill_type="solid")
    header_font = Font(bold=True, color="FFFFFF")
    section_fill = PatternFill(start_color="D9E1F2", end_color="D9E1F2", fill_type="solid")
    section_font = Font(bold=True)
    
    result_fills = {
        "SAT": PatternFill(start_color="C6EFCE", end_color="C6EFCE", fill_type="solid"),
        "UNSAT": PatternFill(start_color="FFC7CE", end_color="FFC7CE", fill_type="solid"),
        "UNKNOWN": PatternFill(start_color="FFEB9C", end_color="FFEB9C", fill_type="solid"),
        "TIMEOUT": PatternFill(start_color="E2EFDA", end_color="E2EFDA", fill_type="solid"),
        "ERROR": PatternFill(start_color="D9D9D9", end_color="D9D9D9", fill_type="solid"),
    }
    
    solvers = stats["solvers"]
    row_idx = 1
    
    ws.cell(row_idx, 1, "Overall Statistics").font = section_font
    ws.cell(row_idx, 1).fill = section_fill
    row_idx += 1
    
    headers = ["Solver", "Total", "SAT", "UNSAT", "UNKNOWN", "TIMEOUT", "ERROR", "Avg Time (s)", "Min Time (s)", "Max Time (s)"]
    for col_idx, header in enumerate(headers, 1):
        cell = ws.cell(row_idx, col_idx, header)
        cell.fill = header_fill
        cell.font = header_font
    row_idx += 1
    
    for solver in solvers:
        data = stats["overall"][solver]
        ws.cell(row_idx, 1, solver)
        ws.cell(row_idx, 2, data["total"])
        ws.cell(row_idx, 3, data["SAT"]).fill = result_fills["SAT"]
        ws.cell(row_idx, 4, data["UNSAT"]).fill = result_fills["UNSAT"]
        ws.cell(row_idx, 5, data["UNKNOWN"]).fill = result_fills["UNKNOWN"]
        ws.cell(row_idx, 6, data["TIMEOUT"]).fill = result_fills["TIMEOUT"]
        ws.cell(row_idx, 7, data["ERROR"]).fill = result_fills["ERROR"]
        ws.cell(row_idx, 8, round(data["avg_time"], 4))
        ws.cell(row_idx, 9, round(data["min_time"], 4))
        ws.cell(row_idx, 10, round(data["max_time"], 4))
        row_idx += 1
    
    row_idx += 1
    ws.cell(row_idx, 1, "Result Consistency Analysis").font = section_font
    ws.cell(row_idx, 1).fill = section_fill
    row_idx += 1
    
    consistency_fills_stats = {
        "Consistent": PatternFill(start_color="A9D08E", end_color="A9D08E", fill_type="solid"),
        "Error": PatternFill(start_color="F4B084", end_color="F4B084", fill_type="solid"),
        "Hard": PatternFill(start_color="FFD966", end_color="FFD966", fill_type="solid"),
        "Conflict": PatternFill(start_color="FF6B6B", end_color="FF6B6B", fill_type="solid"),
        "Other": PatternFill(start_color="BDD7EE", end_color="BDD7EE", fill_type="solid"),
    }
    
    headers = ["Category", "Count", "Percentage", "Description"]
    for col_idx, header in enumerate(headers, 1):
        cell = ws.cell(row_idx, col_idx, header)
        cell.fill = header_fill
        cell.font = header_font
    row_idx += 1
    
    total_cases = sum(stats["consistency"].values())
    
    category_descriptions = {
        "Consistent": "Simple and consistent (all solvers agree on SAT/UNSAT)",
        "Error": "Original problem has issues (all solvers failed)",
        "Hard": "Difficult problem (only UNKNOWN/ERROR, no SAT/UNSAT)",
        "Conflict": "CRITICAL: Inconsistency detected (both SAT and UNSAT)",
        "Other": "Other cases (mixed results)",
    }
    
    for category in ["Consistent", "Conflict", "Hard", "Error", "Other"]:
        count = stats["consistency"].get(category, 0)
        percentage = (count / total_cases * 100) if total_cases > 0 else 0
        description = category_descriptions.get(category, "")
        
        ws.cell(row_idx, 1, category).fill = consistency_fills_stats.get(category)
        ws.cell(row_idx, 2, count)
        ws.cell(row_idx, 3, f"{percentage:.2f}%")
        ws.cell(row_idx, 4, description)
        row_idx += 1
    
    row_idx += 1
    ws.cell(row_idx, 1, "Detailed Consistency Breakdown").font = section_font
    ws.cell(row_idx, 1).fill = section_fill
    row_idx += 1
    
    for category in ["Consistent", "Conflict", "Hard", "Error", "Other"]:
        if category not in stats["consistency_details"]:
            continue
        
        details = stats["consistency_details"][category]
        
        ws.cell(row_idx, 1, f"{category} ({details['count']} cases)").font = Font(bold=True)
        ws.cell(row_idx, 1).fill = consistency_fills_stats.get(category)
        row_idx += 1
        
        ws.cell(row_idx, 1, "By Suite:")
        row_idx += 1
        for suite, count in sorted(details["by_suite"].items(), key=lambda x: -x[1])[:5]:
            ws.cell(row_idx, 2, f"{suite}: {count}")
            row_idx += 1
        
        ws.cell(row_idx, 1, "By Category:")
        row_idx += 1
        for category, count in sorted(details["by_category"].items(), key=lambda x: -x[1])[:5]:
            ws.cell(row_idx, 2, f"{category}: {count}")
            row_idx += 1
        
        row_idx += 1
    
    row_idx += 1
    
    ws.cell(row_idx, 1, "Statistics by Suite").font = section_font
    ws.cell(row_idx, 1).fill = section_fill
    row_idx += 1
    
    for suite, suite_data in sorted(stats["by_suite"].items()):
        ws.cell(row_idx, 1, f"Suite: {suite}").font = Font(bold=True)
        row_idx += 1
        
        headers = ["Solver", "Total", "SAT", "UNSAT", "UNKNOWN", "TIMEOUT", "ERROR", "Avg Time (s)"]
        for col_idx, header in enumerate(headers, 1):
            cell = ws.cell(row_idx, col_idx, header)
            cell.fill = header_fill
            cell.font = header_font
        row_idx += 1
        
        for solver in solvers:
            solver_data = suite_data[solver]
            total = solver_data["SAT"] + solver_data["UNSAT"] + solver_data["UNKNOWN"] + solver_data["TIMEOUT"] + solver_data["ERROR"]
            avg_time = sum(solver_data["times"]) / len(solver_data["times"]) if solver_data["times"] else 0
            
            ws.cell(row_idx, 1, solver)
            ws.cell(row_idx, 2, total)
            ws.cell(row_idx, 3, solver_data["SAT"]).fill = result_fills["SAT"]
            ws.cell(row_idx, 4, solver_data["UNSAT"]).fill = result_fills["UNSAT"]
            ws.cell(row_idx, 5, solver_data["UNKNOWN"]).fill = result_fills["UNKNOWN"]
            ws.cell(row_idx, 6, solver_data["TIMEOUT"]).fill = result_fills["TIMEOUT"]
            ws.cell(row_idx, 7, solver_data["ERROR"]).fill = result_fills["ERROR"]
            ws.cell(row_idx, 8, round(avg_time, 4))
            row_idx += 1
        
        row_idx += 1
    ws.cell(row_idx, 1, "Statistics by Category").font = section_font
    ws.cell(row_idx, 1).fill = section_fill
    row_idx += 1
    
    for category, category_data in sorted(stats["by_category"].items()):
        ws.cell(row_idx, 1, f"Category: {category}").font = Font(bold=True)
        row_idx += 1
        
        headers = ["Solver", "Total", "SAT", "UNSAT", "UNKNOWN", "TIMEOUT", "ERROR", "Avg Time (s)"]
        for col_idx, header in enumerate(headers, 1):
            cell = ws.cell(row_idx, col_idx, header)
            cell.fill = header_fill
            cell.font = header_font
        row_idx += 1
        
        for solver in solvers:
            solver_data = category_data[solver]
            total = solver_data["SAT"] + solver_data["UNSAT"] + solver_data["UNKNOWN"] + solver_data["TIMEOUT"] + solver_data["ERROR"]
            avg_time = sum(solver_data["times"]) / len(solver_data["times"]) if solver_data["times"] else 0
            
            ws.cell(row_idx, 1, solver)
            ws.cell(row_idx, 2, total)
            ws.cell(row_idx, 3, solver_data["SAT"]).fill = result_fills["SAT"]
            ws.cell(row_idx, 4, solver_data["UNSAT"]).fill = result_fills["UNSAT"]
            ws.cell(row_idx, 5, solver_data["UNKNOWN"]).fill = result_fills["UNKNOWN"]
            ws.cell(row_idx, 6, solver_data["TIMEOUT"]).fill = result_fills["TIMEOUT"]
            ws.cell(row_idx, 7, solver_data["ERROR"]).fill = result_fills["ERROR"]
            ws.cell(row_idx, 8, round(avg_time, 4))
            row_idx += 1
        
        row_idx += 1
    
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
    entries: List[LogEntry] = []

    if args.inputs:
        log_paths = iter_log_files(args.inputs)
    else:
        results_root = Path("results")
        if not results_root.exists():
            print(f"error: default results directory not found: {results_root}", file=sys.stderr)
            return 1
        log_paths = iter_log_files([results_root])

    for log_path in log_paths:
        try:
            entries.extend(parse_log_file(
                log_path,
                args.encoding,
                default_solver=args.default_solver,
            ))
        except FileNotFoundError:
            continue

    if not entries:
        print("warning: no log entries found", file=sys.stderr)

    fieldnames, rows = build_rows(entries)

    args.output.parent.mkdir(parents=True, exist_ok=True)
    write_excel(args.output, fieldnames, rows)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
