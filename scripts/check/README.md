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
./batch.sh -s z3-noodler -t 60 -i benchmarks -o results/all_logs -g 10 -j 48
```

## parse_logs.py

```bash
python3 scripts/check/parse_logs.py <log_dir> <output_excel>
```

示例：

```bash
python3 scripts/check/parse_logs.py results/all_logs charts/Excel/analysis.xlsx
```
