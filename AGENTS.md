# Repository Guidelines

## Project Structure & Module Organization
Core C++ sources live in `src/` (paired `.h`/`.cpp` files for context, parser, solver, and CLI entry points). Supporting solvers and parsers are vendored under `external/` (notably `SMTParser/` and language bindings). Benchmark workloads reside in `benchmarks/`, while reproducible experiment outputs land in `results/` and visualization assets in `charts/`. SMT-LIB scenarios for quick regression checks are stored in `test/`. Helper automation lives in `scripts/` (Python utilities grouped by task), and compiled binaries drop into `build/bin/` after a configure/build cycle.

## Build, Test, and Development Commands
- `make build` — configures with CMake (Release by default) and compiles `strprocessor` and `debug_strprocessor` into `build/bin/`.
- `./build.sh` — convenience wrapper around the same configure/build logic; respects `BUILD_TYPE=Debug` when set.
- `./build/bin/strprocessor test/simple_test.smt2` — runs the release binary; add flags such as `-s z3-noodler` or `-l 20` as needed.
- `cmake --build build --target clean` — optional: clean specific targets without deleting the full tree.

## Coding Style & Naming Conventions
Follow the existing C++ style: 4-space indentation, brace-on-same-line (`void foo() {`). Types and singletons use PascalCase (`Context`, `Division`), functions and methods are camelCase (`parseArgs`, `getDivisionNodes`), and constants/macros stay uppercase (`LOGGER`). Keep headers protected via `#pragma once`, prefer `std::` types, and organize includes from local to external. Place new solvers or utilities alongside peers (e.g., `src/SolverX.cpp`, `src/SolverX.h`).

## Testing Guidelines
Add new SMT-LIB fixtures to `test/` using descriptive snake_case filenames (e.g., `test_multi_delimiters_complex.smt2`). Validate behavior by invoking `./build/bin/strprocessor` against the scenario with the intended solver flag and inspecting the log level via `-l`. For regression or performance checks, re-run representative subsets from `benchmarks/` and capture outputs in `results/`.

## Commit & Pull Request Guidelines
Match the repository’s commit prefix style: `[fix]: ...`, `[mod]: ...`, `[add]: ...` followed by a concise imperative summary. Squash incidental commits before opening a PR. PR descriptions should outline the problem, summarize the solution, list added tests or benchmark sets, and call out solver or dependency impacts. Attach log excerpts or screenshots when behavior changes are user-visible, and link related issues or benchmark IDs where possible.

## Solver & Environment Tips
`build.sh` is now a thin wrapper around CMake. Install `cmake`, `libgmp`, and `libmpfr` through your platform package manager before building. The toolchain only shells out to solver wrappers (`z3`, `cvc5`, `ostrich`, `z3-noodler`); if you reintroduce embedded APIs, capture the configuration steps explicitly in the docs. When adding new solver binaries, update the helper scripts under `solvers/` to keep invocation paths consistent.
