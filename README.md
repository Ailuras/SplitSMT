# SplitSMT

SplitSMT is a tool for encoding string split constraints into standard SMT-LIB format, enabling off-the-shelf SMT solvers to handle split operations.

## Overview

This implementation corresponds to the ISSTA 2026 paper: **"Solving String Split Constraints via Structural Relaxation"**.

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

1. Install dependencies:

```bash
# macOS
brew install gmp mpfr cmake

# Ubuntu/Debian
sudo apt-get install libgmp-dev libmpfr-dev cmake build-essential
```

1. Build the project:

```bash
mkdir build && cd build
cmake ..
make
```

1. The executable will be at `build/bin/SplitSMT`

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

## Benchmarks

The repository includes benchmarks in four different encodings:

- **`benchmarks/`**: Original Java-extracted constraints (178 real-world files)
- **`benchmarks_splitsmt/`**: SplitSMT encoding (580 files)
- **`benchmarks_RA/`**: RA baseline encoding (580 files)
- **`benchmarks_REC/`**: REC baseline encoding (580 files)
- **`benchmarks_UF/`**: UF baseline encoding (580 files)

Total: 168 real-world + 412 synthetic = 580 test cases

## Scripts

The `scripts/` directory contains utility tools for batch processing, validation, and format conversion:

### `scripts/batch/`

Batch execution scripts for running experiments:

- **`batch.sh`**: Execute multiple SMT files with external solver wrappers
- Supports parallel processing with automatic CPU detection
- Generates individual log files for each task group
- Platform-aware (auto-detects macOS/Linux solver paths)
  
- **`batch_splitsmt.sh`**: Execute multiple SMT files through SplitSMT
  - Similar to `batch.sh` but uses SplitSMT binary internally
  - Configurable backend solver selection

### `scripts/check/`

Consistency validation scripts:

- **`check.py`**: Cross-solver consistency checker using external solver wrappers
  - Compares results across multiple solvers
  - Detects conflicts (e.g., SAT vs UNSAT)
  
- **`check_splitsmt.py`**: SplitSMT internal consistency checker
  - Tests SplitSMT with different backend solvers
  - Validates solver integration stability
  
- **`check_model.py`**: UF-to-RA model validator
  - Extracts models from UF solutions
  - Verifies models satisfy RA constraints

### `scripts/convert/`

Format conversion utilities:

- **`normalize.py`**: Preprocessor for SMT files
  - Removes `get-model` commands
  - Handles `push`/`pop` operations
  
- **`convert_splitsmt2uf.py`**: Convert original SMT-LIB to UF format
  - Inserts uninterpreted function declarations
  - Changes logic to `ALL`
  
- **`convert_uf2others.py`**: Convert UF format to solver-specific formats
  - Generates three variants: `splitsmt/`, `ra/`, `rec/`
  - Handles solver-specific requirements (e.g., Ostrich needs special `-1` constant)

### `scripts/report/`

Result aggregation:

- **`aggregate.py`**: Aggregate experimental results
  - Processes batch execution logs
  - Generates summary reports

### `scripts/shell/`

Shell convenience scripts:

- **`All.sh`**: Run all benchmarks with all solvers
- **`Split_All.sh`**: Run SplitSMT benchmarks
- **`RA_All.sh`**: Run RA baseline benchmarks  
- **`REC_All.sh`**: Run REC baseline benchmarks
- **`UF_All.sh`**: Run UF baseline benchmarks
- **`convert.sh`**: Complete conversion pipeline (normalize → UF → all formats)
- **`test.sh`**: Quick test runner for development

## Experimental Results

Result summaries are provided in the `results/` directory:

- **`summary.xlsx`**: Complete experimental results (580 benchmarks × 4 solvers)
- **`factors.xlsx`**: Ablation study and factor analysis

These correspond to the tables and figures in our ISSTA 2026 paper.

## Repository Structure

```
SplitSMT/
├── src/               # C++ source code
│   ├── Main.cpp       # Entry point
│   ├── core/          # Core solver logic (Split.cpp, Context.cpp, etc.)
│   ├── parser/        # SMT-LIB parser
│   └── utils/         # Helper utilities
├── benchmarks/        # Original benchmarks
├── benchmarks_*/      # Encoded benchmarks (4 variants)
├── scripts/           # Utility scripts (see above)
├── results/           # Experimental result summaries
├── test/              # Test cases
└── CMakeLists.txt     # Build configuration
```

## Citation

If you use SplitSMT in your research, please cite our ISSTA 2026 paper:

```bibtex
@inproceedings{splitsmt2026,
  title={Solving String Split Constraints via Structural Relaxation},
  author={Anonymous},
  booktitle={ACM International Symposium on Software Testing and Analysis (ISSTA)},
  year={2026}
}
```

## License

[To be added]
