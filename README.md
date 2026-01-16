modify CMakeLists.txt to use corret Parser(src/Parser), z3, and cvc5

```
make clean && make
./run_strprocessor.sh -s z3-noodler xxx.smt2
```

python scripts/collect/collect.py results/splitsmt/report.xlsx --label Conflict --output todos --flatten