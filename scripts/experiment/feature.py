#!/usr/bin/env python3
"""
Extract benchmark characteristics from SMT files in benchmarks_UF directory.

Metrics:
- # Cases: Count of .smt2 files
- Avg. Split Terms: Average count of split function calls per file (all occurrences)
- Avg. Partitions: Average count of unique (source_string, delimiter) pairs per file
"""

import argparse
import os
import re
from collections import defaultdict
from pathlib import Path
from typing import Dict, List, Tuple, NamedTuple


class FileMetrics(NamedTuple):
    """Metrics for a single SMT file."""
    split_terms: int  # Count of split function calls
    partitions: int   # Count of unique (source, delimiter) pairs


# Function names to look for
SPLIT_FUNCS = {'split_at', 'split_rest', 'num_splits', 'split_at_re', 'split_rest_re', 'num_splits_re'}
WRAPPER_FUNCS = {'get_split_length', 'get_split_element', 'get_split_length_re', 'get_split_element_re'}
ALL_FUNCS = SPLIT_FUNCS | WRAPPER_FUNCS

# Template placeholder arguments to filter out
TEMPLATE_ARGS = {'x', 'd', 'i'}


def find_matching_paren(content: str, start: int) -> int:
    """Find the index of the matching closing parenthesis."""
    depth = 1
    i = start
    while i < len(content) and depth > 0:
        if content[i] == '(':
            depth += 1
        elif content[i] == ')':
            depth -= 1
        i += 1
    return i - 1 if depth == 0 else -1


def parse_sexp_arg(content: str, pos: int) -> Tuple[str, int]:
    """Parse a single S-expression argument starting at pos. Returns (arg_str, end_pos)."""
    # Skip whitespace
    while pos < len(content) and content[pos] in ' \t\n\r':
        pos += 1
    
    if pos >= len(content):
        return '', pos
    
    if content[pos] == '(':
        # Nested S-expression
        end = find_matching_paren(content, pos + 1)
        if end == -1:
            return '', pos
        return content[pos:end + 1], end + 1
    elif content[pos] == '"':
        # Quoted string
        end = content.find('"', pos + 1)
        if end == -1:
            return '', pos
        return content[pos:end + 1], end + 1
    else:
        # Atom (identifier)
        end = pos
        while end < len(content) and content[end] not in ' \t\n\r()':
            end += 1
        return content[pos:end], end


def extract_split_calls(content: str) -> List[Tuple[str, str]]:
    """Extract all (source, delimiter) pairs from split function calls."""
    results = []
    
    for func_name in ALL_FUNCS:
        pattern = '(' + func_name
        pos = 0
        while True:
            idx = content.find(pattern, pos)
            if idx == -1:
                break
            
            # Check that we matched the full function name (followed by whitespace)
            end_idx = idx + len(pattern)
            if end_idx < len(content) and content[end_idx] not in ' \t\n\r':
                pos = idx + 1
                continue
            
            # Move past the function name
            arg_pos = end_idx
            
            # Parse first argument (source)
            source, arg_pos = parse_sexp_arg(content, arg_pos)
            if not source:
                pos = idx + 1
                continue
            
            # Parse second argument (delimiter)
            delimiter, arg_pos = parse_sexp_arg(content, arg_pos)
            if not delimiter:
                pos = idx + 1
                continue
            
            # Filter out template arguments
            if source not in TEMPLATE_ARGS and delimiter not in TEMPLATE_ARGS:
                results.append((source, delimiter))
            
            pos = idx + 1
    
    return results


def extract_metrics(filepath: str) -> FileMetrics:
    """Extract split terms and partitions from an SMT file."""
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
    except Exception as e:
        print(f"Warning: Could not read {filepath}: {e}")
        return FileMetrics(0, 0)
    
    # Extract all (source, delimiter) pairs
    all_matches = extract_split_calls(content)
    
    # Count split terms (all occurrences)
    split_terms = len(all_matches)
    
    # Count unique (source, delimiter) pairs for partitions
    partitions_set = set(all_matches)
    partitions = len(partitions_set)
    
    return FileMetrics(split_terms, partitions)


def collect_directory_metrics(directory: str) -> List[FileMetrics]:
    """Collect metrics for all SMT files in a directory."""
    metrics_list = []
    for root, _, files in os.walk(directory):
        for filename in files:
            if filename.endswith('.smt2'):
                filepath = os.path.join(root, filename)
                metrics = extract_metrics(filepath)
                metrics_list.append(metrics)
    return metrics_list


def calculate_stats(metrics_list: List[FileMetrics]) -> Dict[str, float]:
    """Calculate aggregate statistics from metrics list."""
    if not metrics_list:
        return {"cases": 0, "avg_split_terms": 0.0, "avg_partitions": 0.0}
    
    total_split_terms = sum(m.split_terms for m in metrics_list)
    total_partitions = sum(m.partitions for m in metrics_list)
    n = len(metrics_list)
    
    return {
        "cases": n,
        "avg_split_terms": total_split_terms / n,
        "avg_partitions": total_partitions / n
    }


def main():
    parser = argparse.ArgumentParser(description="Extract benchmark characteristics from SMT files")
    parser.add_argument("input_dir", help="Input directory containing benchmarks_UF")
    parser.add_argument("--latex", action="store_true", help="Output LaTeX table format")
    args = parser.parse_args()
    
    base_dir = Path(args.input_dir)
    
    # Define directory mappings
    real_world_dirs = {
        "Maven": base_dir / "RealWorld" / "top20_maven",
        "GitHub": base_dir / "RealWorld" / "top20_gh",
        "Awesome": base_dir / "RealWorld" / "awesome",
        "SeqStr": base_dir / "RealWorld" / "sequences",
    }
    
    llm_dirs = {
        "DeepSeek": {
            "Simple": base_dir / "DeepSeek" / "easy",
            "Complex": base_dir / "DeepSeek" / "complex",
            "Scenarios": base_dir / "DeepSeek" / "scenarios",
        },
        "OpenAI": {
            "Simple": base_dir / "OpenAI" / "easy",
            "Complex": base_dir / "OpenAI" / "complex",
            "Scenarios": base_dir / "OpenAI" / "scenarios",
        }
    }
    
    # Collect Real-World metrics
    print("=" * 80)
    print("Real-World Benchmarks")
    print("=" * 80)
    
    real_world_stats = {}
    real_world_all_metrics = []
    
    for name, dir_path in real_world_dirs.items():
        if dir_path.exists():
            metrics = collect_directory_metrics(str(dir_path))
            stats = calculate_stats(metrics)
            real_world_stats[name] = stats
            real_world_all_metrics.extend(metrics)
            print(f"{name:12} | Cases: {stats['cases']:3} | Avg Split Terms: {stats['avg_split_terms']:.2f} | Avg Partitions: {stats['avg_partitions']:.2f}")
        else:
            print(f"{name}: Directory not found: {dir_path}")
    
    real_world_total = calculate_stats(real_world_all_metrics)
    print(f"{'Total':12} | Cases: {real_world_total['cases']:3} | Avg Split Terms: {real_world_total['avg_split_terms']:.2f} | Avg Partitions: {real_world_total['avg_partitions']:.2f}")
    
    # Collect LLM metrics (combined)
    print("\n" + "=" * 80)
    print("Synthetic Benchmarks (DeepSeek + OpenAI combined)")
    print("=" * 80)
    
    synthetic_combined = {"Simple": [], "Complex": [], "Scenarios": []}
    
    for llm_name, categories in llm_dirs.items():
        for cat_name, dir_path in categories.items():
            if dir_path.exists():
                metrics = collect_directory_metrics(str(dir_path))
                synthetic_combined[cat_name].extend(metrics)
    
    synthetic_stats = {}
    synthetic_all_metrics = []
    
    for cat_name in ["Simple", "Complex", "Scenarios"]:
        stats = calculate_stats(synthetic_combined[cat_name])
        synthetic_stats[cat_name] = stats
        synthetic_all_metrics.extend(synthetic_combined[cat_name])
        print(f"{cat_name:12} | Cases: {stats['cases']:3} | Avg Split Terms: {stats['avg_split_terms']:.2f} | Avg Partitions: {stats['avg_partitions']:.2f}")
    
    synthetic_total = calculate_stats(synthetic_all_metrics)
    print(f"{'Total':12} | Cases: {synthetic_total['cases']:3} | Avg Split Terms: {synthetic_total['avg_split_terms']:.2f} | Avg Partitions: {synthetic_total['avg_partitions']:.2f}")
    
    # Collect LLM metrics (separate)
    print("\n" + "=" * 80)
    print("LLM Breakdown (DeepSeek vs OpenAI)")
    print("=" * 80)
    
    for llm_name, categories in llm_dirs.items():
        print(f"\n{llm_name}:")
        llm_all_metrics = []
        for cat_name, dir_path in categories.items():
            if dir_path.exists():
                metrics = collect_directory_metrics(str(dir_path))
                stats = calculate_stats(metrics)
                llm_all_metrics.extend(metrics)
                print(f"  {cat_name:12} | Cases: {stats['cases']:3} | Avg Split Terms: {stats['avg_split_terms']:.2f} | Avg Partitions: {stats['avg_partitions']:.2f}")
        
        llm_total = calculate_stats(llm_all_metrics)
        print(f"  {'Total':12} | Cases: {llm_total['cases']:3} | Avg Split Terms: {llm_total['avg_split_terms']:.2f} | Avg Partitions: {llm_total['avg_partitions']:.2f}")
    
    # LaTeX output
    if args.latex:
        print("\n" + "=" * 80)
        print("LaTeX Table Data")
        print("=" * 80)
        
        # Format helper
        def fmt_cases(n): return str(int(n))
        def fmt_avg(v): return f"{v:.2f}"
        
        rw = real_world_stats
        rw_t = real_world_total
        syn = synthetic_stats
        syn_t = synthetic_total
        
        print(r"""
\begin{table}[t]
  \centering
  \caption{Benchmark characteristics (after filtering and deduplication).}
  \label{tab:benchmark-characteristics}
  \vspace{-1em}
  \setlength{\tabcolsep}{2.5pt}
  \resizebox{\linewidth}{!}{%
    \begin{tabular}{l|ccccc|cccc}
      \toprule
                                & \multicolumn{5}{c|}{\textbf{Real-World}} & \multicolumn{4}{c}{\textbf{Synthetic}}                                                                                                                      \\
      \cmidrule(lr){2-6} \cmidrule(lr){7-10}
                                & \textbf{Maven}                           & \textbf{GitHub}                        & \textbf{Awesome} & \textbf{SeqStr} & \textbf{Total}
                                & \textbf{Simple}                        & \textbf{Complex} & \textbf{Scenarios} & \textbf{Total}                                                             \\
      \midrule""")
        
        print(f"      \\textbf{{\\# Cases}}         & {fmt_cases(rw.get('Maven', {}).get('cases', 0))}                                       & {fmt_cases(rw.get('GitHub', {}).get('cases', 0))}                                     & {fmt_cases(rw.get('Awesome', {}).get('cases', 0))}              & {fmt_cases(rw.get('SeqStr', {}).get('cases', 0))}                  & {fmt_cases(rw_t['cases'])}                & {fmt_cases(syn.get('Simple', {}).get('cases', 0))}   & {fmt_cases(syn.get('Complex', {}).get('cases', 0))} & {fmt_cases(syn.get('Scenarios', {}).get('cases', 0))} & {fmt_cases(syn_t['cases'])} \\\\")
        
        print(f"      \\textbf{{Avg. Split Terms}} & {fmt_avg(rw.get('Maven', {}).get('avg_split_terms', 0))}                                     & {fmt_avg(rw.get('GitHub', {}).get('avg_split_terms', 0))}                                   & {fmt_avg(rw.get('Awesome', {}).get('avg_split_terms', 0))}             & {fmt_avg(rw.get('SeqStr', {}).get('avg_split_terms', 0))}               & {fmt_avg(rw_t['avg_split_terms'])}               & {fmt_avg(syn.get('Simple', {}).get('avg_split_terms', 0))}   & {fmt_avg(syn.get('Complex', {}).get('avg_split_terms', 0))} & {fmt_avg(syn.get('Scenarios', {}).get('avg_split_terms', 0))} & {fmt_avg(syn_t['avg_split_terms'])} \\\\")
        
        print(f"      \\textbf{{Avg. Partitions}}  & {fmt_avg(rw.get('Maven', {}).get('avg_partitions', 0))}                                     & {fmt_avg(rw.get('GitHub', {}).get('avg_partitions', 0))}                                   & {fmt_avg(rw.get('Awesome', {}).get('avg_partitions', 0))}             & {fmt_avg(rw.get('SeqStr', {}).get('avg_partitions', 0))}               & {fmt_avg(rw_t['avg_partitions'])}               & {fmt_avg(syn.get('Simple', {}).get('avg_partitions', 0))}   & {fmt_avg(syn.get('Complex', {}).get('avg_partitions', 0))} & {fmt_avg(syn.get('Scenarios', {}).get('avg_partitions', 0))} & {fmt_avg(syn_t['avg_partitions'])} \\\\")
        
        print(r"""      \bottomrule
    \end{tabular}%
  }
\end{table}""")


if __name__ == "__main__":
    main()
