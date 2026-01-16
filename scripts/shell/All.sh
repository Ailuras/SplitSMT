set -e

# echo "Running UF_All.sh..."
# bash scripts/shell/UF_All.sh

echo "Running REC_All.sh..."
bash scripts/shell/REC_All.sh

echo "Running RA_All.sh..."
bash scripts/shell/RA_All.sh

echo "All tasks finished!"
