#!/bin/bash

# Batch launcher that groups SMT-LIB files and delegates to run.sh.

set -o pipefail

show_usage() {
    cat <<'EOF'
Usage: batch.sh [OPTIONS]

Options:
  -s, --solver SOLVER        Solver adapter to use (required)
  -t, --timeout SEC          Timeout per file in seconds (default: 60)
  -i, --input-dir DIR        Directory containing SMT-LIB files (default: benchmarks)
  -o, --output-dir DIR       Directory to store per-task logs (default: results)
  -g, --group-size NUM       Number of files per run.sh invocation (default: 1)
      --run-script PATH      Path to run.sh (default: ./run.sh alongside this script)
  -h, --help                 Show this help message

Example:
  ./batch.sh -s ext-z3 --timeout 90 -i benchmarks/awesome -o results/awesome_logs -g 5
EOF
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SOLVER=""
TIMEOUT=60
INPUT_DIR="benchmarks"
OUTPUT_DIR="results"
GROUP_SIZE=1
RUN_SCRIPT="$SCRIPT_DIR/run.sh"

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
        -i|--input-dir)
            INPUT_DIR="$2"
            shift 2
            ;;
        -o|--output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -g|--group-size)
            GROUP_SIZE="$2"
            shift 2
            ;;
        --run-script)
            RUN_SCRIPT="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        -*)
            echo "Unknown option: $1" >&2
            show_usage
            exit 1
            ;;
        *)
            echo "Unexpected positional argument: $1" >&2
            show_usage
            exit 1
            ;;
    esac
done

if [[ -z "$SOLVER" ]]; then
    echo "Error: solver is required." >&2
    show_usage
    exit 1
fi

if ! [[ "$TIMEOUT" =~ ^[0-9]+$ ]]; then
    echo "Error: timeout must be an integer number of seconds." >&2
    exit 1
fi

if ! [[ "$GROUP_SIZE" =~ ^[0-9]+$ ]] || [[ "$GROUP_SIZE" -le 0 ]]; then
    echo "Error: group size must be a positive integer." >&2
    exit 1
fi

if [[ ! -d "$INPUT_DIR" ]]; then
    echo "Error: input directory not found: $INPUT_DIR" >&2
    exit 1
fi

if [[ ! -f "$RUN_SCRIPT" ]]; then
    echo "Error: run.sh not found at $RUN_SCRIPT" >&2
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

mapfile -t SMT_FILES < <(find "$INPUT_DIR" -type f -name "*.smt2" | sort)

if [[ ${#SMT_FILES[@]} -eq 0 ]]; then
    echo "No SMT-LIB files (*.smt2) found under $INPUT_DIR"
    exit 0
fi

echo "[batch.sh] Solver: $SOLVER | Timeout: ${TIMEOUT}s | Files: ${#SMT_FILES[@]}"
echo "[batch.sh] Group size: $GROUP_SIZE"
echo "[batch.sh] Logs will be saved under: $OUTPUT_DIR"

task_index=0
success_tasks=0
failed_tasks=0

pending_files=()

run_task() {
    local files=("$@")
    if [[ ${#files[@]} -eq 0 ]]; then
        return
    fi

    task_index=$((task_index + 1))
    local log_name
    log_name=$(printf "task_%03d.log" "$task_index")
    local log_path="${OUTPUT_DIR%/}/$log_name"

    echo "[batch.sh] Task $task_index -> ${#files[@]} file(s) | log: $log_path"

    "$RUN_SCRIPT" -s "$SOLVER" -t "$TIMEOUT" -o "$log_path" "${files[@]}" >/dev/null
    local exit_code=$?
    if [[ $exit_code -eq 0 ]]; then
        success_tasks=$((success_tasks + 1))
    else
        failed_tasks=$((failed_tasks + 1))
        echo "[batch.sh] Task $task_index exited with code $exit_code (see $log_path)"
    fi
}

for file_path in "${SMT_FILES[@]}"; do
    pending_files+=("$file_path")
    if [[ ${#pending_files[@]} -ge $GROUP_SIZE ]]; then
        run_task "${pending_files[@]}"
        pending_files=()
    fi
done

# Flush remaining files (if any)
if [[ ${#pending_files[@]} -gt 0 ]]; then
    run_task "${pending_files[@]}"
fi

echo "[batch.sh] Completed tasks: $task_index | Success: $success_tasks | Failed: $failed_tasks"

if [[ $failed_tasks -gt 0 ]]; then
    exit 1
fi

exit 0
