#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
File Renamer Script
This script renames mutated SMT files by removing the mutation suffixes.
- *_mut.smt2 -> *.smt2
- *_llm_mut.smt2 -> *.smt2
"""

import os
import sys
import argparse
import shutil
from pathlib import Path

def rename_files_in_directory(directory: str, dry_run: bool = False) -> None:
    """Rename files in a directory to remove mutation suffixes"""
    if not os.path.exists(directory):
        print(f"Directory not found: {directory}")
        return
    
    renamed_count = 0
    skipped_count = 0
    
    print(f"Processing directory: {directory}")
    
    for filename in sorted(os.listdir(directory)):
        if not filename.endswith('.smt2'):
            continue
            
        old_path = os.path.join(directory, filename)
        new_filename = None
        
        # Check for mutation suffixes
        if filename.endswith('_llm_mut.smt2'):
            new_filename = filename.replace('_llm_mut.smt2', '.smt2')
        elif filename.endswith('_mut.smt2'):
            new_filename = filename.replace('_mut.smt2', '.smt2')
        
        if new_filename:
            new_path = os.path.join(directory, new_filename)
            
            # Check if target file already exists
            if os.path.exists(new_path):
                print(f"  SKIP: {filename} -> {new_filename} (target exists)")
                skipped_count += 1
                continue
            
            if dry_run:
                print(f"  DRY-RUN: {filename} -> {new_filename}")
            else:
                try:
                    shutil.move(old_path, new_path)
                    print(f"  RENAMED: {filename} -> {new_filename}")
                    renamed_count += 1
                except Exception as e:
                    print(f"  ERROR: Failed to rename {filename}: {e}")
                    skipped_count += 1
        else:
            print(f"  SKIP: {filename} (no mutation suffix)")
            skipped_count += 1
    
    print(f"\nSummary for {directory}:")
    print(f"  Renamed: {renamed_count}")
    print(f"  Skipped: {skipped_count}")

def main():
    parser = argparse.ArgumentParser(description='Remove mutation suffixes from SMT file names')
    parser.add_argument('directories', nargs='+', help='Directories to process')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be renamed without actually doing it')
    parser.add_argument('--confirm', action='store_true', help='Ask for confirmation before each directory')
    
    args = parser.parse_args()
    
    total_directories = len(args.directories)
    
    print("SMT File Renamer")
    print("================")
    print(f"Will process {total_directories} director{'y' if total_directories == 1 else 'ies'}:")
    for directory in args.directories:
        print(f"  - {directory}")
    
    if args.dry_run:
        print("\n*** DRY RUN MODE - No files will be renamed ***")
    
    print()
    
    for i, directory in enumerate(args.directories, 1):
        print(f"[{i}/{total_directories}] Processing: {directory}")
        
        if args.confirm and not args.dry_run:
            response = input(f"Proceed with renaming files in '{directory}'? (y/N): ")
            if response.lower() not in ['y', 'yes']:
                print("  Skipped by user")
                continue
        
        rename_files_in_directory(directory, args.dry_run)
        print()
    
    if args.dry_run:
        print("Dry run completed. Use without --dry-run to actually rename files.")
    else:
        print("All directories processed!")

if __name__ == "__main__":
    main() 