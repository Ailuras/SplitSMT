#!/bin/bash

# StrProcessor 使用指南
# 
# 最新更新：
# - 添加了多求解器支持（ext-z3, ext-cvc5, ext-ostrich, ext-z3-noodler）
# - 更新了批量求解脚本支持求解器选择
# - 重写了分析脚本支持多求解器结果比较
# - 优化了 split 函数处理性能和模型输出过滤
#
# =============================================================================

# 1. 选择种子文件
python scripts/mutate/select_seeds.py --input-file charts/QF_SLIA_ALL.xlsx --num-seeds 100 --output-dir benchmarks/seeds

# 2. 变异种子文件

# 自动变异器 (基于规则生成 str.split_at 约束)
./scripts/mutate/mutate_batch.sh -p auto -j 8

# LLM变异器 - DeepSeek (智能生成 str.split_at 约束)
./scripts/mutate/mutate_batch.sh -p deepseek -j 4

# LLM变异器 - OpenAI GPT (智能生成 str.split_at 约束)
./scripts/mutate/mutate_batch.sh -p openai -j 4

# LLM变异器 - Claude (智能生成 str.split_at 约束)
./scripts/mutate/mutate_batch.sh -p claude -j 4

# 指定特定模型的LLM变异
./scripts/mutate/mutate_batch.sh -p deepseek -m deepseek-coder -j 4
./scripts/mutate/mutate_batch.sh -p openai -m gpt-4 -j 4
./scripts/mutate/mutate_batch.sh -p claude -m claude-3-sonnet-20240229 -j 4

# 3. 使用不同求解器求解文件

# 使用外部求解器求解原始种子文件
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_ext_z3.log --solver ext-z3
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_ext_cvc5.log --solver ext-cvc5
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_ext_ostrich.log --solver ext-ostrich
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_ext_z3_noodler.log --solver ext-z3-noodler

# 使用外部求解器求解变异文件
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_auto -f results_auto_ext_z3.log --solver ext-z3 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_auto -f results_auto_ext_cvc5.log --solver ext-cvc5 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_auto -f results_auto_ext_ostrich.log --solver ext-ostrich -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_auto -f results_auto_ext_z3_noodler.log --solver ext-z3-noodler -t 60

./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_deepseek -f results_deepseek_ext_z3.log --solver ext-z3 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_deepseek -f results_deepseek_ext_cvc5.log --solver ext-cvc5 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_deepseek -f results_deepseek_ext_ostrich.log --solver ext-ostrich -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_deepseek -f results_deepseek_ext_z3_noodler.log --solver ext-z3-noodler -t 60

./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_openai -f results_openai_ext_z3.log --solver ext-z3 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_openai -f results_openai_ext_cvc5.log --solver ext-cvc5 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_openai -f results_openai_ext_ostrich.log --solver ext-ostrich -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_openai -f results_openai_ext_z3_noodler.log --solver ext-z3-noodler -t 60

# 使用内置求解器（如果需要对比）
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_z3_api.log --solver z3
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_cvc5_api.log --solver cvc5

# 4. 多求解器结果分析

# 分析所有变异类型和求解器组合的完整报告（包含求解器一致性检查）
python scripts/solve/analysis_results.py \
    --results-dir results \
    --seeds-dir benchmarks/seeds \
    --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek benchmarks/seeds_mutate_openai \
    --output-file charts/multi_solver_analysis.xlsx

# 分析特定变异类型的多求解器结果
python scripts/solve/analysis_results.py \
    --results-dir results \
    --seeds-dir benchmarks/seeds \
    --mutated-dirs benchmarks/seeds_mutate_auto \
    --output-file charts/auto_multi_solver.xlsx

python scripts/solve/analysis_results.py \
    --results-dir results \
    --seeds-dir benchmarks/seeds \
    --mutated-dirs benchmarks/seeds_mutate_deepseek \
    --output-file charts/deepseek_multi_solver.xlsx

python scripts/solve/analysis_results.py \
    --results-dir results \
    --seeds-dir benchmarks/seeds \
    --mutated-dirs benchmarks/seeds_mutate_openai \
    --output-file charts/openai_multi_solver.xlsx

# 5. 单文件测试示例

# 单个文件变异测试
python scripts/mutate/mutate_auto.py --input benchmarks/seeds/example.smt2 --output benchmarks/test_auto.smt2
python scripts/mutate/mutate_llm.py --input benchmarks/seeds/example.smt2 --output benchmarks/test_llm.smt2 --provider deepseek

# 单个文件求解测试（使用不同求解器）
./run_strprocessor.sh benchmarks/test_auto.smt2 --solver z3
./run_strprocessor.sh benchmarks/test_auto.smt2 --solver ext-z3
./run_strprocessor.sh benchmarks/test_auto.smt2 --solver ext-cvc5
./run_strprocessor.sh benchmarks/test_auto.smt2 --solver ext-ostrich
./run_strprocessor.sh benchmarks/test_auto.smt2 --solver ext-z3-noodler

# =============================================================================
# 支持的求解器类型：
# 
# 内置求解器（API调用）:
#   - z3      : Z3 solver (默认)
#   - cvc5    : CVC5 solver
#
# 外部求解器（进程调用）:
#   - ext-z3        : 外部Z3求解器
#   - ext-cvc5      : 外部CVC5求解器  
#   - ext-ostrich   : 外部Ostrich求解器
#   - ext-z3-noodler: 外部Z3-Noodler求解器
#
# 分析报告包含：
#   - Overview: 所有变异类型×求解器组合的完整概览
#   - Solver_Performance: 不同求解器的性能统计对比
#   - Seeds_Cross_Solver: 原始文件在不同求解器间的一致性分析
#   - 每个变异类型的详细分析Sheet
#   - solver_consistency列: 检测严重不一致（一个求解器SAT，另一个UNSAT）
# =============================================================================
