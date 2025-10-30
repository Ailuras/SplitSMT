
# **Baselines Guide**

This directory provides scripts for preparing and executing **baseline solvers**. It includes input/output preprocessing, the external solver wrapper, and configuration generation.

---

## **A. baseline_prepare: Input/Output Workflow and Preparation**

**Purpose:**
`baseline_prepare` standardizes benchmark inputs and generates temporary examples and configuration files under `results/baseline_prepared/`.

**Logic:**
During preparation, all `(set-logic ...)` declarations are replaced with `(set-logic ALL)` to maximize compatibility across benchmarks that involve mixed **string**, **regex**, and **integer** features.

**Configuration Generation:**
For each target directory, a `config.txt` file is created.

* The `set-logic` entry inside `config.txt` is determined based on the solver type and mode.
* In the subsequent `config.replace` phase, syntax normalization is performed, such as:

  * Replacing `(str.split ...)` → `(split ...)`
  * Replacing `(str.num ...)` → `(num ...)`

**Solving Pipeline:**
After preparation, the script invokes `scripts/solve/solve_batch` and `baselines/scripts/run_external_solver.sh` to batch-solve the generated examples and collect the results.

**Example Usage:**

```bash
python baselines/scripts/baseline_prepare.py \
  --input-root benchmarks/ \
  --run \
  --parallel 20
```

This command reads benchmark inputs from `benchmarks/`, runs the full preparation-and-solve pipeline, and utilizes a parallelism level of 20.

---

## **B. run_external_solver.sh: External Solver Wrapper**

`baselines/scripts/run_external_solver.sh` serves as a lightweight shell wrapper for invoking external solvers (e.g., **Z3**, **cvc5**, or third-party string solvers).
It primarily handles **process invocation**, **argument forwarding**, and ensures that both **stdout** and **stderr** are properly redirected for higher-level result aggregation.

---

## **C. Configs: Baseline Configuration Definition**

The `configs` directory specifies the per-solver and per-mode configuration fragments.
Each configuration defines how the corresponding solver and mode modify the `(set-logic ...)` declaration for prepared examples.
In essence, these files determine the solver-specific options and control how each external solver is executed during the baseline runs.

---
