make -j
./scripts/convert/clean_non_smt2.sh test/Timeout
python3 scripts/convert/convert.py test/Timeout test/Timeout_REG --clear
# python3 scripts/convert/convert.py test/Timeout test/Timeout_REG_python --version python --clear
./scripts/batch/batch.sh -s cvc5 -i test/Timeout_REG -o results/Timeout/cvc5 -g 10 -j 10 -t 10
./scripts/batch/batch.sh -s z3-noodler -i test/Timeout_REG -o results/Timeout/z3-noodler -g 10 -j 10 -t 10
python3 scripts/report/aggregate.py results/Timeout --output charts/Timeout.xlsx
python3 scripts/collect/collect.py charts/Timeout.xlsx --result TIMEOUT --solvers cvc5 --prune