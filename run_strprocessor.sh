#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LD_LIBRARY_PATH="${SCRIPT_DIR}/external/cvc5/build/deps/lib:${SCRIPT_DIR}/external/z3/build:${LD_LIBRARY_PATH}"
exec "${SCRIPT_DIR}/build/bin/strprocessor" "$@"
