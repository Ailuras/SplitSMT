#!/bin/bash

# 遍历当前文件夹下所有 .smt2 文件
for file in *.smt2; do
    # 确保文件存在，防止 *.smt2 没有匹配到文件时报错
    if [[ -f "$file" ]]; then
        echo "Processing $file ..."
        python preprocess.py "$file"
    fi
done

echo "All .smt2 files have been processed!"