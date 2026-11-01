# SplitSMT

SplitSMT is a tool for solving string split constraints via structural relaxation, accompanying the ISSTA 2026 paper.

The tool provides:

- **SMT-LIB encoding** for string split operations (`split_at`, `split_rest`, `num_splits`)
- **Solver-agnostic** approach working with Z3, CVC5, Ostrich, and Z3-Noodler
- **Structural relaxation** technique for efficient constraint solving
- **Model validation** to ensure correctness

## Building

### Requirements

- C++20 compiler (GCC 10+ or Clang 12+)
- CMake 3.16+
- GMP and MPFR libraries
- SMT solvers (optional): Z3, CVC5, Ostrich, Z3-Noodler

### Build Steps

```bash
sudo apt-get install libgmp-dev libmpfr-dev cmake build-essential
mkdir build && cd build
cmake ..
make
```

## Usage

### Basic Usage

```bash
./build/bin/SplitSMT input.smt2 -s z3-noodler -t 30
```

### Command-Line Options

- `-s, --solver <SOLVER>`: Select SMT solver (z3, cvc5, ostrich, z3-noodler). Default: z3-noodler
- `-t, --timeout <SEC>`: Timeout in seconds. Default: 30
- `-l, --level <LEVEL>`: Log level (10-50). Default: 40 (errors only)
- `--gen`: Generate rewritten SMT2 file without solving
- `--check`: Validate SAT models against original constraints
- `-h, --help`: Show help message

### Examples

```bash
# Solve with Z3-Noodler (default)
./build/bin/SplitSMT benchmarks/Java/awesome/10778.smt2

# Use CVC5 with 60s timeout
./build/bin/SplitSMT benchmarks/Java/awesome/11442.smt2 -s cvc5 -t 60

# Generate rewritten SMT-LIB without solving
./build/bin/SplitSMT input.smt2 output.smt2 --gen

# Solve and validate the model
./build/bin/SplitSMT input.smt2 -s z3-noodler --check
```

## SMT Solvers Setup

SplitSMT supports multiple SMT solvers. To use them, you need to:

1. Download or build the solver binaries from the GitHub repositories
2. Configure the path in the corresponding wrapper script in `solvers/`, e.g., `SOLVER_PATH="/usr/local/bin/z3"`

### GitHub repositories

- **Z3**: [https://github.com/Z3Prover/z3](https://github.com/Z3Prover/z3)
- **CVC5**: [https://github.com/cvc5/cvc5](https://github.com/cvc5/cvc5)
- **Ostrich**: [https://github.com/uuverifiers/ostrich](https://github.com/uuverifiers/ostrich)
- **Z3-Noodler**: [https://github.com/VeriFIT/z3-noodler](https://github.com/VeriFIT/z3-noodler)

## Benchmarks

The repository includes benchmarks in four different encodings:

- **`benchmarks_splitsmt/`**: SplitSMT encoding (580 files)
- **`benchmarks_RA/`**: RA baseline encoding (580 files)
- **`benchmarks_REC/`**: REC baseline encoding (580 files)
- **`benchmarks_UF/`**: UF baseline encoding (580 files)

Total: 168 real-world + 412 synthetic = 580 test cases

## Scripts

The `scripts/` directory provides utilities for batch processing, validation, and format conversion:

- **`batch/`**: Parallel batch execution for running experiments across multiple SMT files
  - `batch.sh`: External solver wrappers
  - `batch_splitsmt.sh`: SplitSMT with configurable backends

- **`check/`**: Consistency validation tools
  - `check.py`: Cross-solver consistency validation
  - `check_splitsmt.py`: SplitSMT internal consistency checks
  - `check_model.py`: Model validation for UF-to-RA transformations

- **`convert/`**: Format conversion pipeline
  - `normalize.py`: SMT-LIB preprocessing
  - `convert_splitsmt2uf.py`: Original to UF format
  - `convert_uf2others.py`: UF to solver-specific formats (SplitSMT/RA/REC)

- **`report/`**: Result aggregation (`aggregate.py`)

- **`shell/`**: Convenience scripts for running benchmarks (`All.sh`, `Split_All.sh`, `UF_All.sh`, etc.)

## Experimental Results

Result summaries are provided in the `results/` directory:

- **`summary.xlsx`**: Complete experimental results (580 benchmarks × 4 solvers)

These correspond to the results reported in the paper (see [Paper and Citation](#paper-and-citation)).

## Paper and Citation

This repository accompanies the paper:

Solving String Split Constraints via Structural Relaxation

DOI: [https://doi.org/10.1145/3832221](https://doi.org/10.1145/3832221)

Cite:

```text
Rui Han, Ziheng Wang, Baoquan Cui, Yuhang Dong, Fuqi Jia, Feifei Ma, Jian Zhang.
Solving String Split Constraints via Structural Relaxation.
Proceedings of the ACM on Software Engineering (ISSTA), 2026.
```
