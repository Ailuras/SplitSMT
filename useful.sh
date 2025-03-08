chmod +x solvers/cvc5/bin/cvc5
chmod +x solvers/cvc5/run.sh
chmod +x solvers/z3/bin/z3
chmod +x solvers/z3/run.sh

# 配置cvc5-trace
mkdir -p /home/hanrui/StrCvc5/solvers/cvc5-trace/lib
find /home/hanrui/StrCvc5/solvers/cvc5-trace -path "*/lib/*" -prune -o -name "*.so*" -exec mv {} /home/hanrui/StrCvc5/solvers/cvc5-trace/lib/ \;


python experiments/analysis_preprocess.py --input-excel charts/Norn.xlsx --input-log results/preprocess/Norn-preprocess.log --output-file charts/Norn_updated.xlsx

bash experiments/bench_preprocess.sh \
    --input-dir Norn \
    --process-script scripts/preprocess.py \
    --output-dir Norn-preprocessed \
    --log-dir results/preprocess \
    --log-file Norn-preprocess.log \
    --excel-dir charts \
    --excel-file Norn.xlsx

# 基本用法（不处理 Excel）
bash experiments/bench_solve.sh \
    --input-dir Norn \
    --output-dir results \
    --task cvc5 \
    --solver cvc5 \
    --timeout 10 \
    --parallel 2

# 完整用法（包含 Excel 处理）
bash experiments/bench_solve.sh \
    --input-dir Norn \
    --output-dir results \
    --task cvc5 \
    --solver cvc5 \
    --timeout 10 \
    --parallel 2 \
    --excel-dir charts \
    --excel-file Norn.xlsx

python experiments/analysis_solve.py \
    --input-excel charts/Norn.xlsx \
    --log-dir results/cvc5 results/cvc5-preprocess \
    --output-file charts/Norn_updated.xlsx

python scripts/preprocess_0321.py test/test.smt2 test/after.smt2