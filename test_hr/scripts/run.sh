#!/bin/bash

../bin/cvc5 --produce-models $1 -t test_sat > $2 2>&1
# ../bin/cvc5 --produce-models $1 -t test_hr -t test_sat -t theory* -t conflict* -t minisat* -t pf* -t cnf* -t model* -t prereg* -t constraint* -t equality* -t string* -t dtview* -t prop* -t smt -t smt-debug > $2 2>&1
# ../bin/cvc5 --produce-models $1 -t test_hr -t theory* -t conflict* -t dec-manager* -t dtview* -t minisat* -t pf* -t cnf* -t model* -t prereg* -t arith* -t constraint* -t equality* -t shared* -t string* -t register* -t te* -t prop* -t sharing* -t equals* -t smt-debug -t skolem* -t im > out.log 2>&1
# ../bin/cvc5 --produce-models $1 > out.log 2>&1