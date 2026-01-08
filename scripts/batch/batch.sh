#!/bin/bash

# Batch launcher that groups SMT-LIB files and runs solvers with optional parallelism.

set -o pipefail

show_usage() {
    cat <<'EOF'
Usage: batch.sh [OPTIONS]

Options:
  -s, --solver SOLVER        Solver name to use (required): z3, z3-noodler, z3-noodler-mocha, cvc5, ostrich
  -t, --timeout SEC          Timeout per file in seconds (default: 60)
  -i, --input-dir DIR        Directory containing SMT-LIB files (default: benchmarks)
  -o, --output-dir DIR       Directory to store per-task logs (default: results)
  -g, --group-size NUM       Number of files per task group (default: auto-calculated)
  -j, --jobs NUM             Maximum number of concurrent tasks (default: detected CPU cores)
      --solver-script PATH   Direct path to solver script (overrides automatic resolution)
  -h, --help                 Show this help message

Examples:
  ./batch.sh -s z3 -t 90 -i benchmarks/awesome -o results/awesome_logs -g 5 -j 4
  ./batch.sh -s cvc5 -i benchmarks/Java -o results/java_logs
EOF
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

SOLVER=""
TIMEOUT=60
INPUT_DIR="benchmarks"
OUTPUT_DIR="results"
GROUP_SIZE=""
GROUP_SIZE_SET=0
JOBS=0
JOBS_SET=0
SOLVER_SCRIPT=""

detect_cpu_cores() {
    if command -v nproc >/dev/null 2>&1; then
        nproc
    elif [[ "$(uname -s)" == "Darwin" ]] && command -v sysctl >/dev/null 2>&1; then
        sysctl -n hw.ncpu
    else
        echo 2
    fi
}

resolve_solver_script() {
    local solver_name="$1"
    local script_path="$REPO_ROOT/solvers/$solver_name.sh"
    if [[ ! -f "$script_path" ]]; then
        echo "Error: Solver script not found: $script_path" >&2
        echo "Expected path: solvers/$solver_name.sh" >&2
        return 1
    fi
    echo "$script_path"
}

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
            GROUP_SIZE_SET=1
            shift 2
            ;;
        -j|--jobs)
            JOBS="$2"
            JOBS_SET=1
            shift 2
            ;;
        --solver-script)
            SOLVER_SCRIPT="$2"
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

if ! [[ "$TIMEOUT" =~ ^[0-9]+$ ]]; then
    echo "Error: timeout must be an integer number of seconds." >&2
    exit 1
fi

if [[ $GROUP_SIZE_SET -eq 1 ]]; then
    if ! [[ "$GROUP_SIZE" =~ ^[0-9]+$ ]] || [[ "$GROUP_SIZE" -le 0 ]]; then
        echo "Error: group size must be a positive integer." >&2
        exit 1
    fi
fi

if [[ $JOBS_SET -eq 1 ]]; then
    if ! [[ "$JOBS" =~ ^[0-9]+$ ]] || [[ "$JOBS" -le 0 ]]; then
        echo "Error: jobs must be a positive integer." >&2
        exit 1
    fi
fi

if [[ -z "$SOLVER" ]]; then
    echo "Error: solver name is required (use -s or --solver)" >&2
    show_usage
    exit 1
fi

if [[ -n "$SOLVER_SCRIPT" ]]; then
    if [[ ! -f "$SOLVER_SCRIPT" ]]; then
        echo "Error: solver script not found: $SOLVER_SCRIPT" >&2
        exit 1
    fi
    if [[ ! -x "$SOLVER_SCRIPT" ]]; then
        chmod +x "$SOLVER_SCRIPT" 2>/dev/null || true
    fi
    if [[ ! -x "$SOLVER_SCRIPT" ]]; then
        echo "Error: solver script is not executable: $SOLVER_SCRIPT" >&2
        exit 1
    fi
else
    SOLVER_SCRIPT=$(resolve_solver_script "$SOLVER")
    if [[ $? -ne 0 ]]; then
        exit 1
    fi
    if [[ ! -x "$SOLVER_SCRIPT" ]]; then
        chmod +x "$SOLVER_SCRIPT" 2>/dev/null || true
    fi
    if [[ ! -x "$SOLVER_SCRIPT" ]]; then
        echo "Error: solver script is not executable: $SOLVER_SCRIPT" >&2
        exit 1
    fi
fi

if [[ ! -d "$INPUT_DIR" ]]; then
    echo "Error: input directory not found: $INPUT_DIR" >&2
    exit 1
fi

if [[ $JOBS -eq 0 ]]; then
    JOBS=$(detect_cpu_cores)
    if ! [[ "$JOBS" =~ ^[0-9]+$ ]] || [[ "$JOBS" -le 0 ]]; then
        JOBS=4
    fi
fi

if ! [[ "$JOBS" =~ ^[0-9]+$ ]] || [[ "$JOBS" -le 0 ]]; then
    echo "Error: jobs must be a positive integer." >&2
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

SMT_FILES=()
while IFS= read -r file_path; do
    [[ -z "$file_path" ]] && continue
    SMT_FILES+=("$file_path")
done < <(find "$INPUT_DIR" -type f -name "*.smt2" | sort)

if [[ ${#SMT_FILES[@]} -eq 0 ]]; then
    echo "No SMT-LIB files (*.smt2) found under $INPUT_DIR"
    exit 0
fi

if [[ $GROUP_SIZE_SET -eq 0 ]]; then
    total_files=${#SMT_FILES[@]}
    GROUP_SIZE=$(( (total_files + JOBS - 1) / JOBS ))
    if [[ "$GROUP_SIZE" -le 0 ]]; then
        GROUP_SIZE=1
    fi
fi

if ! [[ "$GROUP_SIZE" =~ ^[0-9]+$ ]] || [[ "$GROUP_SIZE" -le 0 ]]; then
    echo "Error: group size must be a positive integer." >&2
    exit 1
fi

echo "[batch.sh] Solver: $SOLVER | Timeout: ${TIMEOUT}s | Files: ${#SMT_FILES[@]}"
echo "[batch.sh] Solver script: $SOLVER_SCRIPT"
echo "[batch.sh] Group size: $GROUP_SIZE | Jobs: $JOBS"
echo "[batch.sh] Logs will be saved under: $OUTPUT_DIR"

task_index=0
success_tasks=0
failed_tasks=0

pending_files=()

declare -a ACTIVE_PIDS=()
declare -A PID_TO_TASK=()
declare -A PID_TO_LOG=()

cleanup() {
    for pid in "${ACTIVE_PIDS[@]}"; do
        if kill -0 "$pid" >/dev/null 2>&1; then
            kill "$pid" >/dev/null 2>&1 || true
        fi
    done
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

run_task() {
    local task_id="$1"
    shift
    local log_path="$1"
    shift
    local files=("$@")

    if [[ ${#files[@]} -eq 0 ]]; then
        return
    fi

    : > "$log_path"

    local idx=0
    local failure=0

    for file_path in "${files[@]}"; do
        idx=$((idx + 1))
        local header_separator="==========================================================="
        local section_separator="-----------------------------------------------------------"
        local file_start_wall
        local file_end_wall
        local file_start_epoch
        local file_end_epoch

        if [[ ! -f "$file_path" ]]; then
            {
                echo "$header_separator"
                echo "FILE: $file_path"
                echo "STATUS: SKIPPED"
                echo "REASON: File not found"
                echo ""
            } >> "$log_path"
            failure=1
            continue
        fi

        file_start_wall=$(date '+%Y-%m-%d %H:%M:%S')
        file_start_epoch=$(date +%s.%N)

        local temp_output
        temp_output=$(mktemp)

        local exit_status
        "$SOLVER_SCRIPT" "$TIMEOUT" "$file_path" >"$temp_output" 2>&1
        exit_status=$?

        file_end_wall=$(date '+%Y-%m-%d %H:%M:%S')
        file_end_epoch=$(date +%s.%N)

        local duration_raw
        duration_raw=$(awk "BEGIN {print $file_end_epoch - $file_start_epoch}")
        local duration_formatted
        duration_formatted=$(printf "%.3f" "$duration_raw")

        local result="ERROR"
        case $exit_status in
            0)
                result="SUCCESS"
                ;;
            124|137)
                result="TIMEOUT"
                failure=1
                ;;
            *)
                result="ERROR"
                failure=1
                ;;
        esac
        local is_timeout
        is_timeout=$(awk "BEGIN {print ($duration_raw >= $TIMEOUT) ? 1 : 0}")
        if [[ "$is_timeout" -eq 1 ]]; then
            result="TIMEOUT"
            failure=1
        fi

        {
            echo "$header_separator"
            echo "Solver: $SOLVER"
            echo "FILE: $file_path"
            echo "TIMEOUT: ${TIMEOUT}s"
            echo "START: $file_start_wall"
            echo "END: $file_end_wall"
            echo "DURATION_SEC: $duration_formatted"
            echo "STATUS: $result"
            echo "EXIT_CODE: $exit_status"
            echo "$section_separator"
            cat "$temp_output"
            echo ""
        } >> "$log_path"
        rm -f "$temp_output"
    done

    return $failure
}

wait_for_one() {
    local pid
    while true; do
        for pid in "${ACTIVE_PIDS[@]}"; do
            if ! kill -0 "$pid" >/dev/null 2>&1; then
                wait "$pid"
                local exit_code=$?
                local task_id="${PID_TO_TASK[$pid]}"
                local log_path="${PID_TO_LOG[$pid]}"

                if [[ $exit_code -eq 0 ]]; then
                    success_tasks=$((success_tasks + 1))
                else
                    failed_tasks=$((failed_tasks + 1))
                    echo "[batch.sh] Task $task_id exited with code $exit_code (see $log_path)"
                fi

                unset 'PID_TO_TASK[$pid]'
                unset 'PID_TO_LOG[$pid]'

                local remaining=()
                local current_pid
                for current_pid in "${ACTIVE_PIDS[@]}"; do
                    if [[ "$current_pid" != "$pid" ]]; then
                        remaining+=("$current_pid")
                    fi
                done
                ACTIVE_PIDS=("${remaining[@]}")

                return
            fi
        done
        sleep 0.2
    done
}

wait_for_slot() {
    while [[ ${#ACTIVE_PIDS[@]} -ge $JOBS ]]; do
        wait_for_one
    done
}

for file_path in "${SMT_FILES[@]}"; do
    pending_files+=("$file_path")
    if [[ ${#pending_files[@]} -ge $GROUP_SIZE ]]; then
        task_index=$((task_index + 1))
        log_name=$(printf "task_%03d.log" "$task_index")
        log_path="${OUTPUT_DIR%/}/$log_name"

        echo "[batch.sh] Task $task_index -> ${#pending_files[@]} file(s) | log: $log_path"

        wait_for_slot

        (
            run_task "$task_index" "$log_path" "${pending_files[@]}"
        ) &
        pid=$!
        ACTIVE_PIDS+=("$pid")
        PID_TO_TASK[$pid]=$task_index
        PID_TO_LOG[$pid]=$log_path

        pending_files=()
    fi
done

if [[ ${#pending_files[@]} -gt 0 ]]; then
    task_index=$((task_index + 1))
    log_name=$(printf "task_%03d.log" "$task_index")
    log_path="${OUTPUT_DIR%/}/$log_name"

    echo "[batch.sh] Task $task_index -> ${#pending_files[@]} file(s) | log: $log_path"

    wait_for_slot

    (
        run_task "$task_index" "$log_path" "${pending_files[@]}"
    ) &
    pid=$!
    ACTIVE_PIDS+=("$pid")
    PID_TO_TASK[$pid]=$task_index
    PID_TO_LOG[$pid]=$log_path
fi

while [[ ${#ACTIVE_PIDS[@]} -gt 0 ]]; do
    wait_for_one
done

echo "[batch.sh] Completed tasks: $task_index | Success: $success_tasks | Failed: $failed_tasks"

if [[ $failed_tasks -gt 0 ]]; then
    exit 1
fi

exit 0
