# Check模块使用说明

## 概述

Check模块提供了一个灵活的SMT求解器接口，支持Z3和CVC5两种求解器，并且可以选择使用C++ API或Shell命令两种调用方式。

## 设计特点

### 1. 多求解器支持
- **Z3**: 使用z3++.h C++ API
- **CVC5**: 使用cvc5 C++ API

### 2. 双模式运行
- **C++ API模式**: 直接调用求解器库，性能更好，支持增量式求解
- **Shell模式**: 通过命令行调用求解器，部署简单，无需链接库

### 3. 增量式求解支持
- `push()`/`pop()`: 上下文栈管理
- `checkSatIncremental()`: 增量式断言检查

## 使用方法

### 基本用法

```cpp
#include "Check.h"

// 获取Check实例
auto& checker = strp::Check::getInstance();

// 设置求解器类型和模式
checker.setSolver(strp::SolverType::Z3, false); // 使用Z3 C++ API
// checker.setSolver(strp::SolverType::CVC5, true); // 使用CVC5 Shell模式

// 检查公式可满足性
std::string formula = "(set-logic QF_LIA)\n(assert (> x 0))\n(check-sat)";
strp::SatResult result = checker.checkFormula(formula);

switch (result) {
    case strp::SatResult::SAT:
        std::cout << "Formula is satisfiable" << std::endl;
        std::cout << "Model: " << checker.getModel() << std::endl;
        break;
    case strp::SatResult::UNSAT:
        std::cout << "Formula is unsatisfiable" << std::endl;
        break;
    case strp::SatResult::UNKNOWN:
        std::cout << "Result unknown" << std::endl;
        break;
    case strp::SatResult::ERROR:
        std::cout << "Error occurred" << std::endl;
        break;
}
```

### 增量式求解

```cpp
auto& checker = strp::Check::getInstance();

// 添加断言
checker.checkFormulaIncremental("(> x 0)");
checker.pushContext();

// 添加更多断言
checker.checkFormulaIncremental("(< x 10)");
strp::SatResult result = checker.checkFormulaIncremental("(= x 5)");

// 回退到之前的状态
checker.popContext();
```

## 编译配置

### 启用Z3支持

```cmake
# CMakeLists.txt
find_package(Z3 REQUIRED)
target_compile_definitions(strprocessor PRIVATE ENABLE_Z3)
target_link_libraries(strprocessor z3)
```

### 启用CVC5支持

```cmake
# CMakeLists.txt
find_package(cvc5 REQUIRED)
target_compile_definitions(strprocessor PRIVATE ENABLE_CVC5)
target_link_libraries(strprocessor cvc5)
```

### 仅使用Shell模式

如果不想链接求解器库，可以只使用Shell模式：

```cpp
// 确保系统中安装了z3或cvc5命令行工具
checker.setSolver(strp::SolverType::Z3, true); // Shell模式
```

## 命令行参数

在main.cpp中集成后，可以通过命令行参数控制求解器：

```bash
# 使用Z3 C++ API
./strprocessor input.smt2 -s z3

# 使用CVC5 Shell模式
./strprocessor input.smt2 -s cvc5 --shell

# 设置日志级别
./strprocessor input.smt2 -l 10 -s z3
```

## 错误处理

模块具有完善的错误处理机制：

1. **自动降级**: 如果C++ API不可用，自动切换到Shell模式
2. **详细日志**: 通过Logger模块记录详细的调试信息
3. **异常安全**: 所有操作都有异常处理

## 性能考虑

- **C++ API模式**: 适合频繁调用和增量式求解
- **Shell模式**: 适合简单的一次性求解
- **超时设置**: Z3默认设置30秒超时
- **临时文件**: Shell模式会在/tmp目录创建临时文件

## 扩展性

接口设计支持轻松添加新的求解器：

1. 继承`SolverInterface`
2. 实现所有虚函数
3. 在`Check::initializeSolver()`中添加初始化逻辑 