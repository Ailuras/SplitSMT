#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SMT-LIB Auto Mutator with Difficulty Levels
This script mutates SMT-LIB files by introducing custom string functions:
- str.split_at: returns the I-th part when splitting a string by delimiter
- str.split_rest: returns the remaining parts when splitting a string by delimiter
- str.num_splits: returns the number of parts when splitting a string by delimiter
"""

import os
import re
import random
import string
import argparse
from typing import List, Set, Tuple, Optional, Dict
from enum import Enum
import glob

class DifficultyLevel(Enum):
    EASY = "easy"
    MEDIUM = "medium"
    HARD = "hard"

class SMTMutator:
    def __init__(self, difficulty: DifficultyLevel = DifficultyLevel.MEDIUM):
        self.difficulty = difficulty
        self.random_gen = random.Random()
        
        # 分隔符按难度分类
        self.easy_delimiters = [",", " ", ";", "-", ".", "_", "|", ":", "/", "#"]
        self.medium_delimiters = ["::", "--", "##", "||", "..", "__", ";;", ",,"]
        self.hard_delimiters = [":::", "---", "####", "|||", "...", "___", ";;;", ",,,", "->", "=>", "<->"]
        
        # 根据难度级别设置参数
        self.config = self._get_difficulty_config()
        
    def _get_difficulty_config(self) -> Dict:
        """根据难度级别返回配置参数"""
        if self.difficulty == DifficultyLevel.EASY:
            return {
                "min_constraints": 2,
                "max_constraints": 4,
                "preferred_delimiters": self.easy_delimiters,
                "max_index": 2,
                "functions": ["split_at"],
                "constraint_complexity": "simple",
                "min_partitions": 1,
                "max_partitions": 1
            }
        elif self.difficulty == DifficultyLevel.MEDIUM:
            return {
                "min_constraints": 3,
                "max_constraints": 6,
                "preferred_delimiters": self.easy_delimiters + self.medium_delimiters,
                "max_index": 3,
                "functions": ["split_at", "split_rest"],
                "constraint_complexity": "medium",
                "min_partitions": 2,
                "max_partitions": 3
            }
        else:  # HARD
            return {
                "min_constraints": 4,
                "max_constraints": 8,
                "preferred_delimiters": self.easy_delimiters + self.medium_delimiters + self.hard_delimiters,
                "max_index": 4,
                "functions": ["split_at", "split_rest", "num_splits"],
                "constraint_complexity": "complex",
                "min_partitions": 2,
                "max_partitions": 4
            }
    
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
        delimiters = set(self.config["preferred_delimiters"])
        
        # Extract string literals for additional delimiter candidates
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
                                     string_vars: List[str], count: int) -> Tuple[List[str], List[str]]:
        """Generate str.split_at related constraints"""
        declarations = []
        assertions = []
        
        for i in range(count):
            # Choose index based on difficulty
            idx = self.random_gen.randint(0, self.config["max_index"])
            
            # Choose RHS value type
            rhs_type = self.random_gen.choice(["existing_var", "new_string", "new_var"])
            escaped_delimiter = self.escape_smt_string(delimiter)
            
            if rhs_type == "existing_var" and string_vars:
                # Use existing string variable
                rhs_value = self.random_gen.choice(string_vars)
                assertions.append(f"(assert (= (str.split_at {target_var} {escaped_delimiter} {idx}) {rhs_value}))")
                
            elif rhs_type == "new_string":
                # Generate new string literal
                str_length = self.random_gen.randint(3, 10)
                random_str = self.generate_random_string(str_length, delimiter)
                escaped_str = self.escape_smt_string(random_str)
                assertions.append(f"(assert (= (str.split_at {target_var} {escaped_delimiter} {idx}) {escaped_str}))")
                
            else:  # new_var
                # Create new string variable
                new_var = f"part_{i}_{self.random_gen.randint(1000, 9999)}"
                declarations.append(f"(declare-const {new_var} String)")
                assertions.append(f"(assert (= (str.split_at {target_var} {escaped_delimiter} {idx}) {new_var}))")
                
                # Add additional constraint for the new variable
                if self.config["constraint_complexity"] != "simple":
                    constraint_type = self.random_gen.choice(["length", "contains", "prefix", "suffix"])
                    if constraint_type == "length":
                        length = self.random_gen.randint(1, 12)
                        assertions.append(f"(assert (= (str.len {new_var}) {length}))")
                    elif constraint_type == "contains":
                        char = self.random_gen.choice("abcdefghijk")
                        assertions.append(f"(assert (str.contains {new_var} \"{char}\"))")
                    elif constraint_type == "prefix":
                        prefix = self.random_gen.choice(["a", "b", "c", "ab", "bc"])
                        assertions.append(f"(assert (str.prefixof \"{prefix}\" {new_var}))")
                    else:  # suffix
                        suffix = self.random_gen.choice(["x", "y", "z", "xy", "yz"])
                        assertions.append(f"(assert (str.suffixof \"{suffix}\" {new_var}))")
        
        return declarations, assertions
    
    def generate_split_rest_constraints(self, target_var: str, delimiter: str, 
                                       string_vars: List[str], count: int) -> Tuple[List[str], List[str]]:
        """Generate str.split_rest related constraints"""
        declarations = []
        assertions = []
        
        for i in range(count):
            # Choose index based on difficulty
            idx = self.random_gen.randint(0, self.config["max_index"])
            
            # Choose RHS value type
            rhs_type = self.random_gen.choice(["new_var", "new_string"])
            escaped_delimiter = self.escape_smt_string(delimiter)
            
            if rhs_type == "new_string":
                # Generate new string literal
                str_length = self.random_gen.randint(5, 15)
                random_str = self.generate_random_string(str_length, delimiter)
                escaped_str = self.escape_smt_string(random_str)
                assertions.append(f"(assert (= (str.split_rest {target_var} {escaped_delimiter} {idx}) {escaped_str}))")
                
            else:  # new_var
                # Create new string variable
                new_var = f"rest_{i}_{self.random_gen.randint(1000, 9999)}"
                declarations.append(f"(declare-const {new_var} String)")
                assertions.append(f"(assert (= (str.split_rest {target_var} {escaped_delimiter} {idx}) {new_var}))")
                
                # Add additional constraint for the new variable
                if self.config["constraint_complexity"] == "complex":
                    constraint_type = self.random_gen.choice(["length", "contains", "indexof"])
                    if constraint_type == "length":
                        length = self.random_gen.randint(5, 20)
                        assertions.append(f"(assert (>= (str.len {new_var}) {length}))")
                    elif constraint_type == "contains":
                        char = self.random_gen.choice("abcdefghijk")
                        assertions.append(f"(assert (str.contains {new_var} \"{char}\"))")
                    else:  # indexof
                        substr = self.random_gen.choice(["a", "b", "ab", "bc"])
                        assertions.append(f"(assert (>= (str.indexof {new_var} \"{substr}\" 0) 0))")
        
        return declarations, assertions
    
    def generate_num_splits_constraints(self, target_var: str, delimiter: str, 
                                       string_vars: List[str], count: int) -> Tuple[List[str], List[str]]:
        """Generate str.num_splits related constraints"""
        declarations = []
        assertions = []
        
        for i in range(count):
            # Choose constraint type
            constraint_type = self.random_gen.choice(["exact", "range", "comparison"])
            escaped_delimiter = self.escape_smt_string(delimiter)
            
            if constraint_type == "exact":
                # Exact number of splits
                num = self.random_gen.randint(2, 6)
                assertions.append(f"(assert (= (str.num_splits {target_var} {escaped_delimiter}) {num}))")
                
            elif constraint_type == "range":
                # Range constraint
                min_num = self.random_gen.randint(1, 3)
                max_num = min_num + self.random_gen.randint(2, 4)
                assertions.append(f"(assert (and (>= (str.num_splits {target_var} {escaped_delimiter}) {min_num}) (<= (str.num_splits {target_var} {escaped_delimiter}) {max_num})))")
                
            else:  # comparison
                # Create new integer variable for comparison
                new_var = f"num_{i}_{self.random_gen.randint(1000, 9999)}"
                declarations.append(f"(declare-const {new_var} Int)")
                assertions.append(f"(assert (= (str.num_splits {target_var} {escaped_delimiter}) {new_var}))")
                
                # Add constraint on the new variable
                op = self.random_gen.choice([">", ">=", "<", "<="])
                value = self.random_gen.randint(1, 8)
                assertions.append(f"(assert ({op} {new_var} {value}))")
        
        return declarations, assertions
    
    def generate_partitions(self, string_vars: List[str], delimiters: List[str]) -> List[Tuple[str, str]]:
        """Generate multiple partitions (variable, delimiter) pairs based on difficulty"""
        num_partitions = self.random_gen.randint(self.config["min_partitions"], self.config["max_partitions"])
        
        # Ensure we don't exceed available variables
        num_partitions = min(num_partitions, len(string_vars))
        
        partitions = []
        used_combinations = set()
        
        attempts = 0
        max_attempts = 50
        
        while len(partitions) < num_partitions and attempts < max_attempts:
            # Choose variable and delimiter
            var = self.random_gen.choice(string_vars)
            delimiter = self.random_gen.choice(delimiters)
            
            combination = (var, delimiter)
            
            # Avoid duplicate combinations
            if combination not in used_combinations:
                partitions.append(combination)
                used_combinations.add(combination)
            
            attempts += 1
        
        # If we couldn't generate enough unique combinations, create more by varying delimiters
        while len(partitions) < num_partitions and len(partitions) < len(string_vars) * len(delimiters):
            for var in string_vars:
                if len(partitions) >= num_partitions:
                    break
                for delimiter in delimiters:
                    combination = (var, delimiter)
                    if combination not in used_combinations:
                        partitions.append(combination)
                        used_combinations.add(combination)
                        if len(partitions) >= num_partitions:
                            break
        
        return partitions
    
    def generate_constraints_for_partition(self, target_var: str, delimiter: str, 
                                         string_vars: List[str], constraints_count: int) -> Tuple[List[str], List[str]]:
        """Generate constraints for a single partition"""
        all_declarations = []
        all_assertions = []
        
        available_functions = self.config["functions"]
        
        # Distribute constraints among available functions for this partition
        constraints_per_function = {}
        remaining_constraints = constraints_count
        
        if len(available_functions) == 1:
            constraints_per_function[available_functions[0]] = remaining_constraints
        else:
            for func in available_functions[:-1]:
                if remaining_constraints <= 0:
                    break
                count = self.random_gen.randint(0, max(1, remaining_constraints // 2))
                constraints_per_function[func] = count
                remaining_constraints -= count
            
            # Assign remaining constraints to the last function
            if available_functions and remaining_constraints > 0:
                constraints_per_function[available_functions[-1]] = remaining_constraints
        
        # Generate constraints for each function
        for func, count in constraints_per_function.items():
            if count <= 0:
                continue
                
            if func == "split_at":
                decls, asserts = self.generate_split_at_constraints(target_var, delimiter, string_vars, count)
            elif func == "split_rest":
                decls, asserts = self.generate_split_rest_constraints(target_var, delimiter, string_vars, count)
            elif func == "num_splits":
                decls, asserts = self.generate_num_splits_constraints(target_var, delimiter, string_vars, count)
            else:
                continue
                
            all_declarations.extend(decls)
            all_assertions.extend(asserts)
        
        return all_declarations, all_assertions
    
    def generate_constraints(self, string_vars: List[str], delimiters: List[str]) -> Tuple[List[str], List[str]]:
        """Generate all types of constraints based on difficulty with multiple partitions"""
        all_declarations = []
        all_assertions = []
        
        # Generate partitions
        partitions = self.generate_partitions(string_vars, delimiters)
        
        if not partitions:
            # Fallback to single partition
            target_var = self.random_gen.choice(string_vars)
            delimiter = self.random_gen.choice(delimiters)
            partitions = [(target_var, delimiter)]
        
        total_constraints = self.random_gen.randint(self.config["min_constraints"], self.config["max_constraints"])
        
        # Distribute constraints among partitions
        constraints_per_partition = []
        remaining_constraints = total_constraints
        
        for i in range(len(partitions) - 1):
            count = self.random_gen.randint(1, max(1, remaining_constraints // (len(partitions) - i)))
            constraints_per_partition.append(count)
            remaining_constraints -= count
        
        # Assign remaining constraints to the last partition
        constraints_per_partition.append(max(1, remaining_constraints))
        
        # Generate constraints for each partition
        partition_info = []
        for i, (target_var, delimiter) in enumerate(partitions):
            constraint_count = constraints_per_partition[i]
            
            decls, asserts = self.generate_constraints_for_partition(target_var, delimiter, string_vars, constraint_count)
            all_declarations.extend(decls)
            all_assertions.extend(asserts)
            
            partition_info.append(f"{target_var}:'{delimiter}'({constraint_count})")
        
        print(f"Generated {len(partitions)} partitions: {', '.join(partition_info)}")
        
        return all_declarations, all_assertions
    
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
            
            # Collect delimiter candidates
            delimiters = self.collect_delimiter_candidates(content)
            
            print(f"[{self.difficulty.value.upper()}] Variables: {string_vars}, Delimiters: {delimiters[:5]}...")
            
            # Generate constraints with multiple partitions
            all_declarations, all_assertions = self.generate_constraints(string_vars, delimiters)
            
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

def batch_mutate(input_pattern: str, output_dir: str, seed: Optional[int] = None):
    """Batch mutation with difficulty levels"""
    
    # Set random seed if provided
    if seed is not None:
        random.seed(seed)
        print(f"Using random seed: {seed}")
    
    # Get all input files
    input_files = glob.glob(input_pattern)
    if not input_files:
        print(f"No files found matching pattern: {input_pattern}")
        return
    
    print(f"Found {len(input_files)} input files")
    
    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)
    
    # Generate for each difficulty level
    difficulties = [DifficultyLevel.EASY, DifficultyLevel.MEDIUM, DifficultyLevel.HARD]
    
    for difficulty in difficulties:
        print(f"\n=== Generating {difficulty.value.upper()} difficulty mutations ===")
        
        # Create difficulty-specific output directory
        diff_output_dir = os.path.join(output_dir, difficulty.value)
        os.makedirs(diff_output_dir, exist_ok=True)
        
        mutator = SMTMutator(difficulty)
        
        success_count = 0
        
        for i, input_file in enumerate(input_files):
            base_name = os.path.splitext(os.path.basename(input_file))[0]
            output_file = os.path.join(diff_output_dir, f"{base_name}_{difficulty.value}.smt2")
            
            print(f"Processing [{i+1}/{len(input_files)}]: {input_file}")
            
            if mutator.mutate(input_file, output_file):
                success_count += 1
        
        print(f"Successfully generated {success_count}/{len(input_files)} {difficulty.value} mutations")

def main():
    parser = argparse.ArgumentParser(description='Mutate SMT-LIB files with custom string functions')
    parser.add_argument('--input', required=True, help='Input SMT file path or pattern (e.g., "test/*.smt2")')
    parser.add_argument('--output', required=True, help='Output directory or file path')
    parser.add_argument('--seed', type=int, default=None, help='Random seed for reproducibility')
    parser.add_argument('--difficulty', choices=['easy', 'medium', 'hard'], 
                       help='Difficulty level (if not specified, batch mode for all levels)')
    parser.add_argument('--batch', action='store_true', help='Enable batch mode for all difficulty levels')
    
    args = parser.parse_args()
    
    if args.batch or args.difficulty is None:
        # Batch mode
        batch_mutate(args.input, args.output, args.seed)
    else:
        # Single file mode
        if args.seed is not None:
            random.seed(args.seed)
        
        difficulty = DifficultyLevel(args.difficulty)
        mutator = SMTMutator(difficulty)
        success = mutator.mutate(args.input, args.output)
        
        if success:
            print("Mutation successful!")
        else:
            print("Mutation failed or no changes made.")

if __name__ == "__main__":
    main()