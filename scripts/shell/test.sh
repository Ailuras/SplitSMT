./scripts/batch/batch.sh -s z3-noodler -t 90 -i SLIA -o results/SLIA_z3-noodler -j 40 -g 1
python3 scripts/report/aggregate.py results/SLIA_z3-noodler --output results/SLIA_z3-noodler/report.xlsx --encoding utf-8
python3 ./scripts/report/filter.py results/SLIA_z3-noodler/report.xlsx -t Error Hard Conflict 
python3 scripts/report/filter.py results/SLIA_z3-noodler/report.xlsx -s z3-noodler -r UNSAT