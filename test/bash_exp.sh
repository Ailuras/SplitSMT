
SOLVER="cvc5"

BENCHMARK_DIR="/home/hanrui/StrProcessor/test/example21_4"

OUTPUT_CSV="/home/hanrui/StrProcessor/test/result_cvc5.csv"

THREADS=15   # 设置并行线程数（可修改）

# 初始化输出文件（使用锁机制避免并发写冲突）
echo "filename,result,time" > "$OUTPUT_CSV"

# 定义单个任务的执行函数
run_solver() {
    file="$1"
    filename=$(realpath --relative-to="$BENCHMARK_DIR" "$file")

    tmp_out=$(mktemp)
    tmp_err=$(mktemp)

    # 执行 solver，并记录时间和结果
    timeout 2000s /usr/bin/time -f "%e" "$SOLVER" "$file" > "$tmp_out" 2> "$tmp_err"
    status=$?


    if [[ $status -eq 124 ]]; then
        echo "$filename,TIMEOUT,1200.0"
    elif [[ $status -ne 0 ]]; then
        echo "$filename,ERROR,0.0"
    else
        # time=$(tail -n 1 "$tmp_err")
        time=$(tail -n 1 "$tmp_err" 2>/dev/null)

        # output=$(cat "$tmp_out")
        # 合并输出
        output=$(cat "$tmp_out" "$tmp_err")

        if echo "$output" | grep -q "unsat"; then
            result_str="UNSAT"
        elif echo "$output" | grep -q "sat"; then
            result_str="SAT"
        elif echo "$output" | grep -q "unknown"; then
            result_str="UNKNOWN"
        else
            result_str="UNKNOWN"
        fi

        echo "$filename,$result_str,$time"
    fi

    rm -f "$tmp_out" "$tmp_err"
}

export -f run_solver
export SOLVER BENCHMARK_DIR

# 查找所有 .smt2 文件并并行处理
# find "$BENCHMARK_DIR" -type f -name "*.smt2" \
#     | xargs -P "$THREADS" -I {} bash -c 'run_solver "$@"' _ {} >> "$OUTPUT_CSV"

find "$BENCHMARK_DIR" -type f -name "*.smt2" | sort -u \
    | xargs -P "$THREADS" -I {} bash -c 'run_solver "$@"' _ {} >> "$OUTPUT_CSV"