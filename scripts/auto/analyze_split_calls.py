#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SMT-LIB Split Function Call Analysis Script
This script analyzes SMT-LIB files to count split function calls:
- get_split_length: function calls
- get_split_element: function calls  
- Total split function calls per file
"""

import os
import re
import glob
import argparse
from typing import List, Dict, Tuple
from collections import defaultdict
import statistics

class SplitCallAnalyzer:
    def __init__(self):
        self.split_functions = ["get_split_length", "get_split_element"]
        
    def extract_split_calls(self, content: str) -> Dict[str, int]:
        """Extract split function calls from SMT content
        Returns dict with function name -> call count
        """
        call_counts = {func: 0 for func in self.split_functions}
        
        for func_name in self.split_functions:
            # Pattern to match function calls: (get_split_length ...)
            # Look for the function name followed by arguments in parentheses
            pattern = rf'\({re.escape(func_name)}\s+'
            matches = re.findall(pattern, content)
            call_counts[func_name] = len(matches)
        
        return call_counts
    
    def analyze_file(self, filepath: str) -> Dict:
        """Analyze a single SMT file and return split function call statistics"""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Extract split function calls
            call_counts = self.extract_split_calls(content)
            
            # Calculate total calls
            total_calls = sum(call_counts.values())
            
            return {
                "file": os.path.basename(filepath),
                "path": filepath,
                "get_split_length": call_counts["get_split_length"],
                "get_split_element": call_counts["get_split_element"],
                "total_calls": total_calls,
                "has_split_calls": total_calls > 0
            }
            
        except Exception as e:
            print(f"Error analyzing {filepath}: {e}")
            return {
                "file": os.path.basename(filepath),
                "path": filepath,
                "get_split_length": 0,
                "get_split_element": 0,
                "total_calls": 0,
                "has_split_calls": False,
                "error": str(e)
            }
    
    def analyze_directory(self, input_dir: str) -> Dict:
        """Analyze all SMT files in directory"""
        # Find all SMT files
        smt_files = glob.glob(os.path.join(input_dir, "*.smt2"))
        
        if not smt_files:
            print(f"No SMT files found in {input_dir}")
            return {"total_files": 0, "file_results": []}
        
        print(f"Found {len(smt_files)} SMT files in {input_dir}")
        
        # Analyze each file
        file_results = []
        
        for i, filepath in enumerate(smt_files):
            if (i + 1) % 10 == 0 or i == len(smt_files) - 1:
                print(f"  Analyzing [{i+1}/{len(smt_files)}]: {os.path.basename(filepath)}")
            
            result = self.analyze_file(filepath)
            file_results.append(result)
        
        return {
            "directory": input_dir,
            "total_files": len(smt_files),
            "file_results": file_results
        }
    
    def compute_statistics(self, analysis_results: List[Dict]) -> Dict:
        """Compute overall statistics across all directories"""
        all_results = []
        directory_stats = {}
        
        # Collect all file results and compute per-directory stats
        for dir_result in analysis_results:
            directory = dir_result["directory"]
            file_results = dir_result["file_results"]
            
            valid_results = [r for r in file_results if "error" not in r]
            all_results.extend(valid_results)
            
            if valid_results:
                # Per-directory statistics
                get_split_length_calls = [r["get_split_length"] for r in valid_results]
                get_split_element_calls = [r["get_split_element"] for r in valid_results]
                total_calls = [r["total_calls"] for r in valid_results]
                files_with_calls = len([r for r in valid_results if r["has_split_calls"]])
                
                directory_stats[os.path.basename(directory)] = {
                    "total_files": len(valid_results),
                    "files_with_split_calls": files_with_calls,
                    "percentage_with_calls": (files_with_calls / len(valid_results)) * 100 if valid_results else 0,
                    "avg_get_split_length": statistics.mean(get_split_length_calls),
                    "avg_get_split_element": statistics.mean(get_split_element_calls),
                    "avg_total_calls": statistics.mean(total_calls),
                    "max_total_calls": max(total_calls) if total_calls else 0,
                    "total_get_split_length": sum(get_split_length_calls),
                    "total_get_split_element": sum(get_split_element_calls),
                    "total_all_calls": sum(total_calls)
                }
        
        # Overall statistics
        if all_results:
            get_split_length_calls = [r["get_split_length"] for r in all_results]
            get_split_element_calls = [r["get_split_element"] for r in all_results]
            total_calls = [r["total_calls"] for r in all_results]
            files_with_calls = len([r for r in all_results if r["has_split_calls"]])
            
            overall_stats = {
                "total_files": len(all_results),
                "files_with_split_calls": files_with_calls,
                "percentage_with_calls": (files_with_calls / len(all_results)) * 100,
                "avg_get_split_length": statistics.mean(get_split_length_calls),
                "avg_get_split_element": statistics.mean(get_split_element_calls),
                "avg_total_calls": statistics.mean(total_calls),
                "max_total_calls": max(total_calls) if total_calls else 0,
                "total_get_split_length": sum(get_split_length_calls),
                "total_get_split_element": sum(get_split_element_calls),
                "total_all_calls": sum(total_calls)
            }
        else:
            overall_stats = {}
        
        return {
            "overall": overall_stats,
            "by_directory": directory_stats,
            "all_file_results": all_results
        }
    
    def print_summary(self, statistics: Dict):
        """Print formatted summary of statistics"""
        if not statistics:
            print("No statistics to display")
            return
        
        print("\n" + "="*70)
        print("SMT-LIB SPLIT FUNCTION CALL ANALYSIS SUMMARY")
        print("="*70)
        
        overall = statistics.get("overall", {})
        if overall:
            print(f"\n📊 OVERALL STATISTICS:")
            print(f"  Total Files: {overall['total_files']}")
            print(f"  Files with Split Calls: {overall['files_with_split_calls']} ({overall['percentage_with_calls']:.1f}%)")
            print(f"  Avg get_split_length Calls: {overall['avg_get_split_length']:.2f}")
            print(f"  Avg get_split_element Calls: {overall['avg_get_split_element']:.2f}")
            print(f"  Avg Total Split Calls: {overall['avg_total_calls']:.2f}")
            print(f"  Max Total Split Calls: {overall['max_total_calls']}")
            print(f"  Total get_split_length: {overall['total_get_split_length']}")
            print(f"  Total get_split_element: {overall['total_get_split_element']}")
            print(f"  Total All Calls: {overall['total_all_calls']}")
        
        by_directory = statistics.get("by_directory", {})
        if by_directory:
            print(f"\n📁 BY DIRECTORY:")
            
            for directory, stats in by_directory.items():
                print(f"\n  {directory}:")
                print(f"    Files: {stats['total_files']}")
                print(f"    Files with Calls: {stats['files_with_split_calls']} ({stats['percentage_with_calls']:.1f}%)")
                print(f"    Avg get_split_length: {stats['avg_get_split_length']:.2f}")
                print(f"    Avg get_split_element: {stats['avg_get_split_element']:.2f}")
                print(f"    Avg Total Calls: {stats['avg_total_calls']:.2f}")
                print(f"    Max Total Calls: {stats['max_total_calls']}")
        
        print("\n" + "="*70)
        
        # LaTeX table format
        print("\n📋 LATEX TABLE FORMAT:")
        print("\\begin{tabular}{lcccc}")
        print("\\hline")
        print("Directory & Files & Files w/ Calls (\\%) & Avg Split Length & Avg Split Element & Avg Total \\\\")
        print("\\hline")
        
        for directory, stats in by_directory.items():
            print(f"{directory} & {stats['total_files']} & {stats['files_with_split_calls']} ({stats['percentage_with_calls']:.1f}\\%) & "
                  f"{stats['avg_get_split_length']:.2f} & {stats['avg_get_split_element']:.2f} & {stats['avg_total_calls']:.2f} \\\\")
        
        if overall:
            print(f"Overall & {overall['total_files']} & {overall['files_with_split_calls']} ({overall['percentage_with_calls']:.1f}\\%) & "
                  f"{overall['avg_get_split_length']:.2f} & {overall['avg_get_split_element']:.2f} & {overall['avg_total_calls']:.2f} \\\\")
        
        print("\\hline")
        print("\\end{tabular}")
    
    def save_detailed_report(self, analysis_results: List[Dict], statistics: Dict, output_file: str):
        """Save detailed analysis report to file"""
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write("SMT-LIB SPLIT FUNCTION CALL ANALYSIS DETAILED REPORT\n")
                f.write("="*70 + "\n\n")
                
                # Overall statistics
                overall = statistics.get("overall", {})
                if overall:
                    f.write("OVERALL STATISTICS:\n")
                    f.write(f"Total Files: {overall['total_files']}\n")
                    f.write(f"Files with Split Calls: {overall['files_with_split_calls']} ({overall['percentage_with_calls']:.1f}%)\n")
                    f.write(f"Avg get_split_length Calls: {overall['avg_get_split_length']:.3f}\n")
                    f.write(f"Avg get_split_element Calls: {overall['avg_get_split_element']:.3f}\n")
                    f.write(f"Avg Total Split Calls: {overall['avg_total_calls']:.3f}\n")
                    f.write(f"Max Total Split Calls: {overall['max_total_calls']}\n")
                    f.write(f"Total get_split_length: {overall['total_get_split_length']}\n")
                    f.write(f"Total get_split_element: {overall['total_get_split_element']}\n")
                    f.write(f"Total All Calls: {overall['total_all_calls']}\n\n")
                
                # Per-directory statistics
                by_directory = statistics.get("by_directory", {})
                for directory, stats in by_directory.items():
                    f.write(f"{directory.upper()} DIRECTORY:\n")
                    f.write(f"Files: {stats['total_files']}\n")
                    f.write(f"Files with Split Calls: {stats['files_with_split_calls']} ({stats['percentage_with_calls']:.1f}%)\n")
                    f.write(f"Avg get_split_length: {stats['avg_get_split_length']:.3f}\n")
                    f.write(f"Avg get_split_element: {stats['avg_get_split_element']:.3f}\n")
                    f.write(f"Avg Total Calls: {stats['avg_total_calls']:.3f}\n")
                    f.write(f"Max Total Calls: {stats['max_total_calls']}\n\n")
                
                # Detailed file results by directory
                for dir_result in analysis_results:
                    directory = dir_result["directory"]
                    f.write(f"\nDETAILED RESULTS FOR {os.path.basename(directory).upper()}:\n")
                    f.write("-" * 60 + "\n")
                    
                    for result in dir_result["file_results"]:
                        f.write(f"\nFile: {result['file']}\n")
                        if "error" in result:
                            f.write(f"Error: {result['error']}\n")
                        else:
                            f.write(f"get_split_length calls: {result['get_split_length']}\n")
                            f.write(f"get_split_element calls: {result['get_split_element']}\n")
                            f.write(f"Total calls: {result['total_calls']}\n")
                            f.write(f"Has split calls: {result['has_split_calls']}\n")
                        f.write("-" * 30 + "\n")
            
            print(f"\nDetailed report saved to: {output_file}")
            
        except Exception as e:
            print(f"Error saving detailed report: {e}")

def main():
    parser = argparse.ArgumentParser(description='Analyze SMT-LIB split function calls')
    parser.add_argument('--input-dirs', '-i', nargs='+', 
                       default=["benchmarks/awesome", "benchmarks/top20_maven", "benchmarks/top20_gh"],
                       help='Input directories containing SMT files')
    parser.add_argument('--output-report', '-o', default=None,
                       help='Output file for detailed report')
    
    args = parser.parse_args()
    
    # Create analyzer
    analyzer = SplitCallAnalyzer()
    
    # Analyze each directory
    print(f"Analyzing SMT files in {len(args.input_dirs)} directories...")
    analysis_results = []
    
    for input_dir in args.input_dirs:
        if not os.path.exists(input_dir):
            print(f"Warning: Directory {input_dir} does not exist, skipping...")
            continue
            
        print(f"\n=== Analyzing {input_dir} ===")
        dir_result = analyzer.analyze_directory(input_dir)
        analysis_results.append(dir_result)
    
    if not analysis_results:
        print("No directories to analyze")
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