#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Convert UF (Uninterpreted Functions) files to various formats.
This script generates multiple versions from a UF file:
1. splitsmt: Removes UF declarations, adds str. prefix back.
2. ra: Replaces UF with RA definitions + sanitizes negative numbers.
3. rec: Replaces UF with REC definitions + sanitizes negative numbers.

Only adds RE-related definitions if the file uses RE functions.
"""

import argparse
import re
import sys
from pathlib import Path
from typing import List, Tuple, Dict

# --- Embedded Definitions ---

# Base RA definitions (non-RE)
RA_DEFINITIONS_BASE = r"""(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))"""

# RE RA definitions (only added if RE functions are used)
RA_DEFINITIONS_RE = r"""
(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))"""

# Base REC definitions (non-RE)
REC_DEFINITIONS_BASE = r"""(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))"""

# RE REC definitions (only added if RE functions are used)
REC_DEFINITIONS_RE = r"""
(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))"""

# --- Script Logic ---

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
UF_DECLARATION_PATTERNS_BASE = [
    r'^\s*\(declare-fun split_at \(String String Int\) String\)\s*$',
    r'^\s*\(declare-fun split_rest \(String String Int\) String\)\s*$',
    r'^\s*\(declare-fun num_splits \(String String\) Int\)\s*$',
]

UF_DECLARATION_PATTERNS_RE = [
    r'^\s*\(declare-fun split_at_re \(String RegLan Int\) String\)\s*$',
    r'^\s*\(declare-fun split_rest_re \(String RegLan Int\) String\)\s*$',
    r'^\s*\(declare-fun num_splits_re \(String RegLan\) Int\)\s*$'
]

def uses_re_functions(content: List[str]) -> bool:
    """Check if the content uses any RE-related split functions."""
    content_str = '\n'.join(content)
    # Check for split_at_re, split_rest_re, num_splits_re (with or without str. prefix)
    re_patterns = [
        r'\bsplit_at_re\b',
        r'\bsplit_rest_re\b',
        r'\bnum_splits_re\b',
    ]
    for pattern in re_patterns:
        if re.search(pattern, content_str):
            return True
    return False

def sanitize_negative_one(content: List[str]) -> Tuple[List[str], int]:
    """
    Replace occurrences of -1 with (- 1) to be Ostrich-compatible and standard compliant.
    Avoids replacing inside other words (e.g. var-1).
    """
    new_content = []
    count = 0
    
    pattern = re.compile(r'(^|[\s\(\[])(-1)(?=[\s\)\]]|$)')
    
    for line in content:
        if "-1" not in line:
            new_content.append(line)
            continue
            
        new_line, n = pattern.subn(r'\1(- 1)', line)
        count += n
        new_content.append(new_line)
        
    return new_content, count

def transform_to_splitsmt(content: List[str]) -> Tuple[List[str], Dict]:
    """
    Transform UF format to SplitSMT format:
    1. Remove UF declarations
    2. Add str. prefix back (split_at -> str.split_at)
    """
    stats = {"uf_declarations_removed": 0, "prefixes_added": 0}
    all_patterns = UF_DECLARATION_PATTERNS_BASE + UF_DECLARATION_PATTERNS_RE
    uf_patterns = [re.compile(pattern) for pattern in all_patterns]
    result_lines = []
    
    for line in content:
        if any(pattern.match(line) for pattern in uf_patterns):
            stats["uf_declarations_removed"] += 1
            continue
        
        # Add str. prefix back
        pat_split_at = re.compile(r'\(\s*split_at\b')
        pat_split_rest = re.compile(r'\(\s*split_rest\b')
        pat_num_splits = re.compile(r'\(\s*num_splits\b')
        
        new_line = line
        new_line, c1 = pat_split_at.subn(lambda m: m.group(0).replace("split_at", "str.split_at"), new_line)
        new_line, c2 = pat_split_rest.subn(lambda m: m.group(0).replace("split_rest", "str.split_rest"), new_line)
        new_line, c3 = pat_num_splits.subn(lambda m: m.group(0).replace("num_splits", "str.num_splits"), new_line)

        # Add str. prefix for _re variants
        pat_split_at_re = re.compile(r'\(\s*split_at_re\b')
        pat_split_rest_re = re.compile(r'\(\s*split_rest_re\b')
        pat_num_splits_re = re.compile(r'\(\s*num_splits_re\b')

        new_line, c4 = pat_split_at_re.subn(lambda m: m.group(0).replace("split_at_re", "str.split_at_re"), new_line)
        new_line, c5 = pat_split_rest_re.subn(lambda m: m.group(0).replace("split_rest_re", "str.split_rest_re"), new_line)
        new_line, c6 = pat_num_splits_re.subn(lambda m: m.group(0).replace("num_splits_re", "str.num_splits_re"), new_line)
        
        stats["prefixes_added"] += (c1 + c2 + c3 + c4 + c5 + c6)
        result_lines.append(new_line)
    
    return result_lines, stats

def transform_to_ra(content: List[str]) -> Tuple[List[str], Dict]:
    """
    RA: Remove UF Declarations, inject RA definitions, sanitize -1.
    Only injects RE definitions if RE functions are used.
    """
    stats = {"uf_declarations_removed": 0, "definitions_injected": 0, "negative_ones_sanitized": 0}
    
    # 1. Sanitize
    sanitized_content, n_count = sanitize_negative_one(content)
    stats["negative_ones_sanitized"] = n_count
    
    # 2. Determine if RE functions are used
    has_re = uses_re_functions(content)
    
    # 3. Split definitions
    ra_defs = RA_DEFINITIONS_BASE.strip().split('\n')
    if has_re:
        ra_defs.extend(RA_DEFINITIONS_RE.strip().split('\n'))

    # 4. Remove UF and Inject
    result_lines = []
    all_patterns = UF_DECLARATION_PATTERNS_BASE + UF_DECLARATION_PATTERNS_RE
    uf_patterns = [re.compile(pattern) for pattern in all_patterns]
    
    insertion_done = False
    
    for line in sanitized_content:
        is_uf = any(pattern.match(line) for pattern in uf_patterns)
        
        if is_uf:
            stats["uf_declarations_removed"] += 1
            if not insertion_done:
                result_lines.extend(ra_defs)
                stats["definitions_injected"] = len(ra_defs)
                insertion_done = True
            continue
            
        result_lines.append(line)
        
    if not insertion_done:
        # Fallback injection logic
        final_lines = []
        for line in result_lines:
            final_lines.append(line)
            if "(set-logic" in line and not insertion_done:
                final_lines.extend(ra_defs)
                stats["definitions_injected"] = len(ra_defs)
                insertion_done = True
        if not insertion_done:
             final_lines = ra_defs + result_lines
             stats["definitions_injected"] = len(ra_defs)
        result_lines = final_lines

    return result_lines, stats

def transform_to_rec(content: List[str]) -> Tuple[List[str], Dict]:
    """
    REC: Remove UF Declarations, inject REC definitions, sanitize -1.
    Only injects RE definitions if RE functions are used.
    """
    stats = {"uf_declarations_removed": 0, "definitions_injected": 0, "negative_ones_sanitized": 0}
    
    # 1. Sanitize
    sanitized_content, n_count = sanitize_negative_one(content)
    stats["negative_ones_sanitized"] = n_count

    # 2. Determine if RE functions are used
    has_re = uses_re_functions(content)

    # 3. Split definitions
    rec_defs = REC_DEFINITIONS_BASE.strip().split('\n')
    if has_re:
        rec_defs.extend(REC_DEFINITIONS_RE.strip().split('\n'))
    
    # 4. Remove UF and Inject
    result_lines = []
    all_patterns = UF_DECLARATION_PATTERNS_BASE + UF_DECLARATION_PATTERNS_RE
    uf_patterns = [re.compile(pattern) for pattern in all_patterns]
    
    insertion_done = False
    
    for line in sanitized_content:
        is_uf = any(pattern.match(line) for pattern in uf_patterns)
        
        if is_uf:
            stats["uf_declarations_removed"] += 1
            if not insertion_done:
                result_lines.extend(rec_defs)
                stats["definitions_injected"] = len(rec_defs)
                insertion_done = True
            continue
            
        result_lines.append(line)
        
    if not insertion_done:
        final_lines = []
        for line in result_lines:
            final_lines.append(line)
            if "(set-logic" in line and not insertion_done:
                final_lines.extend(rec_defs)
                stats["definitions_injected"] = len(rec_defs)
                insertion_done = True
        if not insertion_done:
             final_lines = rec_defs + result_lines
             stats["definitions_injected"] = len(rec_defs)
        result_lines = final_lines

    return result_lines, stats

def process_file_to_formats(src_path: Path, output_dir: Path, 
                           rel_path: Path = None) -> Tuple[bool, Dict, str]:
    """Process a single UF file and generate splitsmt, ra, rec versions."""
    try:
        # Read source file
        with open(src_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read().splitlines()
        
        # Determine output filenames
        if rel_path:
            # Directory mode: output_dir is root of outputs
            dst_splitsmt = output_dir / "splitsmt" / rel_path
            dst_ra = output_dir / "ra" / rel_path
            dst_rec = output_dir / "rec" / rel_path
        else:
            # Single file mode: output_dir is target directory
            base_name = src_path.stem
            dst_splitsmt = output_dir / "splitsmt" / f"{base_name}.smt2"
            dst_ra = output_dir / "ra" / f"{base_name}.smt2"
            dst_rec = output_dir / "rec" / f"{base_name}.smt2"

        # Generate versions
        splitsmt_lines, splitsmt_stats = transform_to_splitsmt(content)
        ra_lines, ra_stats = transform_to_ra(content)
        rec_lines, rec_stats = transform_to_rec(content)
        
        # Write files
        for path, lines in [
            (dst_splitsmt, splitsmt_lines),
            (dst_ra, ra_lines),
            (dst_rec, rec_lines)
        ]:
            path.parent.mkdir(parents=True, exist_ok=True)
            with open(path, "w", encoding="utf-8") as f:
                f.write("\n".join(lines) + "\n")
        
        combined_stats = {
            "splitsmt": splitsmt_stats,
            "ra": ra_stats,
            "rec": rec_stats
        }
        
        return True, combined_stats, ""
    except Exception as e:
        return False, {}, str(e)

def collect_smt_files(input_dir: Path) -> List[Path]:
    return sorted(input_dir.rglob("*.smt2"))

def relative_to_or_name(p: Path, base: Path) -> Path:
    try:
        return p.relative_to(base)
    except ValueError:
        return Path(p.name)

def parse_args():
    parser = argparse.ArgumentParser(
        description='Convert UF files to splitsmt, ra, and rec formats.'
    )
    parser.add_argument(
        '--input', '-i', required=True,
        help='Input file or directory'
    )
    parser.add_argument(
        '--output', '-o', default=None,
        help='Output directory'
    )
    parser.add_argument(
        '--dry-run', action='store_true',
        help='Only scan inputs and show what would be done'
    )
    return parser.parse_args()

def main():
    args = parse_args()
    input_path = Path(args.input)
    
    if not input_path.exists():
        print(colored(f"[ERROR] Input path does not exist: {input_path}", Colors.RED))
        return 1
        
    print(colored(f"[INFO] converting formats (splitsmt, ra, rec)...", Colors.CYAN))
    print(colored(f"[INFO] RE definitions are only injected for files using RE functions.", Colors.CYAN))
    
    # Set output dir
    if args.output:
        output_dir = Path(args.output)
    else:
        output_dir = input_path.parent if input_path.is_file() else input_path
        
    if args.dry_run:
        print(colored('[INFO] Dry-run complete.', Colors.YELLOW))
        return 0

    if input_path.is_file():
        success, stats, error = process_file_to_formats(input_path, output_dir)
        if success:
             print(colored(f"[SUCCESS] Converted {input_path.name}", Colors.GREEN))
        else:
             print(colored(f"[ERROR] Failed: {error}", Colors.RED))
             return 1
    else:
        input_files = collect_smt_files(input_path)
        print(colored(f"[INFO] Found {len(input_files)} files.", Colors.BLUE))
        
        processed = 0
        failed = 0
        
        for src in input_files:
            rel = relative_to_or_name(src, input_path)
            success, stats, error = process_file_to_formats(src, output_dir, rel_path=rel)
            if success:
                processed += 1
                if processed % 100 == 0:
                    print(f"Processed {processed}/{len(input_files)}...")
            else:
                failed += 1
                print(colored(f"  ✗ {rel}: {error}", Colors.RED))
                
        print(colored(f"\n[SUMMARY] Success: {processed}, Failed: {failed}", Colors.BOLD))
        
    return 0

if __name__ == '__main__':
    sys.exit(main())
