#!/usr/bin/env python3
"""
SMT file cleaning script
Features:
1. For push/pop examples, only keep constraints before the first check-sat
2. Remove commands like (push), (pop), (get-model), (get-unsat-core)
3. Change (set-logic QF_S) to (set-logic QF_SLIA)
"""

import sys
import re
import argparse
from pathlib import Path


def clean_smt_file(input_file, output_file):
    """Clean a single SMT file"""
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()
    except Exception as e:
        print(f"Error: Cannot read file {input_file}: {e}", file=sys.stderr)
        return False
    
    cleaned_lines = []
    found_first_check_sat = False
    in_push_pop_block = False
    push_count = 0
    
    for line in lines:
        stripped = line.strip()
        
        # Skip empty lines
        if not stripped:
            cleaned_lines.append(line)
            continue
        
        # Replace set-logic QF_S with QF_SLIA
        if re.match(r'^\(set-logic\s+QF_S\)', stripped):
            line = line.replace('QF_S', 'QF_SLIA')
            cleaned_lines.append(line)
            continue
        
        # Check if this is the first check-sat
        if re.match(r'^\(check-sat\)', stripped) and not found_first_check_sat:
            found_first_check_sat = True
            cleaned_lines.append(line)
            continue
        
        # If first check-sat is found, check if entering push/pop block
        if found_first_check_sat:
            # Check if this is push
            if re.match(r'^\(push\)', stripped):
                in_push_pop_block = True
                push_count = 1
                continue
            
            # If in push/pop block
            if in_push_pop_block:
                # Check if this is pop
                if re.match(r'^\(pop\)', stripped):
                    push_count -= 1
                    if push_count == 0:
                        in_push_pop_block = False
                # Check if this is push (nested)
                elif re.match(r'^\(push\)', stripped):
                    push_count += 1
                continue
        
        # Skip unwanted commands
        if (re.match(r'^\(pop\)', stripped) or
            re.match(r'^\(get-model\)', stripped) or
            re.match(r'^\(get-unsat-core\)', stripped) or
            re.match(r'^\(push\)', stripped)):
            continue
        
        # If first check-sat is found and not in push/pop block, skip subsequent content
        if found_first_check_sat and not in_push_pop_block:
            # Only keep exit command
            if re.match(r'^\(exit\)', stripped):
                cleaned_lines.append(line)
            continue
        
        # Keep other lines
        cleaned_lines.append(line)
    
    # Write to output file
    try:
        # Ensure output directory exists
        output_path = Path(output_file)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        with open(output_file, 'w', encoding='utf-8') as f:
            f.writelines(cleaned_lines)
        
        print(f"Processing complete: {Path(input_file).name} ({len(lines)} -> {len(cleaned_lines)} lines)")
        return True
        
    except Exception as e:
        print(f"Error: Cannot write file {output_file}: {e}", file=sys.stderr)
        return False


def main():
    parser = argparse.ArgumentParser(description='Clean SMT files')
    parser.add_argument('input_file', help='Input file path')
    parser.add_argument('output_file', help='Output file path')
    parser.add_argument('-v', '--verbose', action='store_true', help='Show detailed information')
    
    args = parser.parse_args()
    
    # Check input file
    if not Path(args.input_file).exists():
        print(f"Error: Input file does not exist: {args.input_file}", file=sys.stderr)
        sys.exit(1)
    
    # Clean file
    success = clean_smt_file(args.input_file, args.output_file)
    
    if not success:
        sys.exit(1)


if __name__ == '__main__':
    main() 