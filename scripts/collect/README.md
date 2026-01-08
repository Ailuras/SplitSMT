# Collect Scripts

从 `aggregate.py` 生成的 Excel 报告中筛选并收集 SMT 文件。

## 脚本说明

### collect.py

根据一致性标签（label）和/或求解器结果（result）过滤 Excel 报告中的文件，并将匹配的文件复制到指定目录。

**输入**：`aggregate.py` 生成的 Excel 文件（默认 `charts/result.xlsx`）  
**输出**：复制匹配的 SMT 文件到目标目录

## 使用方法

### 基本用法

```bash
# 按一致性标签过滤
python scripts/collect/collect.py charts/result.xlsx --label Conflict --output /tmp/conflicts

# 按求解器结果过滤
python scripts/collect/collect.py charts/result.xlsx --result TIMEOUT --solvers z3 --output /tmp/z3_timeout

# 组合过滤
python scripts/collect/collect.py charts/result.xlsx --label Hard --result UNKNOWN --output /tmp/hard_unknown

# 试运行（不实际复制）
python scripts/collect/collect.py charts/result.xlsx --label Conflict --dry-run
```

## 过滤选项

### --label

按一致性标签过滤（跨求解器比较）：

- `Consistent`：所有求解器结果一致（都是 SAT 或都是 UNSAT）
- `Conflict`：求解器结果冲突（有 SAT 也有 UNSAT）⚠️
- `Error`：所有求解器都失败
- `Hard`：困难问题（只有 UNKNOWN/TIMEOUT，无 SAT/UNSAT）
- `Other`：其他混合情况

### --result

按特定求解器的结果过滤：

- `SAT`：可满足
- `UNSAT`：不可满足
- `UNKNOWN`：未知
- `TIMEOUT`：超时
- `ERROR`：错误

**必须与 `--solvers` 配合使用**

### --solvers

指定求解器表达式，支持 AND/OR 逻辑：

**AND 操作符**：`&`, `&&`, `+`, `and`

```bash
# z3 和 cvc5 都满足条件
--solvers "z3+cvc5"
```

**OR 操作符**：`||`, `|`, `,`, `or`

```bash
# z3 或 cvc5 任一满足即可
--solvers "z3,cvc5"
```

**复合表达式**：

```bash
# (z3 AND ostrich) OR cvc5
--solvers "z3+ostrich,cvc5"
```

## 输出选项

### --output

指定输出目录（默认：当前目录）

### --keep-structure（默认）

保持原始目录结构：

```
benchmarks/2015-Norn/UF/example.smt2
  → output_dir/benchmarks/2015-Norn/UF/example.smt2
```

### --flatten

扁平化结构，文件名重命名为 `suite+category+filename`：

```
benchmarks/2015-Norn/UF/example.smt2
  → output_dir/2015-Norn+UF+example.smt2
```

### --clear

复制前清空输出目录

### --dry-run

仅显示将要复制的文件，不实际执行

## 使用示例

### 示例 1：收集所有冲突文件

```bash
python scripts/collect/collect.py charts/result.xlsx \
  --label Conflict \
  --output benchmarks/conflicts \
  --flatten
```

### 示例 2：查找 z3 超时但 cvc5 成功的文件

```bash
# 先找 z3 超时的
python scripts/collect/collect.py charts/result.xlsx \
  --result TIMEOUT \
  --solvers z3 \
  --output /tmp/z3_timeout

# 再找 cvc5 没超时的（需要额外过滤）
```

### 示例 3：收集困难问题

```bash
python scripts/collect/collect.py charts/result.xlsx \
  --label Hard \
  --output benchmarks/hard_cases \
  --keep-structure
```

### 示例 4：查找所有求解器都超时的文件

```bash
python scripts/collect/collect.py charts/result.xlsx \
  --result TIMEOUT \
  --solvers "z3+cvc5+ostrich" \
  --output benchmarks/all_timeout
```

## 工作流程

```
aggregate.py → result.xlsx → collect.py → 筛选后的文件集合
```

1. 先运行 `scripts/report/aggregate.py` 生成报告
2. 使用 `collect.py` 根据需求筛选文件
3. 筛选后的文件可用于进一步分析或测试

## 注意事项

- `--label` 和 `--result` 可以**同时使用**（AND 关系）
- 如果只提供 `--solvers` 而不提供 `--result`，默认按 `TIMEOUT` 过滤
- `path` 列现在存储完整路径，无需手动拼接
- 如需删除不匹配的文件，请使用 `scripts/report/filter.py`
