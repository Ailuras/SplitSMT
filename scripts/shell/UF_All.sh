mkdir -p results/UF

bash scripts/batch/batch.sh -s z3 -i benchmarks_UF -o results/UF/z3 -t 10 -j 10 -g 10 > results/UF/z3.log 2>&1 &

bash scripts/batch/batch.sh -s cvc5 -i benchmarks_UF -o results/UF/cvc5 -t 10 -j 10 -g 10 > results/UF/cvc5.log 2>&1 &

bash scripts/batch/batch.sh -s ostrich -i benchmarks_UF -o results/UF/ostrich -t 10 -j 10 -g 10 > results/UF/ostrich.log 2>&1 &

bash scripts/batch/batch.sh -s z3-noodler -i benchmarks_UF -o results/UF/z3-noodler -t 10 -j 10 -g 10 > results/UF/z3-noodler.log 2>&1 &

wait

python3 scripts/report/aggregate.py results/UF --output results/UF/report.xlsx --encoding utf-8
python3 scripts/report/filter.py results/UF/report.xlsx -t Error Hard Conflict 
python3 scripts/report/filter.py results/UF/report.xlsx -s z3-noodler -r UNSAT
python3 scripts/report/filter.py results/UF/report.xlsx -s z3 -r UNSAT
python3 scripts/report/filter.py results/UF/report.xlsx -s cvc5 -r UNSAT
python3 scripts/report/filter.py results/UF/report.xlsx -s ostrich -r UNSAT