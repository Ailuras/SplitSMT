# SplitSMT

SplitSMT is a tool for solving string split constraints via structural relaxation. It accompanies the ISSTA 2026 paper cited under [Paper and Citation](#paper-and-citation).

## Overview

SplitSMT reads an SMT-LIB formula that uses the split interface, rewrites it, and submits the rewritten formula to an external string solver. The interface operations are `split_at`, `split_rest`, and `num_splits`.

The tool provides:

- An SMT-LIB encoding of those split operations.
- A solver-agnostic run that selects Z3, CVC5, Ostrich, or Z3-Noodler.
- Structural relaxation of the split constraints before they are sent to the backend.
- Model validation of a SAT result against the original split terms.

The built executable is `build/bin/SplitSMT`. The usage line printed by `--help` names the program `strprocessor`.

## Requirements

- A C++20 compiler (GCC 10+ or Clang 12+).
- CMake 3.16 or newer.
- pkg-config. [CMakeLists.txt](CMakeLists.txt) locates GMP and MPFR through it.
- The GMP and MPFR development libraries.
- Optional solver binaries: Z3, CVC5, Ostrich, and Z3-Noodler. The project builds without them. A selected backend is required only when that solver is invoked.
- GNU `timeout`, which the solver wrappers call. It is provided by coreutils on Linux.
- Python 3 for the scripts under [scripts/](scripts/). [scripts/report/aggregate.py](scripts/report/aggregate.py) imports `openpyxl`, which is not vendored here.

## Building

From the repository root:

```bash
sudo apt-get install libgmp-dev libmpfr-dev pkg-config cmake build-essential
mkdir build && cd build
cmake ..
make
```

CMake sets the C++ standard to 20 and writes the executable to `build/bin/SplitSMT`. The batch scripts expect that path. Their missing-binary message is `cmake --build build --config Release`, which requires the `build` directory to exist already.

## Quick Start

Run the commands below from the repository root after building. Configure the wrapper for the selected solver first; see [Solver Setup](#solver-setup). The default solver is `z3-noodler` and the default timeout is 30 seconds.

```bash
./build/bin/SplitSMT benchmarks_splitsmt/RealWorld/awesome/10778.smt2 -s z3-noodler -t 30
```

```bash
./build/bin/SplitSMT benchmarks_splitsmt/RealWorld/awesome/10778.smt2
```

```bash
./build/bin/SplitSMT benchmarks_splitsmt/RealWorld/awesome/11442.smt2 -s cvc5 -t 60
```

`--gen` writes the rewritten SMT-LIB file and does not solve. The output path is required:

```bash
./build/bin/SplitSMT benchmarks_splitsmt/RealWorld/awesome/10778.smt2 rewritten.smt2 --gen
```

`--check` validates a SAT model against the original split terms:

```bash
./build/bin/SplitSMT benchmarks_splitsmt/RealWorld/awesome/10778.smt2 -s z3-noodler --check
```

The same flags apply to any other SMT-LIB file in the benchmark trees or in [testcases/](testcases/).

## Implementation Guide

### Command-Line Options

The parser in [src/Main.cpp](src/Main.cpp) accepts:

```bash
./build/bin/SplitSMT <input_file> [output_file] [-l <level>] [-s <solver>] [-t <seconds>] [--gen] [--check] [-h]
```

- `-s, --solver <SOLVER>`: `z3`, `cvc5`, `ostrich`, or `z3-noodler`. Default: `z3-noodler`. An unknown name produces a warning and selects Z3-Noodler. A leading `ext-` prefix is removed, so `ext-z3` is read as `z3`.
- `-t, --timeout <SEC>`: timeout in seconds passed through to the solver wrapper. Default: 30.
- `-l, --level <LEVEL>`: integer log threshold. Default: 40 (errors only). Thresholds implemented in [src/Main.cpp](src/Main.cpp): 40 and above, errors; 30–39, warnings; 20–29, info; 15–19, debug; 14, log1; 13, log2; 12, log3; 11, log4; 10 and below, log5. The level names are defined in [src/utils/Logger.h](src/utils/Logger.h).
- `--gen`: write the rewritten SMT-LIB formula to the output path and do not solve. The output path is required.
- `--check`: when the result is SAT, validate the model against the original split terms.
- `-h, --help`: print the usage text and exit.

The first positional argument is the input SMT-LIB file. The second positional argument is the output path used by `--gen`.

### Solver Setup

SplitSMT does not link the solvers. [src/core/Solver.cpp](src/core/Solver.cpp) executes a wrapper from [solvers/](solvers/) as `<wrapper> <timeout> <smt_file>`. The wrapper paths are fixed by [src/utils/Config.h](src/utils/Config.h) to the repository `solvers` directory recorded at configure time:

- [solvers/z3.sh](solvers/z3.sh)
- [solvers/cvc5.sh](solvers/cvc5.sh)
- [solvers/ostrich.sh](solvers/ostrich.sh)
- [solvers/z3-noodler.sh](solvers/z3-noodler.sh)

Each wrapper requires a positive integer timeout and an existing SMT-LIB file. Set `SOLVER_PATH` in the wrapper to the solver binary, for example `SOLVER_PATH="/usr/local/bin/z3"`. The copies in this repository still contain a placeholder such as `/path/to/z3` and exit if that path is not an executable file. [solvers/z3-noodler.sh](solvers/z3-noodler.sh) uses `Z3_NOODLER_BIN` when that variable is set, and otherwise uses its `SOLVER_PATH`.

Arguments passed by the wrappers:

- Z3: `model=true`
- CVC5: `--lang smt2.6 --strings-exp --produce-models`
- Ostrich: `+incremental -quiet -logo -runtime`, after which the wrapper keeps status and model lines
- Z3-Noodler: `-T:<timeout> model=true`

Solver sources:

- Z3: [https://github.com/Z3Prover/z3](https://github.com/Z3Prover/z3)
- CVC5: [https://github.com/cvc5/cvc5](https://github.com/cvc5/cvc5)
- Ostrich: [https://github.com/uuverifiers/ostrich](https://github.com/uuverifiers/ostrich)
- Z3-Noodler: [https://github.com/VeriFIT/z3-noodler](https://github.com/VeriFIT/z3-noodler)

Set `STRP_KEEP_TEMP_SMT=1` to retain the temporary SMT-LIB file that the external solver writes under `/tmp`.

### Scripts

[scripts/](scripts/) holds batch execution, consistency checks, format conversion, reporting, and the benchmark drivers.

#### Batch Execution

[scripts/batch/batch.sh](scripts/batch/batch.sh) groups SMT-LIB files and runs one external wrapper on each file.

- `-s, --solver`: required. The script resolves `solvers/<name>.sh`. Names that resolve in this repository are `z3`, `cvc5`, `ostrich`, and `z3-noodler`. The help text also lists `z3-noodler-mocha`; no wrapper of that name is present.
- `-t, --timeout`: seconds per file. Default: 60.
- `-i, --input-dir`: directory of SMT-LIB files. Default: `benchmarks`. This repository stores the suites in the four directories under [Benchmarks](#benchmarks), not in a directory named `benchmarks`.
- `-o, --output-dir`: directory for per-task logs. Default: `results`.
- `-g, --group-size`: files per task group. Default: calculated from the file count and the job limit.
- `-j, --jobs`: concurrent tasks. Default: detected CPU count (`nproc`, or `sysctl -n hw.ncpu` on macOS, otherwise 2).
- `--solver-script PATH`: use this wrapper instead of `solvers/<name>.sh`.
- `-h, --help`: print the usage text.

[scripts/batch/batch_splitsmt.sh](scripts/batch/batch_splitsmt.sh) performs the same grouping, but each task runs `build/bin/SplitSMT`. The binary must already exist.

- `-s, --solver`: backend passed to SplitSMT. Default: `z3-noodler`. Accepted names: `z3`, `cvc5`, `ostrich`, `z3-noodler`. Any other name is an error.
- `-t, --timeout`: seconds per file. Default: 60.
- `-i, --input-dir`: default `benchmarks`, with the same caveat as `batch.sh`.
- `-o, --output-dir`: default `results`.
- `-g, --group-size`: default calculated from the file count and the job limit.
- `-j, --jobs`: default detected CPU count, using the same detection as `batch.sh`.
- `-h, --help`: print the usage text.

#### Consistency Checks

- [scripts/check/check.py](scripts/check/check.py): run the external wrappers on one SMT-LIB file or directory and compare their `sat`, `unsat`, and `unknown` statuses. The positional argument is the file or directory. `--timeout` defaults to 300 seconds. `--solver-timeout NAME=SECONDS` overrides one solver. `--solver` accepts `z3`, `cvc5`, `ostrich`, `z3-noodler`, or `all`. `--quiet` hides solver output, and `--no-color` disables color.
- [scripts/check/check_splitsmt.py](scripts/check/check_splitsmt.py): the same comparison, invoking `build/bin/SplitSMT` once per backend. The binary must already be built. `--timeout` defaults to 300 seconds. Arguments after `--splitsmt-args` are forwarded to SplitSMT.
- [scripts/check/check_model.py](scripts/check/check_model.py): check a UF model against an RA formula. The positional arguments are `<uf_file> <ra_file> <save_dir>`. `--timeout` defaults to 10 seconds. `--all-arity` and `-j` (default 1) are optional.

#### Format Conversion

- [scripts/convert/normalize.py](scripts/convert/normalize.py): SMT-LIB preprocessing. It truncates the file at the first `(pop)`, removes `(push)`, `(get-model)`, and `(check-sat)` from the retained text, and writes one trailing `(check-sat)` and `(exit)`. `--input` is required. `--output` defaults to overwriting the input. `--dry-run` does not write.
- [scripts/convert/convert_splitsmt2uf.py](scripts/convert/convert_splitsmt2uf.py): replace the split operations with the uninterpreted functions `split_at`, `split_rest`, and `num_splits`. `--input` is required. `--output` and `--dry-run` are optional.
- [scripts/convert/convert_uf2others.py](scripts/convert/convert_uf2others.py): from a UF formula, emit the SplitSMT, RA, and REC encodings. `--input` is required. `--output` and `--dry-run` are optional.
- [scripts/shell/convert.sh](scripts/shell/convert.sh): runs `python scripts/convert/normalize.py --input benchmarks_UF`, then `python scripts/convert/convert_uf2others.py --input benchmarks_UF --output benchmarks_others`. It deletes `benchmarks_RA`, `benchmarks_REC`, and `benchmarks_splitsmt`, moves `benchmarks_others/ra`, `benchmarks_others/rec`, and `benchmarks_others/splitsmt` into those three names, and removes `benchmarks_others`. The call to `convert_splitsmt2uf.py` inside this script is commented out, so the script does not regenerate `benchmarks_UF`.

#### Reporting and Dataset Generation

- [scripts/report/aggregate.py](scripts/report/aggregate.py): read batch logs and write one Excel workbook. Positional arguments are log files or directories. With no positional arguments it scans `results`. `--output` defaults to `charts/result.xlsx`. `--encoding` defaults to `utf-8`. `--solver` fills in a solver name when a log block has none. The script imports `openpyxl`.
- [scripts/shell/gen_dataset.sh](scripts/shell/gen_dataset.sh): run `build/bin/SplitSMT <input> <output> --gen` on every `.smt2` file under an input directory. Invocation, because the file is not marked executable:

```bash
bash scripts/shell/gen_dataset.sh [INPUT_DIR] [OUTPUT_DIR] [JOBS]
```

Defaults are `benchmarks_splitsmt`, `benchmarks_splitsmt_gen`, and the detected processor count. The SplitSMT binary must already be built. Files that fail are omitted from the output directory, and their paths are listed under `<output>/.gen_logs/fail.txt`.

#### Benchmark Drivers

[scripts/shell/](scripts/shell/) contains [All.sh](scripts/shell/All.sh), [Split_All.sh](scripts/shell/Split_All.sh), [UF_All.sh](scripts/shell/UF_All.sh), [RA_All.sh](scripts/shell/RA_All.sh), and [REC_All.sh](scripts/shell/REC_All.sh). The commands they store, including the directories actually passed by `RA_All.sh` and `REC_All.sh`, are listed under [Reproducing Experiments](#reproducing-experiments).

## Benchmarks

The repository includes the same 580 SMT-LIB files in four encodings:

- [benchmarks_splitsmt/](benchmarks_splitsmt/): SplitSMT encoding (580 files).
- [benchmarks_RA/](benchmarks_RA/): RA baseline encoding (580 files).
- [benchmarks_REC/](benchmarks_REC/): REC baseline encoding (580 files).
- [benchmarks_UF/](benchmarks_UF/): UF baseline encoding (580 files).

Those 580 files are 168 real-world instances and 412 synthetic instances. The counts below are for [benchmarks_splitsmt/](benchmarks_splitsmt/). The other three trees repeat the same relative paths.

Real-world files, 168, under `RealWorld/`:

- `awesome`: 129, including [10778.smt2](benchmarks_splitsmt/RealWorld/awesome/10778.smt2) and [11442.smt2](benchmarks_splitsmt/RealWorld/awesome/11442.smt2)
- `top20_gh`: 24
- `top20_maven`: 10
- `seqstr`: 5

Synthetic files, 412:

- `OpenAI/complex`: 46, `OpenAI/easy`: 86, `OpenAI/scenarios`: 81
- `DeepSeek/complex`: 55, `DeepSeek/easy`: 111, `DeepSeek/scenarios`: 33

[testcases/](testcases/) contains five further SMT-LIB files and is not part of the 580: [test_basic.smt2](testcases/test_basic.smt2), [test_boundary.smt2](testcases/test_boundary.smt2), [test_complex_delimiter.smt2](testcases/test_complex_delimiter.smt2), [test_poison_delimiter.smt2](testcases/test_poison_delimiter.smt2), and [test_reassembly.smt2](testcases/test_reassembly.smt2).

## Reproducing Experiments

Each driver below starts four solver batches with a per-file timeout of 1200 seconds, waits for them, and aggregates the logs with [scripts/report/aggregate.py](scripts/report/aggregate.py). Build SplitSMT before the SplitSMT driver. Configure the wrappers before any driver. `aggregate.py` needs `openpyxl`. These runs cover every file in the selected encoding; they are the recorded experiment settings, not a smoke test.

SplitSMT encoding, as stored in [scripts/shell/Split_All.sh](scripts/shell/Split_All.sh):

```bash
mkdir -p results/splitsmt
bash scripts/batch/batch_splitsmt.sh -s z3 -i benchmarks_splitsmt -o results/splitsmt/z3 -t 1200 -j 10 -g 5 > results/splitsmt/z3.log 2>&1 &
bash scripts/batch/batch_splitsmt.sh -s cvc5 -i benchmarks_splitsmt -o results/splitsmt/cvc5 -t 1200 -j 12 -g 5 > results/splitsmt/cvc5.log 2>&1 &
bash scripts/batch/batch_splitsmt.sh -s ostrich -i benchmarks_splitsmt -o results/splitsmt/ostrich -t 1200 -j 13 -g 5 > results/splitsmt/ostrich.log 2>&1 &
bash scripts/batch/batch_splitsmt.sh -s z3-noodler -i benchmarks_splitsmt -o results/splitsmt/z3-noodler -t 1200 -j 5 -g 5 > results/splitsmt/z3-noodler.log 2>&1 &
wait
python3 scripts/report/aggregate.py results/splitsmt --output results/splitsmt/report.xlsx --encoding utf-8
```

UF encoding, as stored in [scripts/shell/UF_All.sh](scripts/shell/UF_All.sh):

```bash
mkdir -p results/UF
bash scripts/batch/batch.sh -s z3 -i benchmarks_UF -o results/UF/z3 -t 1200 -j 7 -g 10 > results/UF/z3.log 2>&1 &
bash scripts/batch/batch.sh -s cvc5 -i benchmarks_UF -o results/UF/cvc5 -t 1200 -j 8 -g 10 > results/UF/cvc5.log 2>&1 &
bash scripts/batch/batch.sh -s ostrich -i benchmarks_UF -o results/UF/ostrich -t 1200 -j 10 -g 10 > results/UF/ostrich.log 2>&1 &
bash scripts/batch/batch.sh -s z3-noodler -i benchmarks_UF -o results/UF/z3-noodler -t 1200 -j 15 -g 10 > results/UF/z3-noodler.log 2>&1 &
wait
python3 scripts/report/aggregate.py results/UF --output results/UF/report.xlsx --encoding utf-8
```

RA encoding. The arguments below are the ones stored in [scripts/shell/REC_All.sh](scripts/shell/REC_All.sh). That file name does not match the encoding directory it passes:

```bash
mkdir -p results/RA
bash scripts/batch/batch.sh -s z3 -i benchmarks_RA -o results/RA/z3 -t 1200 -j 10 -g 5 > results/RA/z3.log 2>&1 &
bash scripts/batch/batch.sh -s cvc5 -i benchmarks_RA -o results/RA/cvc5 -t 1200 -j 10 -g 5 > results/RA/cvc5.log 2>&1 &
bash scripts/batch/batch.sh -s ostrich -i benchmarks_RA -o results/RA/ostrich -t 1200 -j 10 -g 5 > results/RA/ostrich.log 2>&1 &
bash scripts/batch/batch.sh -s z3-noodler -i benchmarks_RA -o results/RA/z3-noodler -t 1200 -j 10 -g 5 > results/RA/z3-noodler.log 2>&1 &
wait
python3 scripts/report/aggregate.py results/RA --output results/RA/report.xlsx --encoding utf-8
```

REC encoding. The arguments below are the ones stored in [scripts/shell/RA_All.sh](scripts/shell/RA_All.sh). That file name does not match the encoding directory it passes:

```bash
mkdir -p results/REC
bash scripts/batch/batch.sh -s z3 -i benchmarks_REC -o results/REC/z3 -t 1200 -j 10 -g 5 > results/REC/z3.log 2>&1 &
bash scripts/batch/batch.sh -s cvc5 -i benchmarks_REC -o results/REC/cvc5 -t 1200 -j 10 -g 5 > results/REC/cvc5.log 2>&1 &
bash scripts/batch/batch.sh -s ostrich -i benchmarks_REC -o results/REC/ostrich -t 1200 -j 10 -g 5 > results/REC/ostrich.log 2>&1 &
bash scripts/batch/batch.sh -s z3-noodler -i benchmarks_REC -o results/REC/z3-noodler -t 1200 -j 10 -g 5 > results/REC/z3-noodler.log 2>&1 &
wait
python3 scripts/report/aggregate.py results/REC --output results/REC/report.xlsx --encoding utf-8
```

[scripts/shell/All.sh](scripts/shell/All.sh) runs `UF_All.sh`, `REC_All.sh`, `RA_All.sh`, and `Split_All.sh` in that order, then executes:

```bash
python3 scripts/report/merge.py --uf results/UF/report.xlsx --ra results/RA/report.xlsx --rec results/REC/report.xlsx --splitsmt results/splitsmt/report.xlsx --output results/summary.xlsx
```

`scripts/report/merge.py` is not in this repository, so that final step cannot be run from the checked-in tree. Per-encoding workbooks are produced by `aggregate.py`. The combined workbook is already stored at [results/summary.xlsx](results/summary.xlsx).

## Results

[results/summary.xlsx](results/summary.xlsx) is the checked-in summary for the 580 benchmarks and the four solvers. The workbook has eight sheets:

- `UF`, `RA`, `REC`, and `SplitSMT` each contain a header plus 580 benchmark rows, with result, time, and output columns for cvc5, Ostrich, Z3, and Z3-Noodler.
- `cvc5`, `ostrich`, `z3`, and `z3-noodler` each contain a header plus 580 benchmark rows and compare the UF, RA, REC, and SplitSMT encodings on that solver.

These sheets correspond to the evaluation reported in the paper. See [Paper and Citation](#paper-and-citation).

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
