#!/bin/bash

# 计数器，从 1 开始
counter=1

# 先获取所有文件，并按编号从小到大排序
for file in $(ls norn-benchmark-*.smt2 2>/dev/null | sort -V); do
    if [[ -f "$file" ]]; then
        # 构造新的文件名
        new_name="norn-benchmark-${counter}.smt2"

        # 执行重命名
        mv "$file" "$new_name"
        echo "Renamed: $file -> $new_name"

        # 计数器递增
        ((counter++))
    fi
done

echo "All files have been renamed in ascending order!"