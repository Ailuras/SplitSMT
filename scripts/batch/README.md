# Batch Processing Script

该目录包含用于批量处理 SMT-LIB 文件的批处理脚本。

## batch.sh

该脚本用于批量运行求解器处理多个 SMT-LIB 文件，支持并行执行和任务分组。

### 功能特性

- 支持多个求解器：z3、z3-noodler、cvc5、ostrich
- 自动根据系统平台选择对应的求解器脚本（macOS 使用 `solvers/macos/`，Linux 使用 `solvers/linux/`）
- 支持并行处理多个任务组，自动检测 CPU 核心数
- 支持任务分组，将多个文件组合为一个任务
- 完整的日志记录，每个任务组生成独立的日志文件
- 支持超时控制，自动处理超时任务
- 优雅的中断处理，支持 Ctrl+C 安全退出

### 使用方法

基本用法：

```bash
./scripts/batch/batch.sh -s z3 -i benchmarks/Java -o results/java_logs
```

完整示例：

```bash
./scripts/batch/batch.sh \
  -s z3 \
  -t 90 \
  -i benchmarks/Java/awesome \
  -o results/java_awesome_logs \
  -g 5 \
  -j 4
```

### 参数说明

- `-s, --solver <SOLVER>`: **必需**，指定求解器名称。可选值：`z3`、`z3-noodler`、`cvc5`、`ostrich`
- `-t, --timeout <SEC>`: 每个文件的超时时间（秒），默认为 60
- `-i, --input-dir <DIR>`: 包含 SMT-LIB 文件的输入目录，默认为 `benchmarks`
- `-o, --output-dir <DIR>`: 存储任务日志的输出目录，默认为 `results`
- `-g, --group-size <NUM>`: 每个任务组包含的文件数量。如果未指定，将根据总文件数和并发任务数自动计算
- `-j, --jobs <NUM>`: 最大并发任务数。如果未指定，将自动检测 CPU 核心数
- `--solver-script <PATH>`: 直接指定求解器脚本路径（覆盖自动解析）
- `-h, --help`: 显示帮助信息

### 平台支持

脚本会自动检测运行平台并选择对应的求解器脚本：

- **macOS** (Darwin): 使用 `solvers/macos/{solver}/run.sh`
- **Linux**: 使用 `solvers/linux/{solver}/run.sh`

如果运行在不支持的平台上，脚本会显示明确的错误信息。

### 求解器脚本要求

求解器脚本必须：

- 位于 `solvers/{platform}/{solver}/run.sh`
- 可执行权限
- 接受两个参数：`<timeout> <smt_file>`
- 返回适当的退出码（0 表示成功，124 或 137 表示超时，其他表示错误）

### 输出说明

脚本会为每个任务组生成独立的日志文件，保存在指定的输出目录中：

- 日志文件命名格式：`task_001.log`、`task_002.log` 等
- 每个日志文件包含该任务组中所有文件的处理信息：
  - 文件路径
  - 开始和结束时间（墙钟时间）
  - 执行时长（秒，精确到毫秒）
  - 状态（SUCCESS/TIMEOUT/ERROR/SKIPPED）
  - 退出码
  - 完整的标准输出和标准错误

### 任务分组

脚本会将输入目录中的所有 `.smt2` 文件按组大小进行分组：

- 如果指定了 `-g`，使用指定的组大小
- 如果未指定 `-g`，根据总文件数和并发任务数自动计算：

  ```
  group_size = ceil(total_files / jobs)
  ```

### 并行处理

脚本支持并行处理多个任务组：

- 默认并发数等于 CPU 核心数
- 可以通过 `-j` 参数手动指定并发数
- 任务组会按照可用槽位依次启动
- 所有任务完成后脚本才会退出

### 中断处理

脚本支持安全中断：

- 按 Ctrl+C 会等待当前运行的任务完成后再退出
- 正在运行的子进程会被正确终止
- 已完成的日志文件会被保留

### 返回值

- `0`: 所有任务成功完成
- `1`: 有任务失败（超时或错误）
- 其他: 参数错误或初始化失败

### 使用示例

运行 z3 求解器处理 benchmarks 目录：

```bash
./scripts/batch/batch.sh -s z3 -i benchmarks -o results/z3_logs
```

使用 cvc5 求解器，设置 120 秒超时，每组 10 个文件，4 个并发任务：

```bash
./scripts/batch/batch.sh \
  -s cvc5 \
  -t 120 \
  -i benchmarks/Java \
  -o results/cvc5_java \
  -g 10 \
  -j 4
```

处理特定目录，使用自动计算的组大小和并发数：

```bash
./scripts/batch/batch.sh \
  -s z3-noodler \
  -i benchmarks/LLMs/ChatGPT/seeds_cso_gpt-4.1 \
  -o results/chatgpt_cso
```

### 性能建议

- 对于大量文件，建议使用较大的组大小（`-g`）以减少任务数量
- 并发数不应超过 CPU 核心数过多，建议设置为核心数或略少
- 根据文件大小和复杂度调整超时时间，避免任务过早超时
- 磁盘 I/O 可能成为瓶颈，建议将输出目录放在快速存储设备上

## batch_splitsmt.sh

该脚本专门用于通过 SplitSMT 批量处理 SMT-LIB 文件。与 `batch.sh` 不同，此脚本直接调用 SplitSMT 二进制文件，由 SplitSMT 内部处理求解逻辑。

### 功能特性

- **内部求解**: 直接使用 SplitSMT 二进制文件处理文件
- **可配置求解器**: 通过 `--solver` 参数指定 SplitSMT 使用的底层求解器
- **并行处理**: 支持多任务并行，自动检测 CPU 核心数
- **完整日志**: 每个任务组生成独立的日志文件
- **超时控制**: 通过 SplitSMT 的 `-t` 参数控制超时

### 使用方法

基本用法：

```bash
./scripts/batch/batch_splitsmt.sh -s z3 -i test/top20_maven -o results/splitsmt_z3
```

完整示例：

```bash
./scripts/batch/batch_splitsmt.sh \
  -s cvc5 \
  -t 90 \
  -i benchmarks/Java \
  -o results/splitsmt_cvc5 \
  -g 5 \
  -j 4
```

### 参数说明

- `-s, --solver <SOLVER>`: 指定 SplitSMT 使用的底层求解器，默认为 `z3-noodler`。可选值：`z3`、`cvc5`、`ostrich`、`z3-noodler`
- `-t, --timeout <SEC>`: 每个文件的超时时间（秒），默认为 60
- `-i, --input-dir <DIR>`: 包含 SMT-LIB 文件的输入目录，默认为 `benchmarks`
- `-o, --output-dir <DIR>`: 存储任务日志的输出目录，默认为 `results`
- `-g, --group-size <NUM>`: 每个任务组包含的文件数量（自动计算）
- `-j, --jobs <NUM>`: 最大并发任务数（自动检测 CPU 核心数）
- `-h, --help`: 显示帮助信息

### 与 batch.sh 的区别

| 特性 | batch.sh | batch_splitsmt.sh |
|------|----------|-------------------|
| 求解方式 | 直接调用外部求解器脚本 | 通过 SplitSMT 内部求解 |
| 适用场景 | 测试原始 SMT2 文件 | 测试 SplitSMT 处理后的结果 |
| 求解器选择 | `-s` 选择求解器脚本 | `-s` 选择 SplitSMT 的底层求解器 |
| 依赖 | 需要 `solvers/{platform}/` 下的脚本 | 只需要 SplitSMT 二进制文件 |

### 使用示例

使用 z3 求解器处理测试数据：

```bash
./scripts/batch/batch_splitsmt.sh \
  -s z3 \
  -i test/top20_maven \
  -o results/splitsmt_z3
```

使用 cvc5 求解器，设置 120 秒超时：

```bash
./scripts/batch/batch_splitsmt.sh \
  -s cvc5 \
  -t 120 \
  -i benchmarks/Auto/easy \
  -o results/splitsmt_cvc5_easy
```
