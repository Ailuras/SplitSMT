# compare.py（报表对比）

对比两个 `aggregate.py` 生成的 Excel（默认 `Results` 工作表），默认以 `filename + suite + category` 为键（要求三者相同），全面检查同一用例在两份报表中的差异。支持 `--soft` 模式，仅按 `filename` 匹配。

## 功能特性

1. **全量对比**：处理所有用例（SAT, UNSAT, TIMEOUT, UNKNOWN, ERROR），不局限于一致性用例。
2. **智能分类**：根据两份报表的结果自动标记行状态：
    - **Conflict**：结果（SAT/UNSAT）冲突，最严重的差异。
    - **Improvement**：状态变好（如 Timeout -> SAT）或在结果相同的情况下时间缩短。
    - **Descent**：状态变差（如 SAT -> Timeout）或在结果相同的情况下时间增加。
    - **Miss**：用例仅出现于其中一份报表。
    - **Others**：其他混合或无显著变化的情况（如均为 TIMEOUT）。
3. **求解器级分析**：针对每一个求解器，分别列出其状态变化（Improvement/Descent/Conflict/Unchanged）及时间差。
4. **统计摘要**：生成 `Statistics` 工作表，统计总体及各求解器的各类变化数量。

## 使用方法

```bash
# 生成对比结果，均默认写入 charts/compare.xlsx
python3 scripts/compare/compare.py charts/a.xlsx charts/b.xlsx

# 仅按 filename 匹配（忽略 suite/category 差异）
python3 scripts/compare/compare.py charts/a.xlsx charts/b.xlsx --soft

# 自定义输出路径
python3 scripts/compare/compare.py charts/a.xlsx charts/b.xlsx --output charts/my-comparison.xlsx
```

## 参数说明

- `xlsx_a`：第一份报表（Base）。
- `xlsx_b`：第二份报表（Comparison目标）。
- `--output`：输出 Excel 路径，默认 `charts/compare.xlsx`。
- `--soft`：仅按 `filename` 匹配，适用于目录结构发生变化但文件名唯一的情况。

## 输出格式

### 1. Comparison 工作表

包含以下列：

- **基础信息**：`filename`, `suite`, `category`
- **Label**：行级标记（Conflict, Improvement, Descent, Miss, Others），**带颜色编码**。
- **求解器详情**（每个求解器 4 列）：
  - `{solver}_Change`：该求解器的变化类型。
  - `{solver}_TimeDiff`：时间差（B - A，负数表示时间缩短/优化）。
  - `{solver}_{label_a}`：A 表中的结果及时间。
  - `{solver}_{label_b}`：B 表中的结果及时间。

### 2. Statistics 工作表

- **Overall Statistics**：各类变化（Improvement, Conflict...）的总数。
- **Per-Solver Statistics**：每个求解器在各分类下的数量统计。
