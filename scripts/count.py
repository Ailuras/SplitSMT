#!/usr/bin/env python3
import os
import argparse
from pathlib import Path

def count_files(directory):
    directory = Path(directory)
    if not directory.exists():
        print(f"Error: Directory '{directory}' not found.")
        return

    print(f"{'Directory':<60} | {'Count':<10}")
    print("-" * 73)

    total_files = 0
    
    # Store results to print in a structured way if needed, 
    # but printing as we go (sorted) is usually fine.
    # To handle "subfolders", os.walk is good.
    
    counts = {}

    for root, dirs, files in os.walk(directory):
        root_path = Path(root)
        count = len(files)
        if count > 0:
            counts[root_path] = count
            total_files += count

    # Sort by path
    for path in sorted(counts.keys()):
        # distinct display for clarity
        rel_path = path.relative_to(directory.parent)
        print(f"{str(rel_path):<60} | {counts[path]:<10}")
    
    print("-" * 73)
    print(f"{'Total':<60} | {total_files:<10}")

def main():
    parser = argparse.ArgumentParser(description="Count files in directories and subdirectories.")
    parser.add_argument("directory", nargs="?", default=".", help="Directory to count files in (default: current)")
    args = parser.parse_args()
    
    count_files(args.directory)

if __name__ == "__main__":
    main()
