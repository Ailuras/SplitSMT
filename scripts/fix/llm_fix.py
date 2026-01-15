#!/usr/bin/env python3
"""
LLM-based SMT2 file fixer for delimiter syntax issues.

Usage:
    python llm_fix.py input.smt2 output.smt2           # Single file
    python llm_fix.py input_dir/ output_dir/           # Directory
    python llm_fix.py input.smt2 output.smt2 --provider openai --model gpt-5.2
"""

import argparse
import json
import os
import sys
from pathlib import Path

import litellm

# ============================================================================
# Provider Configuration (embedded)
# ============================================================================
PROVIDERS = {
    "openai": {
        "api_key": "sk-efXPlQhcIwWtPScBSKdyPQnFozFOcWjIfbygmrn415h5oAuh",
        "api_base": "https://api2.aigcbest.top/v1",
        "default_model": "gpt-5.2",
        "models": {
            "gpt-5.2": {"max_tokens": 8192, "temperature": 1}
        },
        "request_params": {"custom_llm_provider": "openai"}
    },
    "claude": {
        "api_key": "sk-efXPlQhcIwWtPScBSKdyPQnFozFOcWjIfbygmrn415h5oAuh",
        "api_base": "https://api2.aigcbest.top/v1",
        "default_model": "claude-sonnet-4-5-20250929",
        "models": {
            "claude-sonnet-4-5-20250929": {"max_tokens": 8192, "temperature": 0.7}
        },
        "request_params": {"custom_llm_provider": "openai"}
    },
    "deepseek": {
        "api_key": "sk-e23b427628a84830a87196feb49cb354",
        "api_base": "https://api.deepseek.com",
        "default_model": "deepseek-chat",
        "models": {
            "deepseek-chat": {"max_tokens": 8192, "temperature": 0.6},
            "deepseek-reasoner": {"max_tokens": 8192, "temperature": 0.6}
        },
        "request_params": {"custom_llm_provider": "deepseek"}
    }
}

# ============================================================================
# Prompt Template
# ============================================================================
SYSTEM_PROMPT = """You are an expert in SMT-LIB 2.6 syntax. Your task is to fix delimiter-related syntax issues in SMT2 files.

## SMT-LIB String Literal Syntax

In SMT-LIB 2.6, string literals have specific escape sequence rules:

### 1. Valid Escape Sequences
- `""` - Double quote (escaped by doubling)
- `\\u{XXXX}` or `\\u{XXXXX}` - Unicode code point (1-5 hex digits)

### 2. INVALID Escape Sequences (Common Mistakes)
These are NOT valid in SMT-LIB and will be parsed as literal characters:
- `\\t` → Should be `\\u{09}` (Tab)
- `\\n` → Should be `\\u{0A}` (Newline)  
- `\\r` → Should be `\\u{0D}` (Carriage Return)
- `\\u005c` or `\\u005C` → Should be `\\u{5C}` (Backslash with braces)
- `\\u005ct` → Should be `\\u{09}` (This is \\t, a Tab character)
- `\\u005cn` → Should be `\\u{0A}` (This is \\n, a Newline character)

### 3. Regex Delimiters - INLINE CONVERSION
If a delimiter looks like a regex pattern (e.g., `\\s*`, `\\s+`, `\\R`), convert it to an INLINE RegLan expression.
**CRITICAL: Do NOT create auxiliary variables. Inline the RegLan expression directly.**

Use `_re` versions of functions: `get_split_length_re`, `get_split_element_re`, `split_at_re`, `split_rest_re`, `num_splits_re`

### RegLan Syntax Rules (IMPORTANT!)
- `str.to_re` converts a STRING to RegLan: `(str.to_re "x")` 
- `re.union` takes MULTIPLE RegLan args: `(re.union (str.to_re "a") (str.to_re "b"))`
- `re.+` takes EXACTLY ONE RegLan arg: `(re.+ <reglan>)` - one or more
- `re.*` takes EXACTLY ONE RegLan arg: `(re.* <reglan>)` - zero or more
- `re.++` concatenates MULTIPLE RegLan args: `(re.++ <reglan1> <reglan2> ...)`

Common regex patterns and their INLINE RegLan equivalents:
- `\\s` → `(re.union (str.to_re " ") (str.to_re "\\u{09}"))`
- `\\s+` → `(re.+ (re.union (str.to_re " ") (str.to_re "\\u{09}")))`
- `\\s*` → `(re.* (re.union (str.to_re " ") (str.to_re "\\u{09}")))`
- `\\R` (line terminator) → `(re.union (str.to_re "\\u{0D}") (str.to_re "\\u{0A}"))` or simplified to `(str.to_re "\\u{0A}")`
- `\\R+` → `(re.+ (re.union (str.to_re "\\u{0D}") (str.to_re "\\u{0A}")))`

## Examples

### Example 1: Tab character fix
**Before:** `(get_split_length var3643 "\\t" -1)`
**After:** `(get_split_length var3643 "\\u{09}" -1)`

### Example 2: Simple regex \\s+ to inline RegLan
**Before:** `(get_split_length var3643 "\\u005cs+" -1)`
**After:** `(get_split_length_re var3643 (re.+ (re.union (str.to_re " ") (str.to_re "\\u{09}"))) -1)`

### Example 3: Regex \\s*/\\s* - inline directly
**Before:** `(get_split_length var1120 "\\u005cs*/\\u005cs*" -1)`
**After:** `(get_split_length_re var1120 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\\u{09}"))) (str.to_re "/") (re.* (re.union (str.to_re " ") (str.to_re "\\u{09}")))) -1)`

### Example 4: Line terminator \\R
**Before:** `(get_split_length var3301 "\\u005cR" -1)`
**After:** `(get_split_length_re var3301 (re.union (str.to_re "\\u{0D}") (str.to_re "\\u{0A}")) -1)`

### Example 5: Multiple occurrences - replace ALL of them
If the same delimiter appears in multiple function calls, you MUST provide replacements for EACH occurrence.

## Your Task

Analyze the given SMT2 file and identify delimiter syntax issues. Return a JSON object with replacements.

**Response Format (JSON only, no markdown):**
```json
{
  "has_issues": true,
  "replacements": [
    {
      "original": "exact string to find and replace",
      "replacement": "replacement string",
      "reason": "brief explanation"
    }
  ],
  "notes": "optional notes"
}
```

If no issues found:
```json
{
  "has_issues": false,
  "replacements": [],
  "notes": "No delimiter syntax issues detected"
}
```

CRITICAL RULES:
1. Return ONLY valid JSON, no markdown code blocks
2. The "original" field must be an EXACT substring from the input
3. Do NOT create auxiliary variables - INLINE everything directly
4. For regex patterns, simplify if needed (semantic equivalence not required)
5. Replace ALL occurrences of the problematic pattern
"""

USER_PROMPT_TEMPLATE = """Please analyze this SMT2 file and fix any delimiter-related syntax issues:

```smt2
{content}
```

Return your analysis as a JSON object."""


# ============================================================================
# Core Functions
# ============================================================================

def call_llm(content: str, provider: str, model: str | None = None) -> dict | None:
    """Call LLM to analyze and fix SMT2 content. Returns None on failure."""
    config = PROVIDERS.get(provider)
    if not config:
        print(f"[ERROR] Unknown provider: {provider}")
        return None
    
    model = model or config["default_model"]
    model_config = config["models"].get(model, {})
    
    try:
        response = litellm.completion(
            model=f"{config['request_params']['custom_llm_provider']}/{model}",
            api_key=config["api_key"],
            api_base=config["api_base"],
            messages=[
                {"role": "system", "content": SYSTEM_PROMPT},
                {"role": "user", "content": USER_PROMPT_TEMPLATE.format(content=content)}
            ],
            max_tokens=model_config.get("max_tokens", 8192),
            temperature=model_config.get("temperature", 0.6),
            response_format={"type": "json_object"} if "deepseek" not in provider else None
        )
        
        result_text = response.choices[0].message.content.strip()
        
        # Try to extract JSON from response
        if result_text.startswith("```"):
            # Remove markdown code blocks if present
            lines = result_text.split("\n")
            json_lines = []
            in_block = False
            for line in lines:
                if line.startswith("```"):
                    in_block = not in_block
                    continue
                if in_block or not line.startswith("```"):
                    json_lines.append(line)
            result_text = "\n".join(json_lines)
        
        return json.loads(result_text)
        
    except Exception as e:
        print(f"[ERROR] LLM call failed: {e}")
        return None


# Complete declarations block (with _re versions)
FULL_DECLARATIONS = """(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_at_re (String RegLan Int) String)
(declare-fun split_rest_re (String RegLan Int) String)
(declare-fun num_splits_re (String RegLan) Int)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits x d) limit)
         (num_splits x d)
         limit)
    (num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits x d) limit))
    (split_rest x d (- limit 1))
    (split_at x d i)
  )
)

(define-fun get_split_length_re ((x String) (d RegLan) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits_re x d) limit)
         (num_splits_re x d)
         limit)
    (num_splits_re x d)
  )
)

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)"""

# Pattern to match old-style declarations (without _re versions)
OLD_DECL_PATTERNS = [
    "(declare-fun split_at (String String Int) String)",
    "(declare-fun split_rest (String String Int) String)",
    "(declare-fun num_splits (String String) Int)",
]


def ensure_re_declarations(content: str) -> str:
    """Ensure the file has complete _re function declarations.
    
    Replaces old-style declarations with full declarations including _re versions.
    """
    # Check if _re declarations already exist
    if "(declare-fun split_at_re" in content:
        return content  # Already has _re declarations
    
    # Find where the old declarations start
    first_decl_idx = -1
    for pattern in OLD_DECL_PATTERNS:
        idx = content.find(pattern)
        if idx != -1:
            if first_decl_idx == -1 or idx < first_decl_idx:
                first_decl_idx = idx
    
    if first_decl_idx == -1:
        return content  # No split declarations found
    
    # Find the end of get_split_element function (after the closing paren and newline)
    # Look for the pattern that ends the function definitions
    end_markers = [
        "\n)\n\n(declare-",  # Common pattern: function ends, then declarations
        "\n)\n\n;",           # Function ends, then comment
        "\n)\n(declare-",     # No blank line variant
    ]
    
    end_idx = -1
    for marker in end_markers:
        idx = content.find(marker, first_decl_idx)
        if idx != -1:
            if end_idx == -1 or idx < end_idx:
                end_idx = idx + 2  # Include the closing paren and first newline
    
    if end_idx == -1:
        # Try to find just after get_split_element definition
        elem_idx = content.find("(define-fun get_split_element", first_decl_idx)
        if elem_idx != -1:
            # Find matching closing paren - count parens
            paren_count = 0
            for i, c in enumerate(content[elem_idx:]):
                if c == '(':
                    paren_count += 1
                elif c == ')':
                    paren_count -= 1
                    if paren_count == 0:
                        end_idx = elem_idx + i + 1
                        break
    
    if end_idx == -1:
        return content  # Could not find end of declarations
    
    # Replace old declarations with full declarations
    prefix = content[:first_decl_idx]
    suffix = content[end_idx:]
    
    return prefix + FULL_DECLARATIONS + suffix


def apply_replacements(content: str, result: dict) -> str:
    """Apply replacements from LLM result to content."""
    if not result.get("has_issues", False):
        return content
    
    modified = content
    
    # Apply replacements
    for repl in result.get("replacements", []):
        original = repl.get("original", "")
        replacement = repl.get("replacement", "")
        if original and original in modified:
            modified = modified.replace(original, replacement)
    
    return modified


def process_file(input_path: Path, output_path: Path, provider: str, model: str | None) -> bool:
    """Process a single SMT2 file. Returns True on success."""
    filename = input_path.name
    
    try:
        content = input_path.read_text(encoding="utf-8")
    except Exception as e:
        print(f"[ERROR] {filename}: {e}")
        return False
    
    # First ensure _re declarations exist (for regex delimiter support)
    content = ensure_re_declarations(content)
    
    result = call_llm(content, provider, model)
    if result is None:
        print(f"[SKIP] {filename}: LLM failed")
        return False
    
    if not result.get("has_issues", False):
        print(f"[OK] {filename}")
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(content, encoding="utf-8")
        return True
    
    num_fixes = len(result.get('replacements', []))
    modified = apply_replacements(content, result)
    
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(modified, encoding="utf-8")
    print(f"[FIX] {filename}: {num_fixes} replacement(s)")
    
    return True


def process_directory(input_dir: Path, output_dir: Path, provider: str, model: str | None) -> tuple[int, int]:
    """Process all SMT2 files in a directory. Returns (success_count, total_count)."""
    smt2_files = list(input_dir.glob("**/*.smt2"))
    print(f"[INFO] Found {len(smt2_files)} SMT2 files in {input_dir}")
    
    success = 0
    for smt2_file in smt2_files:
        relative = smt2_file.relative_to(input_dir)
        output_file = output_dir / relative
        
        if process_file(smt2_file, output_file, provider, model):
            success += 1
    
    return success, len(smt2_files)


# ============================================================================
# CLI
# ============================================================================

def main():
    parser = argparse.ArgumentParser(
        description="LLM-based SMT2 file fixer for delimiter syntax issues"
    )
    parser.add_argument("input", type=Path, help="Input file or directory")
    parser.add_argument("output", type=Path, help="Output file or directory")
    parser.add_argument(
        "--provider", "-p",
        choices=list(PROVIDERS.keys()),
        default="deepseek",
        help="LLM provider (default: deepseek)"
    )
    parser.add_argument(
        "--model", "-m",
        default=None,
        help="Model name (default: provider's default model)"
    )
    
    args = parser.parse_args()
    
    if args.input.is_file():
        if args.output.is_dir():
            args.output = args.output / args.input.name
        success = process_file(args.input, args.output, args.provider, args.model)
        sys.exit(0 if success else 1)
    elif args.input.is_dir():
        if not args.output.exists():
            args.output.mkdir(parents=True)
        success, total = process_directory(args.input, args.output, args.provider, args.model)
        print(f"\n[SUMMARY] {success}/{total} files processed successfully")
        sys.exit(0 if success == total else 1)
    else:
        print(f"[ERROR] Input path does not exist: {args.input}")
        sys.exit(1)


if __name__ == "__main__":
    main()