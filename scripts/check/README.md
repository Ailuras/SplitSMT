# scripts/check

## batch.sh

```bash
./batch.sh -s <solver> -t <timeout> -i <input_dir> -o <output_dir> -g <group_size> -j <jobs>
```

```bash
./scripts/check/batch.sh -s z3-noodler -t 60 -i benchmarks -o results/all_logs -g 10 -j 48
./scripts/check/batch.sh -s z3-noodler -t 60 -i scripts/check/benchmarks -o results/error_logs -g 5 -j 10
```

## parse_logs.py

```bash
python3 scripts/check/parse_logs.py <log_dir> [output_excel] [--save-errors-dir DIR] [--source-root ROOT]
```

```bash
python3 scripts/check/parse_logs.py results/all_logs --save-errors-dir scripts/check

python3 scripts/check/parse_logs.py results/all_logs charts/Excel/all.xlsx --source-root benchmarks

python3 scripts/check/parse_logs.py results/error_logs charts/Excel/error.xlsx
```
