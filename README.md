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

## SMT Solvers Setup

SplitSMT supports multiple SMT solvers. To use them, you need to:

1. Download or build the solver binaries
2. Configure the path in the corresponding wrapper script in `solvers/`

### Supported Solvers

- **Z3**: [https://github.com/Z3Prover/z3](https://github.com/Z3Prover/z3)
- **CVC5**: [https://github.com/cvc5/cvc5](https://github.com/cvc5/cvc5)
- **Ostrich**: [https://github.com/uuverifiers/ostrich](https://github.com/uuverifiers/ostrich)
- **Z3-Noodler**: [https://github.com/VeriFIT/z3-noodler](https://github.com/VeriFIT/z3-noodler)

### Installation Instructions

1. **Download pre-built binaries** (recommended for Z3 and CVC5):
   - Visit the solver's GitHub repository releases page
   - Download the appropriate binary for your operating system
   - Extract and note the path to the executable

2. **Configure solver paths**:

   ```bash
   # Edit the corresponding solver script
   vim solvers/z3.sh          # For Z3
   vim solvers/cvc5.sh        # For CVC5
   vim solvers/ostrich.sh     # For Ostrich
   vim solvers/z3-noodler.sh  # For Z3-Noodler
   
   # Change the SOLVER_PATH variable to your solver location
   # Example:
   SOLVER_PATH="/usr/local/bin/z3"
   ```

3. **Verify installation**:

   ```bash
   # Test the solver wrapper directly
   ./solvers/z3.sh 30 testcases/test_basic.smt2
   ```

**Note**: On macOS, you need GNU coreutils for the `timeout` command:

```bash
brew install coreutils
```

## Benchmarks

The repository includes benchmarks in four different encodings:

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

These correspond to the tables and figures in our ISSTA 2026 paper.

## Repository Structure

```
SplitSMT/
├── src/                    # C++ source code
│   ├── Main.cpp            # Entry point
│   ├── core/               # Core solver logic (Split.cpp, Context.cpp, etc.)
│   ├── parser/             # SMT-LIB parser
│   ├── utils/              # Helper utilities
│   └── SMTParser/          # External SMT parser library
├── solvers/                # Solver wrapper scripts
│   ├── z3.sh               # Z3 wrapper
│   ├── cvc5.sh             # CVC5 wrapper
│   ├── ostrich.sh          # Ostrich wrapper
│   └── z3-noodler.sh       # Z3-Noodler wrapper
├── benchmarks_splitsmt/    # SplitSMT encoded benchmarks
├── benchmarks_RA/          # RA baseline benchmarks
├── benchmarks_REC/         # REC baseline benchmarks
├── benchmarks_UF/          # UF baseline benchmarks
├── scripts/                # Utility scripts
│   ├── batch/              # Batch execution scripts
│   ├── check/              # Consistency validation
│   ├── convert/            # Format conversion
│   ├── report/             # Result aggregation
│   └── shell/              # Shell convenience scripts
├── testcases/              # Test cases for validation
├── results/                # Experimental result summaries
└── CMakeLists.txt          # Build configuration
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
