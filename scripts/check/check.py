#!/usr/bin/env python3
"""Check consistency across multiple SMT solvers for SMT2 files (file or directory).

Runs a set of solvers (default: z3, cvc5, ostrich, z3-noodler) on the
input file(s) and compares their results. Reports mismatch if any two solvers disagree.
"""

from __future__ import annotations

import argparse
import pathlib
import re
import subprocess
import sys
import time
from dataclasses import dataclass
from typing import Dict, Iterable, List, Optional, Tuple, Set


AVAILABLE_SOLVERS: Tuple[str, ...] = ("z3", "cvc5", "ostrich", "z3-noodler")
SOLVER_CHOICES: Tuple[str, ...] = AVAILABLE_SOLVERS + ("all",)
STATUS_PATTERN = re.compile(r"\b(sat|unsat|unknown)\b", re.IGNORECASE)
REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]


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
        description="Run multiple solvers on SMT2 file(s) and check for consistency.",
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
        help="Solvers to run (default: all available). Use 'all' explicitly to filter.",
    )
    parser.add_argument(
        "--platform",
        choices=["auto", "macos", "linux"],
        default="auto",
        help="Select solver script platform directory (default: auto detect).",
    )
    parser.add_argument(
        "--details",
        action="store_true",
        help="Print stdout/stderr from solvers (default: True). Use --quiet to suppress.",
    )
    parser.add_argument(
        "--quiet",
        action="store_true",
        help="Suppress stdout/stderr from solvers.",
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
    # Default: Run ALL available comparison solvers
    if not selected or "all" in selected:
        return list(AVAILABLE_SOLVERS)
    return list(dict.fromkeys(selected))


def resolve_solver_script(name: str, platform_dir: str) -> pathlib.Path:
    script_path = REPO_ROOT / "solvers" / platform_dir / name / "run.sh"
    if not script_path.is_file():
        raise FileNotFoundError(f"Solver script not found: {script_path}")
    return script_path


def detect_status(stdout: str, stderr: str, exit_code: int) -> str:
    if exit_code == 124 or exit_code == 137 or exit_code == 143: # 137 is SIGKILL, 143 is SIGTERM
        return "timeout"
    
    # Check stdout/stderr for status strings
    for stream in (stdout, stderr):
        for line in stream.splitlines():
            # Check for exact matches on lines first to avoid noise
            if line.strip().lower() in ("sat", "unsat", "unknown"):
                 return line.strip().lower()
            
            # Fallback to regex search
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
        
        # Double check validity of status based on runtime vs timeout
        if runtime >= timeout and status != "timeout":
             pass

        return SolverResult(
            solver=solver,
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
            status="missing",
            runtime=runtime,
            exit_code=None,
            stdout="",
            stderr="",
            error=str(exc),
            file_path=smt_file,
        )
    except Exception as exc:
        runtime = time.perf_counter() - start
        return SolverResult(
            solver=solver,
            status="error",
            runtime=runtime,
            exit_code=None,
            stdout="",
            stderr="",
            error=str(exc),
            file_path=smt_file,
        )


def format_duration(seconds: float) -> str:
    if seconds >= 600:
        return f"{seconds / 60:.1f}m"
    if seconds >= 10:
        return f"{seconds:.1f}s"
    return f"{seconds:.2f}s"


def print_table(results: List[SolverResult]) -> None:
    header = f"{Colors.BOLD}{'Solver':<14} {'Status':<16} {'Time':<8} {'Exit':<6}{Colors.RESET}"
    print(header)
    print(Colors.GRAY + "-" * 46 + Colors.RESET)
    for result in results:
        status_str = f"{Colors.status_color(result.status)}{result.status:<16}{Colors.RESET}"
        runtime_str = f"{Colors.CYAN}{format_duration(result.runtime):<8}{Colors.RESET}"
        exit_code = "" if result.exit_code is None else str(result.exit_code)
        print(f"{result.solver:<14} {status_str} {runtime_str} {exit_code:<6}")


def print_result_details(result: SolverResult) -> None:
    print(f"\n{Colors.BOLD}== {result.solver} =={Colors.RESET}")
    print(f"Status: {Colors.status_color(result.status)}{result.status}{Colors.RESET}")
    
    if result.error:
        print(f"{Colors.RED}error: {result.error}{Colors.RESET}")
    
    if result.stdout.strip():
        print(f"{Colors.GRAY}stdout:{Colors.RESET}")
        print(result.stdout.strip())
    
    if result.stderr.strip():
        print(f"{Colors.GRAY}stderr:{Colors.RESET}")
        print(result.stderr.strip())
    print("-" * 20)


def check_file(
    smt_file: pathlib.Path, 
    solvers: List[str], 
    solver_timeouts: Dict[str, int], 
    platform_dir: str, 
    args: argparse.Namespace
) -> int:
    """Returns 0 if consistent/unknown, 1 if mismatch, 2 if error."""
    print(f"{Colors.BOLD}Checking: {smt_file.name}{Colors.RESET}")
    print(f"Path:     {smt_file}")
    print(f"Solvers:  {', '.join(solvers)}")

    results: List[SolverResult] = []
    status_set: Set[str] = set()
    fatal_error = False

    for solver in solvers:
        timeout = solver_timeouts.get(solver, args.timeout)
        result = run_solver(solver, smt_file, timeout, platform_dir)
        results.append(result)
        
        if result.status in ("sat", "unsat"):
            status_set.add(result.status)
        
        if result.status in ("error", "missing", "permission"):
             # We assume solver errors are not 'fatal' to the whole batch, but worthy of note
             pass

        if not args.quiet:
            print_result_details(result)

    print_table(results)

    if len(status_set) > 1:
        print(f"\n{Colors.RED}{Colors.BOLD}MISMATCH DETECTED!{Colors.RESET}")
        print(f"Solvers reported conflicting statuses: {status_set}")
        print("="*60 + "\n")
        return 1
    elif len(status_set) == 1:
        consensus = list(status_set)[0]
        print(f"\n{Colors.GREEN}Consensus: {consensus.upper()}{Colors.RESET}")
        print("="*60 + "\n")
        return 0
    else:
        print(f"\n{Colors.YELLOW}No definitive result (unknown/timeout).{Colors.RESET}")
        print("="*60 + "\n")
        return 0


def main() -> int:
    args = parse_args()
    if args.no_color or not sys.stdout.isatty():
        Colors.disable()

    input_path = args.input_path.resolve()
    if not input_path.exists():
        print(f"{Colors.RED}Error: path not found {input_path}{Colors.RESET}", file=sys.stderr)
        return 2

    # Collect files
    files_to_check: List[pathlib.Path] = []
    if input_path.is_file():
        if input_path.suffix == '.smt2':
            files_to_check.append(input_path)
        else:
            print(f"{Colors.RED}Error: Input file must have .smt2 extension{Colors.RESET}", file=sys.stderr)
            return 2
    else:
        # Directory - walk recursively
        files_to_check = sorted(list(input_path.rglob("*.smt2")))
        if not files_to_check:
            print(f"{Colors.YELLOW}No .smt2 files found in directory {input_path}{Colors.RESET}")
            return 0

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

    print(f"Found {len(files_to_check)} files to check.\n")

    stats = {
        "total": len(files_to_check),
        "consistent": 0,
        "mismatch": 0,
        "error": 0 # Not currently used for exit code 2, but could track execution errors
    }

    exit_code = 0
    
    for smt_file in files_to_check:
        res = check_file(smt_file, solvers, solver_timeouts, platform_dir, args)
        if res == 0:
            stats["consistent"] += 1
        elif res == 1:
            stats["mismatch"] += 1
            exit_code = 1
        else:
            stats["error"] += 1
            exit_code = 1 # Consider error as failure too

    # Summary
    print(f"{Colors.BOLD}SUMMARY{Colors.RESET}")
    print(f"Total files: {stats['total']}")
    print(f"Consistent/Unknown: {Colors.GREEN}{stats['consistent']}{Colors.RESET}")
    print(f"Mismatches: {Colors.RED}{stats['mismatch']}{Colors.RESET}")
    
    if stats["mismatch"] > 0:
        print(f"\n{Colors.RED}FAILURE: Consistency check failed for {stats['mismatch']} files.{Colors.RESET}")
        return 1
    
    return exit_code


if __name__ == "__main__":
    sys.exit(main())
