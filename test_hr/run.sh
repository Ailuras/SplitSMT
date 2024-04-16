#!/bin/bash

# 检查参数数量
if [ $# -ne 3 ]; then
    echo "Usage: \$0 <input_dir> <solver> <timeout>"
    exit 1
fi

input_dir="$1"
solver="$2"
timeout_t="$3"

# 检查目录是否存在
echo "Checking directory $input_dir..."
if [ ! -d "$input_dir" ]; then
    echo "Error: Directory $input_dir does not exist."
    exit 1
fi

for file_path in "${input_dir}"/*; do
    # 在这里执行你需要的文件处理操作
    echo --------------------------------------------------
    start=$(date +%s)
    if [ "$solver" = "strcvc5" ]; then
        timeout $timeout_t ../build/bin/cvc5 "$file_path"
    else
        echo "Error: Invalid solver. Please use 'cvc5'."
        exit 1
    fi
    end=$(date +%s)
    take=$(( ($end - $start) ))
    echo "$(basename "$file_path") : ${take} s."
done

# nohup ./run.sh QF_SLIA/2015-Norn strcvc5 100 > results/results_all.log 2>&1 &
# nohup ./run.sh smtlib strcvc5 100 > results/results_all.log 2>&1 &