make clean
make -j
python3 scripts/convert/convert.py benchmarks/2015-Norn benchmarks_REG/2015-Norn
nohup ./scripts/batch/batch.sh -s z3 -i benchmarks_REG/2015-Norn -o results/Norn-REG-C++/z3 -g 10 -j 10 &
nohup ./scripts/batch/batch.sh -s cvc5 -i benchmarks_REG/2015-Norn -o results/Norn-REG-C++/cvc5 -g 10 -j 10 &
nohup ./scripts/batch/batch.sh -s ostrich -i benchmarks_REG/2015-Norn -o results/Norn-REG-C++/ostrich -g 10 -j 10 &
nohup ./scripts/batch/batch.sh -s z3-noodler -i benchmarks_REG/2015-Norn -o results/Norn-REG-C++/z3-noodler -g 10 -j 10 &