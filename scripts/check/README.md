# Check Scripts

本目录下包含两个用于一致性检查的脚本：

1. `check.py`：使用外部 solver wrapper 进行跨求解器对比。
2. `check_splitsmt.py`：专门用于检查 `SplitSMT` 在使用不同底层求解器时的一致性。

---

## 1. check.py

`check.py` 用于对 SMT2 文件或目录进行多外部求解器对比。它调用 `solvers/{platform}/{solver}/run.sh` 脚本。

### 功能

- 支持同时运行多个外部求解器（默认为：z3, cvc5, ostrich, z3-noodler）。
- 自动检测并报告结果冲突。
- 支持单独设置超时时间。

### 用法

```bash
python3 scripts/check/check.py <input_path> [选项]
```

### 常用选项

- `--solver <names...>`：选择要运行的求解器（如 `z3 cvc5`）。默认运行所有可用外部求解器。
- `--timeout <seconds>`：默认的单次求解超时时间，默认 300 秒。
- `--solver-timeout name=seconds`：为特定求解器单独设定超时。
- `--platform auto|macos|linux`：强制选择求解器脚本平台目录。

### 示例

```bash
# 检查单个文件
python3 scripts/check/check.py benchmarks/example.smt2 --solver z3 cvc5

# 检查目录
python3 scripts/check/check.py benchmarks/ --timeout 60
```

---

## 2. check_splitsmt.py

`check_splitsmt.py` 专门用于测试 `SplitSMT` 二进制文件本身。它通过传递不同的 `-s` 参数（如 `-s z3`, `-s cvc5`）来运行同一个 `SplitSMT` 二进制，并比较结果是否一致。

### 功能

- 验证 `SplitSMT` 内部集成不同求解器时的稳定性。
- 自动构建并调用 `build/bin/SplitSMT`。
- 发现 `SplitSMT` 自身的 Bug 或底层求解器接口问题。

### 用法

```bash
python3 scripts/check/check_splitsmt.py <input_path> [选项]
```

### 常用选项

- `--solver <names...>`：选择 `SplitSMT` 内部使用的求解器 (z3, cvc5, ostrich, z3-noodler)。默认全部运行。
- `--timeout <seconds>`：超时时间，默认 60 秒。
- `--details`：显示详细输出（stdout/stderr）。

### 示例

```bash
# 使用 z3 和 cvc5 后端检查 SplitSMT 一致性
python3 scripts/check/check_splitsmt.py test/top20_maven/1489.smt2 --solver z3 cvc5

# 批量检查目录
python3 scripts/check/check_splitsmt.py test/top20_maven/ --timeout 10
```

---

## 输出与返回值 (通用)

两个脚本的输出格式一致：

- **表格列含义**：`Solver`（求解器/配置）、`Status`（状态）、`Time`（时间）、`Exit`（退出码）。
- **状态识别**：`sat`, `unsat`, `unknown`, `timeout`。
- **结果摘要**：
  - **Consensus**: 所有有结论的求解器结果一致。
  - **MISMATCH**: 存在冲突结果（如 SAT 和 UNSAT 同时出现）。
  - **No definitive result**: 所有求解器都返回 unknown 或 timeout。
- **返回码**：
  - `0`: 一致或无结论。
  - `1`: 检测到结果冲突 (MISMATCH)。
  - `2`: 参数错误或执行错误。
