import re
import sys

def tokenize(expression):
    tokens = re.findall(r'\(|\)|[^\s()]+', expression)
    return tokens

def parse_expression(tokens):
    stack = []
    while tokens:
        token = tokens.pop(0)
        if token == '(':
            sub_expr = parse_expression(tokens)
            stack.append(sub_expr)
        elif token == ')':
            return stack
        else:
            stack.append(token)
    return stack

def merge_operations(expr):
    if isinstance(expr, list) and len(expr) > 0:
        head = expr[0]
        if isinstance(head, str) and head in {"re.++", "re.union"}:
            merged = [head]
            for sub_expr in expr[1:]:
                if isinstance(sub_expr, list) and sub_expr[0] == head:
                    merged.extend(sub_expr[1:])
                else:
                    merged.append(merge_operations(sub_expr))
            return merged
        elif isinstance(head, str) and head == "let":
            merged_bindings = expr[1]
            body = expr[2]
            while isinstance(body, list) and body[0] == "let":
                merged_bindings.extend(body[1])
                body = body[2]
            return ["let", merged_bindings, merge_operations(body)]
        else:
            return [merge_operations(sub_expr) for sub_expr in expr]
    return expr

def to_smt2(expr, indent=0):
    space = '    ' * indent
    if isinstance(expr, str):
        return expr
    elif isinstance(expr, list):
        head = expr[0]
        if isinstance(head, str):
            if head == "let":
                binding_exprs = ' '.join([f'({to_smt2(b[0], 0)} {to_smt2(b[1], indent + 2)})' for b in expr[1]])
                body_expr = to_smt2(expr[2], indent + 1)
                return f'(let ({binding_exprs})\n{space}    {body_expr}\n{space})'
            elif head == "str.in_re":
                return f'({head}\n{space}    {to_smt2(expr[1], indent + 1)}\n{space}    {to_smt2(expr[2], indent + 1)}\n{space})'
            elif head in {"str.++", "re.++"}:
                sub_exprs = '\n'.join([f'{space}    {to_smt2(e, indent + 1)}' for e in expr[1:]])
                return f'({head}\n{sub_exprs}\n{space})'
            elif head in {"re.*", "re.+"}:
                return f'({head} {to_smt2(expr[1], indent)})'
            elif head == "re.union":
                sub_exprs = '\n'.join([f'{space}    {to_smt2(e, indent + 1)}' for e in expr[1:]])
                return f'({head}\n{sub_exprs}\n{space})'
            elif head == "assert":
                return f'({head} {to_smt2(expr[1], 0)})'
            elif head == "re.range":
                return f'({head} {to_smt2(expr[1], 0)} {to_smt2(expr[2], 0)})'
            else:
                sub_exprs = ' '.join([to_smt2(e, indent) for e in expr])
                return f'({sub_exprs})'
        elif isinstance(head, list):
            return to_smt2(head, indent)
    else:
        return str(expr)

def process_line(line):
    try:
        line = line.strip()
        # 只处理开头和结尾都有括号的行
        if line.startswith('(') and line.endswith(')'):
            tokens = tokenize(line)
            parsed_expr = parse_expression(tokens)
            merged_expr = merge_operations(parsed_expr)
            smt2_expr = to_smt2(merged_expr)
            return smt2_expr
        else:
            return line
    except Exception as e:
        # print(f"Error processing line: {line}")
        # print(f"Exception: {e}")
        return line

def main(input_file, output_file):
    try:
        with open(input_file, 'r') as infile:
            lines = infile.readlines()

        processed_lines = [process_line(line) for line in lines]

        with open(output_file, 'w') as outfile:
            for line in processed_lines:
                outfile.write(line + '\n')
    except Exception as e:
        print(f"Error processing file: {input_file}")
        print(f"Exception: {e}")

if __name__ == "__main__":
    if len(sys.argv) not in [2, 3]:
        print("Usage: python script.py <input_file> [output_file]")
        sys.exit(1)

    input_file = sys.argv[1]

    # 如果只提供一个参数，则输入文件和输出文件相同
    if len(sys.argv) == 2:
        output_file = input_file
    else:
        output_file = sys.argv[2]

    main(input_file, output_file)
