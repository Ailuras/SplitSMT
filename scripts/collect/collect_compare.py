#!/usr/bin/env python3
"""Collect examples from a compare.xlsx produced by scripts/compare/compare.py based on Label or Solver Result."""

from __future__ import annotations

import argparse
import shutil
import sys
import re
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Sequence, Tuple, Set, Optional

from openpyxl import load_workbook


@dataclass
class CompareFile:
    source: Path
    suite: str
    category: str
    filename: str
    label: str


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Collect examples from compare.xlsx (Comparison sheet) based on Label or Solver Result."
    )
    parser.add_argument("xlsx_file", type=Path, help="compare.py 生成的 Excel（包含 Comparison 表）。")
    parser.add_argument(
        "--source-index",
        type=int,
        choices=[1, 2],
        default=1,
        help="选择使用 path_1 还是 path_2（默认 1）。",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=None,
        help="复制到的输出目录（默认当前工作目录）。使用 --filter 时，此参数为用于筛选的路径。",
    )
    
    # Filter group: either by Label or by Solver Result
    filter_group = parser.add_mutually_exclusive_group()
    filter_group.add_argument(
        "--label",
        default=None,
        help="按标签筛选 (e.g., Conflict, Improvement, Descent). 仅支持单标签。",
    )
    filter_group.add_argument(
        "--result",
        dest="result_value",
        default=None,
        help="按求解器结果筛选 (e.g., Improvement, Conflict). 需配合 --solvers 使用。",
    )

    parser.add_argument(
        "--solvers",
        dest="solvers_expr",
        default=None,
        help="配合 --result 使用的求解器表达式（e.g., 'z3+cvc5', 'z3,cvc5'）。",
    )

    parser.add_argument(
        "--filter",
        action="store_true",
        help="筛选模式：在原始文件夹中删除未出现在表格中（或不符合条件）的例子。",
    )
    structure_group = parser.add_mutually_exclusive_group()
    structure_group.add_argument(
        "--flatten",
        action="store_true",
        help="不保持目录结构，目标文件名重命名为 suite+category+filename。",
    )
    structure_group.add_argument(
        "--keep-structure",
        action="store_true",
        help="保持目录结构（默认）。",
    )
    parser.add_argument(
        "--clear-output",
        action="store_true",
        help="复制前清空输出目录（默认不清空，直接覆盖同名文件）。",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="仅展示将要复制的文件，不执行复制。",
    )
    return parser.parse_args()


def parse_solver_expression(expr: Optional[str]) -> List[Tuple[str, ...]]:
    """Return OR groups of solver names, all lower-case.
    Reuse logic from collect.py
    """
    if not expr:
        return []
    normalized = expr.lower().strip()
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
    """Check whether solver result (Change column) filters match for a row."""
    if target_result is None:
        return True # specific logic: if no result filter, we don't call this.
        
    target = target_result.upper().strip()
    if solver_groups:
        for group in solver_groups:
            # Check if logic matches
            # Group is AND (e.g. z3 & cvc5 must be target)
            match_group = True
            for solver in group:
                val = solver_results.get(solver, "").upper()
                if val != target:
                    match_group = False
                    break
            if match_group:
                return True
        return False
    else:
        # If result provided but no solvers? Should have been caught by args check or default behavior.
        # If no solvers specified, maybe match ANY solver?
        return any(res.upper() == target for res in solver_results.values())


def load_target_files(
    xlsx_file: Path,
    source_index: int,
    target_label: Optional[str],
    target_result: Optional[str],
    solver_groups: List[Tuple[str, ...]]
) -> Tuple[List[CompareFile], str]:
    
    if not xlsx_file.exists():
        print(f"error: Excel file not found: {xlsx_file}", file=sys.stderr)
        sys.exit(1)

    workbook = load_workbook(xlsx_file, read_only=True, data_only=True)
    try:
        if "Comparison" not in workbook.sheetnames:
            print(f"error: 'Comparison' sheet not found in {xlsx_file}", file=sys.stderr)
            sys.exit(1)

        worksheet = workbook["Comparison"]
        headers = {
            str(cell.value).strip().lower(): idx
            for idx, cell in enumerate(worksheet[1], start=1)
            if cell.value
        }

        # Identify columns
        label_col_idx = headers.get("label")
        if not label_col_idx:
            label_col_idx = headers.get("consistency")
        if not label_col_idx:
             print("error: required column 'Label' (or 'consistency') not found", file=sys.stderr)
             sys.exit(1)

        required = ["filename", "suite", "category"]
        for key in required:
            if key not in headers:
                print(f"error: required column '{key}' not found", file=sys.stderr)
                sys.exit(1)

        path_cols = sorted(
            [(name, idx) for name, idx in headers.items() if name.startswith("path") or name == "path"],
            key=lambda x: x[1],
        )
        if not path_cols or len(path_cols) < source_index:
            print(f"Debug: Available headers: {list(headers.keys())}")
            print(
                f"error: path column for index {source_index} not found",
                file=sys.stderr,
            )
            sys.exit(1)

        path_col_name, path_col_idx = path_cols[source_index - 1]
        
        filename_col = headers["filename"]
        suite_col = headers["suite"]
        category_col = headers["category"]
        
        # Solver change columns: e.g. "z3_change"
        # We need to map solver name to column index
        # Looking for <solver>_change
        solver_change_cols: Dict[str, int] = {}
        for h, idx in headers.items():
            if h.endswith("_change"):
                s_name = h[:-7] # remove "_change"
                solver_change_cols[s_name] = idx
        
        # Validate solver groups if present
        if target_result and solver_groups:
            requested = {solver for group in solver_groups for solver in group}
            missing = sorted(requested - set(solver_change_cols.keys()))
            if missing:
                print(f"warning: solvers not found in sheet: {', '.join(missing)}", file=sys.stderr)

        records: Dict[Path, CompareFile] = {}
        target_label_lower = target_label.lower() if target_label else None
        target_result_norm = target_result.title() if target_result else None # "Improvement", "Conflict" usually Title case in sheet? 
        # Actually sheet uses "Improvement", "Conflict" (Title case). Arguments are flexible.
        # matches_solver_filter uses upper() comparison.
        
        for row in worksheet.iter_rows(min_row=2):
            # 1. Check Label
            label_cell = row[label_col_idx - 1].value
            label_val = str(label_cell).strip() if label_cell else ""
            
            if target_label_lower:
                if label_val.lower() != target_label_lower:
                    continue

            # 2. Check Solver Result
            if target_result:
                # Gather solver results for this row
                row_solver_results: Dict[str, str] = {}
                for s, idx in solver_change_cols.items():
                    val = row[idx-1].value
                    row_solver_results[s] = str(val).strip() if val else ""
                
                if not matches_solver_filter(target_result, solver_groups, row_solver_results):
                    continue

            # If we get here, row matches
            path_cell = row[path_col_idx - 1].value
            filename_cell = row[filename_col - 1].value
            suite_cell = row[suite_col - 1].value
            category_cell = row[category_col - 1].value

            if not path_cell or not filename_cell:
                continue

            base_path = Path(str(path_cell).strip()).expanduser()
            filename = Path(str(filename_cell).strip()).name
            source_path = base_path / filename
            suite = str(suite_cell).strip() if suite_cell else ""
            category = str(category_cell).strip() if category_cell else ""

            if source_path not in records:
                records[source_path] = CompareFile(
                    source=source_path,
                    suite=suite,
                    category=category,
                    filename=filename,
                    label=label_val
                )

        return list(records.values()), path_col_name
    finally:
        workbook.close()


def filter_files(
    files: Sequence[CompareFile],
    filter_dir: Path,
    dry_run: bool,
) -> tuple[int, int, int, int]:
    kept = 0
    deleted = 0
    failed = 0
    total_scanned = 0
    if not filter_dir.exists():
        print(f"error: filter directory not found: {filter_dir}", file=sys.stderr)
        return 0, 0, 1, 0
    if not filter_dir.is_dir():
        print(f"error: filter path is not a directory: {filter_dir}", file=sys.stderr)
        return 0, 0, 1, 0
    valid_paths = {file_entry.source.resolve() for file_entry in files}
    for file_path in filter_dir.rglob("*"):
        if not file_path.is_file():
            continue
        total_scanned += 1
        file_path_resolved = file_path.resolve()
        if file_path_resolved in valid_paths:
            kept += 1
            continue
        if dry_run:
            print(f"would delete: {file_path}")
            deleted += 1
            continue
        try:
            file_path.unlink()
            deleted += 1
        except Exception as exc:
            print(f"error deleting {file_path}: {exc}", file=sys.stderr)
            failed += 1
    return kept, deleted, failed, total_scanned


def copy_files(
    files: Sequence[CompareFile],
    output_dir: Path,
    keep_structure: bool,
    clear_output: bool,
    dry_run: bool,
) -> tuple[int, int, int]:
    copied = 0
    skipped = 0
    failed = 0

    if clear_output and not dry_run and output_dir.exists():
        try:
            shutil.rmtree(output_dir)
        except Exception as exc:
            print(f"error clearing output directory {output_dir}: {exc}", file=sys.stderr)
            return 0, 0, 1

    if not dry_run:
        output_dir.mkdir(parents=True, exist_ok=True)

    for file_entry in sorted(files, key=lambda x: str(x.source)):
        source_path = file_entry.source
        if keep_structure:
            target_relative = (
                source_path if not source_path.is_absolute() else source_path.relative_to(source_path.anchor)
            )
            # Remove leading slash if present in relative
            if str(target_relative).startswith("/"):
                 target_relative = Path(str(target_relative)[1:])
                 
            target_path = output_dir / target_relative
        else:
            suite_part = file_entry.suite or "unknown"
            category_part = file_entry.category or "unknown"
            target_filename = f"{suite_part}+{category_part}+{file_entry.filename}"
            target_path = output_dir / target_filename

        if not source_path.exists():
            print(f"warning: source file not found: {source_path}", file=sys.stderr)
            skipped += 1
            continue

        if dry_run:
            print(f"would copy: {source_path} -> {target_path} (Label: {file_entry.label})")
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
    
    # Check if neither is provided? Default to Conflict if neither?
    # User requirement: "label... default Conflict".
    # But now we support Result.
    # If no filter provided, what to do?
    # We should probably default to --label Conflict if nothing provided.
    target_label = args.label
    target_result = args.result_value
    
    if not target_label and not target_result:
        target_label = "Conflict"
        
    solver_groups = parse_solver_expression(args.solvers_expr)
    
    # Validation: If result provided, should we enforce solvers?
    # "but cannot share with label" -> handled by mutex group
    
    if args.filter:
        if not args.output:
            print("error: --output is required when using --filter", file=sys.stderr)
            return 1
        filter_dir = args.output
        files, path_label = load_target_files(args.xlsx_file, args.source_index, target_label, target_result, solver_groups)
        print("=" * 60)
        print("Configuration (Filter Mode):")
        print(f"  Excel file: {args.xlsx_file}")
        if target_label:
            print(f"  Target Label: {target_label}")
        if target_result:
            print(f"  Target Result: {target_result}")
            print(f"  Solvers: {args.solvers_expr or 'Any'}")
            
        print(f"  Using column: {path_label}")
        print(f"  Filter directory: {filter_dir}")
        if args.dry_run:
            print("  Mode: DRY RUN (no files will be deleted)")
        print("=" * 60)
        print()
        print(f"Target files found in table: {len(files)}")
        if not files:
            print("No matching rows to filter")
            return 0
        print(f"Filtering files in {filter_dir}...")
        kept, deleted, failed, total_scanned = filter_files(
            files,
            filter_dir,
            dry_run=args.dry_run,
        )
        print()
        print("=" * 60)
        print("Summary:")
        print(f"  Total files scanned: {total_scanned}")
        print(f"  Files kept: {kept}")
        if args.dry_run:
            print(f"  Files would be deleted: {deleted}")
        else:
            print(f"  Files deleted: {deleted}")
        if failed:
            print(f"  Failed operations: {failed}")
        print("=" * 60)
        return 1 if failed > 0 else 0
    else:
        keep_structure = args.keep_structure or not args.flatten
        output_dir = args.output or Path.cwd()
        files, path_label = load_target_files(args.xlsx_file, args.source_index, target_label, target_result, solver_groups)
        print("=" * 60)
        print("Configuration (Collect Mode):")
        print(f"  Excel file: {args.xlsx_file}")
        if target_label:
            print(f"  Target Label: {target_label}")
        if target_result:
            print(f"  Target Result: {target_result}")
            print(f"  Solvers: {args.solvers_expr or 'Any'}")
        
        print(f"  Using column: {path_label}")
        print(f"  Output directory: {output_dir}")
        print(f"  Keep structure: {keep_structure}")
        print(f"  Clear output first: {args.clear_output}")
        if args.dry_run:
            print("  Mode: DRY RUN (no files will be copied)")
        print("=" * 60)
        print()
        print(f"Target files found in table: {len(files)}")
        if not files:
            print(f"No matching rows to collect")
            return 0
        print(f"Copying {len(files)} file(s)...")
        copied, skipped, failed = copy_files(
            files,
            output_dir,
            keep_structure=keep_structure,
            clear_output=args.clear_output,
            dry_run=args.dry_run,
        )
        print()
        print("=" * 60)
        print("Summary:")
        print(f"  Total matches in table: {len(files)}")
        if args.dry_run:
            print(f"  Files would be copied: {copied}")
        else:
            print(f"  Files successfully copied: {copied}")
        if skipped:
            print(f"  Files skipped (not found): {skipped}")
        if failed:
            print(f"  Failed operations: {failed}")
        print("=" * 60)
        return 1 if failed > 0 else 0


if __name__ == "__main__":
    raise SystemExit(main())
