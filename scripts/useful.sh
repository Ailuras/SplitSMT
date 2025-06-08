#!/bin/bash

# StrProcessor 使用指南
# 
# 最新更新：
# - 优化了 split 函数处理性能，移除了冗余的 findSplitAtAtoms 函数
# - 简化了变异逻辑，只使用 str.split_at 函数（移除了 str.num_splits 支持）
# - 改进了模型输出过滤，只显示原始变量值，不显示内部辅助变量
# - 提升了求解器性能和结果的可读性
#
# =============================================================================

# select seeds
python scripts/mutate/select_seeds.py --input-file charts/QF_SLIA_ALL.xlsx --num-seeds 100 --output-dir benchmarks/seeds

# mutate seeds (使用 str.split_at 函数进行变异，不再使用 str.num_splits)

# 1. 自动变异器 (默认) - 基于规则生成 str.split_at 约束
./scripts/mutate/mutate_batch.sh

# 2. 自动变异器 (明确指定) - 8个并行任务
./scripts/mutate/mutate_batch.sh -p auto -j 8

# 3. LLM变异器 - DeepSeek (智能生成 str.split_at 约束)
./scripts/mutate/mutate_batch.sh -p deepseek -j 4

# 4. LLM变异器 - OpenAI GPT (智能生成 str.split_at 约束)
./scripts/mutate/mutate_batch.sh -p openai -j 4

# 5. LLM变异器 - Claude (智能生成 str.split_at 约束)
./scripts/mutate/mutate_batch.sh -p claude -j 4

# 6. 指定特定模型的LLM变异
./scripts/mutate/mutate_batch.sh -p deepseek -m deepseek-coder -j 4
./scripts/mutate/mutate_batch.sh -p openai -m gpt-4 -j 4
./scripts/mutate/mutate_batch.sh -p claude -m claude-3-sonnet-20240229 -j 4

# 7. 单文件变异示例 (如果需要测试单个文件)
# 自动变异 - 生成基于规则的 str.split_at 约束
python scripts/mutate/mutate_auto.py --input benchmarks/seeds/example.smt2 --output benchmarks/test_auto.smt2
# LLM变异 - 智能生成 str.split_at 约束
python scripts/mutate/mutate_llm.py --input benchmarks/seeds/example.smt2 --output benchmarks/test_llm.smt2 --provider deepseek

# 快速测试单个变异文件求解
./run_strprocessor.sh benchmarks/test_auto.smt2 -l 10
./run_strprocessor.sh benchmarks/test_llm.smt2 -l 10

# 8. 求解变异后的文件
# 求解原始种子文件
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds.log

# 求解自动变异文件 (现在性能更优，输出更清晰)
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_auto -f results_mutate_auto.log

# 求解DeepSeek变异文件
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_deepseek -f results_mutate_deepseek.log

# 求解OpenAI变异文件
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_openai -f results_mutate_openai.log

# 求解Claude变异文件
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_claude -f results_mutate_claude.log

# 自定义超时时间的求解
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_auto -f results_mutate_auto_60s.log -t 60

# 使用管道重定向（如果需要额外的日志记录）
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutate_auto -f results_mutate_auto.log 2>&1 | tee logs/solve_auto.log

# 9. 分析变异结果

# 基础分析：Auto vs DeepSeek（最常用）- 包含原始结果对比
python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek --result-logs results/results_mutate_auto.log results/results_mutate_deepseek.log --seeds-result-log results/results_seeds.log --output-file charts/mutation_analysis.xlsx

# 完整分析：包含所有LLM变异类型和原始结果对比
python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek benchmarks/seeds_mutate_openai benchmarks/seeds_mutate_claude --result-logs results/results_mutate_auto.log results/results_mutate_deepseek.log results/results_mutate_openai.log results/results_mutate_claude.log --seeds-result-log results/results_seeds.log --output-file charts/mutation_analysis_all.xlsx

# 只分析LLM变异（不包含Auto）- 包含原始结果对比
python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_deepseek benchmarks/seeds_mutate_openai benchmarks/seeds_mutate_claude --result-logs results/results_mutate_deepseek.log results/results_mutate_openai.log results/results_mutate_claude.log --seeds-result-log results/results_seeds.log --output-file charts/llm_mutation_analysis.xlsx

# 单独分析某个变异类型（示例）- 包含原始结果对比
python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_auto --result-logs results/results_mutate_auto.log --seeds-result-log results/results_seeds.log --output-file charts/auto_mutation_only.xlsx

# 不包含原始结果的分析（向后兼容）
python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek --result-logs results/results_mutate_auto.log results/results_mutate_deepseek.log --output-file charts/mutation_analysis_no_original.xlsx

# 自定义输出目录的分析 - 包含原始结果对比
python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek --result-logs results/results_mutate_auto.log results/results_mutate_deepseek.log --seeds-result-log results/results_seeds.log --output-dir charts/custom --output-file detailed_analysis.xlsx

# 10. 高级分析示例

# 专注于正确性错误检测的分析
python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek benchmarks/seeds_mutate_openai --result-logs results/results_mutate_auto.log results/results_mutate_deepseek.log results/results_mutate_openai.log --seeds-result-log results/results_seeds.log --output-file charts/correctness_analysis.xlsx

# 比较不同LLM提供商的变异效果
python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_deepseek benchmarks/seeds_mutate_openai benchmarks/seeds_mutate_claude --result-logs results/results_mutate_deepseek.log results/results_mutate_openai.log results/results_mutate_claude.log --seeds-result-log results/results_seeds.log --output-file charts/llm_providers_comparison.xlsx

# 分析特定超时时间下的结果
python scripts/solve/analysis_results.py --seeds-dir benchmarks/seeds --mutated-dirs benchmarks/seeds_mutate_auto --result-logs results/results_mutate_auto_60s.log --seeds-result-log results/results_seeds.log --output-file charts/timeout_60s_analysis.xlsx

# =============================================================================
# 性能提升说明:
# 
# 1. 代码优化:
#    - 删除了重复的 findSplitAtAtoms 函数，使用 Context::getSplitAtVarNodes()
#    - 优化了变异算法，减少了不必要的 str.num_splits 处理
#    - 改进了模型输出过滤，提高了结果可读性
#
# 2. 变异策略简化:
#    - 专注于 str.split_at 函数，移除了复杂的 str.num_splits 逻辑
#    - 减少了生成的辅助变量数量
#    - 提高了变异文件的质量和可理解性
#
# 3. 求解器性能:
#    - 优化的约束生成减少了求解时间
#    - 更清晰的模型输出，只显示关键变量
#    - 改进的约束结构提高了求解效率
# =============================================================================
