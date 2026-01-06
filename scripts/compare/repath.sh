#!/usr/bin/env bash

# Recursively replace path fragments inside files under a directory.
# Usage: ./repath.sh <target-dir>

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <target-dir>" >&2
  exit 1
fi

TARGET_DIR=$1

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "Error: '$TARGET_DIR' is not a directory" >&2
  exit 1
fi

find "$TARGET_DIR" -type f -print0 | while IFS= read -r -d '' file; do
  # perl -0777 processes the whole file to catch multi-line occurrences.
  perl -0777 -i -pe 's/benchmarks\/2015-Norn-REG/benchmarks_REG\/2015-Norn/g' "$file"
done
