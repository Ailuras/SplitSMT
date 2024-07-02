def format_smt(smt_string):
    indent_level = 0
    result = []
    buffer = ""
    skip_newline = False

    for char in smt_string:
        if char == '(':
            if buffer.strip():
                result.append(buffer)
                buffer = ""
            if skip_newline:
                result.append(char)
                skip_newline = False
            else:
                result.append('\n' + '    ' * indent_level + char)
            indent_level += 1
        elif char == ')':
            if buffer.strip():
                result.append(buffer)
                buffer = ""
            indent_level -= 1
            result.append('\n' + '    ' * indent_level + char)
            skip_newline = False
        else:
            buffer += char
            # 如果遇到=等情况，不要进行换行处理
            if buffer.strip().startswith('=') or buffer.strip().startswith('str.in_re') or buffer.strip().startswith('not'):
                continue
            # 遇到空格表示一个完整的部分，可以加入结果中
            if char == ' ' and buffer.strip():
                result.append(buffer)
                buffer = ""
                skip_newline = True

    if buffer.strip():
        result.append(buffer)

    # 将结果合并为一个字符串，并去掉最前面和最后面的多余空行
    formatted_smt = ''.join(result).strip()
    
    # 处理多余的换行
    formatted_smt = '\n'.join(line for line in formatted_smt.split('\n') if line.strip() != '')
    
    return formatted_smt

# 示例SMT句子
smt_example_1 = '(let ((_let_1 (str.to_re "c"))) (let ((_let_2 (str.to_re "b"))) (let ((_let_3 (str.to_re "a"))) (let ((_let_4 (re.* (re.union _let_3 _let_2 _let_1)))) (let ((_let_5 (str.to_re "z"))) (not (str.in_re (str.++ "z" var_4) (re.++ (re.* (re.++ (re.union _let_5 _let_3 _let_1) _let_4 _let_5)) (re.union _let_5 _let_3 _let_2) _let_4))))))))'
smt_example_2 = '(let ((_let_1 (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c")))) (or (= var_4 "") (str.in_re var_4 _let_1) (and (and (= var_4 (str.++ @RE_UNFOLD_POS_COMPONENT_7 @RE_UNFOLD_POS_COMPONENT_8 @RE_UNFOLD_POS_COMPONENT_9)) (str.in_re @RE_UNFOLD_POS_COMPONENT_7 _let_1) (str.in_re @RE_UNFOLD_POS_COMPONENT_8 (re.* _let_1)) (str.in_re @RE_UNFOLD_POS_COMPONENT_9 _let_1)) (not (= @RE_UNFOLD_POS_COMPONENT_7 "")) (not (= @RE_UNFOLD_POS_COMPONENT_9 ""))))'

# 格式化后的结果
formatted_smt_1 = format_smt(smt_example_1)
formatted_smt_2 = format_smt(smt_example_2)

print(formatted_smt_1)
print("\n" + "="*40 + "\n")
print(formatted_smt_2)
