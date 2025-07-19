python scripts/mutate/mutate_llm_new.py -i benchmarks/seeds/1b415777353081399f22c146e473815a5dca078827ae55052c0dcaad.smt2 -o output_rws.smt2 --method rws

python scripts/mutate/mutate_llm_new.py -i benchmarks/seeds/1b415777353081399f22c146e473815a5dca078827ae55052c0dcaad.smt2 -o output_sfc.smt2 --method sfc

python scripts/mutate/mutate_llm_new.py -i benchmarks/seeds/1b415777353081399f22c146e473815a5dca078827ae55052c0dcaad.smt2 -o output_cso.smt2 --method cso

scripts/mutate/mutate.sh cso claude claude-sonnet-4-20250514 100

scripts/mutate/mutate.sh sfc claude claude-sonnet-4-20250514 100

scripts/mutate/mutate_new.sh rws claude claude-sonnet-4-20250514 100

python scripts/mutate/mutate_llm_new.py -i benchmarks/seeds/1b415777353081399f22c146e473815a5dca078827ae55052c0dcaad.smt2 -o output_rws.smt2 --method rws --provider claude --model claude-sonnet-4-20250514

python scripts/mutate/mutate_llm_new.py -i benchmarks/seeds/1b415777353081399f22c146e473815a5dca078827ae55052c0dcaad.smt2 -o output_rws.smt2 --method rws --provider deepseek --model deepseek-ai/DeepSeek-V3

scripts/mutate/mutate.sh cso deepseek DeepSeek-V3 100

scripts/mutate/mutate.sh sfc deepseek DeepSeek-V3 100

scripts/mutate/mutate.sh rws deepseek DeepSeek-V3 100

