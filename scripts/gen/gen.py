#!/usr/bin/env python3

from __future__ import annotations

import argparse
import subprocess
import sys
import time
from dataclasses import dataclass
from pathlib import Path
import shutil
from typing import Iterable, List, Sequence

# REPO_ROOT = Path(__file__).resolve().parents[2]
REPO_ROOT = Path(__file__).resolve().parents[2]
CPP_PREPROCESS_PATH = REPO_ROOT / "build" / "bin" / "SplitSMT"


@dataclass
class ProcessResult:
    input_file: Path
    output_file: Path
    ok: bool
    duration: float
    reason: str | None = None


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run SplitSMT on a file or directory of files."
    )
    parser.add_argument(
        "-i", "--input",
        dest="input_path",
        type=Path,
        required=True,
        help="待转换的文件或文件夹。",
    )
    parser.add_argument(
        "-o", "--output",
        dest="output_path",
        type=Path,
        required=True,
        help="输出文件或文件夹。目录输入时会镜像原有相对路径。",
    )
    parser.add_argument(
        "--clear",
        action="store_true",
        help="处理前清空输出路径（文件则删除，目录则递归删除）。",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=60,
        help="单个文件的超时时间（秒），默认 60。",
    )

    parser.add_argument(
        "--log-level",
        type=int,
        default=4,  # Silent mode (NONE) for batch processing
        help="传递 -l/--level 给 SplitSMT，用于调节日志级别。0=DEBUG, 1=INFO, 2=WARN, 3=ERROR, 4=NONE",
    )
    parser.add_argument(
        "--verbose",
        dest="verbose",
        action="store_true",
        help="打印逐文件的输入/输出路径（默认关闭）。",
    )
    parser.add_argument(
        "--quiet",
        dest="verbose",
        action="store_false",
        help="安静模式（默认），仅在失败或汇总时打印。",
    )
    parser.set_defaults(verbose=False)
    return parser.parse_args()


def iter_input_files(input_path: Path) -> tuple[Path, Sequence[Path]]:
    if input_path.is_file():
        return input_path, [input_path]
    if input_path.is_dir():
        files: List[Path] = sorted(p for p in input_path.rglob("*.smt2") if p.is_file())
        return input_path, files
    print(f"error: input path does not exist: {input_path}", file=sys.stderr)
    sys.exit(1)


def build_output_path(input_root: Path, output_root: Path, file_path: Path, is_single_file: bool) -> Path:
    if is_single_file:
        if output_root.is_dir():
            return output_root / file_path.name
        return output_root
    relative = file_path.relative_to(input_root)
    return output_root / relative


def run_preprocess(
    input_file: Path,
    output_file: Path,
    timeout: int,
    log_level: int | None,
    converter_path: Path,
) -> ProcessResult:
    start = time.time()
    try:
        output_file.parent.mkdir(parents=True, exist_ok=True)
        # Always run in generation mode: SplitSMT <input> <output> --gen
        cmd = [str(converter_path), str(input_file), str(output_file), "--gen"]
            
        if log_level is not None:
            cmd.extend(["-l", str(log_level)])

        completed = subprocess.run(
            cmd,
            # cwd=REPO_ROOT, # Optional if paths are absolute or relative to cur dir
            capture_output=True,
            text=False,  # Capture binary data to avoid decoding errors
            timeout=timeout,
        )
        duration = time.time() - start
        if completed.returncode == 0:
            return ProcessResult(input_file, output_file, True, duration)
            
        # Decode output safely with error replacement
        stderr = completed.stderr.decode("utf-8", errors="replace")
        stdout = completed.stdout.decode("utf-8", errors="replace")
        reason = stderr.strip() or stdout.strip() or f"exit code {completed.returncode}"
        return ProcessResult(input_file, output_file, False, duration, reason)
    except subprocess.TimeoutExpired:
        return ProcessResult(
            input_file,
            output_file,
            False,
            time.time() - start,
            f"timeout after {timeout}s",
        )
    except Exception as exc:  # noqa: BLE001 - surface unexpected errors
        return ProcessResult(input_file, output_file, False, time.time() - start, str(exc))


def summarize(results: Iterable[ProcessResult], total_duration: float) -> None:
    results_list = list(results)
    success = [r for r in results_list if r.ok]
    failed = [r for r in results_list if not r.ok]
    print()
    print(f"Processed {len(results_list)} file(s) in {total_duration:.1f}s")
    print(f"  Success: {len(success)}")
    print(f"  Failed : {len(failed)}")


def main() -> None:
    args = parse_args()
    input_path = args.input_path.expanduser().resolve()
    output_path = args.output_path.expanduser().resolve()
    if args.timeout <= 0:
        print("error: --timeout must be positive seconds", file=sys.stderr)
        sys.exit(1)
    converter_path = CPP_PREPROCESS_PATH
    if not converter_path.exists():
        print(f"error: converter not found: {converter_path}", file=sys.stderr)
        sys.exit(1)

    if input_path.is_dir() and output_path.exists() and output_path.is_file():
        print("error: output_path is a file while input_path is a directory; please provide a directory path.", file=sys.stderr)
        sys.exit(1)

    if args.clear and output_path.exists():
        if input_path.exists() and input_path.resolve() == output_path.resolve():
            print("error: --clear would remove the input path; use a different output_path.", file=sys.stderr)
            sys.exit(1)
        try:
            if output_path.is_dir():
                shutil.rmtree(output_path)
            else:
                output_path.unlink()
        except Exception as exc:  # noqa: BLE001 - surface unexpected errors
            print(f"error: failed to clear output_path {output_path}: {exc}", file=sys.stderr)
            sys.exit(1)

    if input_path.is_dir():
        output_path.mkdir(parents=True, exist_ok=True)

    input_root, files = iter_input_files(input_path)
    if not files:
        print("warning: no files found to process.")
        return

    is_single_file = input_path.is_file()
    start = time.time()
    results: List[ProcessResult] = []
    total = len(files)
    if not args.verbose:
        print(f"Processing {total} file(s)...")
    for idx, file_path in enumerate(files, start=1):
        target_path = build_output_path(input_root, output_path, file_path, is_single_file)
        if args.verbose:
            print(f"[{idx}/{total}] {file_path} -> {target_path}")
        try:
            result = run_preprocess(
                file_path,
                target_path,
                args.timeout,
                args.log_level,
                converter_path,
            )
        except Exception as exc:  # noqa: BLE001 - defensive: keep batch running
            result = ProcessResult(file_path, target_path, False, time.time() - start, str(exc))
        if not result.ok and result.reason:
            print(f"    failed: {file_path} -> {target_path}: {result.reason}", file=sys.stderr)
        results.append(result)
    summarize(results, time.time() - start)


if __name__ == "__main__":
    main()
