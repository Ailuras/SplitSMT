#!/bin/bash
# Generate benchmarks_splitsmt_gen by preprocessing benchmarks_splitsmt with SplitSMT --gen.
#
# Usage: bash scripts/shell/gen_dataset.sh [INPUT_DIR] [OUTPUT_DIR] [JOBS]
#   INPUT_DIR   default: benchmarks_splitsmt
#   OUTPUT_DIR  default: benchmarks_splitsmt_gen
#   JOBS        max parallel workers, default: nproc

set -o pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
BINARY="$REPO_ROOT/build/bin/SplitSMT"
INPUT_DIR="${1:-$REPO_ROOT/benchmarks_splitsmt}"
OUTPUT_DIR="${2:-$REPO_ROOT/benchmarks_splitsmt_gen}"
JOBS="${3:-$(nproc 2>/dev/null || echo 4)}"

# ── Sanity checks ────────────────────────────────────────────────────────────
if [[ ! -f "$BINARY" ]]; then
    echo "Error: SplitSMT binary not found at $BINARY" >&2
    echo "Build first: cmake --build build --config Release" >&2
    exit 1
fi

if [[ ! -d "$INPUT_DIR" ]]; then
    echo "Error: Input directory not found: $INPUT_DIR" >&2
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

# ── Collect files ─────────────────────────────────────────────────────────────
ALL_FILES=()
while IFS= read -r f; do
    ALL_FILES+=("$f")
done < <(find "$INPUT_DIR" -type f -name "*.smt2" | sort)

TOTAL=${#ALL_FILES[@]}
if [[ $TOTAL -eq 0 ]]; then
    echo "Error: No .smt2 files found in $INPUT_DIR" >&2
    exit 1
fi

LOG_DIR="$OUTPUT_DIR/.gen_logs"
mkdir -p "$LOG_DIR"
SUCCESS_FILE="$LOG_DIR/success.txt"
FAIL_FILE="$LOG_DIR/fail.txt"
: > "$SUCCESS_FILE"
: > "$FAIL_FILE"

echo "========================================="
echo " SplitSMT Dataset Generation"
echo "========================================="
echo " Input:  $INPUT_DIR"
echo " Output: $OUTPUT_DIR"
echo " Total:  $TOTAL files"
echo " Jobs:   $JOBS"
echo "========================================="
echo

# ── Parallel worker using a semaphore (fd-based) ──────────────────────────────
FIFO="$LOG_DIR/jobs.fifo"
rm -f "$FIFO"
mkfifo "$FIFO"
exec 3<>"$FIFO"
# Pre-fill the semaphore with JOBS tokens
for ((i=0; i<JOBS; i++)); do printf . >&3; done

PROCESSED=0

for INPUT in "${ALL_FILES[@]}"; do
    # Acquire a token
    read -r -n 1 -u 3

    (
        REL="${INPUT#$INPUT_DIR/}"
        OUTPUT="$OUTPUT_DIR/$REL"
        mkdir -p "$(dirname "$OUTPUT")"

        ERR=$("$BINARY" "$INPUT" "$OUTPUT" --gen 2>&1)
        CODE=$?

        if [[ $CODE -eq 0 ]]; then
            echo "$REL" >> "$SUCCESS_FILE"
            echo "OK   $REL"
        else
            rm -f "$OUTPUT"   # remove partial/empty output
            echo "FAIL $REL" >> "$FAIL_FILE"
            echo "FAIL $REL  ($ERR)" >&2
        fi

        # Release the token
        printf . >&3
    ) &

    PROCESSED=$((PROCESSED + 1))
    if (( PROCESSED % 50 == 0 )); then
        echo "... $PROCESSED / $TOTAL dispatched"
    fi
done

# Wait for all background jobs
wait

exec 3>&-
rm -f "$FIFO"

SUCCESS=$(wc -l < "$SUCCESS_FILE" | tr -d ' ')
FAIL=$(wc -l < "$FAIL_FILE" | tr -d ' ')

echo
echo "========================================="
echo " Generation complete."
echo "   Success : $SUCCESS"
echo "   Failed  : $FAIL  (fallback/parse errors — files not written)"
echo "   Output  : $OUTPUT_DIR"
if [[ $FAIL -gt 0 ]]; then
    echo "   Fail log: $FAIL_FILE"
fi
echo "========================================="
