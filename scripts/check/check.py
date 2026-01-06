#!/usr/bin/env python3
"""Compare solver outputs before and after REG-Split preprocessing.

Updated to call the C++ binary built at ``build/REG-Split`` instead of the
old Python script.
"""

from __future__ import annotations

import argparse
import pathlib
import re
import shutil
import subprocess
import sys
import tempfile
import time
from dataclasses import dataclass
from typing import Dict, Iterable, List, Optional, Tuple


AVAILABLE_SOLVERS: Tuple[str, ...] = ("z3-noodler", "z3", "cvc5", "ostrich")
SOLVER_CHOICES: Tuple[str, ...] = AVAILABLE_SOLVERS + ("all",)
STATUS_PATTERN = re.compile(r"\b(sat|unsat|unknown)\b", re.IGNORECASE)
REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
PREPROCESS_PATH = REPO_ROOT / "build" / "REG-Split"


class Colors:
    RESET = "\033[0m"
    BOLD = "\033[1m"
    GREEN = "\033[32m"
    RED = "\033[31m"
    YELLOW = "\033[33m"
    CYAN = "\033[36m"
    GRAY = "\033[90m"

    @staticmethod
    def status_color(status: str) -> str:
        if status == "sat":
            return Colors.GREEN
        if status == "unsat":
            return Colors.RED
        if status in {"unknown", "timeout"}:
            return Colors.YELLOW
        return Colors.RESET

    @staticmethod
    def disable() -> None:
        Colors.RESET = ""
        Colors.BOLD = ""
        Colors.GREEN = ""
        Colors.RED = ""
        Colors.YELLOW = ""
        Colors.CYAN = ""
        Colors.GRAY = ""


@dataclass
class SolverResult:
    solver: str
    target: str
    status: str
    runtime: float
    exit_code: Optional[int]
    stdout: str
    stderr: str
    error: Optional[str]
    file_path: pathlib.Path


@dataclass
class RegSplitResult:
    success: bool
    output_path: pathlib.Path
    runtime: float
    exit_code: Optional[int]
    stdout: str
    stderr: str
    error: Optional[str]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run solvers on an SMT2 file before/after REG-Split and compare results.",
    )
    parser.add_argument("smt_file", type=pathlib.Path, help="Path to the SMT2 file to check.")
    parser.add_argument(
        "--timeout",
        type=int,
        default=300,
        help="Default per-run timeout in seconds (default: 300).",
    )
    parser.add_argument(
        "--solver-timeout",
        action="append",
        default=[],
        metavar="NAME=SECONDS",
        help="Override timeout for a specific solver, e.g. --solver-timeout z3=120.",
    )
    parser.add_argument(
        "--solver",
        dest="solvers",
        nargs="+",
        choices=list(SOLVER_CHOICES),
        help="Solvers to run (default: only z3-noodler). Use 'all' to run all solvers.",
    )
    parser.add_argument(
        "--platform",
        choices=["auto", "macos", "linux"],
        default="auto",
        help="Select solver script platform directory (default: auto detect).",
    )
    parser.add_argument(
        "--save",
        type=pathlib.Path,
        help="Directory to copy REG-Split output into (filename will match the input).",
    )
    parser.add_argument(
        "--reg-split-level",
        type=int,
        help="Pass log level to REG-Split (--level/-l).",
    )
    parser.add_argument(
        "--details",
        action="store_true",
        help="Print stdout/stderr from REG-Split and solvers.",
    )
    parser.add_argument(
        "--no-color",
        action="store_true",
        help="Disable colored output.",
    )
    return parser.parse_args()


def detect_platform_dir(choice: str) -> str:
    if choice in ("macos", "linux"):
        return choice
    if sys.platform.startswith("darwin"):
        return "macos"
    if sys.platform.startswith("linux"):
        return "linux"
    raise RuntimeError(f"Unsupported platform: {sys.platform}. Only macOS and Linux are supported.")


def parse_solver_timeouts(raw: Iterable[str], default_timeout: int) -> Dict[str, int]:
    overrides: Dict[str, int] = {}
    for item in raw:
        if "=" not in item:
            raise ValueError(f"Invalid format: {item}. Use name=seconds.")
        name, value = item.split("=", 1)
        name = name.strip()
        if name not in AVAILABLE_SOLVERS:
            raise ValueError(f"Unknown solver: {name}. Choices: {', '.join(AVAILABLE_SOLVERS)}")
        try:
            timeout_value = int(value)
        except ValueError:
            raise ValueError(f"Invalid timeout: {value}") from None
        if timeout_value <= 0:
            raise ValueError(f"Timeout must be positive: {value}")
        overrides[name] = timeout_value
    if default_timeout <= 0:
        raise ValueError("Default timeout must be positive.")
    return overrides


def resolve_solvers(selected: Optional[List[str]]) -> List[str]:
    if not selected:
        return ["z3-noodler"]
    if "all" in selected:
        return list(AVAILABLE_SOLVERS)
    return list(dict.fromkeys(selected))


def resolve_solver_script(name: str, platform_dir: str) -> pathlib.Path:
    script_path = REPO_ROOT / "solvers" / platform_dir / name / "run.sh"
    if not script_path.is_file():
        raise FileNotFoundError(f"Solver script not found: {script_path}")
    return script_path


def detect_status(stdout: str, stderr: str, exit_code: int) -> str:
    if exit_code == 124:
        return "timeout"
    for stream in (stdout, stderr):
        for line in stream.splitlines():
            match = STATUS_PATTERN.search(line)
            if match:
                return match.group(1).lower()
    return "ok" if exit_code == 0 else "error"


def run_solver(
    solver: str,
    smt_file: pathlib.Path,
    timeout: int,
    platform_dir: str,
) -> SolverResult:
    start = time.perf_counter()
    try:
        script_path = resolve_solver_script(solver, platform_dir)
        completed = subprocess.run(
            [str(script_path), str(timeout), str(smt_file)],
            cwd=str(REPO_ROOT),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )
        runtime = time.perf_counter() - start
        stdout = completed.stdout or ""
        stderr = completed.stderr or ""
        status = detect_status(stdout, stderr, completed.returncode)
        error = None
        if completed.returncode != 0 and status not in {"sat", "unsat", "unknown", "timeout"}:
            error = f"Command exit code: {completed.returncode}"
        return SolverResult(
            solver=solver,
            target="original",
            status=status,
            runtime=runtime,
            exit_code=completed.returncode,
            stdout=stdout,
            stderr=stderr,
            error=error,
            file_path=smt_file,
        )
    except FileNotFoundError as exc:
        runtime = time.perf_counter() - start
        return SolverResult(
            solver=solver,
            target="original",
            status="missing",
            runtime=runtime,
            exit_code=None,
            stdout="",
            stderr="",
            error=str(exc),
            file_path=smt_file,
        )
    except PermissionError as exc:
        runtime = time.perf_counter() - start
        return SolverResult(
            solver=solver,
            target="original",
            status="permission",
            runtime=runtime,
            exit_code=None,
            stdout="",
            stderr="",
            error=str(exc),
            file_path=smt_file,
        )


def run_reg_split(
    input_file: pathlib.Path,
    output_file: pathlib.Path,
    log_level: Optional[int],
) -> RegSplitResult:
    output_file.parent.mkdir(parents=True, exist_ok=True)
    cmd = [str(PREPROCESS_PATH), str(input_file), str(output_file)]
    if log_level is not None:
        cmd.extend(["-l", str(log_level)])
    if not PREPROCESS_PATH.exists():
        return RegSplitResult(
            success=False,
            output_path=output_file,
            runtime=0.0,
            exit_code=None,
            stdout="",
            stderr="",
            error=f"REG-Split binary not found: {PREPROCESS_PATH}",
        )
    start = time.perf_counter()
    completed = subprocess.run(
        cmd,
        cwd=str(REPO_ROOT),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    runtime = time.perf_counter() - start
    output_exists = output_file.exists()
    success = completed.returncode == 0 and output_exists
    if completed.returncode != 0:
        error = f"REG-Split exit code: {completed.returncode}"
    elif not output_exists:
        error = "REG-Split finished without producing output file"
    else:
        error = None
    return RegSplitResult(
        success=success,
        output_path=output_file,
        runtime=runtime,
        exit_code=completed.returncode,
        stdout=completed.stdout or "",
        stderr=completed.stderr or "",
        error=error,
    )


def format_duration(seconds: float) -> str:
    if seconds >= 600:
        return f"{seconds / 60:.1f}m"
    if seconds >= 10:
        return f"{seconds:.1f}s"
    return f"{seconds:.2f}s"


def print_table(results: List[SolverResult]) -> None:
    header = f"{Colors.BOLD}{'Solver':<12} {'Target':<12} {'Status':<16} {'Time':<8} {'Exit':<6}{Colors.RESET}"
    print(header)
    print(Colors.GRAY + "-" * 58 + Colors.RESET)
    for result in results:
        status = f"{Colors.status_color(result.status)}{result.status:<16}{Colors.RESET}"
        runtime = f"{Colors.CYAN}{format_duration(result.runtime):<8}{Colors.RESET}"
        exit_code = "" if result.exit_code is None else str(result.exit_code)
        print(f"{result.solver:<12} {result.target:<12} {status} {runtime} {exit_code:<6}")


def print_details(reg_split: RegSplitResult, results: List[SolverResult]) -> None:
    print("\nREG-Split stdout/stderr")
    print("-----------------------")
    if reg_split.stdout.strip():
        print("stdout:")
        print(reg_split.stdout.strip())
    if reg_split.stderr.strip():
        print("stderr:")
        print(reg_split.stderr.strip())
    for result in results:
        if result.stdout.strip() or result.stderr.strip() or result.error:
            print(f"\n== {result.solver} ({result.target}) ==")
            if result.error:
                print(f"error: {result.error}")
            if result.stdout.strip():
                print("stdout:")
                print(result.stdout.strip())
            if result.stderr.strip():
                print("stderr:")
                print(result.stderr.strip())


def copy_for_variant(original: SolverResult, target: str, file_path: pathlib.Path) -> SolverResult:
    return SolverResult(
        solver=original.solver,
        target=target,
        status=original.status,
        runtime=0.0,
        exit_code=None,
        stdout="",
        stderr="",
        error=None,
        file_path=file_path,
    )


def main() -> int:
    args = parse_args()
    if args.no_color or not sys.stdout.isatty():
        Colors.disable()

    temp_dir: Optional[pathlib.Path] = None
    save_dir: Optional[pathlib.Path] = args.save.resolve() if args.save else None

    smt_file = args.smt_file.resolve()
    if not smt_file.is_file():
        print(f"{Colors.RED}Error: file not found {smt_file}{Colors.RESET}", file=sys.stderr)
        return 2

    try:
        solver_timeouts = parse_solver_timeouts(args.solver_timeout, args.timeout)
    except ValueError as exc:
        print(f"{Colors.RED}Error: {exc}{Colors.RESET}", file=sys.stderr)
        return 2

    try:
        platform_dir = detect_platform_dir(args.platform)
    except RuntimeError as exc:
        print(f"{Colors.RED}Error: {exc}{Colors.RESET}", file=sys.stderr)
        return 2

    solvers = resolve_solvers(args.solvers)

    temp_dir = pathlib.Path(tempfile.mkdtemp(prefix="reg_split_check_"))
    suffix = smt_file.suffix or ".smt2"
    output_path = temp_dir / f"{smt_file.stem}.reg-split{suffix}"

    try:
        reg_split_result = run_reg_split(
            input_file=smt_file,
            output_file=output_path,
            log_level=args.reg_split_level,
        )

        results: List[SolverResult] = []
        fatal_error = not reg_split_result.success
        mismatch_found = False

        save_path: Optional[pathlib.Path] = None
        if reg_split_result.success and save_dir:
            save_dir.mkdir(parents=True, exist_ok=True)
            save_path = save_dir / smt_file.name
            shutil.copy2(reg_split_result.output_path, save_path)

        for solver in solvers:
            timeout = solver_timeouts.get(solver, args.timeout)
            original_result = run_solver(solver, smt_file, timeout, platform_dir)
            results.append(original_result)

            if not reg_split_result.success:
                processed_result = copy_for_variant(
                    original_result, "reg-split", reg_split_result.output_path
                )
                processed_result.status = "reg-split-error"
                processed_result.runtime = reg_split_result.runtime
                processed_result.exit_code = reg_split_result.exit_code
                processed_result.stdout = reg_split_result.stdout
                processed_result.stderr = reg_split_result.stderr
                processed_result.error = reg_split_result.error
                results.append(processed_result)
                continue

            processed_result = run_solver(solver, reg_split_result.output_path, timeout, platform_dir)
            processed_result.target = "reg-split"
            results.append(processed_result)

            comparable = {"sat", "unsat", "unknown"}
            if original_result.status in comparable and processed_result.status in comparable:
                if original_result.status != processed_result.status:
                    mismatch_found = True
            elif original_result.status in comparable or processed_result.status in comparable:
                mismatch_found = True

            if processed_result.status in {"missing", "permission", "error"}:
                fatal_error = True
            if original_result.status in {"missing", "permission", "error"}:
                fatal_error = True

        print_table(results)
        if save_path and reg_split_result.success:
            print(f"\nREG-Split output saved to: {save_path}")
        if args.details:
            print_details(reg_split_result, results)

        if fatal_error:
            return 2
        if mismatch_found:
            return 1
        return 0
    finally:
        if temp_dir:
            shutil.rmtree(temp_dir, ignore_errors=True)


if __name__ == "__main__":
    sys.exit(main())
