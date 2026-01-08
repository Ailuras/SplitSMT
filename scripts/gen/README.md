# gen.py（批量预处理）

批量调用 SplitSMT 转换文件。支持单个文件或目录批量转换，目录会保持原有相对路径结构。

## 用法示例

```bash
# 转换单个文件
python3 scripts/gen/gen.py --input input.smt2 --output output.smt2

# 批量转换目录，默认 60s 超时
python3 scripts/gen/gen.py --input test/2015-Norn/ab --output gened/

# 使用 --gen 生成分割后的 SMT2
python3 scripts/gen/gen.py -i cases/ -o gened/ --gen

# 指定超时与日志级别
python3 scripts/gen/gen.py -i cases/ -o gened/ --timeout 120 --log-level 2

# 清空输出目录再处理
python3 scripts/gen/gen.py -i test/Timeout -o test/Timeout_output --clear --gen
```

## 参数

- `-i, --input`：（必需）待转换的文件或文件夹。
- `-o, --output`：（必需）输出文件或文件夹。目录输入时会镜像相对路径；文件输入时可给文件路径或目录路径。不存在会自动创建。
- `--clear`：处理前清空输出路径（文件则删除，目录则递归删除）。
- `--timeout`：单个文件的超时时间（秒），默认 60。超时会视为失败但继续处理后续文件。
- `--log-level`：传递 `-l/--level` 给 SplitSMT，调整日志级别（0=DEBUG, 1=INFO, 2=WARN, 3=ERROR, 4=NONE，默认 4）。
- `--verbose`：打印每个文件的输入/输出路径，默认不打印逐文件信息。
- `--quiet`：强制安静模式（默认），仅在失败或汇总时打印。

处理结束只打印汇总：总数、成功/失败数量。
