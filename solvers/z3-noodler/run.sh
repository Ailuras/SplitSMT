#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

# # 确定新的 z3-noodler 可执行文件路径；如需调整路径，可修改此变量
# Z3_NOODLER_BIN="${Z3_NOODLER_BIN:-/Users/macbookpro/WorkSpace/z3-noodler/build/z3}"

# if [ ! -x "$Z3_NOODLER_BIN" ]; then
#     echo "Error: z3-noodler binary not found or not executable at '$Z3_NOODLER_BIN'"
#     exit 1
# fi

# # Run z3-noodler with the specified timeout; -T:TIMEOUT 是 z3 的超时参数
# timeout --preserve-status --kill-after=1 "$TIMEOUT" "$Z3_NOODLER_BIN" -T:"$TIMEOUT" model=true "$SMT_FILE"
timeout --preserve-status --kill-after=1 "$TIMEOUT" "$SCRIPT_DIR/bin/z3" model=true "$SMT_FILE"