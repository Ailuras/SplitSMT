# SplitSMT

SplitSMT is a tool for solving string split constraints via structural relaxation. It accompanies the ISSTA 2026 paper cited under [Paper and Citation](#paper-and-citation).

## Overview

The tool provides:

- An SMT-LIB encoding for `split_at`, `split_rest`, and `num_splits`.
- Solver-agnostic solving with Z3, CVC5, Ostrich, and Z3-Noodler.
- Structural relaxation of the split constraints.
- Model validation of SAT results against the original constraints.

## Requirements

- A C++20 compiler (GCC 10+ or Clang 12+).
- CMake 3.16 or newer.
- pkg-config, plus the GMP and MPFR development libraries. CMake finds GMP and MPFR through pkg-config.
- Optional solver binaries: Z3, CVC5, Ostrich, and Z3-Noodler. The project builds without them.
- Python 3 for the scripts. [scripts/report/aggregate.py](scripts/report/aggregate.py) imports `openpyxl`, which is not vendored in this repository.
- GNU `timeout`, which the solver wrappers call.

## Building

From the repository root:

```bash
sudo apt-get install libgmp-dev libmpfr-dev pkg-config cmake build-essential
mkdir build && cd build
cmake ..
make
```

The executable is `build/bin/SplitSMT`.

## Quick Start

Configure the selected solver wrapper before running. See [Solver Setup](#solver-setup). The default solver is `z3-noodler` and the default timeout is 30 seconds.

```bash
./build/bin/SplitSMT benchmarks_splitsmt/RealWorld/awesome/10778.smt2 -s z3-noodler -t 30
./build/bin/SplitSMT benchmarks_splitsmt/RealWorld/awesome/11442.smt2 -s cvc5 -t 60
./build/bin/SplitSMT benchmarks_splitsmt/RealWorld/awesome/10778.smt2 rewritten.smt2 --gen
./build/bin/SplitSMT benchmarks_splitsmt/RealWorld/awesome/10778.smt2 -s z3-noodler --check
```

- `-s, --solver`: `z3`, `cvc5`, `ostrich`, or `z3-noodler`. Default: `z3-noodler`.
- `-t, --timeout`: timeout in seconds. Default: 30.
- `-l, --level`: log level. Default: 40 (errors only).
- `--gen`: write the rewritten SMT-LIB file and do not solve. The output path is required.
- `--check`: validate a SAT model against the original split terms.
- `-h, --help`: print the usage text.

## Implementation Guide

### Solver Setup

SplitSMT calls the wrappers in [solvers/](solvers/). Set `SOLVER_PATH` in the wrapper to the solver binary, for example `SOLVER_PATH="/usr/local/bin/z3"`. The copies in this repository use a placeholder such as `/path/to/z3`. [solvers/z3-noodler.sh](solvers/z3-noodler.sh) uses `Z3_NOODLER_BIN` when that variable is set.

- Z3: [https://github.com/Z3Prover/z3](https://github.com/Z3Prover/z3)
- CVC5: [https://github.com/cvc5/cvc5](https://github.com/cvc5/cvc5)
- Ostrich: [https://github.com/uuverifiers/ostrich](https://github.com/uuverifiers/ostrich)
- Z3-Noodler: [https://github.com/VeriFIT/z3-noodler](https://github.com/VeriFIT/z3-noodler)

### Source and Scripts

[src/Main.cpp](src/Main.cpp) parses the command line. Split rewriting, solver calls, and model checks live in [src/core/](src/core/).

- [scripts/batch/batch.sh](scripts/batch/batch.sh): batch runs through the external solver wrappers.
- [scripts/batch/batch_splitsmt.sh](scripts/batch/batch_splitsmt.sh): batch runs through the SplitSMT binary.
- [scripts/check/check.py](scripts/check/check.py): cross-solver consistency.
- [scripts/check/check_splitsmt.py](scripts/check/check_splitsmt.py): SplitSMT consistency across backends.
- [scripts/check/check_model.py](scripts/check/check_model.py): check a UF model against an RA formula.
- [scripts/convert/normalize.py](scripts/convert/normalize.py): SMT-LIB preprocessing.
- [scripts/convert/convert_splitsmt2uf.py](scripts/convert/convert_splitsmt2uf.py): SplitSMT encoding to UF.
- [scripts/convert/convert_uf2others.py](scripts/convert/convert_uf2others.py): UF encoding to SplitSMT, RA, and REC.
- [scripts/report/aggregate.py](scripts/report/aggregate.py): aggregate batch logs into a workbook.
- [scripts/shell/](scripts/shell/): `Split_All.sh`, `UF_All.sh`, `RA_All.sh`, `REC_All.sh`, and `All.sh` launch the paper runs. `gen_dataset.sh` rewrites a benchmark directory with `--gen`.

## Benchmarks

The repository includes 580 test cases in four encodings (168 real-world and 412 synthetic):

- [benchmarks_splitsmt/](benchmarks_splitsmt/): SplitSMT encoding.
- [benchmarks_RA/](benchmarks_RA/): RA baseline encoding.
- [benchmarks_REC/](benchmarks_REC/): REC baseline encoding.
- [benchmarks_UF/](benchmarks_UF/): UF baseline encoding.

## Reproducing Experiments

Build SplitSMT, configure the solver wrappers, and install `openpyxl`. From the repository root:

```bash
bash scripts/shell/Split_All.sh
bash scripts/shell/UF_All.sh
bash scripts/shell/REC_All.sh
bash scripts/shell/RA_All.sh
```

`Split_All.sh` runs the SplitSMT encoding and `UF_All.sh` runs the UF encoding. Run [scripts/shell/REC_All.sh](scripts/shell/REC_All.sh) for the RA encoding and [scripts/shell/RA_All.sh](scripts/shell/RA_All.sh) for the REC encoding: each file name is the opposite of the benchmark directory it passes. Each of these four drivers runs z3, cvc5, ostrich, and z3-noodler with a 1200-second timeout, then writes a workbook with [scripts/report/aggregate.py](scripts/report/aggregate.py).

Do not use [scripts/shell/All.sh](scripts/shell/All.sh) to produce the combined workbook: its last step calls `scripts/report/merge.py`, which is not in this repository. Use the four drivers above, and take the combined table from [results/summary.xlsx](results/summary.xlsx).

## Results

[results/summary.xlsx](results/summary.xlsx) records the experimental results for the 580 benchmarks and the four solvers. These are the results reported in the paper; see [Paper and Citation](#paper-and-citation).

## Paper and Citation

Rui Han, Ziheng Wang, Baoquan Cui, Yuhang Dong, Fuqi Jia, Feifei Ma, and Jian Zhang. 2026. Solving String Split Constraints via Structural Relaxation. Proceedings of the ACM on Software Engineering 3, ISSTA, Article ISSTA130 (October 2026), 2976–2995. DOI: [https://doi.org/10.1145/3832221](https://doi.org/10.1145/3832221).

```bibtex
@article{han2026solving,
  author = {Han, Rui and Wang, Ziheng and Cui, Baoquan and Dong, Yuhang and Jia, Fuqi and Ma, Feifei and Zhang, Jian},
  title = {Solving String Split Constraints via Structural Relaxation},
  journal = {Proceedings of the ACM on Software Engineering},
  year = {2026},
  month = oct,
  volume = {3},
  number = {ISSTA},
  articleno = {ISSTA130},
  pages = {2976--2995},
  doi = {10.1145/3832221},
  url = {https://doi.org/10.1145/3832221},
  issn = {2994-970X},
  publisher = {Association for Computing Machinery}
}
```
