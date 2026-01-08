# Convert Scripts

该目录提供用于批量准备 SMT-LIB 基准文件的转换工具，主要用于在运行求解器前统一输入格式与配置。

## 📋 目录结构

```
scripts/convert/
├── README.md              # 本文档
├── prepare_option.py      # SMT 文件准备工具
└── configs/               # 求解器配置片段
    ├── UF/                # Uninterpreted Functions 模式
    │   ├── z3.txt
    │   ├── z3-noodler.txt
    │   ├── ostrich.txt
    │   └── cvc5.txt
    ├── RA/                # Regular Automaton 模式
    │   └── ...
    └── REC/               # Recursive 模式
        └── ...
```

---

## 🔧 prepare_option.py

批量转换 SMT-LIB 文件，为不同求解器生成适配版本，支持双输出模式（MODEL/NOM）。

### ✨ 核心功能

#### 1️⃣ **标准化处理**

- 统一设置 `(set-logic ALL)`，避免原始基准缺失逻辑声明
- 自动清理注释行（以 `;` 开头）
- 移除 `(exit)` 语句
- 移除原有的 `(get-model)` 以便统一管理

#### 2️⃣ **求解器适配**

- 自动注入 `configs/{mode}/{solver}.txt` 中的求解器特定配置
- 支持回退机制：若特定求解器配置缺失，回退到 `default.txt`
- 重写函数名：`(str.split ...)` → `(split ...)`，`(str.num_splits ...)` → `(num_splits ...)`

#### 3️⃣ **双版本输出**

**MODEL 版本**（包含模型生成支持）：

- 添加 `(get-model)` 命令
- 强制添加以下必需选项（如果原文件中缺失）：

  ```smt2
  (set-option :produce-assertions true)
  (set-option :produce-assignments true)
  (set-option :produce-models true)
  (set-option :produce-proofs true)
  (set-option :produce-unsat-assumptions true)
  (set-option :produce-unsat-cores true)
  (set-option :random-seed 42)
  ```

**NOM 版本**（仅求解，无模型）：

- **不包含** `(get-model)`
- **移除所有** `set-option` 语句
- 适用于纯求解性能测试

#### 4️⃣ **多模式支持**

- `UF` - Uninterpreted Functions
- `RA` - Regular Automaton  
- `REC` - Recursive

#### 5️⃣ **多求解器支持**

- `z3`
- `z3-noodler`
- `ostrich`
- `cvc5`
- `bitwuzla`

---

### 📖 基本用法

```bash
# 1. 处理单个目录（使用默认设置）
python scripts/convert/prepare_option.py --input benchmarks/strings

# 2. 指定输出目录和模式
python scripts/convert/prepare_option.py \
  --input benchmarks/strings \
  --output results/prepared \
  --modes UF,RA

# 3. 自定义求解器列表
python scripts/convert/prepare_option.py \
  --input benchmarks/strings \
  --output results/prepared \
  --solvers z3,cvc5

# 4. Dry Run（验证输入和配置，不实际写文件）
python scripts/convert/prepare_option.py \
  --input benchmarks/strings \
  --dry-run
```

---

### 🎯 参数说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `-i, --input <路径>` | **必需**，输入文件或目录（支持单个 `.smt2` 文件或目录） | - |
| `-o, --output <目录>` | 输出根目录 | 输入目录 |
| `--modes <列表>` | 逗号分隔的处理模式 | `UF,RA,REC` |
| `--solvers <列表>` | 逗号分隔的求解器列表 | `z3,z3-noodler,ostrich,cvc5,bitwuzla` |
| `--dry-run` | 仅验证输入与配置，不生成输出文件 | False |

---

### 📁 输出目录结构

```
output_root/
├── z3/
│   ├── model/           # MODEL 版本
│   │   ├── UF/
│   │   │   └── file.smt2
│   │   ├── RA/
│   │   └── REC/
│   └── nom/             # NOM 版本
│       ├── UF/
│       ├── RA/
│       └── REC/
├── cvc5/
│   ├── model/
│   └── nom/
└── ...
```

**目录层级说明**：

- 第一层：**求解器名称**（z3, cvc5, etc.）
- 第二层：**版本类型**（model / nom）
- 第三层：**模式名称**（UF, RA, REC）
- 第四层：**SMT 文件**（保持原有相对路径）

---

### 🔍 使用场景

#### 场景 1: 标准转换流程

```bash
# Step 1: Dry Run 验证
python scripts/convert/prepare_option.py \
  --input benchmarks/round1 \
  --dry-run

# Step 2: 执行转换
python scripts/convert/prepare_option.py \
  --input benchmarks/round1 \
  --output results/converted
```

#### 场景 2: 针对特定求解器

```bash
# 仅为 z3 和 cvc5 生成文件
python scripts/convert/prepare_option.py \
  --input benchmarks/round1 \
  --solvers z3,cvc5 \
  --output results/z3_cvc5_only
```

#### 场景 3: 单模式转换

```bash
# 仅处理 UF 模式
python scripts/convert/prepare_option.py \
  --input benchmarks/round1 \
  --modes UF \
  --output results/uf_only
```

#### 场景 4: 处理单个文件

```bash
# 转换单个 SMT 文件
python scripts/convert/prepare_option.py \
  --input test.smt2 \
  --output results/single
```

---

### 📊 统计输出示例

```
======================================================================
Processing Summary
======================================================================

Mode: UF
  Input files processed: 150
    ✓ z3:
       Generated pairs (model/nom): 150
       Replacements/file (avg): 3
    ✓ cvc5:
       Generated pairs (model/nom): 150
       Replacements/file (avg): 3

Mode: RA
  Input files processed: 150
    ✓ z3-noodler:
       Generated pairs (model/nom): 150
       Replacements/file (avg): 2

Output Structure created:
  root/ model / mode / solver / ... (Contains (get-model) + required options)
  root/ nom   / mode / solver / ... (No (get-model), NO options)
======================================================================
```

---

### ⚙️ configs/ 配置说明

求解器配置片段存放于 `configs/` 目录，按模式和求解器组织：

```
configs/
├── UF/
│   ├── z3.txt          # Z3 特定配置
│   ├── cvc5.txt        # CVC5 特定配置
│   └── default.txt     # 回退配置（可选）
├── RA/
│   └── ...
└── REC/
    └── ...
```

**配置文件格式**：

- 纯文本文件，每行一个 SMT-LIB 语句
- 会被插入到 `(set-logic ALL)` 之后
- 示例内容：

  ```smt2
  (declare-fun custom_function () String)
  (assert (= custom_function "value"))
  ```

**新增求解器步骤**：

1. 在每个模式目录（UF/RA/REC）下创建 `{solver}.txt` 文件
2. 填入该求解器的特定配置
3. 运行脚本时指定求解器名称

---

### 🛠️ 环境依赖

- **Python 3.7+**
- **标准库**：仅依赖 Python 标准库，无需额外安装
- **TTY 检测**：当标准输出不是 TTY 时自动禁用彩色输出

---

### ⚠️ 注意事项

1. **输出会覆盖**：如果输出目录已存在同名文件，会被覆盖
2. **configs 必需**：至少需要在一个模式目录下有配置文件
3. **文件编码**：输入文件应使用 UTF-8 编码
4. **相对路径保持**：输出文件保持输入的相对路径结构

---

### 🔧 故障排查

#### 问题：提示 "No solvers specified"

**原因**：未提供求解器列表且默认列表为空

**解决**：使用 `--solvers` 参数明确指定求解器

---

#### 问题：某个求解器显示 "Skipped"

**原因**：`configs/{mode}/{solver}.txt` 和 `default.txt` 都不存在

**解决**：

1. 在对应模式目录下创建 `{solver}.txt` 配置文件
2. 或创建 `default.txt` 作为回退配置

---

#### 问题：文件数为 0

**原因**：输入目录中没有 `.smt2` 文件

**解决**：确认输入路径正确，且包含 `.smt2` 文件

---

## 📚 更新日志

### 2026-01-04

- 🗑️ 移除过时的 `prepare.py`（功能已完全被 `prepare_option.py` 覆盖）
- 📝 更新文档，聚焦于 `prepare_option.py`

### 历史版本

- 初始版本包含 `prepare.py` 和 `prepare_split.py`
