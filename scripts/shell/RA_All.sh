mkdir -p results/REC

bash scripts/batch/batch.sh -s z3 -i benchmarks_REC -o results/REC/z3 -t 1200 -j 10 -g 10  > results/REC/z3.log 2>&1 &

bash scripts/batch/batch.sh -s cvc5 -i benchmarks_REC -o results/REC/cvc5 -t 1200 -j 10 -g 10 > results/REC/cvc5.log 2>&1 &

bash scripts/batch/batch.sh -s ostrich -i benchmarks_REC -o results/REC/ostrich -t 1200 -j 10 -g 10 > results/REC/ostrich.log 2>&1 &

bash scripts/batch/batch.sh -s z3-noodler -i benchmarks_REC -o results/REC/z3-noodler -t 1200 -j 10 -g 10 > results/REC/z3-noodler.log 2>&1 &

wait

python3 scripts/report/aggregate.py results/REC --output results/REC/report.xlsx --encoding utf-8