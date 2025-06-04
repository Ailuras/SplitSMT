#!/bin/bash

echo "Starting mutation analysis..."

SCRIPT_PATH="/home/hanrui/StrProcessor/scripts/solve/analysis_results.py"

python $SCRIPT_PATH \
    --seeds-dir benchmarks/seeds \
    --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek \
    --result-logs results/results_mutate_auto.log results/results_mutate_deepseek.log \
    --output-file charts/QF_SLIA_SPLIT.xlsx

echo "Analysis completed. Check charts/QF_SLIA_SPLIT.xlsx for results." 0