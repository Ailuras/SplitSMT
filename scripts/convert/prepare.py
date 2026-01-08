#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import re
import sys
from pathlib import Path
from typing import List, Dict, Tuple, Optional

class Colors:
    RESET = '\033[0m'
    BOLD = '\033[1m'
    GREEN = '\033[32m'
    RED = '\033[31m'
    YELLOW = '\033[33m'
    BLUE = '\033[34m'
    CYAN = '\033[36m'
    MAGENTA = '\033[35m'

def colored(text: str, color: str) -> str:
    if sys.stdout.isatty():
        return f"{color}{text}{Colors.RESET}"
    return text

# Configuration: where to read snippet templates
# Place your txt snippets here per mode+solver, e.g. scripts/convert/configs/UF/z3.txt
SCRIPT_DIR = Path(__file__).resolve().parent
SNIPPET_ROOT = SCRIPT_DIR / "configs"
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


def _relative_to_or_name(p: Path, base: Path) -> Path:
    try:
        return p.relative_to(base)
    except Exception:
        return Path(p.name)


def run_mode(mode: str, input_dir: Path, input_files: List[Path], out_root: Path) -> Dict:
    smt_files = input_files
    stats_summary = {
        'mode': mode,
        'total_files': len(smt_files),
        'solvers': {},
        'prepared': 0,
        'errors': 0,
        'skipped': 0
    }
    for solver in SUPPORTED_SOLVERS:
        snippet, tag = read_snippet(mode, solver)
        solver_stats = {
            'prepared': 0,
            'errors': 0,
            'skipped': 0,
            'total_replacements': 0,
            'total_lines_inserted': 0
        }
        if not snippet and tag == "none":
            for src in smt_files:
                solver_stats['skipped'] += 1
                stats_summary['skipped'] += 1
            stats_summary['solvers'][solver] = solver_stats
            continue
        solver_out_dir = out_root / solver / mode
        for src in smt_files:
            rel = _relative_to_or_name(src, input_dir)
            dst = solver_out_dir / rel
            ok, stats, err = process_file(src, dst, snippet)
            if ok:
                solver_stats['prepared'] += 1
                solver_stats['total_replacements'] += stats.get('replacements', 0)
                solver_stats['total_lines_inserted'] += stats.get('lines_inserted', 0)
                stats_summary['prepared'] += 1
            else:
                solver_stats['errors'] += 1
                stats_summary['errors'] += 1
        stats_summary['solvers'][solver] = solver_stats
    return stats_summary


def parse_args():
    p = argparse.ArgumentParser(description='Prepare baseline SMT2 files by inserting solver-specific configurations.')
    p.add_argument('--input', '-i', required=True, help='Input file or directory (supports single .smt2 file or directory containing .smt2 files)')
    p.add_argument('--output', '-o', default=None, help='Output root directory for prepared files (default: input directory)')
    p.add_argument('--modes', default='UF,RA,REC', help='Comma-separated modes to run (default: UF,RA,REC)')
    p.add_argument('--dry-run', action='store_true', help='Only scan inputs and check snippets, do not write files')
    return p.parse_args()


def print_results_summary(all_stats: List[Dict]):
    print()
    print(colored("=" * 70, Colors.BOLD))
    print(colored("Processing Summary", Colors.BOLD + Colors.CYAN))
    print(colored("=" * 70, Colors.BOLD))
    
    total_files = 0
    total_prepared = 0
    total_errors = 0
    total_skipped = 0
    
    for stats in all_stats:
        mode = stats['mode']
        total_files += stats['total_files']
        total_prepared += stats['prepared']
        total_errors += stats['errors']
        total_skipped += stats['skipped']
        
        print()
        print(colored(f"Mode: {mode}", Colors.BOLD + Colors.MAGENTA))
        print(f"  Total files: {colored(str(stats['total_files']), Colors.CYAN)}")
        print(f"  {colored('✓ Prepared:', Colors.GREEN)} {colored(str(stats['prepared']), Colors.GREEN)}")
        if stats['errors'] > 0:
            print(f"  {colored('✗ Errors:', Colors.RED)} {colored(str(stats['errors']), Colors.RED)}")
        if stats['skipped'] > 0:
            print(f"  {colored('⊘ Skipped:', Colors.YELLOW)} {colored(str(stats['skipped']), Colors.YELLOW)}")
        
        if stats['solvers']:
            print(colored("  Solvers:", Colors.BLUE))
            for solver, s_stats in stats['solvers'].items():
                status_icon = colored("✓", Colors.GREEN) if s_stats['prepared'] > 0 else colored("⊘", Colors.YELLOW)
                print(f"    {status_icon} {solver}:")
                if s_stats['prepared'] > 0:
                    print(f"       Prepared: {colored(str(s_stats['prepared']), Colors.GREEN)} files")
                    print(f"       Lines inserted: {colored(str(s_stats['total_lines_inserted']), Colors.CYAN)}")
                    print(f"       Replacements: {colored(str(s_stats['total_replacements']), Colors.CYAN)}")
                if s_stats['errors'] > 0:
                    print(f"       Errors: {colored(str(s_stats['errors']), Colors.RED)}")
                if s_stats['skipped'] > 0:
                    print(f"       Skipped: {colored(str(s_stats['skipped']), Colors.YELLOW)}")
        
    print()
    print(colored("=" * 70, Colors.BOLD))
    print(colored("Overall Statistics", Colors.BOLD + Colors.CYAN))
    print(colored("=" * 70, Colors.BOLD))
    print(f"Total files processed: {colored(str(total_files), Colors.CYAN)}")
    print(f"{colored('✓ Successfully prepared:', Colors.GREEN)} {colored(str(total_prepared), Colors.GREEN)}")
    if total_errors > 0:
        print(f"{colored('✗ Errors:', Colors.RED)} {colored(str(total_errors), Colors.RED)}")
    if total_skipped > 0:
        print(f"{colored('⊘ Skipped:', Colors.YELLOW)} {colored(str(total_skipped), Colors.YELLOW)}")
    print()


def main():
    args = parse_args()

    modes = [m.strip() for m in args.modes.split(',') if m.strip()]
    for m in modes:
        if m not in SUPPORTED_MODES:
            print(colored(f"[ERROR] Unsupported mode: {m}", Colors.RED))
            return 1

    input_path = Path(args.input)
    if not input_path.exists():
        print(colored(f"[ERROR] Input path does not exist: {input_path}", Colors.RED))
        return 1

    input_files: List[Path] = []
    input_dir: Optional[Path] = None
    
    if input_path.is_file():
        if input_path.suffix != '.smt2':
            print(colored(f"[ERROR] Input file must be a .smt2 file: {input_path}", Colors.RED))
            return 1
        input_files = [input_path]
        input_dir = input_path.parent
        print(colored(f"[INFO] Processing single file: {input_path}", Colors.BLUE))
    elif input_path.is_dir():
        input_files = collect_smt_files(input_path)
        input_dir = input_path
        print(colored(f"[INFO] Found {len(input_files)} SMT2 files in directory: {input_path}", Colors.BLUE))
    else:
        print(colored(f"[ERROR] Input path is neither a file nor a directory: {input_path}", Colors.RED))
        return 1

    if not input_files:
        print(colored("[WARN] No SMT2 files found to process", Colors.YELLOW))
        return 0

    for m in modes:
        mode_dir = SNIPPET_ROOT / m
        available = []
        for s in SUPPORTED_SOLVERS:
            if (mode_dir / f"{s}.txt").exists():
                available.append(s)
        if available:
            print(colored(f"[INFO] Mode {m} available snippets: {', '.join(available)}", Colors.CYAN))
        else:
            print(colored(f"[WARN] Mode {m} has no solver snippets under {mode_dir}", Colors.YELLOW))

    if args.dry_run:
        print(colored('[INFO] Dry-run complete. No files written.', Colors.YELLOW))
        return 0

    out_root = Path(args.output) if args.output else input_dir
    all_stats: List[Dict] = []
    for m in modes:
        print(colored(f"\n[INFO] Processing mode: {m}", Colors.BOLD + Colors.MAGENTA))
        stats = run_mode(m, input_dir, input_files, out_root)
        all_stats.append(stats)

    print_results_summary(all_stats)
    print(colored('[INFO] Baseline preparation completed.', Colors.GREEN + Colors.BOLD))
    return 0


if __name__ == '__main__':
    sys.exit(main())
