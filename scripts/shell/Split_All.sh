mkdir -p results/splitsmt

bash scripts/batch/batch_splitsmt.sh -s z3 -i benchmarks_splitsmt -o results/splitsmt/z3 -t 2 -j 10 -g 5 > results/splitsmt/z3.log 2>&1 &

bash scripts/batch/batch_splitsmt.sh -s cvc5 -i benchmarks_splitsmt -o results/splitsmt/cvc5 -t 2 -j 12 -g 5 > results/splitsmt/cvc5.log 2>&1 &

bash scripts/batch/batch_splitsmt.sh -s ostrich -i benchmarks_splitsmt -o results/splitsmt/ostrich -t 2 -j 13 -g 5 > results/splitsmt/ostrich.log 2>&1 &

bash scripts/batch/batch_splitsmt.sh -s z3-noodler -i benchmarks_splitsmt -o results/splitsmt/z3-noodler -t 2 -j 5 -g 5 > results/splitsmt/z3-noodler.log 2>&1 &
# nohup bash scripts/batch/batch_splitsmt.sh -s z3-noodler -i benchmarks_splitsmt -o results/splitsmt/z3-noodler -t 120 -j 40 -g 5 > results/splitsmt/z3-noodler.log 2>&1 &

wait

python3 scripts/report/aggregate.py results/splitsmt --output results/splitsmt/report.xlsx --encoding utf-8