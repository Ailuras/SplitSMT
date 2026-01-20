python3 scripts/report/aggregate.py results/splitsmt --output results/splitsmt/report.xlsx --encoding utf-8
python scripts/collect/collect.py results/splitsmt/report.xlsx --result ERROR --solvers SplitSMT-z3 --output todos/round4 --flatten
python scripts/collect/collect.py results/splitsmt/report.xlsx --result ERROR --solvers SplitSMT-z3-noodler --output todos/round1 --flatten
python scripts/check/check_model.py benchmarks_UF/RealWorld benchmarks_RA/RealWorld benchmarks_check
python scripts/check/check_model.py benchmarks_UF benchmarks_RA benchmarks_check -j 40