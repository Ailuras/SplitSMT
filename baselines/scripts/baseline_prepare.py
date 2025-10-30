#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import os
import re
import sys
from pathlib import Path
from typing import List, Dict, Tuple

import pandas as pd
import subprocess
import shlex

# Configuration: where to read snippet templates
# Place your txt snippets here per mode+solver, e.g. baselines/configs/UF/z3.txt
SNIPPET_ROOT = Path("baselines/configs")
SUPPORTED_MODES = ["UF", "RA", "REC"]
SUPPORTED_SOLVERS = ["z3", "z3-noodler", "ostrich", "cvc5"]

def read_snippet(mode: str, solver: str) -> Tuple[List[str], str]:
    """Read snippet lines for a given mode and solver. Returns (lines, tag)."""
    mode_dir = SNIPPET_ROOT / mode
    path = mode_dir / f"{solver}.txt"
    if path.exists():
        try:
            with open(path, "r", encoding="utf-8") as f:
                lines = [line.rstrip("\n") for line in f.readlines()]
            while lines and lines[-1] == "":
                lines.pop()
            return lines, solver
        except Exception:
            return [], solver
    # fallback to default.txt if present
    fallback = mode_dir / "default.txt"
    if fallback.exists():
        try:
            with open(fallback, "r", encoding="utf-8") as f:
                lines = [line.rstrip("\n") for line in f.readlines()]
            while lines and lines[-1] == "":
                lines.pop()
            return lines, "default"
        except Exception:
            return [], "default"
    return [], "none"


def transform_content_insert_and_replace(content: List[str], snippet_lines: List[str]) -> Tuple[List[str], Dict[str, int]]:
    """Insert snippet after first line (as new second line), and perform replacements.
    Replacements:
      - remove `str.` prefix in patterns: (str.split ... => (split ..., (str.num_splits ... => (num_splits ...
    Return transformed lines and stats.
    """
    out_lines: List[str] = []
    stats = {"lines_inserted": 0, "replacements": 0}

    if not content:
        return content, stats
    insert_pos = next((i for i, line in enumerate(content) if "set-logic" in line), -1)
    if insert_pos >= 0:                   
        out_lines.extend(content[:insert_pos])
        out_lines.append("(set-logic ALL)")
        remaining = content[insert_pos+1:]
    else:                                
        out_lines.append("(set-logic ALL)")
        remaining = content               
    if snippet_lines:
        out_lines.extend(snippet_lines)
        stats["lines_inserted"] = len(snippet_lines)

    # compile regexes once
    # Only replace when inside an S-expression start, i.e., after '(' to avoid touching comments
    pat_split = re.compile(r"\(\s*str\.split")
    pat_num_splits = re.compile(r"\(\s*str\.num_splits")

    for line in remaining:
        # Replace (str.split -> (split, preserving any whitespace between '(' and symbol
        def _repl_split(m):
            # m.group() like '(str.split' or '(  str.split'
            return m.group(0).replace("str.", "")
        def _repl_num(m):
            return m.group(0).replace("str.", "")

        new_line, c1 = pat_split.subn(_repl_split, line)
        new_line, c2 = pat_num_splits.subn(_repl_num, new_line)
        stats["replacements"] += (c1 + c2)
        out_lines.append(new_line)

    return out_lines, stats


def process_file(src_path: Path, dst_path: Path, snippet_lines: List[str]) -> Tuple[bool, Dict[str, int], str]:
    """Process single SMT2 file: read, transform, write to dst. Return (ok, stats, message)."""
    try:
        with open(src_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read().splitlines()
        new_lines, stats = transform_content_insert_and_replace(content, snippet_lines)
        dst_path.parent.mkdir(parents=True, exist_ok=True)
        with open(dst_path, "w", encoding="utf-8") as f:
            f.write("\n".join(new_lines) + "\n")
        return True, stats, ""
    except Exception as e:
        return False, {"lines_inserted": 0, "replacements": 0}, str(e)


def collect_smt_files(input_dir: Path) -> List[Path]:
    return sorted([Path(p) for p in input_dir.rglob("*.smt2")])


def ensure_excel_columns(df: pd.DataFrame) -> pd.DataFrame:
    # Align with scripts/solve/simple_analysis.py expected columns ordering
    required = ['file_name', 'result', 'sat_result', 'solving_time', 'solver_type', 'timeout', 'path', 'task', 'exit_code', 'solver_output']
    for col in required:
        if col not in df.columns:
            df[col] = ''
    df = df.reindex(columns=required)
    return df


def write_excel(results: List[Dict], output_file: Path, task_name: str):
    if not results:
        return
    df = pd.DataFrame(results)
    df = ensure_excel_columns(df)
    df = df.sort_values('file_name')
    # Sheet name similar to analysis
    with pd.ExcelWriter(output_file, engine='openpyxl') as writer:
        df.to_excel(writer, index=False, sheet_name=f'{task_name}_results')


def _relative_to_or_name(p: Path, base: Path) -> Path:
    try:
        return p.relative_to(base)
    except Exception:
        return Path(p.name)


def run_mode(mode: str, input_dir: Path, input_files: List[Path], out_root: Path, excel_root: Path) -> Tuple[Path, Dict[str, Path]]:
    smt_files = input_files

    prepared_root = out_root / mode
    results: List[Dict] = []
    prepared_dirs: Dict[str, Path] = {}

    for solver in SUPPORTED_SOLVERS:
        snippet, tag = read_snippet(mode, solver)
        if not snippet and tag == "none":
            # no snippet available for this solver; skip with warning-like row per file
            for src in smt_files:
                rel = _relative_to_or_name(src, input_dir)
                dst = prepared_root / solver / rel
                row = {
                    'file_name': src.name,
                    'result': 'SKIPPED',
                    'sat_result': '',
                    'solving_time': 0.0,
                    'solver_type': solver,
                    'timeout': '',
                    'path': str(dst),
                    'task': f'baseline_{mode}',
                    'exit_code': 'NO_SNIPPET',
                    'solver_output': 'no snippet found',
                }
                results.append(row)
            continue

        # record solver output dir for this run scope
        solver_out_dir = prepared_root / solver
        prepared_dirs[solver] = solver_out_dir

        for src in smt_files:
            rel = _relative_to_or_name(src, input_dir)
            dst = solver_out_dir / rel
            ok, stats, err = process_file(src, dst, snippet)
            row = {
                'file_name': src.name,
                'result': 'PREPARED' if ok else 'ERROR',
                'sat_result': '',
                'solving_time': 0.0,
                'solver_type': solver,
                'timeout': '',
                'path': str(dst if ok else src),
                'task': f'baseline_{mode}',
                'exit_code': '' if ok else 'PREPARE_ERROR',
                'solver_output': f"lines_inserted:{stats.get('lines_inserted',0)}; replacements:{stats.get('replacements',0)}" if ok else err,
            }
            results.append(row)

    # Excel output per mode
    excel_root.mkdir(parents=True, exist_ok=True)
    excel_path = excel_root / f"baseline_{mode}_analysis.xlsx"
    write_excel(results, excel_path, f"baseline_{mode}")
    return excel_path, prepared_dirs


def parse_args():
    p = argparse.ArgumentParser(description='Prepare baseline temporary SMT2 files and Excel summaries (no solving).')
    p.add_argument('--modes', default='UF,RA,REC', help='Comma-separated modes to run (default: UF,RA,REC)')
    p.add_argument('--input-root', default='benchmarks', help='Root directory to recursively scan for SMT2 files when per-mode dirs are not provided (default: benchmarks)')
    p.add_argument('--dir-UF', dest='dir_UF', default=None, help='Benchmark directory for UF mode')
    p.add_argument('--dir-RA', dest='dir_RA', default=None, help='Benchmark directory for RA mode')
    p.add_argument('--dir-REC', dest='dir_REC', default=None, help='Benchmark directory for REC mode')
    p.add_argument('--file', dest='single_file', default=None, help='Process a single SMT2 file (overrides directories)')
    p.add_argument('--out-dir', default='results/baseline_prepared', help='Output root for prepared files')
    p.add_argument('--excel-dir', default='charts/outs', help='Directory to write Excel files')
    p.add_argument('--dry-run', action='store_true', help='Only scan inputs and check snippets, do not write files')
    # run options (execute solvers on prepared inputs)
    p.add_argument('--run', action='store_true', help='After preparing files, run solvers on prepared inputs and aggregate results to XLSX')
    p.add_argument('--solver-script', default='baselines/scripts/run_external_solver.sh', help='Path to solver executable/script (default: baselines/scripts/run_external_solver.sh)')
    p.add_argument('--timeout', type=int, default=60, help='Timeout seconds per file when running (default: 60)')
    p.add_argument('--parallel', type=int, default=0, help='Parallel processes for solve_batch.sh (default: CPU cores)')
    return p.parse_args()


def main():
    args = parse_args()

    modes = [m.strip() for m in args.modes.split(',') if m.strip()]
    for m in modes:
        if m not in SUPPORTED_MODES:
            print(f"[ERROR] Unsupported mode: {m}")
            return 1

    # Determine directories per mode
    # Priority: explicit --dir-<MODE> > --input-root
    mode_to_dir: Dict[str, Path] = {}
    input_root = Path(args.input_root) if args.input_root else None

    if 'UF' in modes:
        mode_to_dir['UF'] = Path(args.dir_UF) if args.dir_UF else input_root
    if 'RA' in modes:
        mode_to_dir['RA'] = Path(args.dir_RA) if args.dir_RA else input_root
    if 'REC' in modes:
        mode_to_dir['REC'] = Path(args.dir_REC) if args.dir_REC else input_root

    # Check inputs
    for m, d in mode_to_dir.items():
        if d is None:
            print(f"[ERROR] No input directory specified for {m} (provide --dir-{m} or --input-root)")
            return 1
        if not d.exists() or not d.is_dir():
            print(f"[ERROR] Input directory does not exist for {m}: {d}")
            return 1

    # Inform about snippet availability per solver
    for m in modes:
        mode_dir = SNIPPET_ROOT / m
        available = []
        for s in SUPPORTED_SOLVERS:
            if (mode_dir / f"{s}.txt").exists():
                available.append(s)
        if available:
            print(f"[INFO] Mode {m} available snippets: {', '.join(available)}")
        else:
            print(f"[WARN] Mode {m} has no solver snippets under {mode_dir}")

    if args.dry_run:
        print('[INFO] Dry-run complete. No files written.')
        return 0

    out_root = Path(args.out_dir)
    excel_root = Path(args.excel_dir) / 'baseline'

    mode_to_prepared_dirs: Dict[str, Dict[str, Path]] = {}
    for m in modes:
        # Determine input files list for this mode
        input_dir = mode_to_dir[m]
        if args.single_file:
            src = Path(args.single_file)
            if not src.exists() or not src.is_file():
                print(f"[ERROR] Single file not found: {src}")
                return 1
            files = [src]
        else:
            files = collect_smt_files(input_dir)
        if not files:
            print(f"[WARN] No SMT2 files found for mode {m} in {input_dir}")
        excel_path, prepared_dirs = run_mode(m, input_dir, files, out_root, excel_root)
        mode_to_prepared_dirs[m] = prepared_dirs

    print('[INFO] Baseline preparation completed.')
    # Optionally run solvers on prepared files and aggregate results
    if not args.run:
        return 0

    solve_batch = Path('scripts/solve/solve_batch.sh')
    analysis_py = Path('scripts/solve/simple_analysis.py')
    if not solve_batch.exists():
        print(f"[ERROR] Missing script: {solve_batch}")
        return 1
    if not analysis_py.exists():
        print(f"[ERROR] Missing analysis script: {analysis_py}")
        return 1

    results_dir = Path('results') / 'baseline'
    results_dir.mkdir(parents=True, exist_ok=True)
    charts_dir = Path(args.excel_dir) / 'baseline'
    charts_dir.mkdir(parents=True, exist_ok=True)

    # For each mode: run 4 solvers only on directories prepared in this run, then merge to one log and build one XLSX
    for m in modes:
        per_solver_logs: List[Path] = []
        for s in SUPPORTED_SOLVERS:
            solver_dir = mode_to_prepared_dirs.get(m, {}).get(s)
            if not solver_dir.exists():
                print(f"[WARN] No prepared inputs for {m}/{s}, skipping run")
                continue
            # If directory exists but empty, skip
            has_files = any(solver_dir.rglob('*.smt2'))
            if not has_files:
                print(f"[WARN] No SMT2 files under {solver_dir}, skipping run")
                continue

            out_file = results_dir / f"baseline_{m}_{s}.log"
            cmd = [
                'bash', str(solve_batch),
                '-i', str(solver_dir),
                '-o', str(results_dir),
                '-f', out_file.name,
                '-s', str(args.solver_script),
                '--solver', s,
                '-t', str(args.timeout)
            ]
            if args.parallel and args.parallel > 0:
                cmd += ['-p', str(args.parallel)]
            cmd += ['-n', f'baseline_{m}_{s}']

            print(f"[INFO] Running: {' '.join(shlex.quote(c) for c in cmd)}")
            try:
                subprocess.run(cmd, check=True)
                per_solver_logs.append(out_file)
            except subprocess.CalledProcessError as e:
                print(f"[ERROR] solve_batch failed for {m}/{s}: {e}")

        # Merge logs and analyze
        merged_log = results_dir / f"baseline_{m}_merged.log"
        with open(merged_log, 'w', encoding='utf-8') as w:
            for lf in per_solver_logs:
                if lf.exists():
                    with open(lf, 'r', encoding='utf-8', errors='ignore') as r:
                        w.write(r.read())
                        if not w.tell() or w.tell() > 0:
                            w.write('\n')

        if merged_log.exists():
            excel_out = charts_dir / f"baseline_{m}_analysis.xlsx"
            cmd_analysis = [
                sys.executable, str(analysis_py),
                '--log-file', str(merged_log),
                '--output-dir', str(charts_dir),
                '--task-name', f'baseline_{m}'
            ]
            print(f"[INFO] Analyzing: {' '.join(shlex.quote(c) for c in cmd_analysis)}")
            try:
                subprocess.run(cmd_analysis, check=True)
            except subprocess.CalledProcessError as e:
                print(f"[ERROR] analysis failed for {m}: {e}")

    print('[INFO] Baseline run & analysis completed.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
