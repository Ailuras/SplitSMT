#!/bin/bash
set -e  # Exit on error
# 1. Preprocessing: remove get-model, handle push/pop, etc.
python scripts/convert/normalize.py --input benchmarks_UF
# 2. Convert to UF format
# python scripts/convert/convert_splitsmt2uf.py --input benchmarks_splitsmt --output benchmarks_UF
# 3. Convert from UF to RA and REC formats (note: correct script name)
python scripts/convert/convert_uf2others.py --input benchmarks_UF --output benchmarks_others
# 4. Reorganize directory structure
rm -rf benchmarks_RA benchmarks_REC benchmarks_splitsmt
mv benchmarks_others/ra benchmarks_RA
mv benchmarks_others/rec benchmarks_REC
mv benchmarks_others/splitsmt benchmarks_splitsmt
# 5. Clean up intermediate files
rm -rf benchmarks_others