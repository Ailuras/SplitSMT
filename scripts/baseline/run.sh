#!/bin/bash

# Simplified serial runner for StrProcessor tasks.
# Executes run_strprocessor.sh for one or more SMT-LIB files and records results.

set -o pipefail

show_usage() {
    cat <<'EOF'
Usage: run.sh [OPTIONS] FILE [FILE...]

Options:
  -s, --solver SOLVER       Solver adapter to use (e.g., z3, ext-z3, ext-cvc5) [required]
  -t, --timeout SEC         Timeout per file in seconds (default: 60)
  -o, --output LOG_PATH     Log file to append results to [required]
      --runner PATH         Path to run_strprocessor.sh (default: ./run_strprocessor.sh)
  -h, --help                Show this help message

Example:
  ./run.sh -s ext-z3 -t 90 -o results/awesome_ext_z3.log benchmarks/awesome/*.smt2
EOF
}

SOLVER=""
TIMEOUT=60
LOG_PATH=""
RUNNER="./run_strprocessor.sh"

FILES=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -s|--solver)
            SOLVER="$2"
            shift 2
            ;;
        -t|--timeout)
            TIMEOUT="$2"
            shift 2
            ;;
        -o|--output)
            LOG_PATH="$2"
            shift 2
            ;;
        --runner)
            RUNNER="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        --)
            shift
            FILES+=("$@")
            break
            ;;
        -*)
            echo "Unknown option: $1" >&2
            show_usage
            exit 1
            ;;
        *)
            FILES+=("$1")
            shift
            ;;
    esac
done

if [[ -z "$SOLVER" ]]; then
    echo "Error: solver is required." >&2
    show_usage
    exit 1
fi

if [[ -z "$LOG_PATH" ]]; then
    echo "Error: log output path is required." >&2
    show_usage
    exit 1
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
    echo "Error: at least one SMT-LIB file must be provided." >&2
    show_usage
    exit 1
fi

if [[ ! -f "$RUNNER" ]]; then
    echo "Error: solver runner not found at $RUNNER." >&2
    exit 1
fi

if ! [[ "$TIMEOUT" =~ ^[0-9]+$ ]]; then
    echo "Error: timeout must be an integer number of seconds." >&2
    exit 1
fi

LOG_DIR=$(dirname "$LOG_PATH")
mkdir -p "$LOG_DIR"

touch "$LOG_PATH"

total_files=${#FILES[@]}
success_count=0
timeout_count=0
failure_count=0
index=0

echo "[run.sh] Solver: $SOLVER | Timeout: ${TIMEOUT}s | Files: $total_files"
echo "[run.sh] Logging to: $LOG_PATH"

for file_path in "${FILES[@]}"; do
    index=$((index + 1))
    if [[ ! -f "$file_path" ]]; then
        echo "[run.sh] [$index/$total_files] Skipping missing file: $file_path"
        {
            echo "==========================================================="
            echo "FILE: $file_path"
            echo "STATUS: SKIPPED"
            echo "REASON: File not found"
            echo ""
        } >> "$LOG_PATH"
        failure_count=$((failure_count + 1))
        continue
    fi

    echo "[run.sh] [$index/$total_files] Solving $(basename "$file_path")"

    file_start_wall=$(date '+%Y-%m-%d %H:%M:%S')
    file_start_epoch=$(date +%s.%N)
    temp_output=$(mktemp)

    timeout "${TIMEOUT}s" "$RUNNER" "$file_path" --solver "$SOLVER" >"$temp_output" 2>&1
    exit_status=$?

    file_end_wall=$(date '+%Y-%m-%d %H:%M:%S')
    file_end_epoch=$(date +%s.%N)

    duration_raw=$(awk "BEGIN {print $file_end_epoch - $file_start_epoch}")
    duration_formatted=$(printf "%.3f" "$duration_raw")

    result="ERROR"
    case $exit_status in
        0)
            result="SUCCESS"
            success_count=$((success_count + 1))
            ;;
        124|137)
            result="TIMEOUT"
            timeout_count=$((timeout_count + 1))
            ;;
        *)
            result="ERROR"
            failure_count=$((failure_count + 1))
            ;;
    esac

    {
        echo "==========================================================="
        echo "FILE: $file_path"
        echo "START: $file_start_wall"
        echo "END: $file_end_wall"
        echo "DURATION_SEC: $duration_formatted"
        echo "STATUS: $result"
        echo "EXIT_CODE: $exit_status"
        echo "-----------------------------------------------------------"
        cat "$temp_output"
        echo ""
    } >> "$LOG_PATH"

    rm -f "$temp_output"
done

echo "[run.sh] Completed. Success: $success_count | Timeouts: $timeout_count | Failed: $failure_count"

exit 0
