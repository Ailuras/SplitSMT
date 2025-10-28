./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Java/awesome -o results/awesome_logs -g 20 -j 4
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Java/top20_gh -o results/top20_gh_logs -g 20 -j 4
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Java/top20_maven -o results/top20_maven_logs -g 20 -j 4

./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Gens/Auto/seeds_mutated_auto -o results/auto_logs -g 20 -j 4
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Gens/LLMs/seeds_mutated_deepseek -o results/deepseek_logs -g 20 -j 4
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Gens/LLMs/seeds_mutated_openai -o results/openai_logs -g 20 -j 4


# Linux Command
nohup ./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks -o results/all_logs -g 10 -j 48 &

# Java
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Java -o results/java_logs -j 100
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Java/awesome -o results/awesome_logs -j 100
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Java/top20_gh -o results/top20_gh_logs -j 100
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Java/top20_maven -o results/top20_maven_logs -j 100


# Auto
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/Auto -o results/auto_logs -j 100

# ChatGPT
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/LLMs/ChatGPT -o results/chatgpt_logs -j 100

# DeepSeek
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/LLMs/DeepSeek -o results/deepseek_logs -j 100

# Claude
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks/LLMs/Claude -o results/claude_logs -j 100