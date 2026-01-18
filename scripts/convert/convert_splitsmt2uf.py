#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Convert SMT-LIB files to UF (Uninterpreted Functions) format.
This script transforms string functions like str.split_at to UF declarations.
Only adds RE-related declarations if the file uses RE functions.
"""

import argparse
import re
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

# UF function declarations - base (non-RE)
UF_DECLARATIONS_BASE = [
    "(declare-fun split_at (String String Int) String)",
    "(declare-fun split_rest (String String Int) String)",
    "(declare-fun num_splits (String String) Int)"
]

# UF function declarations - RE variants
UF_DECLARATIONS_RE = [
    "(declare-fun split_at_re (String RegLan Int) String)",
    "(declare-fun split_rest_re (String RegLan Int) String)",
    "(declare-fun num_splits_re (String RegLan) Int)"
]

def uses_re_functions(content: List[str]) -> bool:
    """Check if the content uses any RE-related split functions."""
    content_str = '\n'.join(content)
    # Check for str.split_at_re, str.split_rest_re, str.num_splits_re
    re_patterns = [
        r'\bstr\.split_at_re\b',
        r'\bstr\.split_rest_re\b',
        r'\bstr\.num_splits_re\b',
    ]
    for pattern in re_patterns:
        if re.search(pattern, content_str):
            return True
    return False

def transform_to_uf(content: List[str]) -> Tuple[List[str], dict]:
    """
    Transform SMT-LIB content to UF format:
    1. Set logic to ALL
    2. Insert UF declarations after set-logic (only RE declarations if RE functions are used)
    3. Replace str.split_at -> split_at, str.split_rest -> split_rest, str.num_splits -> num_splits (and _re variants)
    4. Remove (exit) statements
    
    Returns: (transformed_lines, statistics)
    """
    stats = {
        "lines_inserted": 0,
        "replacements": 0,
        "exit_removed": 0
    }
    
    if not content:
        return [], stats
    
    out_lines = []
    
    # Process line by line - only remove (exit)
    for line in content:
        stripped = line.strip()
        
        # Remove (exit) lines
        if "(exit)" in stripped:
            stats["exit_removed"] += 1
            line = line.replace("(exit)", "")
            if not line.strip():
                continue
        
        out_lines.append(line)
    
    # Determine which declarations to insert
    has_re = uses_re_functions(content)
    declarations = UF_DECLARATIONS_BASE[:]
    if has_re:
        declarations.extend(UF_DECLARATIONS_RE)
    
    # Find set-logic position
    insert_pos = next((i for i, line in enumerate(out_lines) if "set-logic" in line), -1)
    
    result_lines = []
    
    if insert_pos >= 0:
        # Keep everything before set-logic
        result_lines.extend(out_lines[:insert_pos])
        # Replace set-logic with ALL
        result_lines.append("(set-logic ALL)")
        # Insert UF declarations
        result_lines.extend(declarations)
        stats["lines_inserted"] = len(declarations)
        # Add remaining content
        remaining = out_lines[insert_pos + 1:]
    else:
        # No set-logic found, add it at the beginning
        result_lines.append("(set-logic ALL)")
        result_lines.extend(declarations)
        stats["lines_inserted"] = len(declarations)
        remaining = out_lines
    
    # Replace str.split_at -> split_at, str.split_rest -> split_rest, str.num_splits -> num_splits
    # Also handle _re variants
    # Only replace when inside S-expression (after '(')
    pat_split_at = re.compile(r"\(\s*str\.split_at")
    pat_split_rest = re.compile(r"\(\s*str\.split_rest")
    pat_num_splits = re.compile(r"\(\s*str\.num_splits")
    
    for line in remaining:
        new_line = line
        
        # Replace (str.split_at -> (split_at for both straight and _re variants
        # because str.split_at matches str.split_at_re too if we are careful?
        # Actually str.split_at_re starts with str.split_at so replacing str. prefix handles both if we just strip str.
        
        # Replace (str.split_at -> (split_at
        new_line, c1 = pat_split_at.subn(
            lambda m: m.group(0).replace("str.", ""), new_line
        )
        # Replace (str.split_rest -> (split_rest
        new_line, c2 = pat_split_rest.subn(
            lambda m: m.group(0).replace("str.", ""), new_line
        )
        # Replace (str.num_splits -> (num_splits
        new_line, c3 = pat_num_splits.subn(
            lambda m: m.group(0).replace("str.", ""), new_line
        )
        
        stats["replacements"] += (c1 + c2 + c3)
        result_lines.append(new_line)
    
    return result_lines, stats

def process_file(src_path: Path, dst_path: Path) -> Tuple[bool, dict, str]:
    """Process a single SMT2 file."""
    try:
        # Read source file
        with open(src_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read().splitlines()
        
        # Transform content
        transformed, stats = transform_to_uf(content)
        
        # Write to destination
        dst_path.parent.mkdir(parents=True, exist_ok=True)
        with open(dst_path, "w", encoding="utf-8") as f:
            f.write("\n".join(transformed) + "\n")
        
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
        description='Convert SMT-LIB files to UF (Uninterpreted Functions) format.'
    )
    parser.add_argument(
        '--input', '-i', required=True,
        help='Input file or directory (supports single .smt2 file or directory containing .smt2 files)'
    )
    parser.add_argument(
        '--output', '-o', default=None,
        help='Output file or directory (default: <input>_uf for files, <input> for directories)'
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
    
    # Show UF declarations info
    print(colored(f"[INFO] Base UF declarations:", Colors.CYAN))
    for decl in UF_DECLARATIONS_BASE:
        print(f"  {decl}")
    print(colored(f"[INFO] RE UF declarations (added only if RE functions are used):", Colors.CYAN))
    for decl in UF_DECLARATIONS_RE:
        print(f"  {decl}")
    
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
        else:
            # Default: add _uf suffix before extension
            output_path = input_path.parent / f"{input_path.stem}_uf{input_path.suffix}"
        
        print(colored(f"[INFO] Input file:  {input_path}", Colors.BLUE))
        print(colored(f"[INFO] Output file: {output_path}", Colors.BLUE))
        
        if args.dry_run:
            print(colored('[INFO] Dry-run complete. No files written.', Colors.YELLOW))
            return 0
        
        # Process single file
        success, stats, error = process_file(input_path, output_path)
        
        if success:
            print(colored(f"[SUCCESS] File converted successfully!", Colors.GREEN))
            print(f"  Lines inserted: {stats['lines_inserted']}")
            print(f"  Replacements: {stats['replacements']}")
            print(f"  Exit statements removed: {stats['exit_removed']}")
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
        else:
            output_dir = input_path  # Same directory
        
        print(colored(f"[INFO] Output directory: {output_dir}", Colors.BLUE))
        
        if args.dry_run:
            print(colored('[INFO] Dry-run complete. No files written.', Colors.YELLOW))
            return 0
        
        # Process all files
        total_stats = {
            "total": len(input_files),
            "success": 0,
            "failed": 0,
            "lines_inserted": 0,
            "replacements": 0,
            "exit_removed": 0
        }
        
        for src_file in input_files:
            rel_path = relative_to_or_name(src_file, input_path)
            dst_file = output_dir / rel_path
            
            success, stats, error = process_file(src_file, dst_file)
            
            if success:
                total_stats["success"] += 1
                total_stats["lines_inserted"] += stats["lines_inserted"]
                total_stats["replacements"] += stats["replacements"]
                total_stats["exit_removed"] += stats["exit_removed"]
                print(colored(f"  ✓ {rel_path}", Colors.GREEN))
            else:
                total_stats["failed"] += 1
                print(colored(f"  ✗ {rel_path}: {error}", Colors.RED))
        
        # Print summary
        print()
        print(colored("=" * 70, Colors.BOLD))
        print(colored("Conversion Summary", Colors.BOLD + Colors.CYAN))
        print(colored("=" * 70, Colors.BOLD))
        print(f"Total files:           {colored(str(total_stats['total']), Colors.CYAN)}")
        print(f"Successfully converted: {colored(str(total_stats['success']), Colors.GREEN)}")
        if total_stats['failed'] > 0:
            print(f"Failed:                {colored(str(total_stats['failed']), Colors.RED)}")
        print(f"Total lines inserted:  {colored(str(total_stats['lines_inserted']), Colors.CYAN)}")
        print(f"Total replacements:    {colored(str(total_stats['replacements']), Colors.CYAN)}")
        print(f"Exit statements removed: {colored(str(total_stats['exit_removed']), Colors.CYAN)}")
        print()
        
        if total_stats['failed'] > 0:
            print(colored('[WARNING] Some files failed to convert.', Colors.YELLOW))
            return 1
        else:
            print(colored('[SUCCESS] All files converted successfully!', Colors.GREEN + Colors.BOLD))
    
    else:
        print(colored(f"[ERROR] Input path is neither a file nor a directory: {input_path}", Colors.RED))
        return 1
    
    return 0

if __name__ == '__main__':
    sys.exit(main())
