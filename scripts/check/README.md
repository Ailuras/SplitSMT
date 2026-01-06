# check.py

`scripts/check/check.py` 用于校验同一求解器在正则分裂前后的求解结果是否一致。流程如下：
- 调用 `src/REG-Split.py` 对输入 SMT2 进行转换（默认使用临时文件且执行结束后清理）。
- 在原始文件与转换文件上分别调用指定求解器脚本（位于 `solvers/<platform>/<solver>/run.sh`）。
- 打印结果对比表格，标出差异、超时或执行错误。

## 平台与求解器
- macOS 使用 `solvers/macos/`；Linux 使用 `solvers/linux/`；`--platform auto` 会自动选择。
- 默认仅运行 `z3-noodler`，可选求解器：`z3-noodler`、`z3`、`cvc5`、`ostrich`，或使用 `all` 运行全部求解器。
- 求解器脚本接口统一为：`run.sh <timeout> <smt_file>`，超时时间单位为秒。

## 用法
```bash
python3 scripts/check/check.py <smt_file> [选项]
```

常用选项：
- `--solver <names...>`：选择求解器（默认 z3-noodler），传入 `all` 等价于全部求解器。
- `--timeout <seconds>`：默认的单次求解超时时间，默认 300 秒。
- `--solver-timeout name=seconds`：为特定求解器单独设定超时，可重复传入。
- `--platform auto|macos|linux`：强制选择求解器脚本平台目录。
- `--save <dir>`：将 REG-Split 的输出复制到指定目录下，文件名与原始输入文件一致；默认不保留转换结果。
- `--reg-split-level <int>` / `--reg-split-tree`：透传给 `src/REG-Split.py` 的日志级别与树形输出。
- `--details`：打印 REG-Split 与求解器的 stdout/stderr。
- `--no-color`：禁用彩色输出。

## 示例
- 默认检查（z3-noodler，300 秒超时）：
  ```bash
  python3 scripts/check/check.py benchmarks/example.smt2
  ```
- 同时检查多个求解器并单独设置超时：
  ```bash
  python3 scripts/check/check.py benchmarks/example.smt2 \
    --solver z3-noodler z3 cvc5 \
    --solver-timeout z3=120 --solver-timeout cvc5=90
  ```
- 保存转换后的 SMT2 文件并查看详情：
  ```bash
  python3 scripts/check/check.py benchmarks/example.smt2 \
    --save /tmp/reg-split-out --details
  ```

## 输出与返回值
- 表格列含义：`Solver`（求解器）、`Target`（original/reg-split）、`Status`、`Time`、`Exit`。
- 状态会尝试从求解器输出中识别 `sat`/`unsat`/`unknown`，若超时返回 `timeout`，缺失脚本返回 `missing`，权限问题返回 `permission`。
- 返回码：`0`（未发现可比较结果差异且无致命错误）、`1`（可比较结果不一致），`2`（参数错误、REG-Split 失败、求解器脚本缺失/无权限或其他执行错误）。

## 注意事项
- 求解器脚本路径需存在且可执行；其内部依赖的二进制需自行配置。
- 未指定 `--save` 时，转换文件会在脚本结束后清理。
- `--solver` 接受多个值，会持续读取后续位置参数；若要把 `--solver` 写在文件路径之前，请使用 `--solver ... -- <smt_file>` 或直接将 `<smt_file>` 放在命令最前。
