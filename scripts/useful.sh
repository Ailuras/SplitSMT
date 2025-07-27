#!/bin/bash

# StrProcessor Usage Guide
# 
# Latest Updates:
# - Added multi-solver support (ext-z3, ext-cvc5, ext-ostrich, ext-z3-noodler)
# - Updated batch solving script to support solver selection
# - Rewrote analysis script to support multi-solver result comparison
# - Optimized split function processing performance and model output filtering
#
# =============================================================================

# 1. Select seed files
python scripts/mutate/select_seeds.py --input-file charts/QF_SLIA_ALL.xlsx --num-seeds 100 --output-dir benchmarks/seeds

# 2. Mutate seed files

# Auto mutator (rule-based generation of str.split_at constraints)
./scripts/mutate/mutate_batch.sh -p auto -j 8

# LLM mutator - DeepSeek (intelligent generation of str.split_at constraints)
./scripts/mutate/mutate_batch.sh -p deepseek -j 4

# LLM mutator - OpenAI GPT (intelligent generation of str.split_at constraints)
./scripts/mutate/mutate_batch.sh -p openai -j 4

# LLM mutator - Claude (intelligent generation of str.split_at constraints)
./scripts/mutate/mutate_batch.sh -p claude -j 4

# Specify specific model for LLM mutation
./scripts/mutate/mutate_batch.sh -p deepseek -m deepseek-coder -j 4
./scripts/mutate/mutate_batch.sh -p openai -m gpt-4 -j 4
./scripts/mutate/mutate_batch.sh -p claude -m claude-3-sonnet-20240229 -j 4

# 3. Solve files using different solvers

# Solve original seed files using external solvers
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_ext_z3.log --solver ext-z3
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_ext_cvc5.log --solver ext-cvc5
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_ext_ostrich.log --solver ext-ostrich
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_ext_z3_noodler.log --solver ext-z3-noodler

# Solve mutated files using external solvers
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

# Use built-in solvers (if needed for comparison)
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_z3_api.log --solver z3
./scripts/solve/solve_batch.sh -i benchmarks/seeds -f results_seeds_cvc5_api.log --solver cvc5

# Solve real-world examples using external solvers
./scripts/solve/solve_batch.sh -i benchmarks/test -f results_test_ext_cvc5.log --solver ext-cvc5 -t 60 -p 30
./scripts/solve/solve_batch.sh -i benchmarks/test -f results_test_ext_z3-noodler.log --solver ext-z3-noodler -t 60 -p 30
python scripts/solve/classify_files.py --excel-file charts/results_test_ext_cvc5_analysis.xlsx --output-dir benchmarks/test_ext_cvc5 --source-dir benchmarks/test
python scripts/solve/classify_files.py --excel-file charts/results_test_ext_z3-noodler_analysis.xlsx --output-dir benchmarks/test_ext_z3-noodler --source-dir benchmarks/test

./scripts/solve/solve_batch.sh -i benchmarks/awesome -f results_awesome_ext_z3-noodler.log --solver ext-z3-noodler -t 60 -p 30
python scripts/solve/classify_files.py --excel-file charts/results_awesome_ext_z3-noodler_analysis.xlsx --output-dir benchmarks/awesome_ext_z3-noodler --source-dir benchmarks/awesome
./scripts/solve/solve_batch.sh -i benchmarks/top20_gh -f results_top20_gh_ext_z3-noodler.log --solver ext-z3-noodler -t 60 -p 30
python scripts/solve/classify_files.py --excel-file charts/results_top20_gh_ext_z3-noodler_analysis.xlsx --output-dir benchmarks/top20_gh_ext_z3-noodler --source-dir benchmarks/top20_gh
./scripts/solve/solve_batch.sh -i benchmarks/top20_maven -f results_top20_maven_ext_z3-noodler.log --solver ext-z3-noodler -t 60 -p 30
python scripts/solve/classify_files.py --excel-file charts/results_top20_maven_ext_z3-noodler_analysis.xlsx --output-dir benchmarks/top20_maven_ext_z3-noodler --source-dir benchmarks/top20_maven

# 4. Multi-solver result analysis
 
# Analyze complete report for all mutation types and solver combinations (including solver consistency check)
python scripts/solve/analysis_results.py \
    --results-dir results \
    --seeds-dir benchmarks/seeds \
    --mutated-dirs benchmarks/seeds_mutate_auto benchmarks/seeds_mutate_deepseek benchmarks/seeds_mutate_openai \
    --output-file charts/multi_solver_analysis.xlsx

# Analyze multi-solver results for specific mutation types
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

# 5. Single file test examples

# Single file mutation test
python scripts/mutate/mutate_auto.py --input benchmarks/seeds/example.smt2 --output benchmarks/test_auto.smt2
python scripts/mutate/mutate_llm.py --input benchmarks/seeds/example.smt2 --output benchmarks/test_llm.smt2 --provider deepseek

# Single file solving test (using different solvers)
./run_strprocessor.sh benchmarks/test_auto.smt2 --solver z3
./run_strprocessor.sh benchmarks/test_auto.smt2 --solver ext-z3
./run_strprocessor.sh benchmarks/test_auto.smt2 --solver ext-cvc5
./run_strprocessor.sh benchmarks/test_auto.smt2 --solver ext-ostrich
./run_strprocessor.sh benchmarks/test_auto.smt2 --solver ext-z3-noodler

# =============================================================================
# Supported solver types:
# 
# Built-in solvers (API calls):
#   - z3      : Z3 solver (default)
#   - cvc5    : CVC5 solver
#
# External solvers (process calls):
#   - ext-z3        : External Z3 solver
#   - ext-cvc5      : External CVC5 solver  
#   - ext-ostrich   : External Ostrich solver
#   - ext-z3-noodler: External Z3-Noodler solver
#
# Analysis report includes:
#   - Overview: Complete overview of all mutation types × solver combinations
#   - Solver_Performance: Performance statistics comparison of different solvers
#   - Seeds_Cross_Solver: Consistency analysis of original files across different solvers
#   - Detailed analysis sheet for each mutation type
#   - solver_consistency column: Detects severe inconsistencies (one solver SAT, another UNSAT)
# =============================================================================
