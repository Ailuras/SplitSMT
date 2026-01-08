#!/bin/bash
set -e  # 出错即停止
# 1. 预处理：删除 get-model, 处理 push/pop 等
python scripts/convert/normalize.py --input benchmarks_UF
# 2. 转换成 UF 格式
# python scripts/convert/convert_splitsmt2uf.py --input benchmarks_splitsmt --output benchmarks_UF
# 3. 从 UF 转换成 RA 和 REC 格式 (注意修正脚本名称)
python scripts/convert/convert_uf2others.py --input benchmarks_UF --output benchmarks_others
# 4. 整理目录结构
rm -rf benchmarks_RA benchmarks_REC benchmarks_splitsmt
mv benchmarks_others/ra benchmarks_RA
mv benchmarks_others/rec benchmarks_REC
mv benchmarks_others/splitsmt benchmarks_splitsmt
# 5. 清理中间产物
rm -rf benchmarks_others