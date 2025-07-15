# 生成变异文件
python3 scripts/auto/mutate_auto.py --input "benchmarks/seeds/*.smt2" --output "benchmarks/seeds_mutated_auto" --batch

# 分析结果  
./scripts/auto/analyze.sh -i benchmarks/seeds_mutated_auto

./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutated_auto -f results_mutated_auto_ext_z3.log --solver ext-z3 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutated_auto -f results_mutated_auto_ext_cvc5.log --solver ext-cvc5 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutated_auto -f results_mutated_auto_ext_ostrich.log --solver ext-ostrich -t 60
./scripts/solve/solve_batch.sh -i benchmarks/seeds_mutated_auto -f results_mutated_auto_ext_z3_noodler.log --solver ext-z3-noodler -t 60

./scripts/solve/solve_batch.sh -i benchmarks/awesome -f results_awesome_ext_z3.log --solver ext-z3 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/awesome -f results_awesome_ext_cvc5.log --solver ext-cvc5 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/awesome -f results_awesome_ext_ostrich.log --solver ext-ostrich -t 60
./scripts/solve/solve_batch.sh -i benchmarks/awesome -f results_awesome_ext_z3_noodler.log --solver ext-z3-noodler -t 60

./scripts/solve/solve_batch.sh -i benchmarks/top20_maven -f results_top20_maven_ext_z3.log --solver ext-z3 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/top20_maven -f results_top20_maven_ext_cvc5.log --solver ext-cvc5 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/top20_maven -f results_top20_maven_ext_ostrich.log --solver ext-ostrich -t 60
./scripts/solve/solve_batch.sh -i benchmarks/top20_maven -f results_top20_maven_ext_z3_noodler.log --solver ext-z3-noodler -t 60

./scripts/solve/solve_batch.sh -i benchmarks/top20_gh -f results_top20_gh_ext_z3.log --solver ext-z3 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/top20_gh -f results_top20_gh_ext_cvc5.log --solver ext-cvc5 -t 60
./scripts/solve/solve_batch.sh -i benchmarks/top20_gh -f results_top20_gh_ext_ostrich.log --solver ext-ostrich -t 60
./scripts/solve/solve_batch.sh -i benchmarks/top20_gh -f results_top20_gh_ext_z3_noodler.log --solver ext-z3-noodler -t 60