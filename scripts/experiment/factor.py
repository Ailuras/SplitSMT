#!/usr/bin/env python3
"""
factor.py - Extract factors from real-world SMT2 benchmarks.

Factors:
1. Delimiter type: REG > VAR > SIN
2. API semantics: Limit > Normal
3. Accessed index depth: var > 3+ > 2 > 1 > 0
"""
from __future__ import annotations

import argparse
import re
from pathlib import Path
from typing import Dict, List, Tuple

from openpyxl import Workbook


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Extract factors from RealWorld benchmarks")
    parser.add_argument(
        "--input",
        type=Path,
        default=Path("benchmarks_splitsmt/RealWorld"),
        help="Input directory containing SMT2 files",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("results/factors.xlsx"),
        help="Output xlsx file",
    )
    return parser.parse_args()


# Regex to match function calls like:
# (get_split_length var3601 " " (- 1))
# (get_split_element var809 "=" (- 1) 1)
# (get_split_length_re var97 (re.union ...) (- 1))
# We'll use a simpler approach: find the keyword and parse arguments manually
KEYWORDS = ["get_split_length_re", "get_split_element_re", "get_split_length", "get_split_element"]


def parse_sexp_args(s: str, start: int) -> List[str]:
    """Parse S-expression arguments starting from position start.
    
    Returns list of argument strings.
    """
    args = []
    i = start
    depth = 0
    current = ""
    in_string = False
    
    while i < len(s):
        c = s[i]
        
        if c == '"' and (i == 0 or s[i-1] != '\\'):
            in_string = not in_string
            current += c
        elif in_string:
            current += c
        elif c == '(':
            depth += 1
            current += c
        elif c == ')':
            if depth == 0:
                if current.strip():
                    args.append(current.strip())
                break
            depth -= 1
            current += c
        elif c in ' \t\n':
            if depth == 0 and current.strip():
                args.append(current.strip())
                current = ""
            elif depth > 0:
                current += c
        else:
            current += c
        i += 1
    
    return args


def extract_calls(content: str) -> List[Dict]:
    """Extract all get_split_* calls from file content."""
    calls = []
    
    for keyword in KEYWORDS:
        idx = 0
        while True:
            pos = content.find(f"({keyword} ", idx)
            if pos == -1:
                break
            
            # Parse arguments after the keyword
            start = pos + len(keyword) + 2  # skip "(keyword "
            args = parse_sexp_args(content, start)
            
            if len(args) >= 3:
                call = {
                    "func": keyword,
                    "source": args[0],
                    "delimiter": args[1],
                    "limit": args[2],
                    "index": args[3] if len(args) > 3 else None,
                }
                calls.append(call)
            
            idx = pos + 1
    
    return calls


def is_string_literal(s: str) -> bool:
    """Check if s is a string literal like '"..."'."""
    return s.startswith('"') and s.endswith('"')


def is_variable(s: str) -> bool:
    """Check if s looks like a variable (starts with var or similar)."""
    if s is None:
        return False
    # Variables typically start with 'var' followed by digits, or are simple identifiers
    # Exclude known literals
    if is_string_literal(s):
        return False
    if s.startswith("("):
        return False
    # Check if it's a number
    try:
        int(s)
        return False
    except ValueError:
        pass
    return True


def is_limit_normal(limit: str) -> bool:
    """Check if limit is (- 1), meaning 'no limit' / Normal."""
    return limit.strip() == "(- 1)"


def classify_delimiter(calls: List[Dict]) -> str:
    """Classify delimiter type: REG > VAR > SIN."""
    if not calls:
        return "CONST"

    has_re = False
    has_var = False

    for call in calls:
        if "_re" in call["func"]:
            has_re = True
        else:
            delim = call["delimiter"]
            if is_variable(delim):
                has_var = True

    if has_re:
        return "REG"
    if has_var:
        return "VAR"
    return "CONST"


def classify_api_semantics(calls: List[Dict]) -> str:
    """Classify API semantics: Limit > Normal."""
    if not calls:
        return "Normal"

    for call in calls:
        if not is_limit_normal(call["limit"]):
            return "Limit"
    return "Normal"


def classify_index_depth(calls: List[Dict]) -> str:
    """Classify index depth: var > not-var."""
    if not calls:
        return "not-var"

    # Filter to get_split_element calls only
    element_calls = [c for c in calls if "element" in c["func"]]

    if not element_calls:
        return "not-var"

    for call in element_calls:
        idx = call["index"]
        if idx is None:
            continue

        if is_variable(idx):
            return "var"
        # Check if it's an expression (contains parentheses)
        if "(" in idx:
            return "var"

    return "not-var"


def analyze_file(path: Path) -> Dict:
    """Analyze a single SMT2 file."""
    content = path.read_text(encoding="utf-8", errors="ignore")
    calls = extract_calls(content)

    return {
        "path": str(path),
        "category": path.parent.name,
        "delimiter_type": classify_delimiter(calls),
        "api_semantics": classify_api_semantics(calls),
        "index_depth": classify_index_depth(calls),
    }


def main() -> int:
    args = parse_args()

    if not args.input.exists():
        print(f"Error: Input directory not found: {args.input}")
        return 1

    # Find all .smt2 files
    files = list(args.input.rglob("*.smt2"))
    print(f"Found {len(files)} SMT2 files in {args.input}")

    # Analyze each file
    results = []
    for f in files:
        try:
            result = analyze_file(f)
            results.append(result)
        except Exception as e:
            print(f"Error analyzing {f}: {e}")

    # Create workbook
    wb = Workbook()
    ws = wb.active
    ws.title = "Factors"

    # Header
    headers = ["path", "category", "delimiter_type", "api_semantics", "index_depth"]
    ws.append(headers)

    # Data
    for r in results:
        ws.append([r[h] for h in headers])

    # Summary sheet
    ws_summary = wb.create_sheet("Summary")

    # Delimiter type summary
    ws_summary.append(["Delimiter Type", "Count"])
    delim_counts = {}
    for r in results:
        dt = r["delimiter_type"]
        delim_counts[dt] = delim_counts.get(dt, 0) + 1
    for dt in ["REG", "VAR", "CONST"]:
        ws_summary.append([dt, delim_counts.get(dt, 0)])

    ws_summary.append([])

    # API semantics summary
    ws_summary.append(["API Semantics", "Count"])
    api_counts = {}
    for r in results:
        api = r["api_semantics"]
        api_counts[api] = api_counts.get(api, 0) + 1
    for api in ["Limit", "Normal"]:
        ws_summary.append([api, api_counts.get(api, 0)])

    ws_summary.append([])

    # Index depth summary
    ws_summary.append(["Index Depth", "Count"])
    depth_counts = {}
    for r in results:
        depth = r["index_depth"]
        depth_counts[depth] = depth_counts.get(depth, 0) + 1
    for depth in ["var", "not-var"]:
        ws_summary.append([depth, depth_counts.get(depth, 0)])

    # Save
    args.output.parent.mkdir(parents=True, exist_ok=True)
    wb.save(args.output)
    print(f"Results saved to {args.output}")

    # Print summary
    print("\n--- Summary ---")
    print("Delimiter Type:", delim_counts)
    print("API Semantics:", api_counts)
    print("Index Depth:", depth_counts)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
