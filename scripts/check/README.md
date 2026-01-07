# check.py

`scripts/check/check.py` 用于对 SMT2 文件或目录进行多求解器一致性检查。它可以运行指定的多个求解器（包括 SplitSMT）并比较它们的结果，以发现求解器之间的结果冲突（如 SAT vs UNSAT）。

## 功能

- 支持同时运行多个求解器（默认为：z3, cvc5, ostrich, z3-noodler, splitsmt）。
- 自动检测并报告结果冲突。
- 支持单独设置超时时间。
- 清晰的表格输出结果。

## 平台与求解器

- macOS 使用 `solvers/macos/`；Linux 使用 `solvers/linux/`；`--platform auto` 会自动选择。
- 默认运行所有已配置的求解器。
- 求解器脚本接口统一为：`run.sh <timeout> <smt_file>`。

## 用法

```bash
python3 scripts/check/check.py <input_path> [选项]
```

常用选项：

- `--solver <names...>`：选择要运行的求解器（如 `z3 cvc5`）。不传此参数默认运行所有可用求解器。使用 `all` 也可以运行全部。
- `--timeout <seconds>`：默认的单次求解超时时间，默认 300 秒。
- `--solver-timeout name=seconds`：为特定求解器单独设定超时，可重复传入。
- `--platform auto|macos|linux`：强制选择求解器脚本平台目录。
- `--details`：打印求解器的 stdout/stderr。
- `--no-color`：禁用彩色输出。

## 示例

- 默认检查（运行所有求解器）：

  ```bash
  python3 scripts/check/check.py benchmarks/example.smt2

  # 或者输入目录（递归检查目录下的所有 .smt2 文件）
  python3 scripts/check/check.py benchmarks/
  ```

- 指定求解器并设置超时：

  ```bash
  python3 scripts/check/check.py benchmarks/example.smt2 \
    --solver z3 cvc5 splitsmt \
    --timeout 60
  ```

- 单独设置超时：

  ```bash
  python3 scripts/check/check.py benchmarks/example.smt2 \
    --solver-timeout splitsmt=120
  ```

## 输出与返回值

- 表格列含义：`Solver`（求解器）、`Status`（状态）、`Time`（时间）、`Exit`（退出码）。
- 状态识别：`sat`, `unsat`, `unknown`, `timeout`。
- 结果摘要：
  - **Consensus**: 所有有结论的求解器结果一致。
  - **MISMATCH**: 存在冲突结果（如 SAT 和 UNSAT 同时出现）。
  - **No definitive result**: 所有求解器都返回 unknown 或 timeout。
- 返回码：
  - `0`: 一致或无结论。
  - `1`: 检测到结果冲突 (MISMATCH)。
  - `2`: 参数错误或执行错误。

## 注意事项

- 求解器脚本路径需存在且可执行。
