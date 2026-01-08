#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Normalize SMT-LIB files by removing specific commands.
This script is mainly responsible for deleting (get-model) from SMT files.
"""

import argparse
import sys
from pathlib import Path
from typing import List, Tuple

class Colors:
    RESET = '\033[0m'
    BOLD = '\033[1m'
    GREEN = '\033[32m'
    RED = '\033[31m'
    YELLOW = '\033[33m'
    BLUE = '\033[34m'
    CYAN = '\033[36m'

def colored(text: str, color: str) -> str:
    """Return colored text if terminal supports it."""
    if sys.stdout.isatty():
        return f"{color}{text}{Colors.RESET}"
    return text

def normalize_content(content: List[str]) -> Tuple[List[str], dict]:
    """
    Normalize SMT-LIB content:
    1. Truncate file at the first (pop) command (inclusive).
    2. Remove (push) and (get-model) commands from the retained content.
    3. Ensure (check-sat) is present (if missing, add it before exit).
    4. Ensure (exit) is present at the end.
    
    Returns: (normalized_lines, statistics)
    """
    stats = {
        "get_model_removed": 0,
        "push_removed": 0,
        "pop_truncated": False,
        "check_sat_added": 0,
        "exit_added": 0
    }
    
    if not content:
        return [], stats
    
    # 1. Truncate at first pop
    truncated_content = []
    found_pop = False
    for line in content:
        if "(pop" in line:
            found_pop = True
            stats["pop_truncated"] = True
            break
        truncated_content.append(line)
        
    # 2. Filter push and get-model
    filtered_lines = []
    for line in truncated_content:
        # Check for (get-model)
        if "(get-model)" in line:
            stats["get_model_removed"] += 1
            continue
        # Check for (push)
        if "(push" in line:
            stats["push_removed"] += 1
            continue
            
        filtered_lines.append(line)
    
    # 3 & 4. Ensure check-sat and exit
    final_lines = list(filtered_lines)
    
    # Check if we already have them
    has_check_sat = any("(check-sat)" in line for line in final_lines)
    has_exit = any("(exit)" in line for line in final_lines)
    
    if not has_check_sat:
        if has_exit:
            # Insert before the first exit
            for i, line in enumerate(final_lines):
                if "(exit)" in line:
                    final_lines.insert(i, "(check-sat)")
                    stats["check_sat_added"] += 1
                    break
        else:
            final_lines.append("(check-sat)")
            stats["check_sat_added"] += 1
            
    if not has_exit:
        final_lines.append("(exit)")
        stats["exit_added"] += 1
    
    return final_lines, stats

def process_file(src_path: Path, dst_path: Path) -> Tuple[bool, dict, str]:
    """Process a single SMT2 file."""
    try:
        # Read source file
        with open(src_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read().splitlines()
        
        # Transform content
        normalized, stats = normalize_content(content)
        
        # Write to destination
        dst_path.parent.mkdir(parents=True, exist_ok=True)
        with open(dst_path, "w", encoding="utf-8") as f:
            f.write("\n".join(normalized) + "\n")
        
        return True, stats, ""
    except Exception as e:
        return False, {}, str(e)

def collect_smt_files(input_dir: Path) -> List[Path]:
    """Recursively collect all .smt2 files."""
    return sorted(input_dir.rglob("*.smt2"))

def relative_to_or_name(p: Path, base: Path) -> Path:
    """Get relative path or just filename if not relative."""
    try:
        return p.relative_to(base)
    except ValueError:
        return Path(p.name)

def parse_args():
    parser = argparse.ArgumentParser(
        description='Normalize SMT-LIB files (e.g., remove get-model).'
    )
    parser.add_argument(
        '--input', '-i', required=True,
        help='Input file or directory (supports single .smt2 file or directory containing .smt2 files)'
    )
    parser.add_argument(
        '--output', '-o', default=None,
        help='Output file or directory (default: overwrite input)'
    )
    parser.add_argument(
        '--dry-run', action='store_true',
        help='Only scan inputs and show what would be done, do not write files'
    )
    return parser.parse_args()

def main():
    args = parse_args()
    
    # Check input path
    input_path = Path(args.input)
    if not input_path.exists():
        print(colored(f"[ERROR] Input path does not exist: {input_path}", Colors.RED))
        return 1
    
    # Determine input/output mode
    is_single_file = input_path.is_file()
    
    if is_single_file:
        # Single file mode
        if input_path.suffix != '.smt2':
            print(colored(f"[ERROR] Input file must be a .smt2 file: {input_path}", Colors.RED))
            return 1
        
        # Determine output path
        if args.output:
            output_path = Path(args.output)
            print(colored(f"[INFO] Input file:  {input_path}", Colors.BLUE))
            print(colored(f"[INFO] Output file: {output_path}", Colors.BLUE))
        else:
            # Default: overwrite input
            output_path = input_path
            print(colored(f"[INFO] Processing file: {input_path}", Colors.BLUE))
        
        if args.dry_run:
            print(colored('[INFO] Dry-run complete. No files written.', Colors.YELLOW))
            return 0
        
        # Process single file
        success, stats, error = process_file(input_path, output_path)
        
        if success:
            print(colored(f"[SUCCESS] File normalized successfully!", Colors.GREEN))
            print(f"  (get-model) removed: {stats['get_model_removed']}")
            print(f"  (push) removed:      {stats['push_removed']}")
            print(f"  Truncated at (pop):  {'Yes' if stats['pop_truncated'] else 'No'}")
            print(f"  (check-sat) added:   {stats['check_sat_added']}")
            print(f"  (exit) added:        {stats['exit_added']}")
        else:
            print(colored(f"[ERROR] Failed to process file: {error}", Colors.RED))
            return 1
    
    elif input_path.is_dir():
        # Directory mode
        input_files = collect_smt_files(input_path)
        
        if not input_files:
            print(colored(f"[WARN] No .smt2 files found in: {input_path}", Colors.YELLOW))
            return 0
        
        print(colored(f"[INFO] Found {len(input_files)} .smt2 files in: {input_path}", Colors.BLUE))
        
        # Determine output directory
        if args.output:
            output_dir = Path(args.output)
            print(colored(f"[INFO] Output directory: {output_dir}", Colors.BLUE))
        else:
            output_dir = input_path  # Same directory
            print(colored(f"[INFO] Processing directory in-place: {output_dir}", Colors.BLUE))
        
        if args.dry_run:
            print(colored('[INFO] Dry-run complete. No files written.', Colors.YELLOW))
            return 0
        
        # Process all files
        total_stats = {
            "total": len(input_files),
            "success": 0,
            "failed": 0,
            "get_model_removed": 0,
            "push_removed": 0,
            "pop_truncated": 0,
            "check_sat_added": 0,
            "exit_added": 0
        }
        
        for src_file in input_files:
            rel_path = relative_to_or_name(src_file, input_path)
            dst_file = output_dir / rel_path
            
            success, stats, error = process_file(src_file, dst_file)
            
            if success:
                total_stats["success"] += 1
                total_stats["get_model_removed"] += stats["get_model_removed"]
                total_stats["push_removed"] += stats["push_removed"]
                if stats["pop_truncated"]:
                    total_stats["pop_truncated"] += 1
                total_stats["check_sat_added"] += stats["check_sat_added"]
                total_stats["exit_added"] += stats["exit_added"]
                print(colored(f"  ✓ {rel_path}", Colors.GREEN))
            else:
                total_stats["failed"] += 1
                print(colored(f"  ✗ {rel_path}: {error}", Colors.RED))
        
        # Print summary
        print()
        print(colored("=" * 70, Colors.BOLD))
        print(colored("Normalization Summary", Colors.BOLD + Colors.CYAN))
        print(colored("=" * 70, Colors.BOLD))
        print(f"Total files:           {colored(str(total_stats['total']), Colors.CYAN)}")
        print(f"Successfully normalized: {colored(str(total_stats['success']), Colors.GREEN)}")
        if total_stats['failed'] > 0:
            print(f"Failed:                {colored(str(total_stats['failed']), Colors.RED)}")
        print(f"Total (get-model) removed: {colored(str(total_stats['get_model_removed']), Colors.CYAN)}")
        print(f"Total (push) removed:      {colored(str(total_stats['push_removed']), Colors.CYAN)}")
        print(f"Total files truncated:     {colored(str(total_stats['pop_truncated']), Colors.CYAN)}")
        print(f"Total (check-sat) added:   {colored(str(total_stats['check_sat_added']), Colors.CYAN)}")
        print(f"Total (exit) added:        {colored(str(total_stats['exit_added']), Colors.CYAN)}")
        print()
        
        if total_stats['failed'] > 0:
            print(colored('[WARNING] Some files failed to normalize.', Colors.YELLOW))
            return 1
        else:
            print(colored('[SUCCESS] All files normalized successfully!', Colors.GREEN + Colors.BOLD))
    
    else:
        print(colored(f"[ERROR] Input path is neither a file nor a directory: {input_path}", Colors.RED))
        return 1
    
    return 0

if __name__ == '__main__':
    sys.exit(main())
