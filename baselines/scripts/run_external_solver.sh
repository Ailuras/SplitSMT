#!/bin/bash

# External solver wrapper for baseline: call native solvers directly
# Usage: run_external_solver.sh <smt2_file> --solver <z3|cvc5|ostrich|z3-noodler>

set -euo pipefail

FILE=""
SOLVER="z3"

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <file.smt2> --solver <z3|cvc5|ostrich|z3-noodler>" >&2
  exit 2
fi

FILE="$1"; shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --solver)
      SOLVER="$2"; shift 2;;
    *)
      shift;;
  esac
done

case "$SOLVER" in
  z3)
    exec z3 -smt2 "$FILE"
    ;;
  cvc5)
    exec cvc5 --lang smt2 "$FILE"
    ;;
  ostrich)
    # assuming ostrich jar available; adapt if different
    exec ostrich "$FILE"
    ;;
  z3-noodler)
    # if there's a noodler wrapper, call it; fallback to z3
    exec z3-noodler "$FILE"
    ;;
  *)
    echo "Unknown solver: $SOLVER" >&2
    exit 2
    ;;
esac


