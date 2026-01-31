# Solver Scripts

This directory contains wrapper scripts for running various SMT solvers with timeout support.

## Configuration

Before using these scripts, you need to configure the solver paths:

1. Edit each `.sh` file
2. Change the `SOLVER_PATH` variable to point to your solver installation
3. Make sure the scripts are executable: `chmod +x *.sh`

Example configuration in `z3.sh`:

```bash
SOLVER_PATH="/usr/local/bin/z3"  # Change this to your Z3 path
```

## Available Solvers

- **z3.sh**: Z3 solver
- **cvc5.sh**: CVC5 solver
- **z3-noodler.sh**: Z3-Noodler solver (supports `Z3_NOODLER_BIN` environment variable)
- **ostrich.sh**: Ostrich solver

## Usage

All scripts follow the same usage pattern:

```bash
./solver.sh <timeout> <smt_file>
```

- `<timeout>`: Timeout in seconds
- `<smt_file>`: Path to the SMT-LIB file to solve

Example:

```bash
./z3.sh 300 problem.smt2
```

## Requirements

- **timeout command**: Required for all scripts
  - Linux: Usually pre-installed
  - macOS: Install GNU coreutils: `brew install coreutils`

## Notes

- All scripts enable model generation by default
- Scripts will terminate gracefully on Ctrl+C
- Exit codes are preserved from the solver
