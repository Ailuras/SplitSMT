#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Detect OS and set paths/commands
OS="$(uname -s)"
if [ "$OS" = "Darwin" ]; then
    # Fallback/Default path if Z3_NOODLER_BIN not set
    DEFAULT_SOLVER_PATH=~/WorkSpace/z3-noodler/build/z3
    if command -v gtimeout >/dev/null 2>&1; then
        TIMEOUT_CMD="gtimeout"
    elif command -v timeout >/dev/null 2>&1; then
        TIMEOUT_CMD="timeout"
    else
        echo "Error: Neither 'gtimeout' nor 'timeout' command found. Please install GNU coreutils:" >&2
        echo "  brew install coreutils" >&2
        exit 1
    fi
elif [ "$OS" = "Linux" ]; then
    DEFAULT_SOLVER_PATH=/home/hanrui/z3-noodler/build/z3
    TIMEOUT_CMD="timeout"
else
    echo "Error: Unsupported OS '$OS'"
    exit 1
fi

# Use env var if set, else default
if [ -z "$Z3_NOODLER_BIN" ]; then
    Z3_NOODLER_BIN="$DEFAULT_SOLVER_PATH"
fi

# Ensure solver binary exists and is executable
if [ ! -x "$Z3_NOODLER_BIN" ]; then
    echo "Error: z3-noodler binary not found or not executable at '$Z3_NOODLER_BIN'"
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

# Run z3-noodler with the specified timeout
"$TIMEOUT_CMD" --preserve-status --kill-after=1 "$TIMEOUT" "$Z3_NOODLER_BIN" -T:"$TIMEOUT" model=true "$SMT_FILE"
