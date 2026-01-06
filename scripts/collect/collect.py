#!/usr/bin/env python3
"""Collect SMT examples from the aggregate Excel report.

Works with the output of scripts/report/aggregate.py. Supports filtering by
label (consistency) and/or solver results (AND/OR expressions). Matching rows'
`path` + `filename` are joined and copied to the output directory, with options
to keep or flatten directory structure and to clear the output directory first.
"""

from __future__ import annotations

import argparse
import re
import shutil
import sys
from pathlib import Path
from dataclasses import dataclass
from typing import Dict, List, Optional, Sequence, Tuple

from openpyxl import load_workbook


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Collect SMT files from aggregate.xlsx using label or solver result filters."
    )
    parser.add_argument(
        "xlsx_file",
        type=Path,
        help="Excel file produced by scripts/report/aggregate.py",
    )
    parser.add_argument(
        "--label",
        default=None,
        help="Filter rows by Label (e.g. Other, Conflict), default no filter.",
    )
    parser.add_argument(
        "--result",
        dest="result_value",
        default=None,
        help="Target solver result, matches <solver>_result column (e.g. TIMEOUT, UNKNOWN, SAT).",
    )
    parser.add_argument(
        "--solvers",
        dest="solvers_expr",
        default=None,
        help="求解器表达式（AND: &, &&, +, and；OR: ||, |, ,, or），例如 'z3&cvc5' 或 'z3||cvc5'，推荐用 '+' 表示 AND、',' 表示 OR，可省去引号。",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=None,
        help="复制到的输出目录前缀（默认当前工作目录）。",
    )
    structure_group = parser.add_mutually_exclusive_group()
    structure_group.add_argument(
        "--keep-structure",
        action="store_true",
        help="保持原始目录结构（默认）。",
    )
    structure_group.add_argument(
        "--flatten",
        action="store_true",
        help="不保持原始目录结构，目标文件名将重命名为 suite+category+filename。",
    )
    parser.add_argument(
        "--clear",
        action="store_true",
        help="复制前清空输出目录（默认不清空，存在则覆盖）。",
    )
    parser.add_argument(
        "--prune",
        action="store_true",
        help="在原路径中删除不匹配的文件（--output 失效）。",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="仅展示匹配文件，不执行复制。",
    )
    return parser.parse_args()


@dataclass
class CollectedFile:
    source: Path
    suite: str
    category: str
    filename: str


def parse_solver_expression(expr: Optional[str]) -> List[Tuple[str, ...]]:
    """Return OR groups of solver names, all lower-case.

    支持符号和关键字：
    - AND: &, &&, +, and
    - OR : ||, |, ,, or
    """
    if not expr:
        return []
    normalized = expr.lower().strip()
    # 统一 AND/OR 符号，移除空格
    normalized = re.sub(r"\s+", "", normalized)
    normalized = normalized.replace("&&", "&").replace("+", "&").replace("and", "&")
    normalized = normalized.replace("||", "|").replace(",", "|").replace("or", "|")
    or_parts = [part for part in re.split(r"\|+", normalized) if part]
    groups: List[Tuple[str, ...]] = []
    for part in or_parts:
        solvers = [s for s in re.split(r"&+", part) if s]
        if solvers:
            groups.append(tuple(solvers))
    return groups


def matches_solver_filter(
    target_result: Optional[str],
    solver_groups: Sequence[Tuple[str, ...]],
    solver_results: Dict[str, str],
) -> bool:
    """Check whether solver result filters match for a row."""
    if target_result is None and not solver_groups:
        return True
    if target_result is None:
        return False
    target = target_result.upper().strip()
    if solver_groups:
        for group in solver_groups:
            if all(solver_results.get(solver, "").upper() == target for solver in group):
                return True
        return False
    return any(res.upper() == target for res in solver_results.values())


def collect_file_paths(
    xlsx_file: Path,
    label_filter: Optional[str],
    target_result: Optional[str],
    solver_groups: Sequence[Tuple[str, ...]],
    include_all: bool = False,
) -> tuple[List[CollectedFile], List[str], Optional[List[CollectedFile]]]:
    workbook = load_workbook(xlsx_file, read_only=True, data_only=True)
    try:
        if "Results" not in workbook.sheetnames:
            print(f"error: 'Results' sheet not found in {xlsx_file}", file=sys.stderr)
            sys.exit(1)
        worksheet = workbook["Results"]

        headers = {
            str(cell.value).strip(): idx
            for idx, cell in enumerate(worksheet[1], start=1)
            if cell.value
        }
        path_col = headers.get("path")
        filename_col = headers.get("filename")
        suite_col = headers.get("suite")
        category_col = headers.get("category")

        if path_col is None or filename_col is None:
            print("error: 'path' and/or 'filename' column not found in Results sheet", file=sys.stderr)
            sys.exit(1)
        if suite_col is None or category_col is None:
            print("error: 'suite' and/or 'category' column not found in Results sheet", file=sys.stderr)
            sys.exit(1)
            
        label_col = headers.get("label")
        if not label_col:
            # Fallback to consistency if label not found
            label_col = headers.get("consistency")
            
        if label_filter and label_col is None:
            print("error: 'label' (or 'consistency') column missing but --label provided", file=sys.stderr)
            sys.exit(1)

        solver_result_cols = {
            header[:-7].lower(): idx
            for header, idx in headers.items()
            if header.endswith("_result")
        }
        available_solvers = sorted(solver_result_cols.keys())

        if target_result and not solver_result_cols:
            print("error: no <solver>_result columns found in the Results sheet", file=sys.stderr)
            sys.exit(1)

        normalized_target = target_result.upper().strip() if target_result else None
        label_check = label_filter.lower().strip() if label_filter else None

        requested = {solver for group in solver_groups for solver in group}
        missing = sorted(requested - set(available_solvers))
        if missing:
            print(
                f"warning: solver(s) not found in sheet and will be ignored: {', '.join(missing)}",
                file=sys.stderr,
            )

        file_records: Dict[Path, CollectedFile] = {}
        all_records: Optional[Dict[Path, CollectedFile]] = {} if include_all else None
        for row in worksheet.iter_rows(min_row=2):
            path_cell = row[path_col - 1].value
            filename_cell = row[filename_col - 1].value
            suite_cell = row[suite_col - 1].value
            category_cell = row[category_col - 1].value

            if not filename_cell:
                continue

            if label_check and label_col:
                row_label = row[label_col - 1].value
                if not row_label or str(row_label).strip().lower() != label_check:
                    continue

            solver_results: Dict[str, str] = {}
            for solver, idx in solver_result_cols.items():
                value = row[idx - 1].value
                solver_results[solver] = str(value).upper().strip() if value else ""

            if not matches_solver_filter(normalized_target, solver_groups, solver_results):
                continue

            path_str = str(path_cell).strip() if path_cell is not None else ""
            filename_str = str(filename_cell).strip()
            if not filename_str:
                continue
            base_path = Path(path_str).expanduser() if path_str else Path()
            source_path = (base_path / filename_str).expanduser()
            if all_records is not None and source_path not in all_records:
                all_records[source_path] = CollectedFile(
                    source=source_path,
                    suite=str(suite_cell).strip() if suite_cell else "",
                    category=str(category_cell).strip() if category_cell else "",
                    filename=Path(filename_str).name,
                )
            if source_path not in file_records:
                file_records[source_path] = CollectedFile(
                    source=source_path,
                    suite=str(suite_cell).strip() if suite_cell else "",
                    category=str(category_cell).strip() if category_cell else "",
                    filename=Path(filename_str).name,
                )

        return (
            list(file_records.values()),
            available_solvers,
            list(all_records.values()) if all_records is not None else None,
        )
    finally:
        workbook.close()


def copy_files(
    files: Sequence[CollectedFile],
    output_prefix: Path,
    keep_structure: bool,
    clear_output: bool,
    dry_run: bool = False,
) -> tuple[int, int, int]:
    copied = 0
    skipped = 0
    failed = 0

    if clear_output and not dry_run and output_prefix.exists():
        try:
            shutil.rmtree(output_prefix)
        except Exception as exc:
            print(f"error clearing output directory {output_prefix}: {exc}", file=sys.stderr)
            return 0, 0, 1

    if not dry_run:
        output_prefix.mkdir(parents=True, exist_ok=True)

    for file_entry in sorted(files, key=lambda x: str(x.source)):
        source_path = file_entry.source
        if keep_structure:
            target_relative = (
                source_path if not source_path.is_absolute() else source_path.relative_to(source_path.anchor)
            )
            target_path = output_prefix / target_relative
        else:
            suite_part = file_entry.suite or "unknown"
            category_part = file_entry.category or "unknown"
            target_filename = f"{suite_part}+{category_part}+{file_entry.filename}"
            target_path = output_prefix / target_filename

        if not source_path.exists():
            print(f"warning: source file not found: {source_path}", file=sys.stderr)
            skipped += 1
            continue
        if dry_run:
            print(f"would copy: {source_path} -> {target_path}")
            copied += 1
            continue
        try:
            target_path.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source_path, target_path)
            copied += 1
        except Exception as exc:
            print(f"error copying {source_path}: {exc}", file=sys.stderr)
            failed += 1
    return copied, skipped, failed


def main() -> int:
    args = parse_args()

    if not args.xlsx_file.exists():
        print(f"error: Excel file not found: {args.xlsx_file}", file=sys.stderr)
        return 1

    solver_groups = parse_solver_expression(args.solvers_expr)
    defaulted_timeout = False
    target_result = args.result_value.upper() if args.result_value else None
    if solver_groups and target_result is None:
        target_result = "TIMEOUT"
        defaulted_timeout = True

    output_dir = args.output or Path.cwd()

    print("=" * 60)
    print("Configuration:")
    print(f"  Excel file: {args.xlsx_file}")
    print(f"  Label filter: {args.label or 'Any'}")
    print(f"  Solver result filter: {target_result or 'Any'}")
    if args.solvers_expr:
        print(f"  Solver expression: {args.solvers_expr}")
    if defaulted_timeout:
        print("  Note: --solvers provided without --result，默认按 TIMEOUT 过滤")
    if args.prune:
        print("  Output directory: (ignored due to --prune)")
    else:
        print(f"  Output directory: {output_dir}")
    if args.dry_run:
        print("  Mode: DRY RUN (no files will be copied)")
    print("=" * 60)
    print()

    keep_structure = args.keep_structure or not args.flatten

    file_records, available_solvers, all_records = collect_file_paths(
        args.xlsx_file,
        args.label,
        target_result,
        solver_groups,
        include_all=args.prune,
    )

    if available_solvers:
        print(f"Available solver columns: {', '.join(available_solvers)}")
    print(f"Matching files found: {len(file_records)}")
    if args.prune:
        print("  Prune mode: True")
    else:
        print(f"  Keep structure: {keep_structure}")
        print(f"  Clear output first: {args.clear}")

    print()
    if not file_records and not args.prune:
        print("No files to collect after filtering")
        return 0

    if args.prune:
        if all_records is None:
            print("error: prune requested but no records were loaded", file=sys.stderr)
            return 1
        keep_set = {record.source for record in file_records}
        to_delete = [record for record in all_records if record.source not in keep_set]
        print(f"Pruning {len(to_delete)} file(s)...")
        deleted = 0
        missing = 0
        failed = 0
        for record in sorted(to_delete, key=lambda x: str(x.source)):
            source_path = record.source
            if not source_path.exists():
                print(f"warning: source file not found: {source_path}", file=sys.stderr)
                missing += 1
                continue
            if source_path.is_dir():
                print(f"warning: path is a directory, skipping: {source_path}", file=sys.stderr)
                failed += 1
                continue
            if args.dry_run:
                print(f"would delete: {source_path}")
                deleted += 1
                continue
            try:
                source_path.unlink()
                deleted += 1
            except Exception as exc:
                print(f"error deleting {source_path}: {exc}", file=sys.stderr)
                failed += 1
        print()
        print("=" * 60)
        print("Summary:")
        print(f"  Kept (matched): {len(keep_set)}")
        if args.dry_run:
            print(f"  Would delete: {deleted}")
        else:
            print(f"  Deleted: {deleted}")
        if missing > 0:
            print(f"  Skipped (not found): {missing}")
        if failed > 0:
            print(f"  Failed: {failed}")
        print("=" * 60)
        return 1 if failed > 0 else 0

    print(f"Copying {len(file_records)} file(s)...")
    copied, skipped, failed = copy_files(
        file_records,
        output_dir,
        keep_structure=keep_structure,
        clear_output=args.clear,
        dry_run=args.dry_run,
    )
    print()
    print("=" * 60)
    print("Summary:")
    if args.dry_run:
        print(f"  Would copy: {copied}")
    else:
        print(f"  Successfully copied: {copied}")
    if skipped > 0:
        print(f"  Skipped (not found): {skipped}")
    if failed > 0:
        print(f"  Failed: {failed}")
    print("=" * 60)

    return 1 if failed > 0 else 0


if __name__ == "__main__":
    raise SystemExit(main())
