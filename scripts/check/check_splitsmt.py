#!/usr/bin/env python3
"""Check consistency across SplitSMT with different underlying solvers.

Runs SplitSMT with different underlying solvers (z3, cvc5, ostrich, z3-noodler)
on the input file(s) and compares their results. Reports mismatch if any disagree.
"""

from __future__ import annotations

import argparse
import pathlib
import re
import subprocess
import sys
import time
from dataclasses import dataclass
from typing import Dict, Iterable, List, Optional, Tuple

AVAILABLE_SOLVERS: Tuple[str, ...] = ("z3", "cvc5", "ostrich", "z3-noodler")
SOLVER_CHOICES: Tuple[str, ...] = AVAILABLE_SOLVERS + ("all",)
STATUS_PATTERN = re.compile(r"\b(sat|unsat|unknown)\b", re.IGNORECASE)
REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
SPLITSMT_BINARY = REPO_ROOT / "build" / "bin" / "SplitSMT"


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
    status: str
    runtime: float
    exit_code: Optional[int]
    stdout: str
    stderr: str
    error: Optional[str]
    file_path: pathlib.Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run SplitSMT with different underlying solvers and check for consistency.",
    )
    parser.add_argument("input_path", type=pathlib.Path, help="Path to the SMT2 file or directory to check.")
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
        help="Underlying solvers for SplitSMT to use (default: all available).",
    )
    parser.add_argument(
        "--details",
        action="store_true",
        help="Print stdout/stderr from SplitSMT runs.",
    )
    parser.add_argument(
        "--quiet",
        action="store_true",
        help="Suppress stdout/stderr from SplitSMT runs.",
    )
    parser.add_argument(
        "--no-color",
        action="store_true",
        help="Disable colored output.",
    )
    parser.add_argument(
        "--splitsmt-args",
        nargs=argparse.REMAINDER,
        default=[],
        help="Additional arguments to pass to SplitSMT (e.g., --splitsmt-args --check --verbose).",
    )
    return parser.parse_args()


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
    if not selected or "all" in selected:
        return list(AVAILABLE_SOLVERS)
    return [s for s in selected if s != "all"]


def detect_status(stdout: str, stderr: str, exit_code: int) -> str:
    """Detect solver status from output."""
    if exit_code == 124 or exit_code == 137 or exit_code == 143:
        return "timeout"
    
    combined = stdout + "\n" + stderr
    match = STATUS_PATTERN.search(combined.lower())
    if match:
        return match.group(1).lower()
    
    if exit_code != 0:
        return "error"
    
    return "unknown"


def run_solver(
    file_path: pathlib.Path,
    solver: str,
    timeout: int,
    show_details: bool,
    extra_args: List[str] = None,
) -> SolverResult:
    """Run SplitSMT with the specified underlying solver."""
    if not SPLITSMT_BINARY.exists():
        return SolverResult(
            solver=solver,
            status="error",
            runtime=0.0,
            exit_code=None,
            stdout="",
            stderr="",
            error=f"SplitSMT binary not found: {SPLITSMT_BINARY}",
            file_path=file_path,
        )

    cmd = [
        str(SPLITSMT_BINARY),
        str(file_path),
        "-s", solver,
        "-t", str(timeout),
    ]
    
    # Add extra arguments if provided
    if extra_args:
        cmd.extend(extra_args)

    if show_details:
        print(f"    {Colors.GRAY}Running: {' '.join(cmd)}{Colors.RESET}")

    start_time = time.time()
    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=timeout + 5,
        )
        runtime = time.time() - start_time
        
        stdout = result.stdout
        stderr = result.stderr
        exit_code = result.returncode
        
        if show_details:
            if stdout:
                print(f"      {Colors.GRAY}[stdout]{Colors.RESET} {stdout[:200]}")
            if stderr:
                print(f"      {Colors.GRAY}[stderr]{Colors.RESET} {stderr[:200]}")

        status = detect_status(stdout, stderr, exit_code)
        
        return SolverResult(
            solver=solver,
            status=status,
            runtime=runtime,
            exit_code=exit_code,
            stdout=stdout,
            stderr=stderr,
            error=None,
            file_path=file_path,
        )

    except subprocess.TimeoutExpired:
        runtime = time.time() - start_time
        return SolverResult(
            solver=solver,
            status="timeout",
            runtime=runtime,
            exit_code=None,
            stdout="",
            stderr="",
            error="Process timeout",
            file_path=file_path,
        )
    except Exception as e:
        runtime = time.time() - start_time
        return SolverResult(
            solver=solver,
            status="error",
            runtime=runtime,
            exit_code=None,
            stdout="",
            stderr="",
            error=str(e),
            file_path=file_path,
        )


def check_file(
    file_path: pathlib.Path,
    solvers: List[str],
    solver_timeouts: Dict[str, int],
    default_timeout: int,
    show_details: bool,
    extra_args: List[str] = None,
) -> Tuple[str, List[SolverResult]]:
    """Check a single file with all specified solvers."""
    print(f"\n{Colors.BOLD}Checking: {file_path.name}{Colors.RESET}")
    print(f"Path:     {file_path}")
    print(f"Solvers:  {', '.join(solvers)}")
    
    results: List[SolverResult] = []
    
    for solver in solvers:
        timeout = solver_timeouts.get(solver, default_timeout)
        result = run_solver(file_path, solver, timeout, show_details, extra_args)
        results.append(result)
    
    # Determine consistency
    if show_details:
        print()
    
    # Filter strictly definitive results
    definitive_statuses = {r.status for r in results if r.status in ("sat", "unsat")}
    
    if "sat" in definitive_statuses and "unsat" in definitive_statuses:
        consistency = "mismatch"
    elif definitive_statuses:
        consistency = "consistent"
    else:
        consistency = "no_result"
    
    return consistency, results


def print_results(
    consistency: str,
    results: List[SolverResult],
    show_details: bool,
) -> None:
    """Print results table and summary."""
    if not show_details:
        print()
    
    if consistency == "mismatch":
        print(f"{Colors.RED}⚠ MISMATCH DETECTED{Colors.RESET}")
    elif consistency == "consistent":
        print(f"{Colors.GREEN}✓ Consistent{Colors.RESET}")
    else:
        print(f"{Colors.YELLOW}⚠ No definitive result{Colors.RESET}")
    
    print("-" * 60)
    print(f"{'Solver':<20} {'Status':<16} {'Time':<12} {'Exit':<6}")
    print("-" * 60)
    
    for result in results:
        status_color = Colors.status_color(result.status)
        print(
            f"{result.solver:<20} "
            f"{status_color}{result.status:<16}{Colors.RESET} "
            f"{result.runtime:<11.2f}s "
            f"{result.exit_code if result.exit_code is not None else 'N/A':<6}"
        )
    
    print()
    
    if consistency == "no_result":
        print("No definitive result (unknown/timeout).")
    elif consistency == "consistent":
        definitive_results = [r for r in results if r.status in ("sat", "unsat")]
        if definitive_results:
            print(f"All solvers agree: {definitive_results[0].status.upper()}")
    
    print("=" * 60)


def find_smt2_files(path: pathlib.Path) -> List[pathlib.Path]:
    """Find all .smt2 files in path (file or directory)."""
    if path.is_file():
        if path.suffix == ".smt2":
            return [path]
        print(f"Error: {path} is not an .smt2 file", file=sys.stderr)
        sys.exit(1)
    
    if path.is_dir():
        files = sorted(path.rglob("*.smt2"))
        if not files:
            print(f"Error: No .smt2 files found in {path}", file=sys.stderr)
            sys.exit(1)
        return files
    
    print(f"Error: {path} does not exist", file=sys.stderr)
    sys.exit(1)


def main() -> int:
    args = parse_args()
    
    if args.no_color:
        Colors.disable()
    
    if not SPLITSMT_BINARY.exists():
        print(f"Error: SplitSMT binary not found: {SPLITSMT_BINARY}", file=sys.stderr)
        print("Please build SplitSMT first: cmake --build build --config Release", file=sys.stderr)
        return 1
    
    try:
        solver_timeouts = parse_solver_timeouts(args.solver_timeout, args.timeout)
    except ValueError as e:
        print(f"Error: {e}", file=sys.stderr)
        return 1
    
    solvers = resolve_solvers(args.solvers)
    show_details = args.details and not args.quiet
    
    files = find_smt2_files(args.input_path)
    
    print(f"Found {len(files)} file(s) to check.")
    
    total_consistent = 0
    total_mismatch = 0
    total_no_result = 0
    
    for file_path in files:
        consistency, results = check_file(
            file_path,
            solvers,
            solver_timeouts,
            args.timeout,
            show_details,
            args.splitsmt_args,
        )
        
        print_results(consistency, results, show_details)
        
        if consistency == "consistent":
            total_consistent += 1
        elif consistency == "mismatch":
            total_mismatch += 1
        else:
            total_no_result += 1
    
    if len(files) > 1:
        print()
        print("SUMMARY")
        print(f"Total files: {len(files)}")
        print(f"Consistent/Unknown: {total_consistent + total_no_result}")
        print(f"Mismatches: {total_mismatch}")
    
    return 1 if total_mismatch > 0 else 0


if __name__ == "__main__":
    sys.exit(main())
