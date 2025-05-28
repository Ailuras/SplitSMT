# StrProcessor

A string processing tool with SMT solver integration supporting both Z3 and CVC5 solvers.

## Building

```bash
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug
make -j$(nproc)
```

## Usage

Due to dynamic library dependencies, use the automatically generated wrapper script:

```bash
# Using Z3 solver (default)
./build/bin/strprocessor_wrapper.sh input.smt2 -l 10

# Using CVC5 solver
./build/bin/strprocessor_wrapper.sh input.smt2 -s cvc5 -l 10

# With output file
./build/bin/strprocessor_wrapper.sh input.smt2 output.smt2 -s z3 -l 10
```

### Command Line Options

- `<input_file>`: Input SMT2 file (required)
- `[output_file]`: Output file (optional)
- `-l, --level <level>`: Set logging level (default: 20, info level)
- `-s, --solver <solver>`: Set solver type: z3 or cvc5 (default: z3)

### Alternative Usage

If you prefer to run the binary directly, you need to set the library path:

```bash
LD_LIBRARY_PATH="external/cvc5/build/deps/lib:$LD_LIBRARY_PATH" ./build/bin/strprocessor input.smt2 -s cvc5
```

## Supported Solvers

- **Z3**: Microsoft Z3 SMT solver
- **CVC5**: Stanford CVC5 SMT solver

Both solvers support SMT-LIB 2.6 format input files.

## Dependencies

- CMake 3.16+
- C++17 compiler
- Boost (system component)
- GMP and MPFR libraries
- Z3 solver (included in external/)
- CVC5 solver (included in external/)

## Project Structure

- `src/`: Source code
- `external/`: External dependencies (Z3, CVC5, SMTLIBParser)
- `build/`: Build directory
- `test/`: Test files

## 功能特性

- 📝 **SMT2文件解析**: 支持解析标准SMT2格式文件
- 🔍 **多求解器支持**: 支持Z3和CVC5两种求解器
- ⚡ **双模式运行**: C++ API模式（高性能）和Shell模式（易部署）
- 🔄 **增量式求解**: 支持push/pop上下文管理和增量式断言
- 📊 **详细日志**: 多级别日志输出，支持性能监控
- 🛠️ **灵活配置**: 命令行参数配置求解器类型和运行模式

## 快速开始

### 1. 编译求解器

首先需要编译Z3和/或CVC5求解器：

```bash
# 运行求解器编译脚本
./build_solvers.sh

# 选择要编译的求解器：
# 1) 仅Z3
# 2) 仅CVC5  
# 3) Z3和CVC5都编译
```

### 2. 编译项目

```bash
# 创建构建目录
mkdir build && cd build

# 配置项目（自动检测已编译的求解器）
cmake ..

# 编译
make -j$(nproc)
```

### 3. 运行程序

```bash
# 基本用法
./bin/strprocessor input.smt2

# 使用Z3求解器（C++ API模式）
./bin/strprocessor input.smt2 -s z3

# 使用CVC5求解器（Shell模式）
./bin/strprocessor input.smt2 -s cvc5 --shell

# 设置详细日志级别
./bin/strprocessor input.smt2 -l 10 -s z3

# 指定输出文件
./bin/strprocessor input.smt2 output.txt -s z3
```

## 命令行参数

```
Usage: strprocessor <input_file> [output_file] [-l <log_level>] [-s <solver>] [--shell]

参数说明:
  <input_file>      输入的SMT2文件（必需）
  [output_file]     输出文件（可选）
  -l, --level       设置日志级别（默认: 20, info级别）
                    - 40+: ERROR
                    - 30+: WARNING  
                    - 20+: INFO
                    - 15+: DEBUG
                    - 10+: 详细调试信息
  -s, --solver      设置求解器类型: z3 或 cvc5（默认: z3）
  --shell           使用Shell模式而非C++ API
```

## 日志级别说明

- **ERROR (40+)**: 仅显示错误信息
- **WARNING (30+)**: 显示警告和错误
- **INFO (20+)**: 显示基本信息（默认）
- **DEBUG (15+)**: 显示调试信息
- **LOG1-LOG5 (10-14)**: 详细的调试信息

## 求解器模式对比

### C++ API模式（推荐）
- ✅ **性能优秀**: 直接调用库函数，无进程间通信开销
- ✅ **增量式求解**: 支持push/pop和增量断言
- ✅ **丰富功能**: 支持模型获取、不可满足核心等
- ❌ **部署复杂**: 需要链接求解器库

### Shell模式
- ✅ **部署简单**: 只需系统中有求解器命令行工具
- ✅ **灵活切换**: 可以轻松切换不同版本的求解器
- ❌ **性能较低**: 有进程启动和文件I/O开销
- ❌ **功能受限**: 难以实现复杂的增量式求解

## 项目结构

```
StrProcessor/
├── src/                    # 源代码
│   ├── main.cpp           # 主程序入口
│   ├── Check.h/cpp        # 求解器接口实现
│   ├── Parser.h/cpp       # SMT2解析器
│   ├── Context.h/cpp      # 上下文管理
│   ├── Logger.h           # 日志系统
│   └── Structures.h/cpp   # 数据结构
├── external/              # 外部依赖
│   ├── z3/               # Z3求解器源码
│   ├── cvc5/             # CVC5求解器源码
│   └── SMTLIBParser/     # SMT2解析库
├── build_solvers.sh      # 求解器编译脚本
├── CMakeLists.txt        # CMake配置
└── README.md             # 本文件
```

## 开发指南

### 添加新的求解器

1. 继承`strp::SolverInterface`接口
2. 实现所有虚函数
3. 在`Check::initializeSolver()`中添加初始化逻辑
4. 更新CMakeLists.txt添加库链接

### 使用Check模块

```cpp
#include "Check.h"

// 获取Check实例
auto& checker = strp::Check::getInstance();

// 设置求解器
checker.setSolver(strp::SolverType::Z3, false);

// 检查公式
auto result = checker.checkFormula("(assert (> x 0))\n(check-sat)");

// 增量式求解
checker.checkFormulaIncremental("(> x 0)");
checker.pushContext();
checker.checkFormulaIncremental("(< x 10)");
checker.popContext();
```

## 故障排除

### 编译错误

1. **求解器库未找到**: 确保运行了`./build_solvers.sh`
2. **头文件未找到**: 检查CMakeLists.txt中的路径配置
3. **链接错误**: 确保求解器库编译成功

### 运行时错误

1. **Shell模式失败**: 确保系统PATH中有z3或cvc5命令
2. **API模式失败**: 会自动降级到Shell模式
3. **文件权限错误**: 确保对/tmp目录有写权限

## 性能优化建议

1. **使用C++ API模式**: 比Shell模式快10-100倍
2. **合理设置日志级别**: 详细日志会影响性能
3. **使用增量式求解**: 避免重复解析相同的约束
4. **批量处理**: 一次性添加多个断言而非逐个添加

## 许可证

本项目采用MIT许可证，详见LICENSE文件。

## 贡献

欢迎提交Issue和Pull Request！ 