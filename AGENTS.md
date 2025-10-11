# Repository Guidelines

## Project Structure & Module Organization
Core C++ sources live in `src/`, paired `.h` and `.cpp` files for the context, parser, solver, and CLI layers. External parsers and solver bindings are vendored under `external/` (notably `SMTParser/`). Benchmark inputs sit in `benchmarks/`, quick SMT-LIB checks in `test/`, reproducible experiment logs in `results/`, and visualization artifacts in `charts/`. Helper automation scripts are collected in `scripts/`, while `run_strprocessor.sh` and `run_debug.sh` wrap binaries generated into `build/bin/`.

## Build, Test, and Development Commands
- `make build` — installs missing deps, configures CMake, and emits release binaries into `build/bin/`.
- `./run_strprocessor.sh test/simple_test.smt2` — run the release solver with default configuration; pass `-s ext-z3-noodler` to try other engines.
- `./run_debug.sh -s ext-z3 test/debug_variables.smt2` — launch the debug build with tracing enabled for targeted investigation.
- `cmake --build build --target clean` — clean configured targets without deleting the entire build tree.

## Coding Style & Naming Conventions
Use 4-space indentation, braces on the same line (`void foo() {}`). Types and singletons use PascalCase, methods camelCase, and constants uppercase (`LOGGER`). Prefer `std::` containers, guard headers with `#pragma once`, and order includes from local to external. Keep comments purposeful; describe intent over mechanics.

## Testing Guidelines
Add SMT-LIB fixtures in `test/` using snake_case names (`test_multi_delimiters_complex.smt2`). Validate changes via `./run_strprocessor.sh` with the relevant solver flag and adjust `-l` for log verbosity. For regressions or performance snapshots, rerun representative `benchmarks/` inputs and capture outputs in `results/`.

## Commit & Pull Request Guidelines
Prefix commits with `[fix]:`, `[mod]:`, or `[add]:` followed by an imperative summary. PRs should explain the motivating problem, outline the solution, note added tests or benchmarks, and call out solver or dependency impacts. Attach log excerpts or screenshots when behavior is user-visible, and link issues or benchmark IDs when available.

## Solver & Environment Tips
On non-Debian systems install `libgmp`, `libmpfr`, `boost-system`, and `cmake` before running `build.sh`. When executing binaries manually, ensure `LD_LIBRARY_PATH` covers `external/cvc5/build/deps/lib` and `external/z3/build` so solver backends load correctly.
