# collect.py（用例收集）

基于 `scripts/report/aggregate.py` 生成的 Excel（`Results` 工作表），按标签（一致性）或指定求解器的结果筛选用例，并复制对应的 `path + filename`。支持保持原目录结构或展平并重命名，支持复制前清空输出目录。

求解器表达式支持：

- AND：`+`、`&`、`&&`、`and`
- OR：`,`、`||`、`|`、`or`
推荐用 `+` 表示 AND、`,` 表示 OR，可避免 shell 对 `&`/`||` 的特殊处理。

## 用法示例

```bash
# 收集标签（一致性）为 Other 的用例（保持原目录结构）
python3 scripts/collect/collect.py charts/result.xlsx --label Other

# 收集 z3 和 cvc5 都是 TIMEOUT 的用例（AND 可用 + 或 &）
python3 scripts/collect/collect.py charts/Norn.xlsx --result TIMEOUT --solvers z3+cvc5

# 收集 z3 或 cvc5 任一为 TIMEOUT 的用例（OR 可用 , 或 ||）
python3 scripts/collect/collect.py charts/result.xlsx --result TIMEOUT --solvers z3,cvc5

# 展平并重命名：复制到同一目录下，文件名变为 suite+category+filename
python3 scripts/collect/collect.py charts/result.xlsx --label Other --flatten --output /tmp/collected

# 清空输出目录后再复制
python3 scripts/collect/collect.py charts/result.xlsx --label Other --clear-output --output /tmp/collected

# 仅预览（不复制）
python3 scripts/collect/collect.py charts/result.xlsx --result TIMEOUT --solvers z3 --dry-run
```

## 参数与规则

- `xlsx_file`：`aggregate.py` 生成的 Excel（默认读取 `Results` 工作表）。
- `--label`（原 `--consistency`）：按标签筛选（如 `Consistent`、`Conflict`、`Hard`、`Other`），缺省则不过滤。
- `--result`：目标求解结果（如 `TIMEOUT`、`UNKNOWN`、`SAT`、`UNSAT` 等）。
- `--solvers`：求解器表达式，使用 `&` 表示“都满足”，`||` 表示“满足其一”。
  - 例：`z3&cvc5` → z3 和 cvc5 结果都等于 `--result`
  - 例：`z3||cvc5` → z3 或 cvc5 任一结果等于 `--result`
  - 若提供 `--solvers` 但未给 `--result`，默认按 `TIMEOUT` 过滤。
  - **注意**：`--label` 和 `--result` 不能同时使用。
- `--output`：输出目录前缀（默认命令执行的当前目录）。
- `--flatten`：不保持目录结构，文件名重命名为 `suite+category+filename`。
- `--clear-output`：复制前清空输出目录（默认不清空，直接覆盖同名文件）。
- `--dry-run`：仅打印将要复制的文件，不执行复制。

## collect_compare.py（对比表收集）

针对 `scripts/compare/compare.py` 生成的 `compare.xlsx`（`Comparison` 工作表），收集特定条件的用例。支持按 **行标签** (Label) 或 **求解器结果** (Result) 筛选。

### 用法示例

```bash
# 收集结果为 Conflict 的用例（默认行为，--label Conflict）
python3 scripts/collect/collect_compare.py charts/compare.xlsx --output /tmp/conflicts

# 收集标签为 Improvement 的用例
python3 scripts/collect/collect_compare.py charts/compare.xlsx --label Improvement --output /tmp/improvements

# 收集 z3 提升 (Improvement) 的用例
python3 scripts/collect/collect_compare.py charts/compare.xlsx --result Improvement --solvers z3 --output /tmp/z3_improved

# 收集 z3 和 cvc5 都提升的用例
python3 scripts/collect/collect_compare.py charts/compare.xlsx --result Improvement --solvers z3+cvc5

# 收集 z3 或 cvc5 发生冲突 (Conflict) 的用例
python3 scripts/collect/collect_compare.py charts/compare.xlsx --result Conflict --solvers z3,cvc5

# 筛选模式：在 test/norn 目录中，仅保留 Conflict 的文件，其余删除
python3 scripts/collect/collect_compare.py charts/compare.xlsx --filter --label Conflict --output test/norn
```

### 参数

- `xlsx_file`：`compare.py` 生成的对比表（`Comparison` 工作表）。
- `--label`：按行标签筛选（`Conflict`, `Improvement`, `Descent`, `Miss`, `Others`），仅支持单个标签。默认（未指定 filters 时）为 `Conflict`。
- `--result`：按求解器变化结果筛选（`Improvement`, `Descent`, `Conflict` 等）。需配合 `--solvers` 使用。
  - **互斥**：不能同时使用 `--label` 和 `--result`。
- `--solvers`：配合 `--result` 使用的求解器表达式（同 `collect.py`）。
- `--source-index`：选择使用哪一列路径，`1` 或 `2`（默认 `1`）。
- `--output`：输出目录（默认当前工作目录）。筛选模式下为必需参数。
- `--filter`：筛选模式，删除不匹配的文件。
- `--flatten`：不保持目录结构，重命名文件。
- `--clear-output`：复制前清空输出目录。
- `--dry-run`：预览模式。

## 依赖

```bash
pip install openpyxl
```
