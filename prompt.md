# LLM Prompt for SMT Benchmark Generation

---

## The Prompt

**System Role:**
You are an expert in Formal Methods, specifically in Satisfiability Modulo Theories (SMT) and String Theory solvers. You deeply understand the SMT-LIB v2 standard and the semantics of string operations, particularly `split`.

**Objective:**
Generate a set of 5 diverse SMT-LIB v2 scripts (benchmarks) to rigorously test a new SMT solver extension that handles string `split` operations.

**Supported Syntax for Split:**
The target solver supports a custom extension for string splitting. Please use the following function signatures in your generated formulas:

1. `(str.split_at string_term delimiter_term index_term)` -> Returns the substring at the given index.
2. `(str.split_rest string_term delimiter_term index_term)` -> Returns the suffix of the string starting from the given split index.
3. `(str.num_splits string_term delimiter_term)` -> Returns the total number of segments (integer).

**Requirements for Benchmarks:**
Each of the 5 generated files should focus on a different aspect to stress-test the solver:

1. **Case 1: Basic Functionality (Sanity Check)**
    * Use simple constant strings and delimiters (e.g., split "a,b,c" by ",").
    * Assert specific values for `split_at` indices 0, 1, 2.
    * Expectation: SAT.

2. **Case 2: Internal Delimiter Robustness (The "Poison" Case)**
    * Use a delimiter that might conflict with internal representations, such as `#` or `|`.
    * Constraint: `(str.split_at x "#" 0) = "data"`.
    * This tests if the solver correctly handles special characters without crashing or incorrectly reporting UNSAT.

3. **Case 3: Logic Bomb / Boundary Conditions**
    * Test constraints on the number of splits.
    * E.g., `(str.num_splits x ";") > 5` AND `(str.len x) < 5`. (This should likely be UNSAT unless the delimiter is empty, but assume non-empty delimiter).
    * Test out-of-bounds access: Asserting a value for `(str.split_at x "," 100)` when `num_splits` is small.

4. **Case 4: Re-assembly (Concatenation Consistency)**
    * Split a variable `x` by a delimiter `d`.
    * Reconstruct `x` by concatenating the parts and the delimiter.
    * Assert that `reconstructed_x == x`.

5. **Case 5: Regex or Complex Delimiter (If supported, otherwise Multi-char)**
    * Use a multi-character delimiter (e.g., `"::"` or `"--"`).
    * Complex string constraints combined with integer arithmetic constraints on the `index`.

**Output Format:**

* Provide the content for 5 separate `.smt2` files.
* Start each file with `(set-logic QF_SLIA)`.
* Include proper `declare-fun` and `assert` statements.
* End with `(check-sat)`.
* Do NOT use `define-fun` for the split functions; assume they are built-in or handled by the pre-processor. Just call them directly as `(str.split_at ...)`.

---
**Guidance for You (User):**

* **Why Case 2?** This directly tests the internal delimiter vulnerability we discussed.
* **Why Case 4?** This tests the "Soundness" of the relaxation. If the solver says SAT but the parts don't add up to the whole, it's a soundness bug.
