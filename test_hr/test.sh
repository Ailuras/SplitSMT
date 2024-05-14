#!/bin/bash

# cd ../build/;make -j4;cd ../test_hr

mode=$1
file=$2

# if mode == 1, then use sh 1, else if mode == 2, then use sh 2
if [ $mode -eq 1 ]; then
    # cd ../build;make;cd ../test_hr
    ../build/bin/cvc5 --produce-models $file > results/out.log 2>&1
elif [ $mode -eq 2 ]; then
    # cd ../build;make;cd ../test_hr
    ../build/bin/cvc5 --produce-models $file -t theory* -t conflict* -t dec-manager* -t dtview* -t minisat* -t pf* -t cnf* -t mode* -t prereg* -t constraint* -t shared* -t string* -t register* -t prop* -t sharing* -t equals* -t skolem* -t im -t rewrite* -t regexp* -t test_Extf -t test_Member -t test_sat -t test_cnf > results/all.log 2>&1
elif [ $mode -eq 3 ]; then
    # cd ../build;make;cd ../test_hr
    ../build/bin/cvc5 --produce-models $file -t test_char > results/out.log 2>&1
elif [ $mode -eq 4 ]; then
    # cd ../build;make;cd ../test_hr
    ../build/bin/cvc5 --produce-models $file -t test_sat > results/out.log 2>&1
elif [ $mode -eq 5 ]; then
    # cd ../build;make;cd ../test_hr
    ../build/bin/cvc5 --produce-models $file -t test_Extf -t test_Member -t test_sat -t test_cnf > results/test.log 2>&1
elif [ $mode -eq 6 ]; then # test_inc
    # cd ../build;make;cd ../test_hr
    ../build/bin/cvc5 --produce-models --incremental $file -t cmd* -t minisat* -t cnf* > results/inc.log 2>&1
fi