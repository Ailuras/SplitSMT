#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SOLVER_PATH=/home/hanrui/z3/build/z3

# Ensure solver binary exists and is executable
if [ ! -x "$SOLVER_PATH" ]; then
    echo "Error: Solver binary '$SOLVER_PATH' not found or not executable"
    exit 1
fi

# Function to kill all child processes
cleanup() {
    pkill -P $$
    exit 1
}

# Set up trap for Ctrl+C
trap cleanup SIGINT SIGTERM

# Check if correct number of arguments is provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <timeout> <smt_file>"
    echo "Example: $0 300 problem.smt2"
    exit 1
fi

TIMEOUT=$1
SMT_FILE=$2

# Check if timeout is a positive number
if ! [[ "$TIMEOUT" =~ ^[0-9]+$ ]] || [ "$TIMEOUT" -le 0 ]; then
    echo "Error: Timeout must be a positive number"
    exit 1
fi

# Check if SMT file exists
if [ ! -f "$SMT_FILE" ]; then
    echo "Error: SMT file '$SMT_FILE' does not exist"
    exit 1
fi

# Run z3 with the specified timeout and enable model generation
# --preserve-status: preserve the exit status of the command
# --kill-after=1: send SIGKILL after 1 second if the process doesn't terminate
timeout --preserve-status --kill-after=1 "$TIMEOUT" "$SOLVER_PATH" model=true "$SMT_FILE"
