#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SMT-LIB Mutation Analysis Script
This script analyzes mutated SMT-LIB files to compute:
1. Avg. Partitions: Number of unique (variable, delimiter) pairs
2. Avg. Split Terms: Total number of split function calls
"""

import os
import re
import glob
import argparse
from typing import List, Dict, Set, Tuple
from collections import defaultdict

class MutationAnalyzer:
    def __init__(self):
        self.split_functions = ["str.split_at", "str.split_rest", "str.num_splits"]
        
    def extract_split_calls(self, content: str) -> List[Tuple[str, str, str]]:
        """Extract all split function calls from SMT content
        Returns list of (function_name, variable, delimiter) tuples
        """
        split_calls = []
        
        for func_name in self.split_functions:
            # Pattern to match function calls: (str.split_at var "delimiter" index)
            # or (str.split_rest var "delimiter" index) or (str.num_splits var "delimiter")
            if func_name == "str.num_splits":
                pattern = rf'\({re.escape(func_name)}\s+(\w+)\s+"([^"\\]*(?:\\.[^"\\]*)*)"\)'
            else:
                pattern = rf'\({re.escape(func_name)}\s+(\w+)\s+"([^"\\]*(?:\\.[^"\\]*)*)"\s+\d+\)'
            
            matches = re.findall(pattern, content)
            for match in matches:
                variable = match[0]
                delimiter = match[1]
                split_calls.append((func_name, variable, delimiter))
        
        return split_calls
    
    def analyze_file(self, filepath: str) -> Dict:
        """Analyze a single SMT file and return statistics"""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Extract all split function calls
            split_calls = self.extract_split_calls(content)
            
            # Count unique partitions (variable, delimiter) pairs
            partitions = set()
            for func_name, variable, delimiter in split_calls:
                partitions.add((variable, delimiter))
            
            # Count total split terms
            total_split_terms = len(split_calls)
            
            # Count by function type
            function_counts = defaultdict(int)
            for func_name, _, _ in split_calls:
                function_counts[func_name] += 1
            
            return {
                "file": os.path.basename(filepath),
                "path": filepath,
                "partitions": len(partitions),
                "split_terms": total_split_terms,
                "function_counts": dict(function_counts),
                "partition_details": list(partitions),
                "split_calls": split_calls
            }
            
        except Exception as e:
            print(f"Error analyzing {filepath}: {e}")
            return {
                "file": os.path.basename(filepath),
                "path": filepath,
                "partitions": 0,
                "split_terms": 0,
                "function_counts": {},
                "partition_details": [],
                "split_calls": [],
                "error": str(e)
            }
    
    def analyze_directory(self, input_dir: str, pattern: str = "**/*.smt2") -> Dict:
        """Analyze all SMT files in directory and subdirectories"""
        # Find all SMT files
        search_pattern = os.path.join(input_dir, pattern)
        smt_files = glob.glob(search_pattern, recursive=True)
        
        if not smt_files:
            print(f"No SMT files found in {input_dir}")
            return {}
        
        print(f"Found {len(smt_files)} SMT files to analyze")
        
        # Analyze each file
        file_results = []
        difficulty_stats = defaultdict(list)
        
        for i, filepath in enumerate(smt_files):
            print(f"Analyzing [{i+1}/{len(smt_files)}]: {os.path.basename(filepath)}")
            
            result = self.analyze_file(filepath)
            file_results.append(result)
            
            # Categorize by difficulty level
            filename = result["file"]
            if "_easy" in filename:
                difficulty_stats["easy"].append(result)
            elif "_medium" in filename:
                difficulty_stats["medium"].append(result)
            elif "_hard" in filename:
                difficulty_stats["hard"].append(result)
            else:
                difficulty_stats["unknown"].append(result)
        
        return {
            "total_files": len(smt_files),
            "file_results": file_results,
            "difficulty_stats": dict(difficulty_stats)
        }
    
    def compute_statistics(self, analysis_results: Dict) -> Dict:
        """Compute overall and per-difficulty statistics"""
        if not analysis_results:
            return {}
        
        file_results = analysis_results["file_results"]
        difficulty_stats = analysis_results["difficulty_stats"]
        
        # Overall statistics
        total_partitions = sum(r["partitions"] for r in file_results if "error" not in r)
        total_split_terms = sum(r["split_terms"] for r in file_results if "error" not in r)
        valid_files = len([r for r in file_results if "error" not in r])
        
        overall_stats = {
            "total_files": len(file_results),
            "valid_files": valid_files,
            "avg_partitions": total_partitions / valid_files if valid_files > 0 else 0,
            "avg_split_terms": total_split_terms / valid_files if valid_files > 0 else 0,
            "total_partitions": total_partitions,
            "total_split_terms": total_split_terms
        }
        
        # Per-difficulty statistics
        difficulty_detailed_stats = {}
        for difficulty, results in difficulty_stats.items():
            if not results:
                continue
                
            valid_results = [r for r in results if "error" not in r]
            if not valid_results:
                continue
            
            d_total_partitions = sum(r["partitions"] for r in valid_results)
            d_total_split_terms = sum(r["split_terms"] for r in valid_results)
            d_valid_files = len(valid_results)
            
            # Function type statistics
            function_counts = defaultdict(int)
            for result in valid_results:
                for func, count in result["function_counts"].items():
                    function_counts[func] += count
            
            difficulty_detailed_stats[difficulty] = {
                "files": len(results),
                "valid_files": d_valid_files,
                "avg_partitions": d_total_partitions / d_valid_files if d_valid_files > 0 else 0,
                "avg_split_terms": d_total_split_terms / d_valid_files if d_valid_files > 0 else 0,
                "total_partitions": d_total_partitions,
                "total_split_terms": d_total_split_terms,
                "function_counts": dict(function_counts)
            }
        
        return {
            "overall": overall_stats,
            "by_difficulty": difficulty_detailed_stats
        }
    
    def print_summary(self, statistics: Dict):
        """Print formatted summary of statistics"""
        if not statistics:
            print("No statistics to display")
            return
        
        print("\n" + "="*60)
        print("SMT-LIB MUTATION ANALYSIS SUMMARY")
        print("="*60)
        
        overall = statistics["overall"]
        print(f"\n📊 OVERALL STATISTICS:")
        print(f"  Total Files: {overall['total_files']}")
        print(f"  Valid Files: {overall['valid_files']}")
        print(f"  Avg. Partitions: {overall['avg_partitions']:.2f}")
        print(f"  Avg. Split Terms: {overall['avg_split_terms']:.2f}")
        print(f"  Total Partitions: {overall['total_partitions']}")
        print(f"  Total Split Terms: {overall['total_split_terms']}")
        
        by_difficulty = statistics["by_difficulty"]
        if by_difficulty:
            print(f"\n📈 BY DIFFICULTY LEVEL:")
            
            for difficulty in ["easy", "medium", "hard"]:
                if difficulty in by_difficulty:
                    stats = by_difficulty[difficulty]
                    print(f"\n  {difficulty.upper()}:")
                    print(f"    Files: {stats['valid_files']}")
                    print(f"    Avg. Partitions: {stats['avg_partitions']:.2f}")
                    print(f"    Avg. Split Terms: {stats['avg_split_terms']:.2f}")
                    
                    if stats['function_counts']:
                        print(f"    Function Usage:")
                        for func, count in stats['function_counts'].items():
                            print(f"      {func}: {count}")
        
        print("\n" + "="*60)
        
        # LaTeX table format
        print("\n📋 LATEX TABLE FORMAT:")
        print("\\begin{tabular}{lccc}")
        print("\\hline")
        print("Difficulty & Files & Avg. Partitions & Avg. Split Terms \\\\")
        print("\\hline")
        
        for difficulty in ["easy", "medium", "hard"]:
            if difficulty in by_difficulty:
                stats = by_difficulty[difficulty]
                print(f"{difficulty.capitalize()} & {stats['valid_files']} & "
                      f"{stats['avg_partitions']:.2f} & {stats['avg_split_terms']:.2f} \\\\")
        
        if overall['valid_files'] > 0:
            print(f"Overall & {overall['valid_files']} & "
                  f"{overall['avg_partitions']:.2f} & {overall['avg_split_terms']:.2f} \\\\")
        
        print("\\hline")
        print("\\end{tabular}")
    
    def save_detailed_report(self, analysis_results: Dict, statistics: Dict, output_file: str):
        """Save detailed analysis report to file"""
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write("SMT-LIB MUTATION ANALYSIS DETAILED REPORT\n")
                f.write("="*60 + "\n\n")
                
                # Overall statistics
                overall = statistics["overall"]
                f.write("OVERALL STATISTICS:\n")
                f.write(f"Total Files: {overall['total_files']}\n")
                f.write(f"Valid Files: {overall['valid_files']}\n")
                f.write(f"Avg. Partitions: {overall['avg_partitions']:.3f}\n")
                f.write(f"Avg. Split Terms: {overall['avg_split_terms']:.3f}\n")
                f.write(f"Total Partitions: {overall['total_partitions']}\n")
                f.write(f"Total Split Terms: {overall['total_split_terms']}\n\n")
                
                # Per-difficulty statistics
                by_difficulty = statistics["by_difficulty"]
                for difficulty, stats in by_difficulty.items():
                    f.write(f"{difficulty.upper()} DIFFICULTY:\n")
                    f.write(f"Files: {stats['valid_files']}\n")
                    f.write(f"Avg. Partitions: {stats['avg_partitions']:.3f}\n")
                    f.write(f"Avg. Split Terms: {stats['avg_split_terms']:.3f}\n")
                    f.write(f"Function Counts: {stats['function_counts']}\n\n")
                
                # Detailed file results
                f.write("\nDETAILED FILE RESULTS:\n")
                f.write("-" * 60 + "\n")
                
                for result in analysis_results["file_results"]:
                    f.write(f"\nFile: {result['file']}\n")
                    f.write(f"Path: {result['path']}\n")
                    if "error" in result:
                        f.write(f"Error: {result['error']}\n")
                    else:
                        f.write(f"Partitions: {result['partitions']}\n")
                        f.write(f"Split Terms: {result['split_terms']}\n")
                        f.write(f"Function Counts: {result['function_counts']}\n")
                        f.write(f"Partition Details: {result['partition_details']}\n")
                        
                        if result['split_calls']:
                            f.write("Split Calls:\n")
                            for func, var, delim in result['split_calls']:
                                f.write(f"  {func}({var}, \"{delim}\")\n")
                    f.write("-" * 40 + "\n")
            
            print(f"\nDetailed report saved to: {output_file}")
            
        except Exception as e:
            print(f"Error saving detailed report: {e}")

def main():
    parser = argparse.ArgumentParser(description='Analyze SMT-LIB mutation results')
    parser.add_argument('--input-dir', '-i', required=True, 
                       help='Input directory containing mutated SMT files')
    parser.add_argument('--output-report', '-o', default=None,
                       help='Output file for detailed report')
    parser.add_argument('--pattern', '-p', default="**/*.smt2",
                       help='File pattern to search (default: **/*.smt2)')
    
    args = parser.parse_args()
    
    # Create analyzer
    analyzer = MutationAnalyzer()
    
    # Analyze directory
    print(f"Analyzing SMT files in: {args.input_dir}")
    analysis_results = analyzer.analyze_directory(args.input_dir, args.pattern)
    
    if not analysis_results:
        print("No results to analyze")
        return
    
    # Compute statistics
    statistics = analyzer.compute_statistics(analysis_results)
    
    # Print summary
    analyzer.print_summary(statistics)
    
    # Save detailed report if requested
    if args.output_report:
        analyzer.save_detailed_report(analysis_results, statistics, args.output_report)
    
    print(f"\nAnalysis completed!")

if __name__ == "__main__":
    main() 