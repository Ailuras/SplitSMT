#!/bin/bash

# Configuration: Set the path to the Ostrich solver binary
# Modify this path to point to your Ostrich installation
SOLVER_PATH="/path/to/ostrich"

# Ensure solver binary exists and is executable
if [ ! -x "$SOLVER_PATH" ]; then
    echo "Error: Solver binary '$SOLVER_PATH' not found or not executable"
    echo "Please set SOLVER_PATH in this script to point to your Ostrich binary"
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

# Run Ostrich with the specified timeout
# Enable incremental mode for model support and filter verbose output
# Note: timeout command is standard on Linux; on macOS, install via: brew install coreutils
timeout --preserve-status --kill-after=1 "$TIMEOUT" "$SOLVER_PATH" +incremental -quiet -logo -runtime "$SMT_FILE" 2>&1 | grep -v -E "Loading|OSTRICH|Matthew|For more|contributions|Running|Considered|Warning|^\s*$|^\s*\.\.\." | grep -E "sat|unsat|unknown|model|define-fun|\(|\)|^$"
