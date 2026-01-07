#!/bin/bash

# Batch launcher for SplitSMT that processes SMT-LIB files using SplitSMT's internal solver framework.
# Unlike batch.sh which directly calls external solver wrappers, this script invokes SplitSMT
# which handles the solving internally.

set -o pipefail

show_usage() {
    cat <<'EOF'
Usage: batch_splitsmt.sh [OPTIONS]

Options:
  -s, --solver SOLVER        Solver to use within SplitSMT (default: z3-noodler)
                             Available: z3, cvc5, ostrich, z3-noodler
  -t, --timeout SEC          Timeout per file in seconds (default: 60)
  -i, --input-dir DIR        Directory containing SMT-LIB files (default: benchmarks)
  -o, --output-dir DIR       Directory to store per-task logs (default: results)
  -g, --group-size NUM       Number of files per task group (default: auto-calculated)
  -j, --jobs NUM             Maximum number of concurrent tasks (default: detected CPU cores)
  -h, --help                 Show this help message

Examples:
  ./batch_splitsmt.sh -s z3 -t 90 -i benchmarks/Java -o results/splitsmt_z3
  ./batch_splitsmt.sh -s cvc5 -i test/top20_maven -o results/splitsmt_cvc5
EOF
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

SOLVER="z3-noodler"
TIMEOUT=60
INPUT_DIR="benchmarks"
OUTPUT_DIR="results"
GROUP_SIZE=""
GROUP_SIZE_SET=0
JOBS=0
JOBS_SET=0
SPLITSMT_BINARY="$REPO_ROOT/build/bin/SplitSMT"

detect_cpu_cores() {
    if command -v nproc >/dev/null 2>&1; then
        nproc
    elif [[ "$(uname -s)" == "Darwin" ]] && command -v sysctl >/dev/null 2>&1; then
        sysctl -n hw.ncpu
    else
        echo 2
    fi
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
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "Error: Unknown option: $1" >&2
            show_usage >&2
            exit 1
            ;;
    esac
done

# Validate SplitSMT binary exists
if [[ ! -f "$SPLITSMT_BINARY" ]]; then
    echo "Error: SplitSMT binary not found at: $SPLITSMT_BINARY" >&2
    echo "Please build SplitSMT first: cmake --build build --config Release" >&2
    exit 1
fi

# Validate solver choice
case "$SOLVER" in
    z3|cvc5|ostrich|z3-noodler)
        ;;
    *)
        echo "Error: Unknown solver: $SOLVER" >&2
        echo "Available solvers: z3, cvc5, ostrich, z3-noodler" >&2
        exit 1
        ;;
esac

# Validate input directory
if [[ ! -d "$INPUT_DIR" ]]; then
    echo "Error: Input directory not found: $INPUT_DIR" >&2
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR" || {
    echo "Error: Failed to create output directory: $OUTPUT_DIR" >&2
    exit 1
}

# Find all .smt2 files (compatible with bash 3 and zsh)
ALL_FILES=()
while IFS= read -r file; do
    ALL_FILES+=("$file")
done < <(find "$INPUT_DIR" -type f -name "*.smt2" | sort)
TOTAL_FILES=${#ALL_FILES[@]}

if [[ $TOTAL_FILES -eq 0 ]]; then
    echo "Error: No .smt2 files found in $INPUT_DIR" >&2
    exit 1
fi

# Determine parallelism
if [[ $JOBS_SET -eq 0 ]]; then
    JOBS=$(detect_cpu_cores)
fi

if [[ $JOBS -le 0 ]]; then
    JOBS=1
fi

# Determine group size
if [[ $GROUP_SIZE_SET -eq 0 ]]; then
    GROUP_SIZE=$(( (TOTAL_FILES + JOBS - 1) / JOBS ))
    if [[ $GROUP_SIZE -lt 1 ]]; then
        GROUP_SIZE=1
    fi
fi

echo "========================================="
echo "Batch SplitSMT Configuration"
echo "========================================="
echo "Solver:      $SOLVER"
echo "Timeout:     $TIMEOUT seconds"
echo "Input:       $INPUT_DIR"
echo "Output:      $OUTPUT_DIR"
echo "Total files: $TOTAL_FILES"
echo "Group size:  $GROUP_SIZE"
echo "Jobs:        $JOBS"
echo "========================================="
echo

# Create task groups
TASK_GROUPS=()
for ((i=0; i<TOTAL_FILES; i+=GROUP_SIZE)); do
    GROUP_FILES=("${ALL_FILES[@]:$i:$GROUP_SIZE}")
    TASK_GROUPS+=("$(IFS=$'\n'; echo "${GROUP_FILES[*]}")")
done

TOTAL_GROUPS=${#TASK_GROUPS[@]}
echo "Created $TOTAL_GROUPS task groups"
echo

# Process function for a single task group
process_task_group() {
    local task_id=$1
    local files=$2
    local log_file="$OUTPUT_DIR/task_$(printf '%03d' "$task_id").log"
    
    {
        echo "==========================================================="
        echo "Task Group $task_id"
        echo "Solver: SplitSMT (using $SOLVER)"
        echo "Started: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "==========================================================="
        echo
        
        while IFS= read -r file; do
            [[ -z "$file" ]] && break
            
            echo "==========================================================="
            echo "Solver: SplitSMT-$SOLVER"
            echo "FILE: $file"
            echo "START: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
            
            START_TIME=$(date +%s.%N)
            
            # Run SplitSMT with specified solver and timeout
            set +e
            OUTPUT=$("$SPLITSMT_BINARY" "$file" -s "$SOLVER" -t "$TIMEOUT" 2>&1)
            EXIT_CODE=$?
            set -e
            
            END_TIME=$(date +%s.%N)
            DURATION=$(echo "$END_TIME - $START_TIME" | bc)
            
            echo "END: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
            echo "DURATION_SEC: $DURATION"
            
            if [[ $EXIT_CODE -eq 0 ]]; then
                echo "STATUS: SUCCESS"
            elif [[ $EXIT_CODE -eq 124 ]] || [[ $EXIT_CODE -eq 143 ]]; then
                echo "STATUS: TIMEOUT"
            else
                echo "STATUS: ERROR"
            fi
            
            echo "EXIT_CODE: $EXIT_CODE"
            echo "-----------------------------------------------------------"
            echo "$OUTPUT"
            echo "==========================================================="
            echo
        done <<< "$files"
        
        echo "Task Group $task_id completed at $(date '+%Y-%m-%d %H:%M:%S')"
    } > "$log_file" 2>&1
}

# Run tasks in parallel
RUNNING_TASKS=()
TASK_ID=1

for task_group in "${TASK_GROUPS[@]}"; do
    # Wait if max jobs reached
    while [[ ${#RUNNING_TASKS[@]} -ge $JOBS ]]; do
        for i in "${!RUNNING_TASKS[@]}"; do
            if ! kill -0 "${RUNNING_TASKS[$i]}" 2>/dev/null; then
                wait "${RUNNING_TASKS[$i]}" || true
                unset "RUNNING_TASKS[$i]"
            fi
        done
        RUNNING_TASKS=("${RUNNING_TASKS[@]}")
        [[ ${#RUNNING_TASKS[@]} -ge $JOBS ]] && sleep 0.5
    done
    
    # Start new task
    process_task_group "$TASK_ID" "$task_group" &
    RUNNING_TASKS+=($!)
    echo "Started task group $TASK_ID (PID: $!)"
    ((TASK_ID++))
done

# Wait for all tasks to complete
echo
echo "Waiting for all tasks to complete..."
for pid in "${RUNNING_TASKS[@]}"; do
    wait "$pid" || true
done

echo
echo "========================================="
echo "All tasks completed!"
echo "Results saved to: $OUTPUT_DIR/"
echo "========================================="
