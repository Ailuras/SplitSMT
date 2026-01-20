set -e

echo "Running UF_All.sh..."
bash scripts/shell/UF_All.sh

echo "Running REC_All.sh..."
bash scripts/shell/REC_All.sh

echo "Running RA_All.sh..."
bash scripts/shell/RA_All.sh

echo "Running Split_All.sh..."
bash scripts/shell/Split_All.sh

# echo "Running Summary report..."
# python3 scripts/report/merge.py --uf results/UF/report.xlsx --ra results/RA/report.xlsx --rec results/REC/report.xlsx --splitsmt results/splitsmt/report.xlsx --output results/summary.xlsx

 echo "All tasks finished!"
