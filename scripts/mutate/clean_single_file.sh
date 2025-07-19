#!/bin/bash
# 清理单个SMT文件脚本

if [[ $# -ne 2 ]]; then
    echo "用法: $0 <输入文件> <输出文件>"
    exit 1
fi

input_file="$1"
output_file="$2"

if [[ ! -f "$input_file" ]]; then
    echo "错误: 输入文件不存在: $input_file"
    exit 1
fi

echo "处理文件: $input_file -> $output_file"

# 读取文件内容
content=$(cat "$input_file")
lines=()
i=0

# 将内容按行分割
while IFS= read -r line; do
    lines[i]="$line"
    ((i++))
done <<< "$content"

cleaned_lines=()
cleaned_index=0
found_first_check_sat=false
in_push_pop_block=false
push_count=0

# 处理每一行
for ((i=0; i<${#lines[@]}; i++)); do
    line="${lines[i]}"
    stripped=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    # 跳过空行
    if [[ -z "$stripped" ]]; then
        cleaned_lines[cleaned_index]="$line"
        ((cleaned_index++))
        continue
    fi
    
    # 替换 set-logic QF_S 为 QF_SLIA
    if [[ "$stripped" =~ ^\(set-logic[[:space:]]+QF_S\) ]]; then
        line=$(echo "$line" | sed 's/QF_S/QF_SLIA/g')
        echo "替换: $stripped -> $(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
        cleaned_lines[cleaned_index]="$line"
        ((cleaned_index++))
        continue
    fi
    
    # 检查是否是第一个 check-sat
    if [[ "$stripped" =~ ^\(check-sat\) ]] && [[ "$found_first_check_sat" == "false" ]]; then
        found_first_check_sat=true
        echo "找到第一个 check-sat"
        cleaned_lines[cleaned_index]="$line"
        ((cleaned_index++))
        continue
    fi
    
    # 如果已经找到第一个 check-sat，检查是否进入 push/pop 块
    if [[ "$found_first_check_sat" == "true" ]]; then
        # 检查是否是 push
        if [[ "$stripped" =~ ^\(push\) ]]; then
            in_push_pop_block=true
            push_count=1
            echo "进入 push/pop 块"
            continue
        fi
        
        # 如果在 push/pop 块中
        if [[ "$in_push_pop_block" == "true" ]]; then
            # 检查是否是 pop
            if [[ "$stripped" =~ ^\(pop\) ]]; then
                push_count=$((push_count - 1))
                echo "pop, 剩余 push_count: $push_count"
                if [[ $push_count -eq 0 ]]; then
                    in_push_pop_block=false
                    echo "退出 push/pop 块"
                fi
            # 检查是否是 push（嵌套）
            elif [[ "$stripped" =~ ^\(push\) ]]; then
                push_count=$((push_count + 1))
                echo "嵌套 push, push_count: $push_count"
            fi
            continue
        fi
    fi
    
    # 跳过不需要的命令
    if [[ "$stripped" =~ ^\(pop\) ]] || \
       [[ "$stripped" =~ ^\(get-model\) ]] || \
       [[ "$stripped" =~ ^\(get-unsat-core\) ]] || \
       [[ "$stripped" =~ ^\(push\) ]]; then
        echo "跳过: $stripped"
        continue
    fi
    
    # 如果已经找到第一个 check-sat 且不在 push/pop 块中，跳过后续内容
    if [[ "$found_first_check_sat" == "true" ]] && [[ "$in_push_pop_block" == "false" ]]; then
        # 只保留 exit 命令
        if [[ "$stripped" =~ ^\(exit\) ]]; then
            cleaned_lines[cleaned_index]="$line"
            ((cleaned_index++))
        else
            echo "跳过后续内容: $stripped"
        fi
        continue
    fi
    
    # 保留其他行
    cleaned_lines[cleaned_index]="$line"
    ((cleaned_index++))
done

# 写入输出文件
printf '%s\n' "${cleaned_lines[@]}" > "$output_file"

echo "处理完成，输出到: $output_file"
echo "原始行数: ${#lines[@]}, 处理后行数: ${#cleaned_lines[@]}" 