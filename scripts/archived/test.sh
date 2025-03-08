#!/bin/bash

# cd ../build/;make -j4;cd ../test_hr

mode=$1
verbose=$2
file=$3

# 提取文件名，不包含路径和扩展名
filename=$(basename "$file")
logname="${filename%.*}"  # 去掉扩展名

# 默认设置输出文件名
output_file=""

# 根据 verbose 的值判断是否输出到文件
if [ $verbose -eq 1 ]; then
    output_file="results/${logname}_${mode}.log"
fi

# if mode == 1, then use sh 1, else if mode == 2, then use sh 2
if [ $mode -eq 1 ]; then
    if [ -z "$output_file" ]; then
        ../build/bin/cvc5 --produce-models $file
    else
        ../build/bin/cvc5 --produce-models $file > $output_file 2>&1
    fi
elif [ $mode -eq 2 ]; then
    if [ -z "$output_file" ]; then
        ../build/bin/cvc5 --produce-models $file -t theory* -t conflict* -t dec-manager* -t dtview* -t minisat* -t pf* -t cnf* -t mode* -t prereg* -t constraint* -t shared* -t string* -t register* -t prop* -t sharing* -t equals* -t skolem* -t im -t rewrite* -t regexp* -t test_Extf -t test_Member -t test_sat -t test_cnf
    else
        ../build/bin/cvc5 --produce-models $file -t theory* -t conflict* -t dec-manager* -t dtview* -t minisat* -t pf* -t cnf* -t mode* -t prereg* -t constraint* -t shared* -t string* -t register* -t prop* -t sharing* -t equals* -t skolem* -t im -t rewrite* -t regexp* -t test_Extf -t test_Member -t test_sat -t test_cnf > $output_file 2>&1
    fi
elif [ $mode -eq 3 ]; then
    if [ -z "$output_file" ]; then
        ../build/bin/cvc5 --produce-models $file -t test_char
    else
        ../build/bin/cvc5 --produce-models $file -t test_char > $output_file 2>&1
    fi
elif [ $mode -eq 4 ]; then
    if [ -z "$output_file" ]; then
        ../build/bin/cvc5 --produce-models $file -t test_Member
    else
        ../build/bin/cvc5 --produce-models $file -t test_Member > $output_file 2>&1
    fi
elif [ $mode -eq 5 ]; then
    if [ -z "$output_file" ]; then
        ../build/bin/cvc5 --produce-models $file -t test_Extf -t test_Member -t test_sat -t test_cnf -t test_lemma
    else
        ../build/bin/cvc5 --produce-models $file -t test_Extf -t test_Member -t test_sat -t test_cnf -t test_lemma > $output_file 2>&1
    fi
elif [ $mode -eq 6 ]; then # test_inc
    if [ -z "$output_file" ]; then
        ../build/bin/cvc5 --produce-models --incremental $file -t cmd* -t minisat* -t cnf*
    else
        ../build/bin/cvc5 --produce-models --incremental $file -t cmd* -t minisat* -t cnf* > $output_file 2>&1
    fi
elif [ $mode -eq 7 ]; then
    if [ -z "$output_file" ]; then
        ../build/bin/cvc5 --produce-models $file -t test_Extf -t test_Member -t t_reg
    else
        ../build/bin/cvc5 --produce-models $file -t test_Extf -t test_Member -t t_reg > $output_file 2>&1
    fi
fi