# 求解器结果聚合

仅保留一个工具：`aggregate.py`。它将 `scripts/batch/batch.sh` 生成的日志汇总为 Excel 报告，适配目录结构 `benchmarks/<suite>/<category>/...`（如 `benchmarks/2015-Norn/HammingDistance/...`）。

## 日志格式要求
- 每个区块形如：
  ```
  Solver: z3
  File: benchmarks/2015-Norn/HammingDistance/norn-benchmark-123.smt2
  Start: ...
  End: ...
  Duration_sec: 2.003
  Status: SUCCESS
  Exit_code: 0
  -----------------------------------------------------------
  sat
  ```
- 求解器名称取自区块内 `Solver:`；目录名不影响结果。
- 推荐使用最新的 `scripts/batch/batch.sh`（已在日志头自动写 `Solver: <name>`）。如果旧日志缺少 `Solver:`，可在命令行用 `--solver <name>` 指定默认求解器（建议按求解器拆分目录分别执行）。
- 结果字段标准化为 `SAT / UNSAT / UNKNOWN / TIMEOUT / ERROR`。

## 输出列
- 基础：`path | filename | suite | category | consistency`
  - `path` 为目录部分，`filename` 为文件名，可方便对比不同目录下的同名用例。
- 每求解器：`<solver>_result | <solver>_time | <solver>_output`
- 统计页：Overall、Consistency、By Suite、By Category（含时间统计）。

一致性分类规则：
- Consistent：全部 SAT 或全部 UNSAT
- Conflict：同时出现 SAT 和 UNSAT
- Hard：只有 UNKNOWN/TIMEOUT/ERROR
- Error：全部为非标准结果
- Other：其他混合

## 使用方法
```bash
# 扫描 results/ 下所有 .log（推荐）
python3 scripts/report/aggregate.py results/Norn --output charts/Norn.xlsx

# 旧日志没有写 Solver: 时指定默认求解器
python3 scripts/report/aggregate.py results/Norn/z3 --solver z3 --output charts/Norn-z3.xlsx

# 指定文件或目录（可混合，目录递归查找 .log）
python3 scripts/report/aggregate.py logs/a.log logs_dir/ other/*.log

# 自定义输出与编码
python3 scripts/report/aggregate.py --output charts/result.xlsx --encoding utf-8
```
