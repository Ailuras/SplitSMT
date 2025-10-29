# scripts/check 用法

## batch.sh

```bash
./batch.sh -s <solver> -t <timeout> -i <input_dir> -o <output_dir> -g <group_size> -j <jobs>
```

- `-s` 指定求解器名称，例如 `z3`、`z3-noodler`、`cvc5`
- `-t` 设置单个文件超时秒数
- `-i` 选择待处理的基准目录
- `-o` 指定日志输出目录
- `-g` 控制单个任务包含的文件数量
- `-j` 控制并发任务数

示例：

```bash
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks -o results/all_logs -g 10 -j 48
./scripts/check/batch.sh -s z3-noodler -t 60 -i scripts/check/benchmarks -o results/error_logs -g 5 -j 10
```

## parse_logs.py

```bash
python3 scripts/check/parse_logs.py <log_dir> [output_excel] [--save-errors-dir DIR] [--source-root ROOT]
```

- `<output_excel>` 可选，默认为 `log_dir` 上一级目录下的 `analysis.xlsx`
- `--save-errors-dir` 指定将解析结果中 `Error` 对应的 SMT2 文件复制到的目标目录，并保持原始目录结构
- `--source-root` （可选）设置解析 SMT2 路径时额外的根目录，适用于在不同工作目录下运行脚本的情况

示例：

```bash
# 解析日志并导出 Excel，同时把出错的输入复制到 scripts/check/errors 目录
python3 scripts/check/parse_logs.py results/all_logs --save-errors-dir scripts/check

# 指定 Excel 输出及自定义源路径解析根目录
python3 scripts/check/parse_logs.py results/all_logs charts/Excel/all.xlsx --source-root benchmarks

python3 scripts/check/parse_logs.py results/error_logs charts/Excel/error.xlsx
```
