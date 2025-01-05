#!/bin/bash

# 输入文件
input_file=$1
# 输出文件
output_file="output.txt"

# 计数器，从 1 开始
counter=1

# 读取文件逐行处理
while IFS= read -r line; do
    # 如果行中匹配 norn-benchmark-数字.smt2，则替换编号
    if [[ "$line" =~ norn-benchmark-[0-9]+\.smt2 ]]; then
        new_line=$(echo "$line" | sed -E "s/norn-benchmark-[0-9]+/norn-benchmark-${counter}/")
        ((counter++))
    else
        new_line="$line"
    fi

    # 追加到新文件
    echo "$new_line" >> "$output_file"
done < "$input_file"

echo "Reindexing completed. Output saved to $output_file"