#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Convert UF (Uninterpreted Functions) files to various formats.
This script generates three versions from a UF file:
1. splitsmt: Removes UF declarations, adds str. prefix back
2. generic: Keeps UF declarations (for cvc5, z3, z3-noodler)
3. ostrich: UF declarations + special handling (adds -1 constant)
"""

import argparse
import re
import sys
from pathlib import Path
from typing import List, Tuple, Dict

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
    """Return colored text if terminal supports it."""
    if sys.stdout.isatty():
        return f"{color}{text}{Colors.RESET}"
    return text

# UF function declarations patterns to identify and remove
UF_DECLARATION_PATTERNS = [
    r'^\s*\(declare-fun split_at \(String String Int\) String\)\s*$',
    r'^\s*\(declare-fun split_rest \(String String Int\) String\)\s*$',
    r'^\s*\(declare-fun num_splits \(String String\) Int\)\s*$'
]

# Ostrich-specific additions
OSTRICH_ADDITIONS = [
    "(declare-const -1 Int)",
    "(assert (= -1 (- 1)))"
]

def transform_to_splitsmt(content: List[str]) -> Tuple[List[str], Dict]:
    """
    Transform UF format to SplitSMT format:
    1. Remove UF declarations
    2. Add str. prefix back (split_at -> str.split_at)
    3. Keep logic as ALL
    """
    stats = {"uf_declarations_removed": 0, "prefixes_added": 0}
    
    # Compile UF declaration patterns
    uf_patterns = [re.compile(pattern) for pattern in UF_DECLARATION_PATTERNS]
    
    result_lines = []
    
    for line in content:
        # Check if this line is a UF declaration
        is_uf_declaration = any(pattern.match(line) for pattern in uf_patterns)
        
        if is_uf_declaration:
            stats["uf_declarations_removed"] += 1
            continue  # Skip UF declarations
        
        # Add str. prefix back to function calls
        # Match: (split_at ... , (split_rest ... , (num_splits ...
        pat_split_at = re.compile(r'\(\s*split_at\b')
        pat_split_rest = re.compile(r'\(\s*split_rest\b')
        pat_num_splits = re.compile(r'\(\s*num_splits\b')
        
        new_line = line
        new_line, c1 = pat_split_at.subn(lambda m: m.group(0).replace("split_at", "str.split_at"), new_line)
        new_line, c2 = pat_split_rest.subn(lambda m: m.group(0).replace("split_rest", "str.split_rest"), new_line)
        new_line, c3 = pat_num_splits.subn(lambda m: m.group(0).replace("num_splits", "str.num_splits"), new_line)
        
        stats["prefixes_added"] += (c1 + c2 + c3)
        result_lines.append(new_line)
    
    return result_lines, stats

def transform_to_generic(content: List[str]) -> Tuple[List[str], Dict]:
    """
    Transform UF format to generic format (cvc5, z3, z3-noodler):
    Keep everything as-is, UF declarations remain
    """
    stats = {"lines_kept": len(content)}
    return content.copy(), stats

def transform_to_ostrich(content: List[str]) -> Tuple[List[str], Dict]:
    """
    Transform UF format to Ostrich format:
    1. Keep UF declarations
    2. Add Ostrich-specific declarations after UF declarations
    """
    stats = {"ostrich_additions": 0}
    
    result_lines = []
    uf_declarations_found = []
    uf_patterns = [re.compile(pattern) for pattern in UF_DECLARATION_PATTERNS]
    
    # Track if we've found UF declarations
    last_uf_index = -1
    
    for i, line in enumerate(content):
        is_uf_declaration = any(pattern.match(line) for pattern in uf_patterns)
        
        if is_uf_declaration:
            last_uf_index = len(result_lines)
            uf_declarations_found.append(line)
        
        result_lines.append(line)
    
    # Insert Ostrich-specific additions after the last UF declaration
    if last_uf_index >= 0:
        # Insert after the last UF declaration
        insert_position = last_uf_index + 1
        for addition in OSTRICH_ADDITIONS:
            result_lines.insert(insert_position, addition)
            insert_position += 1
            stats["ostrich_additions"] += 1
    
    return result_lines, stats

def process_file_to_three_formats(src_path: Path, 
                                  dst_splitsmt: Path,
                                  dst_generic: Path,
                                  dst_ostrich: Path) -> Tuple[bool, Dict, str]:
    """Process a single UF file and generate three format versions."""
    try:
        # Read source file
        with open(src_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read().splitlines()
        
        # Generate three versions
        splitsmt_lines, splitsmt_stats = transform_to_splitsmt(content)
        generic_lines, generic_stats = transform_to_generic(content)
        ostrich_lines, ostrich_stats = transform_to_ostrich(content)
        
        # Write splitsmt version
        dst_splitsmt.parent.mkdir(parents=True, exist_ok=True)
        with open(dst_splitsmt, "w", encoding="utf-8") as f:
            f.write("\n".join(splitsmt_lines) + "\n")
        
        # Write generic version
        dst_generic.parent.mkdir(parents=True, exist_ok=True)
        with open(dst_generic, "w", encoding="utf-8") as f:
            f.write("\n".join(generic_lines) + "\n")
        
        # Write ostrich version
        dst_ostrich.parent.mkdir(parents=True, exist_ok=True)
        with open(dst_ostrich, "w", encoding="utf-8") as f:
            f.write("\n".join(ostrich_lines) + "\n")
        
        combined_stats = {
            "splitsmt": splitsmt_stats,
            "generic": generic_stats,
            "ostrich": ostrich_stats
        }
        
        return True, combined_stats, ""
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
        description='Convert UF files to multiple formats (splitsmt, generic, ostrich).'
    )
    parser.add_argument(
        '--input', '-i', required=True,
        help='Input file or directory (supports single .smt2 file or directory containing .smt2 files)'
    )
    parser.add_argument(
        '--output', '-o', default=None,
        help='Output directory (default: creates splitsmt/, generic/, ostrich/ in input directory)'
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
    
    print(colored(f"[INFO] Converting UF files to 3 formats:", Colors.CYAN))
    print(f"  1. {colored('splitsmt', Colors.GREEN)} - Removes UF declarations, adds str. prefix")
    print(f"  2. {colored('generic', Colors.BLUE)} - Keeps UF declarations (for cvc5, z3, z3-noodler)")
    print(f"  3. {colored('ostrich', Colors.MAGENTA)} - UF declarations + special handling")
    
    # Determine input/output mode
    is_single_file = input_path.is_file()
    
    if is_single_file:
        # Single file mode
        if input_path.suffix != '.smt2':
            print(colored(f"[ERROR] Input file must be a .smt2 file: {input_path}", Colors.RED))
            return 1
        
        # Determine output paths
        if args.output:
            output_dir = Path(args.output)
        else:
            output_dir = input_path.parent
        
        # Generate output file names
        base_name = input_path.stem
        dst_splitsmt = output_dir / f"{base_name}_splitsmt.smt2"
        dst_generic = output_dir / f"{base_name}_generic.smt2"
        dst_ostrich = output_dir / f"{base_name}_ostrich.smt2"
        
        print(colored(f"\n[INFO] Input file:  {input_path}", Colors.BLUE))
        print(colored(f"[INFO] Output files:", Colors.BLUE))
        print(f"  - SplitSMT: {dst_splitsmt}")
        print(f"  - Generic:  {dst_generic}")
        print(f"  - Ostrich:  {dst_ostrich}")
        
        if args.dry_run:
            print(colored('\n[INFO] Dry-run complete. No files written.', Colors.YELLOW))
            return 0
        
        # Process single file
        success, stats, error = process_file_to_three_formats(
            input_path, dst_splitsmt, dst_generic, dst_ostrich
        )
        
        if success:
            print(colored(f"\n[SUCCESS] File converted successfully!", Colors.GREEN))
            print(f"  SplitSMT: {stats['splitsmt']['uf_declarations_removed']} UF declarations removed, "
                  f"{stats['splitsmt']['prefixes_added']} str. prefixes added")
            print(f"  Generic:  {stats['generic']['lines_kept']} lines kept as-is")
            print(f"  Ostrich:  {stats['ostrich']['ostrich_additions']} special declarations added")
        else:
            print(colored(f"[ERROR] Failed to process file: {error}", Colors.RED))
            return 1
    
    elif input_path.is_dir():
        # Directory mode
        input_files = collect_smt_files(input_path)
        
        if not input_files:
            print(colored(f"[WARN] No .smt2 files found in: {input_path}", Colors.YELLOW))
            return 0
        
        print(colored(f"\n[INFO] Found {len(input_files)} .smt2 files in: {input_path}", Colors.BLUE))
        
        # Determine output directory
        if args.output:
            output_dir = Path(args.output)
        else:
            output_dir = input_path
        
        print(colored(f"[INFO] Output structure:", Colors.BLUE))
        print(f"  - {output_dir}/splitsmt/")
        print(f"  - {output_dir}/generic/")
        print(f"  - {output_dir}/ostrich/")
        
        if args.dry_run:
            print(colored('\n[INFO] Dry-run complete. No files written.', Colors.YELLOW))
            return 0
        
        # Process all files
        total_stats = {
            "total": len(input_files),
            "success": 0,
            "failed": 0,
            "splitsmt_uf_removed": 0,
            "splitsmt_prefixes_added": 0,
            "ostrich_additions": 0
        }
        
        for src_file in input_files:
            rel_path = relative_to_or_name(src_file, input_path)
            
            dst_splitsmt = output_dir / "splitsmt" / rel_path
            dst_generic = output_dir / "generic" / rel_path
            dst_ostrich = output_dir / "ostrich" / rel_path
            
            success, stats, error = process_file_to_three_formats(
                src_file, dst_splitsmt, dst_generic, dst_ostrich
            )
            
            if success:
                total_stats["success"] += 1
                total_stats["splitsmt_uf_removed"] += stats["splitsmt"]["uf_declarations_removed"]
                total_stats["splitsmt_prefixes_added"] += stats["splitsmt"]["prefixes_added"]
                total_stats["ostrich_additions"] += stats["ostrich"]["ostrich_additions"]
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
        print(f"Successfully converted: {colored(str(total_stats['success']), Colors.GREEN)} "
              f"({total_stats['success'] * 3} output files)")
        if total_stats['failed'] > 0:
            print(f"Failed:                {colored(str(total_stats['failed']), Colors.RED)}")
        print()
        print(colored("Format-specific statistics:", Colors.BLUE))
        print(f"  SplitSMT:")
        print(f"    - UF declarations removed: {total_stats['splitsmt_uf_removed']}")
        print(f"    - str. prefixes added: {total_stats['splitsmt_prefixes_added']}")
        print(f"  Generic:")
        print(f"    - Files kept as-is: {total_stats['success']}")
        print(f"  Ostrich:")
        print(f"    - Special declarations added: {total_stats['ostrich_additions']}")
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
