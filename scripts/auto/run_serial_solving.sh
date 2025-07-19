#!/bin/bash

# Serial Solver Execution Script
# This script runs multiple solve_batch.sh commands serially to avoid resource conflicts

# Configuration
PARALLEL_LIMIT=20  # Increased parallel processes for better performance
TIMEOUT_PER_TASK=180  # 3 minutes timeout per task (60s solve + overhead)
LOG_DIR="results"
SUMMARY_LOG="serial_solving_summary.log"
FULL_EXECUTION_LOG="serial_solving_full.log"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Simplified logging functions
log_info() {
    echo "[INFO] $1" | tee -a "$LOG_DIR/$SUMMARY_LOG"
}

log_error() {
    echo "[ERROR] $1" | tee -a "$LOG_DIR/$SUMMARY_LOG"
}

log_with_timestamp() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_DIR/$SUMMARY_LOG"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  -p, --parallel NUM      Limit parallel processes per task (default: 8)"
    echo "  -t, --timeout SEC       Timeout per task in seconds (default: 180)"
    echo "  -l, --log-dir DIR       Log directory (default: results)"
    echo "  --dry-run               Show commands without executing"
    echo "  -h, --help              Show this help message"
    echo ""
}

# Parse command line arguments
DRY_RUN=false
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--parallel)
            PARALLEL_LIMIT="$2"
            shift 2
            ;;
        -t|--timeout)
            TIMEOUT_PER_TASK="$2"
            shift 2
            ;;
        -l|--log-dir)
            LOG_DIR="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Define the list of commands to run
declare -a COMMANDS=(
    # seed_auto_easy directory
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_easy -f results_seed_auto_easy_ext_z3.log --solver ext-z3 -t 60 -p $PARALLEL_LIMIT"
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_easy -f results_seed_auto_easy_ext_cvc5.log --solver ext-cvc5 -t 60 -p $PARALLEL_LIMIT"
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_easy -f results_seed_auto_easy_ext_ostrich.log --solver ext-ostrich -t 60 -p $PARALLEL_LIMIT"
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_easy -f results_seed_auto_easy_ext_z3_noodler.log --solver ext-z3-noodler -t 60 -p $PARALLEL_LIMIT"
    
    # seed_auto_medium directory
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_medium -f results_seed_auto_medium_ext_z3.log --solver ext-z3 -t 60 -p $PARALLEL_LIMIT"
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_medium -f results_seed_auto_medium_ext_cvc5.log --solver ext-cvc5 -t 60 -p $PARALLEL_LIMIT"
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_medium -f results_seed_auto_medium_ext_ostrich.log --solver ext-ostrich -t 60 -p $PARALLEL_LIMIT"
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_medium -f results_seed_auto_medium_ext_z3_noodler.log --solver ext-z3-noodler -t 60 -p $PARALLEL_LIMIT"
    
    # seed_auto_hard directory
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_hard -f results_seed_auto_hard_ext_z3.log --solver ext-z3 -t 60 -p $PARALLEL_LIMIT"
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_hard -f results_seed_auto_hard_ext_cvc5.log --solver ext-cvc5 -t 60 -p $PARALLEL_LIMIT"
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_hard -f results_seed_auto_hard_ext_ostrich.log --solver ext-ostrich -t 60 -p $PARALLEL_LIMIT"
    "./scripts/solve/solve_batch.sh -i benchmarks/seed_auto_hard -f results_seed_auto_hard_ext_z3_noodler.log --solver ext-z3-noodler -t 60 -p $PARALLEL_LIMIT"
)

# Create log directory
mkdir -p "$LOG_DIR"

# Initialize log files
: > "$LOG_DIR/$SUMMARY_LOG"
: > "$LOG_DIR/$FULL_EXECUTION_LOG"

# Function to run a single command with timeout and minimal logging
run_command() {
    local cmd="$1"
    local cmd_num="$2"
    local total_cmds="$3"
    
    # Extract solver and dataset info
    local solver=$(echo "$cmd" | grep -o 'ext-[a-z0-9_-]*' | head -1)
    local dataset=$(echo "$cmd" | grep -o 'benchmarks/[a-z0-9_]*' | sed 's|benchmarks/||')
    
    echo "[$cmd_num/$total_cmds] Running $solver on $dataset..."
    log_with_timestamp "Starting [$cmd_num/$total_cmds] $solver on $dataset"
    
    if [[ "$DRY_RUN" == "true" ]]; then
        echo "DRY RUN: $cmd"
        return 0
    fi
    
    # Record start time
    local start_time=$(date +%s)
    
    # Run command with timeout and capture output to full log only
    timeout "${TIMEOUT_PER_TASK}s" bash -c "$cmd" >> "$LOG_DIR/$FULL_EXECUTION_LOG" 2>&1
    local exit_code=$?
    
    # Record end time and calculate duration
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    local duration_readable=$(printf "%02d:%02d" $((duration/60)) $((duration%60)))
    
    # Report results concisely
    if [[ $exit_code -eq 0 ]]; then
        echo "[$cmd_num/$total_cmds] ✓ $solver on $dataset (${duration_readable})"
        log_with_timestamp "COMPLETED [$cmd_num/$total_cmds] $solver on $dataset - Duration: ${duration_readable}"
    elif [[ $exit_code -eq 124 ]] || [[ $exit_code -eq 137 ]]; then
        echo "[$cmd_num/$total_cmds] ✗ TIMEOUT $solver on $dataset (>${TIMEOUT_PER_TASK}s)"
        log_with_timestamp "TIMEOUT [$cmd_num/$total_cmds] $solver on $dataset"
    else
        echo "[$cmd_num/$total_cmds] ✗ FAILED $solver on $dataset (exit: $exit_code)"
        log_with_timestamp "FAILED [$cmd_num/$total_cmds] $solver on $dataset - Exit: $exit_code"
    fi
    
    return $exit_code
}

# Main execution
echo "=========================================="
echo "Serial Solver Execution Starting"
echo "=========================================="
echo "Parallel: $PARALLEL_LIMIT | Timeout: ${TIMEOUT_PER_TASK}s | Tasks: ${#COMMANDS[@]}"

if [[ "$DRY_RUN" == "true" ]]; then
    echo "DRY RUN MODE - No commands will be executed"
fi

log_with_timestamp "Serial solving started: parallel=$PARALLEL_LIMIT, timeout=${TIMEOUT_PER_TASK}s, tasks=${#COMMANDS[@]}"

# Record overall start time
overall_start=$(date +%s)
echo "Start time: $(date '+%Y-%m-%d %H:%M:%S')"

# Execute commands serially
completed=0
failed=0
timeout_count=0

for i in "${!COMMANDS[@]}"; do
    cmd_num=$((i + 1))
    
    # Stop if too many failures
    if [[ $failed -gt 3 ]]; then
        echo "Too many failures ($failed), stopping execution"
        log_with_timestamp "Execution stopped due to failures: $failed"
        break
    fi
    
    run_command "${COMMANDS[i]}" "$cmd_num" "${#COMMANDS[@]}"
    exit_code=$?
    
    if [[ $exit_code -eq 0 ]]; then
        ((completed++))
    elif [[ $exit_code -eq 124 ]] || [[ $exit_code -eq 137 ]]; then
        ((timeout_count++))
    else
        ((failed++))
    fi
    
    # Brief pause between commands (no message)
    if [[ "$DRY_RUN" == "false" && $((cmd_num)) -lt ${#COMMANDS[@]} ]]; then
        sleep 2
    fi
done

# Calculate overall duration
overall_end=$(date +%s)
overall_duration=$((overall_end - overall_start))
overall_duration_readable=$(printf "%02d:%02d:%02d" $((overall_duration/3600)) $((overall_duration%3600/60)) $((overall_duration%60)))

# Final summary
echo "=========================================="
echo "Execution Completed"
echo "=========================================="
echo "Duration: $overall_duration_readable | Completed: $completed/${#COMMANDS[@]}"

if [[ $timeout_count -gt 0 ]]; then
    echo "Timeouts: $timeout_count"
fi

if [[ $failed -gt 0 ]]; then
    echo "Failed: $failed"
fi

log_with_timestamp "Completed - Success: $completed, Failed: $failed, Timeouts: $timeout_count, Duration: $overall_duration_readable"

echo "Logs saved to: $LOG_DIR/$SUMMARY_LOG (summary), $LOG_DIR/$FULL_EXECUTION_LOG (full)"

# Determine exit code
if [[ $completed -eq ${#COMMANDS[@]} ]]; then
    echo "All tasks completed successfully!"
    exit 0
elif [[ $completed -gt 0 ]]; then
    echo "Partial completion: $completed/${#COMMANDS[@]} tasks succeeded"
    exit 2
else
    echo "No tasks completed successfully"
    exit 1
fi 