#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SMT-LIB Auto Mutator
This script mutates SMT-LIB files by introducing custom string functions:
- str.split_at: returns the I-th part when splitting a string by delimiter
"""

import os
import re
import random
import string
import argparse
from typing import List, Set, Tuple, Optional

class SMTMutator:
    def __init__(self):
        self.default_delimiters = [",", " ", ";", "-", ".", "_", "|", ":", "/"]
        self.random_gen = random.Random()
        
    def extract_string_variables(self, content: str) -> List[str]:
        """Extract declared string variable names from SMT content"""
        string_vars = []
        
        # Pattern for (declare-const var String) or (declare-fun var () String)
        declare_patterns = [
            r'\(declare-const\s+(\w+)\s+String\)',
            r'\(declare-fun\s+(\w+)\s+\(\)\s+String\)'
        ]
        
        for pattern in declare_patterns:
            matches = re.findall(pattern, content, re.IGNORECASE)
            string_vars.extend(matches)
        
        return list(set(string_vars))  # Remove duplicates
    
    def extract_string_literals(self, content: str) -> Set[str]:
        """Extract string literals from SMT content"""
        # Pattern for string literals: "content"
        pattern = r'"([^"\\]*(?:\\.[^"\\]*)*)"'
        matches = re.findall(pattern, content)
        return set(matches)
    
    def collect_delimiter_candidates(self, content: str) -> List[str]:
        """Collect potential delimiters from file content"""
        delimiters = set(self.default_delimiters)
        
        # Extract string literals
        string_literals = self.extract_string_literals(content)
        
        # Add single characters from string literals
        for literal in string_literals:
            for char in literal:
                if len(char) == 1 and char.isprintable() and char not in string.ascii_letters:
                    delimiters.add(char)
        
        # Add short string literals themselves
        for literal in string_literals:
            if 1 <= len(literal) <= 3:
                delimiters.add(literal)
        
        return list(delimiters)
    
    def escape_smt_string(self, s: str) -> str:
        """Escape string for SMT-LIB format"""
        # Escape quotes and backslashes
        s = s.replace('\\', '\\\\')
        s = s.replace('"', '\\"')
        return f'"{s}"'
    
    def generate_random_string(self, length: int, avoid_delimiter: str = "") -> str:
        """Generate a random string that likely doesn't contain the delimiter"""
        chars = string.ascii_lowercase + string.digits
        if avoid_delimiter:
            chars = ''.join(c for c in chars if c != avoid_delimiter)
        
        result = ''.join(self.random_gen.choice(chars) for _ in range(length))
        # Make sure it doesn't contain the delimiter
        if avoid_delimiter and avoid_delimiter in result:
            result = result.replace(avoid_delimiter, 'x')
        
        return result
    

    
    def generate_split_at_constraints(self, target_var: str, delimiter: str, 
                                     string_vars: List[str]) -> Tuple[List[str], List[str]]:
        """Generate str.split_at related constraints"""
        declarations = []
        assertions = []
        
        # Generate 1-2 split_at constraints
        num_constraints = self.random_gen.randint(1, 2)
        
        for i in range(num_constraints):
            # Choose a small index
            idx = self.random_gen.randint(0, 2)
            
            # Choose RHS value type
            rhs_type = self.random_gen.choice(["existing_var", "new_string", "new_var"])
            escaped_delimiter = self.escape_smt_string(delimiter)
            
            if rhs_type == "existing_var" and string_vars:
                # Use existing string variable
                rhs_value = self.random_gen.choice(string_vars)
                assertions.append(f"(assert (= (str.split_at {target_var} {escaped_delimiter} {idx}) {rhs_value}))")
                
            elif rhs_type == "new_string":
                # Generate new string literal
                str_length = self.random_gen.randint(3, 7)
                random_str = self.generate_random_string(str_length, delimiter)
                escaped_str = self.escape_smt_string(random_str)
                assertions.append(f"(assert (= (str.split_at {target_var} {escaped_delimiter} {idx}) {escaped_str}))")
                
            else:  # new_var
                # Create new string variable
                new_var = f"part_{i}_{self.random_gen.randint(1000, 9999)}"
                declarations.append(f"(declare-const {new_var} String)")
                assertions.append(f"(assert (= (str.split_at {target_var} {escaped_delimiter} {idx}) {new_var}))")
                
                # Add additional constraint for the new variable
                constraint_type = self.random_gen.choice(["length", "contains"])
                if constraint_type == "length":
                    length = self.random_gen.randint(1, 8)
                    assertions.append(f"(assert (= (str.len {new_var}) {length}))")
                else:  # contains
                    char = self.random_gen.choice("abcdefg")
                    assertions.append(f"(assert (str.contains {new_var} \"{char}\"))")
        
        return declarations, assertions
    
    def find_insertion_points(self, lines: List[str]) -> Tuple[int, int]:
        """Find where to insert declarations and assertions"""
        decl_insert_point = -1
        assert_insert_point = -1
        
        for i, line in enumerate(lines):
            line_stripped = line.strip()
            
            # Find last declaration or after set-logic
            if (line_stripped.startswith("(declare-") or 
                line_stripped.startswith("(set-logic")):
                decl_insert_point = i + 1
            
            # Find check-sat for assertion insertion
            if line_stripped.startswith("(check-sat"):
                assert_insert_point = i
                break
        
        # If no declarations found, insert after set-logic or at beginning
        if decl_insert_point == -1:
            for i, line in enumerate(lines):
                if line.strip().startswith("(set-logic"):
                    decl_insert_point = i + 1
                    break
            else:
                decl_insert_point = 0
        
        # If no check-sat found, insert at end
        if assert_insert_point == -1:
            assert_insert_point = len(lines)
        
        return decl_insert_point, assert_insert_point
    
    def mutate(self, seed_filepath: str, output_filepath: str) -> bool:
        """Main mutation function"""
        try:
            # Read the seed file
            with open(seed_filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Extract string variables
            string_vars = self.extract_string_variables(content)
            
            if not string_vars:
                print(f"No string variables found in {seed_filepath}, copying as-is")
                with open(output_filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                return False
            
            print(f"Found {len(string_vars)} string variables: {string_vars}")
            
            # Collect delimiter candidates
            delimiters = self.collect_delimiter_candidates(content)
            print(f"Found {len(delimiters)} delimiter candidates: {delimiters[:10]}...")
            
            # Select target variable and delimiter
            target_var = self.random_gen.choice(string_vars)
            delimiter = self.random_gen.choice(delimiters)
            
            print(f"Selected target: {target_var}, delimiter: '{delimiter}'")
            
            # Generate constraints
            split_at_decls, split_at_asserts = self.generate_split_at_constraints(target_var, delimiter, string_vars)
            
            # Combine all new content
            all_declarations = split_at_decls
            all_assertions = split_at_asserts
            
            print(f"Generated {len(all_declarations)} declarations and {len(all_assertions)} assertions")
            
            # Process the file
            lines = content.split('\n')
            decl_point, assert_point = self.find_insertion_points(lines)
            
            # Insert declarations
            for i, decl in enumerate(reversed(all_declarations)):
                lines.insert(decl_point, decl)
            
            # Update assertion insertion point (it may have shifted)
            assert_point += len(all_declarations)
            
            # Insert assertions
            for i, assertion in enumerate(reversed(all_assertions)):
                lines.insert(assert_point, assertion)
            
            # Write output file
            output_content = '\n'.join(lines)
            with open(output_filepath, 'w', encoding='utf-8') as f:
                f.write(output_content)
            
            print(f"Mutation completed: {seed_filepath} -> {output_filepath}")
            return True
            
        except Exception as e:
            print(f"Error during mutation: {e}")
            return False

def main():
    parser = argparse.ArgumentParser(description='Mutate SMT-LIB files with custom string functions')
    parser.add_argument('--input', required=True, help='Input SMT file path')
    parser.add_argument('--output', required=True, help='Output SMT file path')
    parser.add_argument('--seed', type=int, default=None, help='Random seed for reproducibility')
    
    args = parser.parse_args()
    
    # Set random seed if provided
    if args.seed is not None:
        random.seed(args.seed)
        print(f"Using random seed: {args.seed}")
    
    # Create mutator and run
    mutator = SMTMutator()
    success = mutator.mutate(args.input, args.output)
    
    if success:
        print("Mutation successful!")
    else:
        print("Mutation failed or no changes made.")

if __name__ == "__main__":
    main()

# python scripts/auto_mutator.py --input test/05_track_99.smt2 --output test/05_track_99_mut.smt2