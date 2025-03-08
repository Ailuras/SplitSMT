#!/bin/bash

# This script kills all related processes including batch processes and solver processes
# Usage: kill.sh

echo "Searching for processes to terminate..."

# Kill all batch.sh processes
echo "Terminating batch processing scripts..."
pkill -f "batch.sh"

# Kill all solver processes (cvc5 and z3)
echo "Terminating solver processes..."
pkill -f "cvc5"
pkill -f "z3"

# Kill any remaining run.sh processes
echo "Terminating run.sh processes..."
pkill -f "run.sh"

# Kill any remaining Python analysis processes
echo "Terminating Python analysis processes..."
pkill -f "analysis_solve.py"
pkill -f "analysis_preprocess.py"

# Wait a moment for processes to terminate
sleep 1

# Check if any processes are still running
if pgrep -f "batch.sh" > /dev/null; then
    echo "Warning: Some batch processes are still running. Forcing termination..."
    pkill -9 -f "batch.sh"
fi

if pgrep -f "cvc5" > /dev/null || pgrep -f "z3" > /dev/null; then
    echo "Warning: Some solver processes are still running. Forcing termination..."
    pkill -9 -f "cvc5"
    pkill -9 -f "z3"
fi

if pgrep -f "run.sh" > /dev/null; then
    echo "Warning: Some run.sh processes are still running. Forcing termination..."
    pkill -9 -f "run.sh"
fi

if pgrep -f "analysis_solve.py" > /dev/null || pgrep -f "analysis_preprocess.py" > /dev/null; then
    echo "Warning: Some Python analysis processes are still running. Forcing termination..."
    pkill -9 -f "analysis_solve.py"
    pkill -9 -f "analysis_preprocess.py"
fi

echo "Process termination complete." 