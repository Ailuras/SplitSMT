#!/usr/bin/env python3
"""Temporary script to fix benchmarks_splitsmt/RealWorld files.

Removes declare-fun statements and updates function calls to use str. prefix.
Also removes unused get_split_length_re and get_split_element_re definitions.
"""

from pathlib import Path
import re

def fix_file(file_path: Path) -> bool:
    """Fix a single SMT2 file. Returns True if modified."""
    content = file_path.read_text(encoding='utf-8')
    original_content = content
    
    # Remove the three declare-fun statements for _re functions
    lines_to_remove = [
        r'\(declare-fun split_at_re \(String RegLan Int\) String\)',
        r'\(declare-fun split_rest_re \(String RegLan Int\) String\)',
        r'\(declare-fun num_splits_re \(String RegLan\) Int\)',
    ]
    
    for pattern in lines_to_remove:
        content = re.sub(pattern + r'\s*\n?', '', content)
    
    # Replace function calls with str. prefix
    replacements = [
        (r'\(num_splits_re\b', '(str.num_splits_re'),
        (r'\(split_rest_re\b', '(str.split_rest_re'),
        (r'\(split_at_re\b', '(str.split_at_re'),
    ]
    
    for old, new in replacements:
        content = re.sub(old, new, content)
    
    # Check if get_split_length_re and get_split_element_re are actually used
    # These are define-fun-rec definitions that may be unused
    
    # Check for get_split_length_re: look for calls like (get_split_length_re ...)
    # but not the definition itself
    has_get_split_length_re_call = bool(re.search(r'\(get_split_length_re\s+[^)]+\)', content))
    has_get_split_length_re_def = bool(re.search(r'\(define-fun(?:-rec)?\s+get_split_length_re\b', content))
    
    # Check for get_split_element_re: look for calls like (get_split_element_re ...)
    has_get_split_element_re_call = bool(re.search(r'\(get_split_element_re\s+[^)]+\)', content))
    has_get_split_element_re_def = bool(re.search(r'\(define-fun(?:-rec)?\s+get_split_element_re\b', content))
    
    # Remove unused get_split_length_re definition
    if has_get_split_length_re_def and not has_get_split_length_re_call:
        # Match the entire define-fun-rec block by matching balanced parentheses
        content = remove_define_fun(content, 'get_split_length_re')
    
    # Remove unused get_split_element_re definition
    if has_get_split_element_re_def and not has_get_split_element_re_call:
        content = remove_define_fun(content, 'get_split_element_re')
    
    if content != original_content:
        file_path.write_text(content, encoding='utf-8')
        return True
    return False


def remove_define_fun(content: str, func_name: str) -> str:
    """Remove a define-fun or define-fun-rec block for the given function name."""
    # Find the start of the definition
    pattern = re.compile(r'\(define-fun(?:-rec)?\s+' + re.escape(func_name) + r'\b')
    match = pattern.search(content)
    if not match:
        return content
    
    start = match.start()
    
    # Find the matching closing parenthesis
    paren_count = 0
    end = start
    for i, char in enumerate(content[start:], start):
        if char == '(':
            paren_count += 1
        elif char == ')':
            paren_count -= 1
            if paren_count == 0:
                end = i + 1
                break
    
    # Remove the definition (and any trailing whitespace/newline)
    after_def = content[end:]
    # Remove leading whitespace/newlines after the definition
    after_def = re.sub(r'^\s*\n?', '', after_def)
    content = content[:start] + after_def
    
    return content


def main():
    base_dir = Path("benchmarks_splitsmt/RealWorld")
    
    if not base_dir.exists():
        print(f"Error: {base_dir} not found")
        return 1
    
    modified_count = 0
    total_count = 0
    
    for smt2_file in base_dir.rglob("*.smt2"):
        total_count += 1
        if fix_file(smt2_file):
            modified_count += 1
            print(f"Fixed: {smt2_file}")
    
    print(f"\nProcessed {total_count} files, modified {modified_count} files")
    return 0


if __name__ == "__main__":
    import sys
    sys.exit(main())
