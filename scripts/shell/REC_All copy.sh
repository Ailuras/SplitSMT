mkdir -p results/RA

bash scripts/batch/batch.sh -s z3 -i benchmarks_RA/RealWorld -o results/RA/z3 -t 1200 -j 10 -g 1 > results/RA/z3.log 2>&1 &

bash scripts/batch/batch.sh -s cvc5 -i benchmarks_RA/RealWorld -o results/RA/cvc5 -t 1200 -j 10 -g 1 > results/RA/cvc5.log 2>&1 &

bash scripts/batch/batch.sh -s ostrich -i benchmarks_RA/RealWorld -o results/RA/ostrich -t 1200 -j 10 -g 1 > results/RA/ostrich.log 2>&1 &

bash scripts/batch/batch.sh -s z3-noodler -i benchmarks_RA/RealWorld -o results/RA/z3-noodler -t 1200 -j 10 -g 1 > results/RA/z3-noodler.log 2>&1 &

wait

python3 scripts/report/aggregate.py results/RA --output results/RA/report.xlsx --encoding utf-8