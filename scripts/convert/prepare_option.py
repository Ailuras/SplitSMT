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

# Configuration
SCRIPT_DIR = Path(__file__).resolve().parent
SNIPPET_ROOT = SCRIPT_DIR / "configs"
SUPPORTED_MODES = ["UF", "RA", "REC"]

# Default solvers if not provided via arguments
DEFAULT_SOLVERS = ["z3", "z3-noodler", "ostrich", "cvc5", "bitwuzla"]

# Options configuration for Model generation
# If these are missing in the source file, they will be added with these values.
REQUIRED_MODEL_OPTIONS = {
    ":produce-assertions": "true",
    ":produce-assignments": "true",
    ":produce-models": "true",
    ":produce-proofs": "true",
    ":produce-unsat-assumptions": "true",
    ":produce-unsat-cores": "true",
    ":random-seed": "42"
}

def read_snippet(mode: str, solver: str) -> Tuple[List[str], str]:
    """Read snippet lines for a given mode and solver."""
    mode_dir = SNIPPET_ROOT / mode
    path = mode_dir / f"{solver}.txt"
    
    # Try specific solver snippet
    if path.exists():
        try:
            with open(path, "r", encoding="utf-8") as f:
                lines = [line.rstrip("\n") for line in f.readlines()]
            while lines and lines[-1] == "":
                lines.pop()
            return lines, solver
        except Exception:
            pass # Fall through to default
            
    # Fallback to default.txt
    fallback = mode_dir / "default.txt"
    if fallback.exists():
        try:
            with open(fallback, "r", encoding="utf-8") as f:
                lines = [line.rstrip("\n") for line in f.readlines()]
            while lines and lines[-1] == "":
                lines.pop()
            return lines, "default"
        except Exception:
            pass
            
    return [], "none"

def clean_and_transform_content(content: List[str], snippet_lines: List[str]) -> Tuple[List[str], List[str], Dict[str, int]]:
    """
    Process content:
    1. Remove comments (lines starting with ;) and (exit).
    2. Insert snippets and perform str replacements.
    3. FILTER: Remove uninterpreted functions that have input arguments.
    4. Generate two versions: 
       - MODEL: Includes (get-model) AND enforces required set-options if missing.
       - NOM: NO (get-model), removes ALL set-options.
    
    Returns: (lines_model, lines_nom, stats)
    """
    stats = {"lines_inserted": 0, "replacements": 0}

    if not content:
        return [], [], stats
    
    # --- Step 1: Pre-cleaning (Remove comments and exit) ---
    cleaned_source = []
    for line in content:
        stripped = line.strip()
        # Remove comment lines
        if stripped.startswith(";"):
            continue
        # Remove (exit) lines
        if "(exit)" in stripped:
            line = line.replace("(exit)", "")
            if not line.strip():
                continue
        
        # Also remove existing (get-model) to standardize later
        if "(get-model)" in stripped:
             line = line.replace("(get-model)", "")
             if not line.strip():
                 continue
                 
        cleaned_source.append(line)

    # --- Step 2: Logic Insertion & Splitting ---
    
    # Find set-logic to split content
    insert_pos = next((i for i, line in enumerate(cleaned_source) if "set-logic" in line), -1)
    
    pre_logic = []
    logic_part = []
    post_logic = []

    if insert_pos >= 0:
        pre_logic = cleaned_source[:insert_pos]
        # Standardize set-logic
        logic_part = ["(set-logic ALL)"]
        post_logic = cleaned_source[insert_pos+1:]
    else:
        logic_part = ["(set-logic ALL)"]
        post_logic = cleaned_source

    # Separate existing set-options from the rest of the body
    existing_option_lines = []
    other_lines = []
    
    for line in post_logic:
        if "set-option" in line:
            existing_option_lines.append(line)
        else:
            other_lines.append(line)

    # --- Step 3: Transform Body (Filter UFs & Replace str.split) ---
    pat_split = re.compile(r"\(\s*str\.split")
    pat_num_splits = re.compile(r"\(\s*str\.num_splits")
    
    # REGEX: Matches (declare-fun name (ARGS) type)
    # capture group 1 is the content of ARGS
    pat_decl_fun_args = re.compile(r'\(\s*declare-fun\s+.+?\s*\(([^)]*)\)')
    
    processed_body = []
    for line in other_lines:
        # -- Filter Logic --
        # Check if this is a declare-fun with arguments
        m_decl = pat_decl_fun_args.search(line)
        if m_decl:
            args_content = m_decl.group(1)
            # If the parenthesis content has any non-whitespace characters,
            # it means it takes inputs (e.g., (Int Int)). We remove it.
            # If it is empty or just whitespace (e.g., ()), it is a variable. We keep it.
            if args_content.strip():
                continue

        # -- String Replacements --
        def _repl_split(m): return m.group(0).replace("str.", "")
        def _repl_num(m): return m.group(0).replace("str.", "")
        
        new_line, c1 = pat_split.subn(_repl_split, line)
        new_line, c2 = pat_num_splits.subn(_repl_num, new_line)
        stats["replacements"] += (c1 + c2)
        processed_body.append(new_line)

    # --- Step 4: Construct Output Versions ---

    # === Construct MODEL Version ===
    # Logic: pre_logic -> set-logic ALL -> existing options -> missing options -> snippets -> body -> get-model
    
    model_options_block = list(existing_option_lines)
    
    # Identify which options are already present
    present_keys = set()
    for line in existing_option_lines:
        for key in REQUIRED_MODEL_OPTIONS.keys():
            if key in line:
                present_keys.add(key)
    
    # Append missing options
    for key, val in REQUIRED_MODEL_OPTIONS.items():
        if key not in present_keys:
            model_options_block.append(f"(set-option {key} {val})")
            
    lines_model = []
    lines_model.extend(pre_logic)
    lines_model.extend(logic_part)
    lines_model.extend(model_options_block) # Add combined options
    if snippet_lines:
        lines_model.extend(snippet_lines)
        stats["lines_inserted"] = len(snippet_lines)
    lines_model.extend(processed_body)
    
    # Clean up trailing empty lines before appending get-model
    while lines_model and not lines_model[-1].strip():
        lines_model.pop()
    lines_model.append("(get-model)")

    # === Construct NOM Version ===
    # Logic: pre_logic -> set-logic ALL -> snippets -> body (NO OPTIONS, NO get-model)
    
    lines_nom = []
    lines_nom.extend(pre_logic)
    lines_nom.extend(logic_part)
    # Skip existing_option_lines entirely!
    # Skip adding new options!
    if snippet_lines:
        lines_nom.extend(snippet_lines)
    lines_nom.extend(processed_body)
    
    # Clean up trailing empty lines
    while lines_nom and not lines_nom[-1].strip():
        lines_nom.pop()
    
    return lines_model, lines_nom, stats

def process_file_dual_output(src_path: Path, 
                             dst_model: Path, 
                             dst_nom: Path, 
                             snippet_lines: List[str]) -> Tuple[bool, Dict[str, int], str]:
    """Read src, transform, write to both dst_model and dst_nom."""
    try:
        with open(src_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read().splitlines()
        
        lines_model, lines_nom, stats = clean_and_transform_content(content, snippet_lines)
        
        # Write Model version
        dst_model.parent.mkdir(parents=True, exist_ok=True)
        with open(dst_model, "w", encoding="utf-8") as f:
            f.write("\n".join(lines_model) + "\n")
            
        # Write Nom version
        dst_nom.parent.mkdir(parents=True, exist_ok=True)
        with open(dst_nom, "w", encoding="utf-8") as f:
            f.write("\n".join(lines_nom) + "\n")
            
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

def run_mode(mode: str, input_dir: Path, input_files: List[Path], out_root: Path, solvers: List[str]) -> Dict:
    stats_summary = {
        'mode': mode,
        'total_files': len(input_files),
        'solvers': {},
        'prepared': 0,
        'errors': 0,
        'skipped': 0
    }
    
    for solver in solvers:
        snippet, tag = read_snippet(mode, solver)
        solver_stats = {
            'prepared': 0,
            'errors': 0,
            'skipped': 0,
            'total_replacements': 0,
            'total_lines_inserted': 0
        }
        
        if not snippet and tag == "none":
            for _ in input_files:
                solver_stats['skipped'] += 1
                stats_summary['skipped'] += 1
            stats_summary['solvers'][solver] = solver_stats
            continue

        # Define Output Paths
        base_out_model = out_root / solver / "model" / mode
        base_out_nom = out_root / solver / "nom" / mode

        for src in input_files:
            rel = _relative_to_or_name(src, input_dir)
            
            dst_model = base_out_model / rel
            dst_nom = base_out_nom / rel
            
            ok, stats, err = process_file_dual_output(src, dst_model, dst_nom, snippet)
            
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
    p = argparse.ArgumentParser(description='Prepare baseline SMT2 files (model & nom versions) with cleaning and config insertion.')
    p.add_argument('--input', '-i', required=True, help='Input file or directory (supports single .smt2 file or directory)')
    p.add_argument('--output', '-o', default=None, help='Output root directory (default: input directory)')
    p.add_argument('--modes', default='UF,RA,REC', help='Comma-separated modes to run (default: UF,RA,REC)')
    p.add_argument('--solvers', default=None, help='Comma-separated list of solvers (default: z3,z3-noodler,ostrich,cvc5)')
    p.add_argument('--dry-run', action='store_true', help='Only scan inputs and check snippets, do not write files')
    return p.parse_args()

def print_results_summary(all_stats: List[Dict]):
    print()
    print(colored("=" * 70, Colors.BOLD))
    print(colored("Processing Summary", Colors.BOLD + Colors.CYAN))
    print(colored("=" * 70, Colors.BOLD))
    
    for stats in all_stats:
        mode = stats['mode']
        print()
        print(colored(f"Mode: {mode}", Colors.BOLD + Colors.MAGENTA))
        print(f"  Input files processed: {colored(str(stats['total_files']), Colors.CYAN)}")
        
        if stats['solvers']:
            for solver, s_stats in stats['solvers'].items():
                status_icon = colored("✓", Colors.GREEN) if s_stats['prepared'] > 0 else colored("⊘", Colors.YELLOW)
                print(f"    {status_icon} {colored(solver, Colors.BOLD)}:")
                if s_stats['prepared'] > 0:
                    print(f"       Generated pairs (model/nom): {colored(str(s_stats['prepared']), Colors.GREEN)}")
                    print(f"       Replacements/file (avg): {s_stats['total_replacements'] // s_stats['prepared']}")
                if s_stats['errors'] > 0:
                    print(f"       Errors: {colored(str(s_stats['errors']), Colors.RED)}")
                if s_stats['skipped'] > 0:
                    print(f"       Skipped: {colored(str(s_stats['skipped']), Colors.YELLOW)}")
        
    print()
    print(colored(f"Output Structure created:", Colors.BLUE))
    print(f"  root/ {colored('model', Colors.GREEN)} / mode / solver / ... (Contains (get-model) + required options)")
    print(f"  root/ {colored('nom', Colors.YELLOW)}    / mode / solver / ... (No (get-model), NO options)")
    print(colored("=" * 70, Colors.BOLD))

def main():
    args = parse_args()

    # Parse Modes
    modes = [m.strip() for m in args.modes.split(',') if m.strip()]
    for m in modes:
        if m not in SUPPORTED_MODES:
            print(colored(f"[ERROR] Unsupported mode: {m}", Colors.RED))
            return 1

    # Parse Solvers
    if args.solvers:
        target_solvers = [s.strip() for s in args.solvers.split(',') if s.strip()]
    else:
        target_solvers = DEFAULT_SOLVERS
        
    if not target_solvers:
        print(colored("[ERROR] No solvers specified.", Colors.RED))
        return 1

    # Check Input
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
        print(colored(f"[ERROR] Input path is neither a file nor a directory.", Colors.RED))
        return 1

    if not input_files:
        print(colored("[WARN] No SMT2 files found to process", Colors.YELLOW))
        return 0

    print(colored(f"[INFO] Target Solvers: {', '.join(target_solvers)}", Colors.CYAN))

    if args.dry_run:
        print(colored('[INFO] Dry-run complete. No files written.', Colors.YELLOW))
        return 0

    out_root = Path(args.output) if args.output else input_dir
    all_stats: List[Dict] = []
    
    for m in modes:
        print(colored(f"\n[INFO] Processing mode: {m}", Colors.BOLD + Colors.MAGENTA))
        stats = run_mode(m, input_dir, input_files, out_root, target_solvers)
        all_stats.append(stats)

    print_results_summary(all_stats)
    print(colored('[INFO] Preparation completed.', Colors.GREEN + Colors.BOLD))
    return 0


if __name__ == '__main__':
    sys.exit(main())