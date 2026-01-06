# convert.py（批量预处理）

支持单个文件或目录批量转换，目录会保持原有相对路径结构，并在每个文件后给出成功/失败样例。
支持选择转换器版本：默认 C++，也可切换到 Python 版。

## 用法示例

```bash
# 转换单个文件（输出路径是文件名或已存在的目录）
python3 scripts/convert/convert.py input.smt2 output.smt2
python3 scripts/convert/convert.py input.smt2 out-dir/

# 批量转换目录，默认 60s 超时
python3 scripts/convert/convert.py test/2015-Norn/ab converted/

python3 scripts/convert/convert.py test/2015-Norn test/2015-Norn-Converted

# 使用 Python 版本的转换器
python3 scripts/convert/convert.py test/Timeout test/Timeout_REG_python --version python

# 指定超时与 REG-Split 选项
python3 scripts/convert/convert.py cases/ converted/ --timeout 120 --tree --log-level 10
```

## 参数

- `input_path`：待转换的文件或文件夹。
- `output_path`：输出文件或文件夹。目录输入时会镜像相对路径；文件输入时可给文件路径或目录路径。不存在会自动创建。
- `--version`：选择转换器版本：`cplus`（默认，`build/REG-Split`）或 `python`（`python/REG-Split.py`）。
- `--clear`：处理前清空输出路径（文件则删除，目录则递归删除）。
- `--timeout`：单个文件的超时时间（秒），默认 60。超时会视为失败但继续处理后续文件。
- `--tree`：传递 `--tree` 给转换器，输出树状格式。
- `--log-level`：传递 `-l/--level` 给转换器，调整日志级别。
- `--verbose`：打印每个文件的输入/输出路径，默认不打印逐文件信息。
- `--quiet`：强制安静模式（默认即安静），仅在失败或汇总时打印。

处理结束只打印汇总：总数、成功/失败数量。若 Python 版本依赖的包缺失，先按项目 README 安装依赖。
