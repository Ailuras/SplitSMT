#!/bin/bash
# Full pipeline script for processing test/top20_maven
# Each line can be executed independently - no variable dependencies
# Usage: ./scripts/shell/test_pipeline.sh

echo "========================================="
echo "SplitSMT Test Pipeline"
echo "Input:  test/top20_maven"
echo "Output: results/round1"
echo "========================================="

# Step 1: Build SplitSMT (if needed)
echo "[1/3] Building SplitSMT..."
if [ ! -f "build/bin/SplitSMT" ]; then
    echo "Building from scratch..."
    rm -rf build
    mkdir -p build
    cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build . --config Release && cd ..
else
    echo "SplitSMT binary already exists, skipping build."
fi

# Step 2: Run batch_splitsmt with different solvers
# Each line below can be run independently
echo "[2/3] Running batch_splitsmt with different solvers..."

bash scripts/batch/batch_splitsmt.sh -s z3 -i test/top20_maven -o results/round1/splitsmt_z3 -t 10 -j 4

bash scripts/batch/batch_splitsmt.sh -s cvc5 -i test/top20_maven -o results/round1/splitsmt_cvc5 -t 10 -j 4

bash scripts/batch/batch_splitsmt.sh -s ostrich -i test/top20_maven -o results/round1/splitsmt_ostrich -t 10 -j 4

bash scripts/batch/batch_splitsmt.sh -s z3-noodler -i test/top20_maven -o results/round1/splitsmt_z3-noodler -t 10 -j 4

# Step 3: Aggregate results into Excel report
echo "[3/3] Generating Excel report..."
python3 scripts/report/aggregate.py results/round1 --output results/round1/report.xlsx --encoding utf-8

