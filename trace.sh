#!/bin/bash

# Set library path for cvc5
export LD_LIBRARY_PATH=/home/hanrui/StrCvc5/solvers/cvc5-trace/lib:$LD_LIBRARY_PATH

# Usage: ./trace.sh <mode> <verbose> <file>
# Parameters:
#   mode: 1-7, different trace modes for cvc5
#     1: Basic mode without traces
#     2: Full trace mode with all components
#     3: Character test trace mode
#     4: Member test trace mode
#     5: Extended test mode with lemma traces
#     6: Incremental mode with command traces
#     7: Regular expression test mode
#   verbose: 0 or 1
#     0: Output to stdout
#     1: Output to file in results/ directory
#   file: Input file path to process

mode=$1
verbose=$2
file=$3

filename=$(basename "$file")
logname="${filename%.*}"

output_file=""
[ $verbose -eq 1 ] && output_file="results/${logname}_${mode}.log"

cvc5_path="/home/hanrui/StrCvc5/solvers/cvc5-trace/bin/cvc5"
base_cmd="$cvc5_path --produce-models"

case $mode in
    1) trace_args="" ;;
    2) trace_args="-t theory* -t conflict* -t dec-manager* -t dtview* -t minisat* -t pf* -t cnf* -t mode* -t prereg* -t constraint* -t shared* -t string* -t register* -t prop* -t sharing* -t equals* -t skolem* -t im -t rewrite* -t regexp* -t test_Extf -t test_Member -t test_sat -t test_cnf" ;;
    3) trace_args="-t test_char" ;;
    4) trace_args="-t test_Member" ;;
    5) trace_args="-t test_Extf -t test_Member -t test_sat -t test_cnf -t test_lemma" ;;
    6) base_cmd="$base_cmd --incremental"; trace_args="-t cmd* -t minisat* -t cnf*" ;;
    7) trace_args="-t test_Extf -t test_Member -t t_reg" ;;
esac

cmd="$base_cmd $file $trace_args"

if [ -z "$output_file" ]; then
    $cmd
else
    $cmd > $output_file 2>&1
fi 