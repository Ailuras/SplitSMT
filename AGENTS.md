# Repository Guidelines

## Project Structure & Module Organization
Core C++ sources live in `src/` (paired `.h`/`.cpp` files for context, parser, solver, and CLI entry points). Supporting solvers and parsers are vendored under `external/` (notably `SMTParser/` and language bindings). Benchmark workloads reside in `benchmarks/`, while reproducible experiment outputs land in `results/` and visualization assets in `charts/`. SMT-LIB scenarios for quick regression checks are stored in `test/`. Helper automation lives in `scripts/` (Python utilities grouped by task) and top-level shell scripts (`run_strprocessor.sh`, `run_debug.sh`) wrap binaries in `build/`.

## Build, Test, and Development Commands
- `make build` — runs `build.sh`; installs missing system deps, configures CMake, and builds release binaries into `build/bin/`.
- `./run_strprocessor.sh test/simple_test.smt2` — executes the release binary with solver defaults; accepts `-s ext-z3-noodler` or other solver flags.
- `./run_debug.sh -s ext-z3 test/debug_variables.smt2` — launches the debug build with the same CLI options for tracing.
- `cmake --build build --target clean` — optional: clean specific targets without deleting the full tree.

## Coding Style & Naming Conventions
Follow the existing C++ style: 4-space indentation, brace-on-same-line (`void foo() {`). Types and singletons use PascalCase (`Context`, `Division`), functions and methods are camelCase (`parseArgs`, `getDivisionNodes`), and constants/macros stay uppercase (`LOGGER`). Keep headers protected via `#pragma once`, prefer `std::` types, and organize includes from local to external. Place new solvers or utilities alongside peers (e.g., `src/SolverX.cpp`, `src/SolverX.h`).

## Testing Guidelines
Add new SMT-LIB fixtures to `test/` using descriptive snake_case filenames (e.g., `test_multi_delimiters_complex.smt2`). Validate behavior by running `./run_strprocessor.sh` against the scenario with the intended solver flag and inspecting the log level via `-l`. For regression or performance checks, re-run representative subsets from `benchmarks/` and capture outputs in `results/`.

## Commit & Pull Request Guidelines
Match the repository’s commit prefix style: `[fix]: ...`, `[mod]: ...`, `[add]: ...` followed by a concise imperative summary. Squash incidental commits before opening a PR. PR descriptions should outline the problem, summarize the solution, list added tests or benchmark sets, and call out solver or dependency impacts. Attach log excerpts or screenshots when behavior changes are user-visible, and link related issues or benchmark IDs where possible.

## Solver & Environment Tips
`build.sh` attempts to apt-install dependencies; on non-Debian systems install `libgmp`, `libmpfr`, `boost-system`, and `cmake` manually before running it. Ensure `LD_LIBRARY_PATH` includes `external/cvc5/build/deps/lib` and `external/z3/build` when executing binaries outside the helper scripts.
