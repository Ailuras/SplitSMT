mkdir -p results/UF

bash scripts/batch/batch.sh -s z3 -i benchmarks_UF -o results/UF/z3 -t 1200 -j 7 -g 10 > results/UF/z3.log 2>&1 &

bash scripts/batch/batch.sh -s cvc5 -i benchmarks_UF -o results/UF/cvc5 -t 1200 -j 8 -g 10 > results/UF/cvc5.log 2>&1 &

bash scripts/batch/batch.sh -s ostrich -i benchmarks_UF -o results/UF/ostrich -t 1200 -j 10 -g 10 > results/UF/ostrich.log 2>&1 &

bash scripts/batch/batch.sh -s z3-noodler -i benchmarks_UF -o results/UF/z3-noodler -t 1200 -j 15 -g 10 > results/UF/z3-noodler.log 2>&1 &

wait

python3 scripts/report/aggregate.py results/UF --output results/UF/report.xlsx --encoding utf-8