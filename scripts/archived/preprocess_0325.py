import re
import sys
import logging
import argparse
from colorama import Fore, Back, Style, init
from collections import deque
import math
from functools import reduce

def setup_logger(level=20):
    logging.basicConfig(
        level=level,
        format='%(asctime)s - %(levelname)s - %(message)s',
        force=True
    )
    logging.addLevelName(11, "DEBUG1")
    logging.addLevelName(12, "DEBUG2")
    logging.addLevelName(13, "DEBUG3")
    logging.addLevelName(14, "DEBUG4")
    logging.addLevelName(15, "DEBUG5")
    def debug1(self, message, *args, **kwargs):
        if self.isEnabledFor(11):
            colored_message = f"{Back.RED}{message}{Style.RESET_ALL}"
            self._log(11, colored_message, args, **kwargs)
    def debug2(self, message, *args, **kwargs):
        if self.isEnabledFor(12):
            colored_message = f"{Back.BLUE}{message}{Style.RESET_ALL}"
            self._log(12, colored_message, args, **kwargs)
    def debug3(self, message, *args, **kwargs):
        if self.isEnabledFor(13):
            colored_message = f"{Back.CYAN}{message}{Style.RESET_ALL}"
            self._log(13, colored_message, args, **kwargs)
    def debug4(self, message, *args, **kwargs):
        if self.isEnabledFor(14):
            colored_message = f"{Back.GREEN}{message}{Style.RESET_ALL}"
            self._log(14, colored_message, args, **kwargs)
    def debug5(self, message, *args, **kwargs):
        if self.isEnabledFor(15):
            colored_message = f"{Back.YELLOW}{message}{Style.RESET_ALL}"
            self._log(15, colored_message, args, **kwargs)
    logging.Logger.debug1 = debug1
    logging.Logger.debug2 = debug2
    logging.Logger.debug3 = debug3
    logging.Logger.debug4 = debug4
    logging.Logger.debug5 = debug5
    def colored_log(level, color, msg, *args, **kwargs):
        colored_msg = f"{color}{msg}{Style.RESET_ALL}"
        logging.log(level, colored_msg, *args, **kwargs)
    setattr(logging, 'debug1', lambda msg, *args, **kwargs: colored_log(11, Back.RED, msg, *args, **kwargs))
    setattr(logging, 'debug2', lambda msg, *args, **kwargs: colored_log(12, Back.BLUE, msg, *args, **kwargs))
    setattr(logging, 'debug3', lambda msg, *args, **kwargs: colored_log(13, Back.CYAN, msg, *args, **kwargs))
    setattr(logging, 'debug4', lambda msg, *args, **kwargs: colored_log(14, Back.GREEN, msg, *args, **kwargs))
    setattr(logging, 'debug5', lambda msg, *args, **kwargs: colored_log(15, Back.YELLOW, msg, *args, **kwargs))
    init()

class Parser:
    tree_format = False

    @staticmethod
    def set_tree_format(tree):
        Parser.tree_format = tree

    @staticmethod
    def tokenize(expr):
        if isinstance(expr, str):
            return re.findall(r'\(|\)|[^\s()]+', expr)
        return expr
    
    @staticmethod
    def parse_expression(tokens):
        expr_stack = []
        tokens = deque(tokens)
        while tokens:
            t = tokens.popleft()
            if t == '(':
                expr_stack.append([])
            elif t == ')':
                sub_expr = expr_stack.pop()
                if expr_stack:
                    expr_stack[-1].append(sub_expr)
                else:
                    return sub_expr
            else:
                if expr_stack:
                    expr_stack[-1].append(t)
        return expr_stack[0] if expr_stack else None

    @staticmethod
    def classify_line(line):
        if not line:
            return 'empty'
        if line.startswith(';'):
            return 'comment'
        if line.startswith('(set-logic'):
            return 'logic'
        if line.startswith('(check-sat'):
            return 'check_sat'
        if line.startswith('(exit'):
            return 'exit'
        if line.startswith(('(declare-fun', '(define-fun')):
            return 'declare'
        if line.startswith('(assert'):
            return 'assert'
        return 'info'

    @staticmethod
    def classify_type(expr):
        if isinstance(expr, list):
            if not expr:
                return 'default'
            head = expr[0]
            if head == 'assert' and len(expr) == 2:
                return 'assert'
            if head == 'declare-fun' and len(expr) == 4:
                return 'declare'
            if head == 'not' and len(expr) == 2:
                return 'not'
            if head == 'let' and len(expr) == 3:
                return 'let'
            if head == 'str.in_re' and len(expr) == 3:
                return 're_in'
            if head == 'str.++' and len(expr) > 1:
                return 'str_cat'
            if head == 're.++' and len(expr) > 1:
                return 're_cat'
            if head == 're.union' and len(expr) > 1:
                return 're_union'
            if head == 're.range' and len(expr) == 3:
                return 're_range'
            if head == 're.*' and len(expr) == 2:
                return 're_star'
            if head == 're.+' and len(expr) == 2:
                return 're_plus'
            if head == 're.in':
                return 're_in'
            if head == 'and' and len(expr) > 1:
                return 'and'
            if head == 'or' and len(expr) > 1:
                return 'or'
            if head == '=' and len(expr) == 3:
                return 'eq'
            if head == '<' and len(expr) == 3:
                return 'lt'
            if head == '>' and len(expr) == 3:
                return 'gt'
            if head == '<=' and len(expr) == 3:
                return 'le'
            if head == '>=' and len(expr) == 3:
                return 'ge'
            return 'default'
        if isinstance(expr, str):
            if expr == "":
                return None
            if expr.startswith('"'):
                return 'const'
            if expr.startswith('x'):
                return 'var'
            return 'str'
        return None

    @staticmethod
    def simplify_expr(expr):
        def split_string_constants(expr):
            if not isinstance(expr, list) or not expr:
                if isinstance(expr, str) and expr.startswith('"') and len(expr) > 2:
                    content = expr[1:-1]
                    if len(content) > 1:
                        chars = [f'"{c}"' for c in content]
                        return ['str.++'] + chars
                return expr
            h = expr[0]
            if h == 'str.to_re':
                if len(expr) == 2:
                    if isinstance(expr[1], str) and expr[1].startswith('"') and len(expr[1]) > 2:
                        content = expr[1][1:-1]
                        if len(content) > 1:
                            char_to_re = [['str.to_re', f'"{c}"'] for c in content]
                            return ['re.++'] + char_to_re
                        return expr
                    inner = split_string_constants(expr[1])
                    if isinstance(inner, list) and inner and inner[0] == 'str.++':
                        char_to_re = [['str.to_re', part] for part in inner[1:]]
                        return ['re.++'] + char_to_re
                return [h, split_string_constants(expr[1])]
            return [h] + [split_string_constants(e) for e in expr[1:]]
        
        def clear_re_nesting(expr):
            if not isinstance(expr, list) or not expr:
                return expr
            h = expr[0]
            if h in ['re.++', 're.union', 'str.++']:
                merged = [h]
                for sub in expr[1:]:
                    simplified = clear_re_nesting(sub)
                    if isinstance(simplified, list) and simplified and simplified[0] == h:
                        merged.extend(simplified[1:])
                    else:
                        merged.append(simplified)
                if h == 're.union':
                    result = merged
                    for i in range(1, len(merged)):
                        if isinstance(merged[i], list) and merged[i] and merged[i][0] == 're.++':
                            re_cat = merged[i]
                            for j in range(len(re_cat) - 1, 0, -1):
                                if isinstance(re_cat[j], list) and re_cat[j] and re_cat[j][0] == 're.union':
                                    union_parts = re_cat[j][1:]
                                    new_cats = []
                                    for part in union_parts:
                                        new_cat = re_cat[1:j] + [part] + re_cat[j+1:]
                                        if len(new_cat) > 1:
                                            new_cats.append(['re.++'] + new_cat)
                                        else:
                                            new_cats.append(new_cat[0])
                                    result = ['re.union']
                                    for item in merged[1:i]:
                                        result.append(item)
                                    result.extend(new_cats)
                                    for item in merged[i+1:]:
                                        result.append(item)
                                    return clear_re_nesting(result)
                    return result
                return merged
            elif h in ['re.*', 're.+']:
                body = clear_re_nesting(expr[1])
                if isinstance(body, list) and body and body[0] == 're.union':
                    for i in range(1, len(body)):
                        if isinstance(body[i], list) and body[i] and body[i][0] == 're.++':
                            re_cat = body[i]
                            for j in range(len(re_cat) - 1, 0, -1):
                                if isinstance(re_cat[j], list) and re_cat[j] and re_cat[j][0] == 're.union':
                                    union_parts = re_cat[j][1:]
                                    new_cats = []
                                    for part in union_parts:
                                        new_cat = re_cat[1:j] + [part] + re_cat[j+1:]
                                        if len(new_cat) > 1:
                                            new_cats.append(['re.++'] + new_cat)
                                        else:
                                            new_cats.append(new_cat[0])
                                    new_union = ['re.union']
                                    for item in body[1:i]:
                                        new_union.append(item)
                                    new_union.extend(new_cats)
                                    for item in body[i+1:]:
                                        new_union.append(item)
                                    return [h, clear_re_nesting(new_union)]
                return [h, body]
            return [h] + [clear_re_nesting(e) for e in expr[1:]]
            
        def deploy_union_in_kleene(expr):
            if not isinstance(expr, list) or not expr:
                return expr
            if isinstance(expr, str):
                return expr
            op = expr[0]
            if op == 'str.to_re':
                return expr
            elif op == 're.range':
                return expr
            elif op == 're.union':
                result = []
                for sub_expr in expr[1:]:
                    sub_result = deploy_union_in_kleene(sub_expr)
                    if isinstance(sub_result, list) and sub_result and sub_result[0] == 're.union':
                        result.extend(sub_result[1:])
                    else:
                        result.append(sub_result)
                if not result:
                    return ['str.to_re', '""']
                if len(result) == 1:
                    return result[0]
                return ['re.union'] + result
            elif op == 're.++':
                parts = []
                for part in expr[1:]:
                    sub_result = deploy_union_in_kleene(part)
                    if isinstance(sub_result, list) and sub_result and sub_result[0] == 're.union':
                        parts.append(sub_result[1:])
                    else:
                        parts.append([sub_result])
                if not parts:
                    return ['str.to_re', '""']
                result = cartesian_product_concat(parts)
                if len(result) == 1:
                    return result[0]
                return ['re.union'] + result
            elif op in ['re.*', 're.+']:
                inner = deploy_union_in_kleene(expr[1])
                return [op, inner]
            return [op] + [deploy_union_in_kleene(e) for e in expr[1:]]

        def cartesian_product_concat(parts_list):
            if not parts_list:
                return [['str.to_re', '""']]
            def recursive_concat(index, current_concat):
                if index == len(parts_list):
                    if len(current_concat) == 0:
                        return [['str.to_re', '""']]
                    elif len(current_concat) == 1:
                        return [current_concat[0]]
                    else:
                        return [['re.++'] + current_concat]
                result = []
                for part in parts_list[index]:
                    new_concat = current_concat.copy()
                    if part != ['str.to_re', '""']:
                        if isinstance(part, list) and part and part[0] == 're.++':
                            new_concat.extend(part[1:])
                        else:
                            new_concat.append(part)
                    result.extend(recursive_concat(index + 1, new_concat))
                return result
            return recursive_concat(0, [])
        
        expr = split_string_constants(expr)
        expr = clear_re_nesting(expr)
        expr = deploy_union_in_kleene(expr)
        return expr

    @staticmethod
    def to_smt2(expr, indent=0):
        if expr is None:
            return None
        expr_type = Parser.classify_type(expr)
        if not expr_type:
            return None
        if expr_type in ('const', 'var', 'str'):
            return expr
        
        # If not in tree format, return single line
        if not Parser.tree_format:
            if expr_type == 'assert':
                inner = Parser.to_smt2(expr[1], 0)
                return f'(assert {inner})' if inner else None
            elif expr_type == 'not':
                inner = Parser.to_smt2(expr[1], 0)
                return f'(not {inner})' if inner else None
            elif expr_type == 'let':
                bindings = ' '.join([f'({Parser.to_smt2(x[0], 0)} {Parser.to_smt2(x[1], 0)})' for x in expr[1]])
                body = Parser.to_smt2(expr[2], 0)
                return f'(let ({bindings}) {body})'
            elif expr_type == 're_in':
                str_expr = Parser.to_smt2(expr[1], 0)
                re_expr = Parser.to_smt2(expr[2], 0)
                return f'(str.in_re {str_expr} {re_expr})'
            elif expr_type == 're_range':
                return f'(re.range {Parser.to_smt2(expr[1], 0)} {Parser.to_smt2(expr[2], 0)})'
            elif expr_type in ('re_star', 're_plus'):
                return f'({expr[0]} {Parser.to_smt2(expr[1], 0)})'
            elif expr_type in ('re_union', 'str_cat', 're_cat'):
                op = 're.union' if expr_type == 're_union' else expr[0]
                parts = [Parser.to_smt2(e, 0) for e in expr[1:]]
                return f'({op} {" ".join(parts)})'
            if isinstance(expr, list) and len(expr) > 0:
                op = expr[0]
                if op in ('and', 'or'):
                    parts = [Parser.to_smt2(e, 0) for e in expr[1:]]
                    return f'({op} {" ".join(parts)})'
                elif op in ('=', '>=', '<=', '>', '<', '+', '-', '*', '/'):
                    parts = [Parser.to_smt2(e, 0) for e in expr[1:]]
                    return f'({op} {" ".join(parts)})'
                elif op == 'str.len':
                    arg = Parser.to_smt2(expr[1], 0) if len(expr) > 1 else ""
                    return f'(str.len {arg})'
                elif op == 'declare-fun':
                    if len(expr) >= 4:
                        name = expr[1]
                        params = expr[2]
                        ret_type = expr[3]
                        params_str = " ".join([Parser.to_smt2(p, 0) for p in params])
                        return f'(declare-fun {name} ({params_str}) {ret_type})'
            parts = [Parser.to_smt2(e, 0) for e in expr]
            return f'({" ".join(parts)})'

        # Tree format output (existing code)
        indent_str = '    ' * indent
        indent_next_str = '    ' * (indent + 1)
        if expr_type == 'assert':
            res = Parser.to_smt2(expr[1], indent + 1)
            if not res:
                return None
            return f'(assert {Parser.to_smt2(expr[1], indent)})' if Parser.classify_type(expr[1]) == 'not' else f'(assert\n{indent_next_str}{res}\n{indent_str})'
        elif expr_type == 'not':
            inner_expr = Parser.to_smt2(expr[1], indent + 1)
            return None if not inner_expr else f'(not\n{indent_next_str}{inner_expr}\n{indent_str})'
        elif expr_type == 'let':
            bindings = ' '.join([f'({Parser.to_smt2(x[0], 0)} {Parser.to_smt2(x[1], indent + 2)})' for x in expr[1]])
            body = Parser.to_smt2(expr[2], indent + 1)
            return f'(let ({bindings})\n{indent_next_str}{body}\n{indent_str})'
        elif expr_type == 're_in':
            str_expr = Parser.to_smt2(expr[1], indent + 1)
            re_expr = Parser.to_smt2(expr[2], indent + 1)
            return f'(str.in_re\n{indent_next_str}{str_expr}\n{indent_next_str}{re_expr}\n{indent_str})'
        elif expr_type == 're_range':
            return f'(re.range {Parser.to_smt2(expr[1], 0)} {Parser.to_smt2(expr[2], 0)})'
        elif expr_type in ('re_star', 're_plus'):
            return f'({expr[0]} {Parser.to_smt2(expr[1], indent)})'
        elif expr_type in ('re_union', 'str_cat', 're_cat'):
            op = 're.union' if expr_type == 're_union' else expr[0]
            parts = [f'{indent_next_str}{Parser.to_smt2(e, indent + 1)}' for e in expr[1:]]
            return f'({op}\n{chr(10).join(parts)}\n{indent_str})'
        if isinstance(expr, list) and len(expr) > 0:
            op = expr[0]
            if op in ('and', 'or'):
                parts = [f'{indent_next_str}{Parser.to_smt2(e, indent + 1)}' for e in expr[1:]]
                return f'({op}\n{chr(10).join(parts)}\n{indent_str})'
            elif op in ('=', '>=', '<=', '>', '<'):
                parts = [Parser.to_smt2(e, indent) for e in expr[1:]]
                return f'({op} {" ".join(parts)})'
            elif op in ('+', '-', '*', '/'):
                parts = [Parser.to_smt2(e, indent) for e in expr[1:]]
                return f'({op} {" ".join(parts)})'
            elif op == 'str.len':
                arg = Parser.to_smt2(expr[1], indent) if len(expr) > 1 else ""
                return f'(str.len {arg})'
            elif op == 'declare-fun':
                if len(expr) >= 4:
                    name = expr[1]
                    params = expr[2]
                    ret_type = expr[3]
                    params_str = " ".join([Parser.to_smt2(p, indent) for p in params])
                    return f'(declare-fun {name} ({params_str}) {ret_type})'
        parts = [Parser.to_smt2(e, indent) for e in expr]
        return f'({" ".join(parts)})'

    @staticmethod
    def to_str(expr):
        def needs_brackets(expr, parent_op=None):
            if not isinstance(expr, list) or not expr:
                return False
            op = expr[0]
            if parent_op == 're.++' and op in ['re.union', 're.*', 're.+']:
                return True
            if parent_op == 're.*' and op in ['re.++', 're.union']:
                return True
            if parent_op == 're.union' and op == 're.++':
                return True
            if parent_op in ['and', 'or'] and op in ['and', 'or'] and parent_op != op:
                return True
            return False
        
        def needs_logical_brackets(expr, parent_op=None):
            if not isinstance(expr, list) or not expr:
                return False
            op = expr[0]
            if parent_op == 'and' and op == 'or':
                return True
            if parent_op == 'or' and op == 'and':
                return True
            return False
        
        def process_expr(expr, parent_op=None):
            if not isinstance(expr, list):
                if isinstance(expr, str) and expr.startswith('"'):
                    val = expr[1:-1]
                    return f'"{val}"'
                return expr
            if not expr:
                return '""'
            
            op = expr[0]
            if op == 'not':
                inner = expr[1]
                if isinstance(inner, list) and inner[0] == 'str.in_re':
                    var = process_expr(inner[1], op)
                    regex = process_expr(inner[2], op)
                    return f"{var} not in {regex}"
                return f"not {process_expr(inner, op)}"
            if op == 'str.++':
                result = ' + '.join(process_expr(e, op) for e in expr[1:])
                return f"[{result}]" if needs_brackets(expr, parent_op) else result
            if op == 'str.in_re':
                return f"{process_expr(expr[1], op)} in {process_expr(expr[2], op)}"
            if op == 're.++':
                parts = [process_expr(e, op) for e in expr[1:]]
                result = ' + '.join(parts)
                return f"[{result}]" if needs_brackets(expr, parent_op) else result
            if op == 're.union':
                parts = [process_expr(e, op) for e in expr[1:]]
                if not parts:
                    return '[""]'
                result = ' | '.join(parts)
                return f"[{result}]"
            if op == 're.*':
                inner = process_expr(expr[1], op)
                if inner.startswith('[') and inner.endswith(']'):
                    return f"{inner}*"
                return f"[{inner}]*"
            if op == 're.+':
                inner = process_expr(expr[1], op)
                if inner.startswith('[') and inner.endswith(']'):
                    return f"{inner}+"
                return f"[{inner}]+"
            if op == 're.range':
                start = expr[1][1:-1]
                end = expr[2][1:-1]
                return f"[{start}-{end}]"
            if op == 'str.to_re':
                if len(expr) > 1:
                    val = process_expr(expr[1], op)
                    return val
                return '""'
            if op == 'and':
                parts = [process_expr(e, op) for e in expr[1:]]
                result = ' and '.join(parts)
                if needs_logical_brackets(expr, parent_op):
                    return f"({result})"
                return result
            if op == 'or':
                parts = [process_expr(e, op) for e in expr[1:]]
                result = ' or '.join(parts)
                if needs_logical_brackets(expr, parent_op):
                    return f"({result})"
                return result
            if op == '=':
                left = process_expr(expr[1], op)
                right = process_expr(expr[2], op)
                return f"{left} = {right}"
            if op == '>=':
                left = process_expr(expr[1], op)
                right = process_expr(expr[2], op)
                return f"{left} >= {right}"
            if op == '<=':
                left = process_expr(expr[1], op)
                right = process_expr(expr[2], op)
                return f"{left} <= {right}"
            if op == '>':
                left = process_expr(expr[1], op)
                right = process_expr(expr[2], op)
                return f"{left} > {right}"
            if op == '<':
                left = process_expr(expr[1], op)
                right = process_expr(expr[2], op)
                return f"{left} < {right}"
            if op == '+':
                parts = [process_expr(e, op) for e in expr[1:]]
                return ' + '.join(parts)
            if op == '-':
                parts = [process_expr(e, op) for e in expr[1:]]
                return ' - '.join(parts)
            if op == '*':
                parts = [process_expr(e, op) for e in expr[1:]]
                return ' * '.join(parts)
            if op == '/':
                parts = [process_expr(e, op) for e in expr[1:]]
                return ' / '.join(parts)
            if op == 'mod':
                if len(expr) >= 3:
                    left = process_expr(expr[1], op)
                    right = process_expr(expr[2], op)
                    if isinstance(expr[1], list):
                        return f"({left}) mod {right}"
                    return f"{left} mod {right}"
            if op == 'str.len':
                if len(expr) > 1:
                    return f"len({process_expr(expr[1], op)})"
                return "len()"
            return str(expr)
        
        if isinstance(expr, list) and len(expr) >= 3 and expr[0] == 'str.in_re':
            left = process_expr(expr[1])
            right = process_expr(expr[2])
            return f"{left} in {right}"
        else:
            return process_expr(expr)

    @staticmethod
    def to_pyre(expr):
        import re
        if not isinstance(expr, list):
            if isinstance(expr, str) and expr.startswith('"'):
                return re.escape(expr[1:-1])
            return None
        if not expr:
            return None
        op = expr[0]
        if op == 'str.to_re':
            if len(expr) < 2:
                return None
            if isinstance(expr[1], str) and expr[1].startswith('"'):
                return re.escape(expr[1][1:-1])
            return None
        elif op == 're.++':
            parts = []
            for e in expr[1:]:
                part = Parser.to_pyre(e)
                if part is None:
                    return None
                parts.append(part)
            result = ''.join(parts)
            return result
        elif op == 're.union':
            parts = []
            for e in expr[1:]:
                part = Parser.to_pyre(e)
                if part is None:
                    return None
                parts.append(part)
            if not parts:
                return ''
            result = '|'.join(['(?:' + p + ')' for p in parts])
            return result
        elif op == 're.*':
            if len(expr) < 2:
                return None
            inner = Parser.to_pyre(expr[1])
            if inner is None:
                return None
            return '(?:' + inner + ')*'
        elif op == 're.+':
            if len(expr) < 2:
                return None
            inner = Parser.to_pyre(expr[1])
            if inner is None:
                return None
            return '(?:' + inner + ')+'
        elif op == 're.range':
            if len(expr) < 3:
                return None
            start, end = None, None
            if isinstance(expr[1], str):
                if expr[1].startswith('"'):
                    start = expr[1][1:-1]
                else:
                    try:
                        start = str(int(expr[1]))
                    except:
                        return None
            if isinstance(expr[2], str):
                if expr[2].startswith('"'):
                    end = expr[2][1:-1]
                else:
                    try:
                        end = str(int(expr[2]))
                    except:
                        return None
            if start is None or end is None:
                return None
            if len(start) != 1 or len(end) != 1:
                return None
            return '[' + re.escape(start) + '-' + re.escape(end) + ']'
        elif op == 're.opt':
            if len(expr) < 2:
                return None
            inner = Parser.to_pyre(expr[1])
            if inner is None:
                return None
            return '(?:' + inner + ')?'
        elif op == 're.allchar':
            return '.'
        elif op == 're.none':
            return '$^'
        elif op == 're.all':
            return '.*'
        return None

class SMTVar:
    def __init__(self, index, var, var_type, name = None):
        self.index = index
        self.name = f"x{index}" if name is None else name
        self.var = var
        self.type = var_type
        self.used = False
        self.allow = set(chr(c) for c in range(32, 127))
        self.original_line = None

    def __eq__(self, other):
        if not isinstance(other, SMTVar):
            return False
        return self.index == other.index
        
    def __hash__(self):
        return hash(self.index)
    
    def get_smt2(self):
        if not self.used:
            return None
        expr = ['declare-fun', self.name, [], self.type]
        return Parser.to_smt2(expr)
    
    def get_comment(self):
        return f"Var({self.index})"
    
    def __str__(self):
        return f"{self.name}: {self.type}"

class SMTClause:
    def __init__(self, index, expr, expr_type):
        self.index = index
        self.expr_tree = expr
        self.type = expr_type
        self.original_line = None
    
    def get_smt2(self):
        if self.expr_tree:
            expr = self.expr_tree.get_expr()
            if expr:
                return Parser.to_smt2(['assert', expr])
        return None
    
    def get_comment(self):
        return f"Clause({self.index}): {self.expr_tree.get_comment() if self.expr_tree else 'None'}"

    def __eq__(self, other):
        if not isinstance(other, SMTClause):
            return False
        return self.index == other.index
    
    def __hash__(self):
        return hash(self.index)
    
    def __str__(self):
        if self.expr_tree:
            expr = self.expr_tree.get_expr()
            if expr:
                return f"; {Parser.to_str(expr)}"
        return f"; Empty clause({self.index})"

class ExpressionTree:
    def __init__(self, op, elements):
        self.op = op
        self.elements = elements
        self.info_manager = None
    
    def get_comment(self):
        if self.op == 'not':
            return f"(not {self.elements[0].get_comment()})"
        elif self.op == 'leaf':
            return f"Leaf({self.elements[0]})"
        return f"({self.op} {' '.join([e.get_comment() for e in self.elements])})"
    
    def get_expr(self):
        if self.op == 'not':
            if not self.elements:
                return None
            inner_expr = self.elements[0].get_expr()
            if inner_expr:
                return ['not', inner_expr]
        elif self.op == 'leaf':
            if not self.elements:
                return None
            return self.get_lit_expr(self.elements[0])
        elif self.op in ['and', 'or']:
            if not self.elements:
                return None
            result = [self.op]
            for element in self.elements:
                inner_expr = element.get_expr()
                if inner_expr:
                    result.append(inner_expr)
            if len(result) == 1:
                return None
            return result
        return None
    
    def get_lit_expr(self, lit_index):
        if hasattr(self, 'info_manager') and self.info_manager:
            if 0 <= lit_index < len(self.info_manager.literals):
                lit = self.info_manager.literals[lit_index]
                if lit:
                    return lit.get_expr()
        return None
    
    def get_all_leaf_indices(self):
        leaf_indices = set()
        if self.op == 'not':
            if self.elements:
                leaf_indices.update(self.elements[0].get_all_leaf_indices())
        elif self.op == 'leaf':
            if self.elements:
                leaf_indices.add(self.elements[0])
        elif self.op in ['and', 'or']:
            for element in self.elements:
                leaf_indices.update(element.get_all_leaf_indices())
        return leaf_indices
    
    @staticmethod
    def OR(elements):
        if not elements:
            return None
        children = []
        for element in elements:
            if isinstance(element, ExpressionTree):
                children.append(element)
            else:
                children.append(ExpressionTree.LEAF(element))
        if len(children) == 1:
            return children[0]
        return ExpressionTree('or', children)
    
    @staticmethod
    def AND(elements):
        if not elements:
            return None
        children = []
        for element in elements:
            if isinstance(element, ExpressionTree):
                children.append(element)
            else:
                children.append(ExpressionTree.LEAF(element))
        if len(children) == 1:
            return children[0]
        return ExpressionTree('and', children)
    
    @staticmethod
    def NOT(expr):
        if expr is None:
            return None
        if not isinstance(expr, ExpressionTree):
            return ExpressionTree('not', [ExpressionTree.LEAF(expr)])
        return ExpressionTree('not', [expr])
    
    @staticmethod
    def LEAF(lit_index):
        return ExpressionTree('leaf', [lit_index])
    
    def set_info_manager(self, info_manager):
        self.info_manager = info_manager
        for element in self.elements:
            if isinstance(element, ExpressionTree):
                element.set_info_manager(info_manager)
    
    def __str__(self):
        expr = self.get_expr()
        return Parser.to_str(expr)
    
    def __repr__(self):
        return str(self)

class SMTLemma:
    def __init__(self, expr, lemma_type, comment=None):
        self.expr_tree = None
        self.comment = comment
        self.index = None
        self.type = lemma_type
        if isinstance(expr, ExpressionTree):
            self.expr_tree = expr
    
    def get_smt2(self):
        if self.expr_tree:
            expr = self.expr_tree.get_expr()
            if expr:
                return Parser.to_smt2(['assert', expr])
        return None
    
    def get_comment(self):
        if self.comment:
            return f"; {self.comment}"
        if self.expr_tree:
            return self.expr_tree.get_comment()
        return f"Lemma({self.index})"
    
    def get_expr(self):
        if self.expr_tree:
            return self.expr_tree.get_expr()
        return None
    
    def get_lits_indices(self):
        if self.expr_tree:
            return self.expr_tree.get_all_leaf_indices()
        return set()
    
    def __eq__(self, other):
        if not isinstance(other, SMTLemma):
            return False
        return self.index == other.index
    
    def __hash__(self):
        return hash(self.index)
    
    def __str__(self):
        if self.expr_tree:
            expr = self.expr_tree.get_expr()
            if expr:
                return f"; {Parser.to_str(expr)}"
        return "None"
    
    def __repr__(self):
        return str(self)

class SMTLit:
    def __init__(self, expr):
        self.expr = expr
        self.type = self._determine_type()
        self.index = None
        self.lemma_indices = []
    
    def _determine_type(self):
        if isinstance(self.expr, str):
            if self.expr == 'true' or self.expr == 'false':
                return 'bool'
        if isinstance(self.expr, list):
            if len(self.expr) > 0:
                if self.expr[0] == 'str.in_re':
                    return 'string'
                elif self.expr[0] in ['=', '>=', '<=', '>', '<']:
                    return 'arith'
        return 'unknown'
    
    def add_lemma(self, lemma_index):
        if lemma_index not in self.lemma_indices:
            self.lemma_indices.append(lemma_index)
    
    def get_expr(self):
        return self.expr
    
    def get_tree(self):
        return ExpressionTree.LEAF(self.index) if self.index is not None else None
    
    def get_comment(self):
        return f"Lit({self.index})"
    
    def __eq__(self, other):
        if not isinstance(other, SMTLit):
            return False
        if self.index is not None and other.index is not None:
            return self.index == other.index
        return str(self.expr) == str(other.expr)
        
    def __hash__(self):
        if self.index is not None:
            return hash(self.index)
        return hash(str(self.expr))
    
    def __str__(self):
        return Parser.to_str(self.expr)
    
    def __repr__(self):
        return str(self)

class InfoManager:
    def __init__(self):
        self.preamble = []
        self.postamble = []
        self.var_counter = 0
        self.vars = []
        self.var_map = {}
        self.clause_counter = 0
        self.clauses = []
        self.tmp_var_counter = 0
        self.tmp_vars = []
        self.lemma_counter = 0
        self.lemmas = []
        self.literal_counter = 0
        self.literals = []
        self.add_literal(SMTLit('false'))
        self.add_literal(SMTLit('true'))

    def _process_declare(self, line):
        expr = Parser.parse_expression(Parser.tokenize(line))
        var = expr[1]
        type_info = expr[3]
        v = SMTVar(self.var_counter, var, type_info)
        v.original_line = line
        self.add_var(v)

    def _rename_var(self, expr):
        if not isinstance(expr, list):
            if isinstance(expr, str) and expr in self.var_map:
                index = self.var_map[expr]
                self.vars[index].used = True
                return self.vars[index].name
            return expr
        return [self._rename_var(e) for e in expr]

    def get_var(self, var):
        if var not in self.var_map:
            raise KeyError(f"Variable {var} not found in var_map")
        return self.vars[self.var_map[var]]

    def _get_expr_tree(self, expr):
        if not expr:
            return None
        if isinstance(expr, str):
            lit = SMTLit(expr)
            lit_index = self.add_literal(lit)
            return ExpressionTree('leaf', [lit_index])
        if not isinstance(expr, list):
            return None
        expr_type = Parser.classify_type(expr)
        if expr_type == 'not':
            inner_tree = self._get_expr_tree(expr[1])
            if inner_tree:
                return ExpressionTree('not', [inner_tree])
            return None
        if expr_type in ['and', 'or']:
            elements = []
            for e in expr[1:]:
                subtree = self._get_expr_tree(e)
                if subtree:
                    elements.append(subtree)
            if elements:
                return ExpressionTree(expr_type, elements)
            return None
        lit = SMTLit(expr)
        lit_index = self.add_literal(lit)
        return ExpressionTree('leaf', [lit_index])

    def _process_assert(self, line):
        expr = Parser.parse_expression(Parser.tokenize(line))
        expr = Parser.simplify_expr(expr)
        expr = self._rename_var(expr)
        if isinstance(expr, list) and len(expr) > 1 and isinstance(expr[1], list):
            clu_type = Parser.classify_type(expr[1]) if expr[1] else 'default'
        else:
            clu_type = 'default'
        expr_tree = self._get_expr_tree(expr[1])
        if expr_tree:
            expr_tree.set_info_manager(self)
        clause = SMTClause(self.clause_counter, expr_tree, clu_type)
        clause.original_line = line
        self.add_clause(clause)
        logging.debug4(f"Clause({self.clause_counter}): {clause.get_comment()}")

    def process_line(self, line):
        line = line.strip()
        line_type = Parser.classify_line(line)
        if line_type == 'empty' or line_type == 'comment':
            self.preamble.append(line)
        elif line_type == 'logic' or line_type == 'info':
            self.preamble.append(line)
        elif line_type == 'check_sat' or line_type == 'exit':
            self.postamble.append(line)
        elif line_type == 'declare':
            self._process_declare(line)
        elif line_type == 'assert':
            self._process_assert(line)
    
    def add_var(self, var):
        self.vars.append(var)
        self.var_map[var.var] = var.index
        self.var_counter += 1
    
    def add_clause(self, clause):
        self.clauses.append(clause)
        self.clause_counter += 1

    def add_lemma(self, lemma):
        lemma.index = self.lemma_counter
        self.lemmas.append(lemma)
        self.lemma_counter += 1
        return lemma.index
        
    def add_tmp_var(self, var):
        self.tmp_vars.append(var)
        self.tmp_var_counter += 1

    def add_literal(self, lit):
        lit.index = self.literal_counter
        self.literals.append(lit)
        self.literal_counter += 1
        return lit.index

    def find_literal(self, lit):
        for l in self.literals:
            if str(lit) == str(l):
                return l
        return None

    def reset_lemmas(self):
        self.lemma_counter = 0
        self.lemmas = []

    def update_info(self):
        self.var_map = {var.name: var.index for var in self.vars}
        for clause in self.clauses:
            if clause.type != 're_in' or not clause.expr_tree:
                continue
            expr = clause.expr_tree.get_expr()
            if not expr or len(expr) < 3 or expr[0] != 'str.in_re':
                continue
            vars_found = self._extract_vars(expr[1])
            chars_found = self._extract_chars(expr[2])
            for var_name in vars_found:
                var = self.get_var(var_name)
                var.allow = var.allow.intersection(chars_found)

    def _extract_vars(self, exp):
        vars_found = set()
        if isinstance(exp, str) and exp.startswith('x'):
            vars_found.add(exp)
        elif isinstance(exp, list):
            for e in exp:
                vars_found.update(self._extract_vars(e))
        return vars_found
    
    def _extract_chars(self, exp):
        chars = set()
        if isinstance(exp, str) and exp.startswith('"'):
            chars.update(exp[1:-1])
        elif isinstance(exp, list) and exp:
            op = exp[0]
            if op == 'not':
                return self._extract_chars(exp[1])
            elif len(exp) >= 3 and op == 're.range':
                start, end = exp[1][1:-1], exp[2][1:-1]
                chars.update(chr(c) for c in range(ord(start), ord(end) + 1))
            elif op in ['re.++', 're.union', 're.*', 're.+']:
                for e in exp[1:]:
                    chars.update(self._extract_chars(e))
            elif op == 'str.in_re' and len(exp) >= 3:
                chars.update(self._extract_chars(exp[2]))
            else:
                for e in exp:
                    chars.update(self._extract_chars(e))
        return chars

class RegexProcessor:
    def __init__(self, info):
        self.info_manager = info
    
    def get_variables(self, expr):
        vars_found = set()
        if isinstance(expr, str) and expr.startswith('x'):
            vars_found.add(expr)
        elif isinstance(expr, list):
            for e in expr:
                vars_found.update(self.get_variables(e))
        return vars_found
    
    def get_parikh_image(self, expr):
        if isinstance(expr, str):
            if expr.startswith('"') and len(expr) > 2:
                result = {}
                for char in expr[1:-1]:
                    result[char] = result.get(char, 0) + 1
                return result
            return {}
        constants = {}
        for e in expr:
            sub_constants = self.get_parikh_image(e)
            for char, count in sub_constants.items():
                constants[char] = constants.get(char, 0) + count
        return constants

    def is_direct_match(self, expr, constant):
        if isinstance(constant, str) and constant.startswith('"'):
            constant_value = constant[1:-1]
        else:
            constant_value = constant
        if not isinstance(expr, list):
            if isinstance(expr, str) and expr.startswith('"'):
                return expr[1:-1] == constant_value
            return expr == constant
        if expr and expr[0] == 'str.to_re' and len(expr) > 1:
            if isinstance(expr[1], str) and expr[1].startswith('"'):
                return expr[1][1:-1] == constant_value
            return expr[1] == constant
        return False

    def is_must_match(self, expr, constant):
        constant = constant[1:-1]
        if not isinstance(expr, list):
            if isinstance(expr, str) and expr.startswith('"'):
                return constant in expr
            return False
        if not expr:
            return False
        op = expr[0]
        if op == 'str.to_re':
            if len(expr) > 1 and isinstance(expr[1], str) and expr[1].startswith('"'):
                return constant in expr[1]
            return False
        if op in ['re.*', 're.+']:
            return False
        if op == 're.union':
            if len(expr) <= 1:
                return False
            return all(self.is_must_match(sub_expr, constant) for sub_expr in expr[1:])
        if op == 're.++':
            if len(expr) <= 1:
                return False
            return any(self.is_must_match(sub_expr, constant) for sub_expr in expr[1:])
        return False

    def is_constant_contain(self, expr, constant):
        if not expr:
            return False
        if self.is_direct_match(expr, constant):
            return True
        constant_value = constant[1:-1] if isinstance(constant, str) and constant.startswith('"') else constant
        if isinstance(expr, str) and expr.startswith('"'):
            return constant_value in expr[1:-1]
        op = expr[0]
        if op == 'str.to_re' and len(expr) > 1:
            if isinstance(expr[1], str) and expr[1].startswith('"'):
                return constant_value in expr[1][1:-1]
        if op == 're.range' and len(expr) > 2:
            if len(constant_value) == 1:
                range_start = expr[1][1:-1] if isinstance(expr[1], str) and expr[1].startswith('"') else expr[1]
                range_end = expr[2][1:-1] if isinstance(expr[2], str) and expr[2].startswith('"') else expr[2]
                return range_start <= constant_value <= range_end
            return False
        if op in ['re.*', 're.+'] and len(expr) > 1:
            return self.is_constant_contain(expr[1], constant)
        if op in ['re.++', 're.union']:
            for sub_expr in expr[1:]:
                if self.is_constant_contain(sub_expr, constant):
                    return True
        return False
    
    def get_index_first_unique_constant(self, expr):
        if not isinstance(expr, list):
            if isinstance(expr, str) and expr.startswith('"'):
                char = expr[1:-1]
                for var_name in self.get_variables(expr):
                    var = self.info_manager.get_var(var_name)
                    if var.allow is not None and char in var.allow:
                        return None
                return 0
            return None
        for i, e in enumerate(expr):
            if isinstance(e, str) and e.startswith('"'):
                char = e[1:-1]
                is_unique = True
                for var_name in self.get_variables(expr):
                    var = self.info_manager.get_var(var_name)
                    if var.allow is not None and char in var.allow:
                        is_unique = False
                        break
                if is_unique:
                    return i
        return None
    
    def get_index_constant_must_in_pattern(self, re_expr, constant):
        indices = self.get_index_constant_in_pattern(re_expr, constant)
        if not indices:
            return None
        if len(indices) == 1:
            return indices[0]
        must_contain_indices = []
        for i in indices:
            if self.is_must_match(re_expr[i], constant):
                must_contain_indices.append(i)
        if len(must_contain_indices) == 1:
            return must_contain_indices[0]
        return None
    
    def get_index_constant_in_pattern(self, re_expr, constant):
        if not isinstance(re_expr, list) or not re_expr:
            return None
        indices = []
        for i, sub_expr in enumerate(re_expr):
            if self.is_constant_contain(sub_expr, constant):
                indices.append(i)
        return indices
    
    def get_deploy_pattern(self, pattern, constant, mode='once'):
        if not isinstance(pattern, list):
            return None
        if not pattern:
            return None
        op = pattern[0]
        if op in ['str.to_re', 're.++']:
            result = self.filter_constant_in_pattern(pattern, constant, mode)
            if result:
                return [[], result, []]
            return None
        elif op == 're.union':
            filtered_elements = []
            for element in pattern[1:]:
                result = self.filter_constant_in_pattern(element, constant, mode)
                if result:
                    filtered_elements.append(result)
            if not filtered_elements:
                return None
            filtered_pattern = ['re.union'] + filtered_elements
            return [[], filtered_pattern, []]
        elif op == 're.range':
            if constant >= pattern[1] and constant <= pattern[2]:
                return [[], constant, []]
            return None
        elif op == 're.*':
            inner_result = self.get_deploy_pattern(pattern[1], constant, mode)
            if inner_result is None:
                return None
            return [pattern, inner_result[1], pattern]
        return None

    def filter_constant_in_pattern(self, pattern, constant, mode='once'):
        def remove_kleene_and_union(expr, constant):
            expr = expr[1] if expr[0] == 're.*' else expr
            if expr[0] == 're.union':
                filtered_elements = []
                for sub_expr in expr[1:]:
                    if isinstance(sub_expr, list) and self.is_constant_contain(sub_expr, constant):
                        filtered_elements.append(sub_expr)
                if len(filtered_elements) == 1:
                    return filtered_elements[0]
                if filtered_elements:
                    return ['re.union'] + filtered_elements
            return expr

        if self.is_direct_match(pattern, constant):
            return pattern
        pattern = pattern[1:] if pattern[0] == 're.++' else pattern
        new_pattern = []
        if mode == 'once':
            index = self.get_index_constant_must_in_pattern(pattern, constant)
            if index is None:
                return None
            indices = [i for i in self.get_index_constant_in_pattern(pattern, constant) if i != index]
            for i in range(len(pattern)):
                if i in indices:
                    continue
                elif i == index:
                    new_pattern.append(remove_kleene_and_union(pattern[i], constant))
                else:
                    new_pattern.append(pattern[i])
            return self.normalize_expr(new_pattern, is_regex=True)
        elif mode == 'first':
            indices = self.get_index_constant_in_pattern(pattern, constant)
            if indices is None:
                return None
            for index in indices:
                new_sub_pattern = []
                for i in range(len(pattern)):
                    if i < index and not self.can_be_empty(pattern[i]):
                        break
                    elif i == index:
                        new_sub_pattern.append(remove_kleene_and_union(pattern[i], constant))
                    else:
                        new_sub_pattern.append(pattern[i])
                if new_sub_pattern:
                    new_pattern.append(self.normalize_expr(new_sub_pattern, is_regex=True))
            if not new_pattern:
                return None
            if len(new_pattern) == 1:
                return new_pattern[0]
            return ['re.union'] + new_pattern
    
    def get_split_pattern(self, left_expr, right_expr, constant_index, constant_in_index):
        left_left = self.normalize_expr(left_expr[:constant_index])
        left_mid = left_expr[constant_index]
        left_right = self.normalize_expr(left_expr[constant_index+1:])
        right_left = right_expr[:constant_in_index]
        right_mid = right_expr[constant_in_index]
        right_right = right_expr[constant_in_index+1:]
        deploy_pattern = self.get_deploy_pattern(right_mid, left_mid, mode='once')
        if not deploy_pattern:
            return None
        left_sides, right_sides = self.extract_sides_from_pattern(deploy_pattern[1], left_mid)
        left_left_list = []
        left_right_list = []
        for left_side in left_sides:
            right_left_norm = self.normalize_expr(right_left + [deploy_pattern[0]] + [left_side], is_regex=True)
            left_left_list.append(['str.in_re', left_left, right_left_norm])
        for right_side in right_sides:
            right_right_norm = self.normalize_expr([right_side] + [deploy_pattern[2]] + right_right, is_regex=True)
            left_right_list.append(['str.in_re', left_right, right_right_norm])
        paired_list = list(zip(left_left_list, left_right_list))
        return paired_list

    def extract_sides_from_pattern(self, pattern, constant):
        if self.is_direct_match(pattern, constant):
            return [['str.to_re', '""']], [['str.to_re', '""']]
        if isinstance(pattern, list) and pattern and pattern[0] == 're.++':
            left_parts = []
            right_parts = []
            for i, part in enumerate(pattern[1:], 1):
                if self.is_direct_match(part, constant):
                    left_segment = pattern[1:i]
                    right_segment = pattern[i+1:] if i+1 < len(pattern) else []
                    if not left_segment:
                        left_parts.append(['str.to_re', '""'])
                    elif len(left_segment) == 1:
                        left_parts.append(left_segment[0])
                    else:
                        left_parts.append(['re.++'] + left_segment)
                    if not right_segment:
                        right_parts.append(['str.to_re', '""'])
                    elif len(right_segment) == 1:
                        right_parts.append(right_segment[0])
                    else:
                        right_parts.append(['re.++'] + right_segment)
                    break
            if left_parts and right_parts:
                return left_parts, right_parts
        if isinstance(pattern, list) and pattern and pattern[0] == 're.union':
            left_parts = []
            right_parts = []
            for option in pattern[1:]:
                if isinstance(option, list) and option and option[0] == 're.++':
                    option_left, option_right = self.extract_sides_from_pattern(option, constant)
                    left_parts.extend(option_left)
                    right_parts.extend(option_right)
                elif self.is_direct_match(option, constant):
                    left_parts.append(['str.to_re', '""'])
                    right_parts.append(['str.to_re', '""'])
            if left_parts and right_parts:
                return left_parts, right_parts
        return [['str.to_re', '""']], [['str.to_re', '""']]

    def get_reverse_expr(self, expr):
        if not expr or len(expr) == 0:
            return expr
        if isinstance(expr, str):
            if expr.startswith('"') and expr.endswith('"'):
                inner_str = expr[1:-1]
                reversed_str = inner_str[::-1]
                return f'"{reversed_str}"'
            return expr
        if expr[0] == 'str.to_re':
            if expr[1].startswith('"') and expr[1].endswith('"'):
                inner_str = expr[1][1:-1]
                reversed_str = inner_str[::-1]
                return ['str.to_re', f'"{reversed_str}"']
            return expr
        elif expr[0] == 're.++':
            reversed_elements = [self.get_reverse_expr(elem) for elem in expr[1:]]
            reversed_elements.reverse()
            return ['re.++'] + reversed_elements
        elif expr[0] == 're.union':
            return ['re.union'] + [self.get_reverse_expr(elem) for elem in expr[1:]]
        elif expr[0] == 're.*':
            return ['re.*', self.get_reverse_expr(expr[1])]
        elif expr[0] == 're.range':
            return expr
        elif isinstance(expr, list):
            reversed_list = []
            for item in expr:
                if isinstance(item, str) and item.startswith('"') and item.endswith('"'):
                    inner_str = item[1:-1]
                    reversed_str = inner_str[::-1]
                    reversed_list.append(f'"{reversed_str}"')
                elif isinstance(item, list):
                    reversed_list.append(self.get_reverse_expr(item))
                else:
                    reversed_list.append(item)
            reversed_list.reverse()
            return reversed_list
        return expr

    def can_be_empty(self, expr):
        if not expr or len(expr) == 0:
            return True
        if expr[0] == 'str.to_re':
            return expr[1] == '""'
        elif expr[0] == 're.++':
            return all(self.can_be_empty(elem) for elem in expr[1:])
        elif expr[0] == 're.union':
            return any(self.can_be_empty(elem) for elem in expr[1:])
        elif expr[0] == 're.*':
            return True
        return False

    def get_remove_constant_pattern(self, left_expr, right_expr, constant_in_index):
        constant = left_expr[0]
        left_norm = self.normalize_expr(left_expr[1:])
        right_left = self.normalize_expr(right_expr[:constant_in_index], is_regex=True)
        right_mid = right_expr[constant_in_index]
        right_right = right_expr[constant_in_index+1:]
        if not self.can_be_empty(right_left):
            logging.debug1(f"{Parser.to_str(right_left)} can't be empty")
            return []
        deploy_pattern = self.get_deploy_pattern(right_mid, constant, mode='first')
        if not deploy_pattern:
            return []
        _, right_side = self.extract_sides_from_pattern(deploy_pattern[1], constant)
        result = []
        for right_part in right_side:
            right_norm = self.normalize_expr([right_part] + [deploy_pattern[2]] + right_right, is_regex=True)
            result.append(['str.in_re', left_norm, right_norm])
        return result

    def normalize_expr(self, expr, is_regex=False):
        if not expr:
            return ['str.to_re', '""'] if is_regex else '""'
        if len(expr) == 1:
            return expr[0]
        concat_op = 're.++' if is_regex else 'str.++'
        result = [concat_op]
        for item in expr:
            if isinstance(item, list) and item and item[0] == concat_op:
                result.extend(item[1:])
            else:
                result.append(item)
        return result

    def filter_by_allowed_chars(self, expr, allowed_chars):
        if not allowed_chars:
            return expr
        def optimize_range(start, end, allowed):
            start_code = ord(start)
            end_code = ord(end)
            valid_codes = [ord(c) for c in allowed if start_code <= ord(c) <= end_code]
            if not valid_codes:
                return None
            valid_codes.sort()
            ranges = []
            range_start = valid_codes[0]
            range_end = range_start
            for code in valid_codes[1:]:
                if code == range_end + 1:
                    range_end = code
                else:
                    if range_start == range_end:
                        ranges.append(['str.to_re', f'"{chr(range_start)}"'])
                    else:
                        ranges.append(['re.range', f'"{chr(range_start)}"', f'"{chr(range_end)}"'])
                    range_start = code
                    range_end = code
            if range_start == range_end:
                ranges.append(['str.to_re', f'"{chr(range_start)}"'])
            else:
                ranges.append(['re.range', f'"{chr(range_start)}"', f'"{chr(range_end)}"'])
            if len(ranges) == 1:
                return ranges[0]
            else:
                return ['re.union'] + ranges
        def process_expr(e):
            if not isinstance(e, list):
                if isinstance(e, str) and e.startswith('"'):
                    char = e[1:-1]
                    if not char:
                        return e, True
                    return e, all(c in allowed_chars for c in char)
                return e, True
            if not e:
                return ['str.to_re', '""'], True
            op = e[0]
            if op == 'str.to_re' and len(e) > 1:
                if isinstance(e[1], str) and e[1].startswith('"'):
                    char = e[1][1:-1]
                    if not char:
                        return e, True
                    return e, all(c in allowed_chars for c in char)
                return e, True
            elif op == 're.range' and len(e) == 3:
                start, end = e[1][1:-1], e[2][1:-1]
                chars_in_range = set(chr(c) for c in range(ord(start), ord(end) + 1))
                intersection = chars_in_range.intersection(allowed_chars)
                if not intersection:
                    return None, False
                if len(intersection) == len(chars_in_range):
                    return e, True
                optimized = optimize_range(start, end, allowed_chars)
                if optimized:
                    return optimized, True
                return None, False
            elif op == 're.++':
                filtered = []
                is_valid = True
                for sub_e in e[1:]:
                    sub_result, sub_valid = process_expr(sub_e)
                    if not sub_valid:
                        is_valid = False
                        break
                    filtered.append(sub_result)
                if not is_valid:
                    return None, False
                if not filtered:
                    return ['str.to_re', '""'], True
                if len(filtered) == 1:
                    return filtered[0], True
                return ['re.++'] + filtered, True
            elif op == 're.union':
                filtered = []
                for sub_e in e[1:]:
                    sub_result, sub_valid = process_expr(sub_e)
                    if sub_valid and sub_result is not None:
                        filtered.append(sub_result)
                if not filtered:
                    return None, False
                if len(filtered) == 1:
                    return filtered[0], True
                return ['re.union'] + filtered, True
            elif op in ['re.*', 're.+']:
                body_result, body_valid = process_expr(e[1])
                if not body_valid or body_result is None:
                    if op == 're.*':
                        return ['str.to_re', '""'], True
                    else:
                        return None, False
                return [op, body_result], True
            processed_parts = []
            all_valid = True
            for part in e[1:]:
                part_result, part_valid = process_expr(part)
                if not part_valid:
                    all_valid = False
                processed_parts.append(part_result)
            return [op] + processed_parts, all_valid
        result, valid = process_expr(expr)
        return result if valid else None

    def remove_redundant_constants(self, expr):
        if not isinstance(expr, list):
            return expr
        if not expr:
            return expr
        op = expr[0]
        if op == 're.union':
            seen_constants = {}
            filtered = []
            for e in expr[1:]:
                e_simplified = self.remove_redundant_constants(e)
                if isinstance(e_simplified, list) and e_simplified and e_simplified[0] == 'str.to_re':
                    const_val = str(e_simplified)
                    if const_val not in seen_constants:
                        seen_constants[const_val] = True
                        filtered.append(e_simplified)
                else:
                    filtered.append(e_simplified)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.union'] + filtered
        elif op == 're.++':
            filtered = []
            for e in expr[1:]:
                e_simplified = self.remove_redundant_constants(e)
                if e_simplified != ['str.to_re', '""']:
                    filtered.append(e_simplified)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.++'] + filtered
        elif op in ['re.*', 're.+']:
            body = self.remove_redundant_constants(expr[1])
            if body == ['str.to_re', '""']:
                if op == 're.*':
                    return ['str.to_re', '""']
                else:  # re.+
                    return ['str.to_re', '""']
            if isinstance(body, list) and body and body[0] in ['re.*', 're.+']:
                if op == 're.*':
                    return ['re.*', body[1]]
                elif op == 're.+' and body[0] == 're.+':
                    return ['re.+', body[1]]
            return [op, body]
        return [op] + [self.remove_redundant_constants(e) for e in expr[1:]]

    def remove_empty_strings(self, expr):
        if not isinstance(expr, list):
            return expr
        if not expr:
            return expr
        op = expr[0]
        if op == 're.++':
            filtered = []
            for e in expr[1:]:
                e_simplified = self.remove_empty_strings(e)
                if e_simplified == ['str.to_re', '""']:
                    continue
                if isinstance(e_simplified, list) and e_simplified and e_simplified[0] == 're.*' and e_simplified[1] == ['str.to_re', '""']:
                    continue
                filtered.append(e_simplified)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.++'] + filtered
        elif op == 're.union':
            filtered = []
            seen_empty = False
            for e in expr[1:]:
                e_simplified = self.remove_empty_strings(e)
                if e_simplified == ['str.to_re', '""']:
                    if not seen_empty:
                        seen_empty = True
                        filtered.append(e_simplified)
                else:
                    filtered.append(e_simplified)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.union'] + filtered
        elif op in ['re.*', 're.+']:
            body = self.remove_empty_strings(expr[1])
            if body == ['str.to_re', '""']:
                if op == 're.*':
                    return ['str.to_re', '""']
                else:  # re.+
                    return ['str.to_re', '""']
            return [op, body]
        return [op] + [self.remove_empty_strings(e) for e in expr[1:]]

    def reorder_union(self, expr):
        if not isinstance(expr, list):
            return expr
        if not expr:
            return expr
        op = expr[0]
        if op == 're.range':
            start_char = expr[1][1:-1]
            end_char = expr[2][1:-1]
            if start_char == end_char:
                return ['str.to_re', f'"{start_char}"']
            else:
                range_elements = []
                for char_code in range(ord(start_char), ord(end_char) + 1):
                    char = chr(char_code)
                    range_elements.append(['str.to_re', f'"{char}"'])
                if len(range_elements) == 1:
                    return range_elements[0]
                return ['re.union'] + range_elements
        elif op == 're.union':
            str_to_re_elements = []
            str_to_re_seen = set()
            other_elements = []
            for e in expr[1:]:
                processed_e = self.reorder_union(e)
                if isinstance(processed_e, list) and processed_e and processed_e[0] == 'str.to_re':
                    str_repr = str(processed_e)
                    if str_repr not in str_to_re_seen:
                        str_to_re_seen.add(str_repr)
                        str_to_re_elements.append(processed_e)
                elif isinstance(processed_e, list) and processed_e and processed_e[0] == 're.union':
                    for sub_e in processed_e[1:]:
                        if isinstance(sub_e, list) and sub_e and sub_e[0] == 'str.to_re':
                            str_repr = str(sub_e)
                            if str_repr not in str_to_re_seen:
                                str_to_re_seen.add(str_repr)
                                str_to_re_elements.append(sub_e)
                        else:
                            other_elements.append(sub_e)
                else:
                    other_elements.append(processed_e)
            str_to_re_elements.sort(key=lambda x: (len(x[1]) - 2, x[1]))
            other_elements.sort(key=lambda x: Parser.to_str(x))
            sorted_elements = str_to_re_elements + other_elements
            if not sorted_elements:
                return ['str.to_re', '""']
            if len(sorted_elements) == 1:
                return sorted_elements[0]
            return ['re.union'] + sorted_elements
        elif op in ['re.*', 're.+']:
            inner = self.reorder_union(expr[1])
            if isinstance(inner, list) and inner and inner[0] == 're.range':
                union_elements = self.reorder_union(inner)
                return [op, union_elements]
            return [op, inner]
        else:
            processed_parts = []
            for e in expr[1:]:
                processed_e = self.reorder_union(e)
                processed_parts.append(processed_e)
            return [op] + processed_parts

    def is_constant_in_regex(self, left_expr, right_expr):
        constant_str = ""
        if isinstance(left_expr, list) and left_expr[0] == 'str.++':
            if all(isinstance(e, str) and e.startswith('"') for e in left_expr[1:]):
                constant_str = ''.join(e[1:-1] for e in left_expr[1:])
            else:
                return None
        elif isinstance(left_expr, str):
            if left_expr.startswith('"'):
                constant_str = left_expr[1:-1]
            else:
                return None
        else:
            return None

        # Special case for empty string match
        if constant_str == "":
            # If the regex is empty or can accept empty string, return true
            if right_expr == '""' or right_expr == ['str.to_re', '""']:
                return 'true'
                
            # Handle specifically the case seen in logs: "" in "" + ""
            if isinstance(right_expr, list) and right_expr[0] == 're.++':
                # If all parts can be empty, the empty string is accepted
                if self.can_be_empty(right_expr):
                    return 'true'
                return 'false'
                
            if isinstance(right_expr, list):
                if right_expr[0] == 'str.to_re' and len(right_expr) > 1:
                    if isinstance(right_expr[1], str) and right_expr[1] != '""':
                        return 'false'
                    elif isinstance(right_expr[1], str) and right_expr[1] == '""':
                        return 'true'
                elif right_expr[0] in ['re.range', 're.allchar']:
                    return 'false'
            if isinstance(right_expr, str) and right_expr.startswith('"') and right_expr != '""':
                return 'false'
                
        if isinstance(right_expr, list) and len(right_expr) > 1:
            if right_expr[0] == 're.++' and any(isinstance(e, str) and e.startswith('"') and 'z' in e for e in right_expr[1:]):
                if constant_str == "" or 'z' not in constant_str:
                    return 'false'
            if right_expr[0] == 'str.to_re' and len(right_expr) == 2:
                if isinstance(right_expr[1], str) and right_expr[1].startswith('"'):
                    pattern_str = right_expr[1][1:-1]
                    if constant_str != pattern_str:
                        return 'false'
                    else:
                        return 'true'
        if isinstance(right_expr, list) and len(right_expr) == 1:
            right_expr = right_expr[0]
        regex_pattern = Parser.to_pyre(right_expr)
        if regex_pattern is None:
            return None
        try:
            if re.fullmatch(regex_pattern, constant_str):
                return 'true'
            else:
                return 'false'
        except Exception as e:
            logging.debug1(f"Exception in is_constant_in_regex: {e}, for string '{constant_str}' and pattern '{regex_pattern}'")
            return 'false'

    def rebuild_expr(self, expr):
        if not isinstance(expr, list):
            return expr
        if not expr:
            return expr
        op = expr[0]
        if op == 're.++':
            result = []
            for part in expr[1:]:
                rebuilt_part = self.rebuild_expr(part)
                if rebuilt_part != ['str.to_re', '""']:
                    result.append(rebuilt_part)
            if not result:
                return ['str.to_re', '""']
            if len(result) == 1:
                return result[0]
            constant_parts = []
            other_parts = []
            for part in result:
                if isinstance(part, list) and part and part[0] == 'str.to_re' and len(part) > 1 and isinstance(part[1], str) and part[1].startswith('"'):
                    constant_parts.append(part)
                else:
                    other_parts.append(part)
            constant_parts.sort(key=lambda x: (len(x[1]) - 2, x[1]))
            other_parts.sort(key=lambda x: Parser.to_str(x))
            sorted_result = constant_parts + other_parts
            return ['re.++'] + sorted_result
        elif op == 're.union':
            kleene_parts = {}
            parts = []
            for part in expr[1:]:
                rebuilt_part = self.rebuild_expr(part)
                if rebuilt_part == ['str.to_re', '""']:
                    continue
                if isinstance(rebuilt_part, list) and rebuilt_part and rebuilt_part[0] in ['re.*', 're.+']:
                    part_key = str(rebuilt_part[1])
                    if part_key in kleene_parts:
                        continue
                    kleene_parts[part_key] = rebuilt_part
                    parts.append(rebuilt_part)
                else:
                    parts.append(rebuilt_part)
            if not parts:
                return ['str.to_re', '""']
            if len(parts) == 1:
                return parts[0]
            return ['re.union'] + parts
        elif op in ['re.*', 're.+']:
            inner = self.rebuild_expr(expr[1])
            if inner == ['str.to_re', '""']:
                if op == 're.*':
                    return ['str.to_re', '""']
                else:
                    return ['str.to_re', '""']
            if isinstance(inner, list) and inner and inner[0] == 're.union':
                separate_parts = []
                for part in inner[1:]:
                    separate_parts.append([op, part])
                if len(separate_parts) == 1:
                    return separate_parts[0]
                return ['re.union'] + separate_parts
            return [op, inner]
        elif op == 'str.to_re':
            if len(expr) > 1:
                return expr
            return ['str.to_re', '""']
        return [op] + [self.rebuild_expr(e) for e in expr[1:]]

    def get_index_unique_constant(self, expr, unique_char):
        if not isinstance(expr, list):
            if isinstance(expr, str) and expr.startswith('"'):
                char = expr[1:-1]
                if char == unique_char:
                    for var_name in self.get_variables(expr):
                        var = self.info_manager.get_var(var_name)
                        if var.allow is not None and char in var.allow:
                            return None
                    return 0
            return None
        for i, e in enumerate(expr):
            if isinstance(e, str) and e.startswith('"'):
                char = e[1:-1]
                if char == unique_char:
                    is_unique = True
                    for var_name in self.get_variables(expr):
                        var = self.info_manager.get_var(var_name)
                        if var.allow is not None and char in var.allow:
                            is_unique = False
                            break
                    if is_unique:
                        return i
        return None

class BoolProcessor:
    def __init__(self, info):
        self.info_manager = info
        self.var_map = {}
        self.unit_clauses = []
        self.cnf_clauses = [[1]]
        self.original_clauses = []
        self.is_sat = 'UNKNOWN'
    
    def read_clause(self, clause):
        if not clause.expr_tree:
            return
        bool_structure = self._extract_bool_structure(clause.expr_tree)
        if bool_structure:
            clause_clauses = self._expr_to_cnf(bool_structure)
            for clu in clause_clauses:
                self.cnf_clauses.append(clu)
                self.original_clauses.append(clu)

    def read_lemma(self, lemma):
        if not lemma.expr_tree:
            return
        bool_structure = self._extract_bool_structure(lemma.expr_tree)
        if bool_structure:
            lemma_clauses = self._expr_to_cnf(bool_structure)
            for clu in lemma_clauses:
                self.cnf_clauses.append(clu)
    
    def _extract_bool_structure(self, expr_tree):
        if not expr_tree:
            return None
        if expr_tree.op == 'leaf':
            if not expr_tree.elements:
                return None
            lit_index = expr_tree.elements[0]
            return lit_index
        elif expr_tree.op == 'not':
            if not expr_tree.elements:
                return None
            inner = self._extract_bool_structure(expr_tree.elements[0])
            return ['not', inner] if inner is not None else None
        else:
            result = [expr_tree.op]
            for element in expr_tree.elements:
                inner = self._extract_bool_structure(element)
                if inner is not None:
                    result.append(inner)
            return result if len(result) > 1 else None
    
    def _expr_to_cnf(self, expr):
        cnf_formula = self._convert_to_cnf(expr)
        clauses = self._formula_to_clauses(cnf_formula)
        return clauses
    
    def _convert_to_cnf(self, formula):
        if formula is None:
            return None
        if not isinstance(formula, list):
            return formula
        if len(formula) <= 1:
            return formula
        op = formula[0]
        if op == 'not':
            if len(formula) < 2:
                return None
            if not isinstance(formula[1], list):
                return formula
            inner_op = formula[1][0]
            inner_args = formula[1][1:]
            if inner_op == 'not':
                if len(inner_args) == 1:
                    return self._convert_to_cnf(inner_args[0])
                return None
            elif inner_op == 'and':
                or_terms = ['or']
                for term in inner_args:
                    or_terms.append(['not', term])
                return self._convert_to_cnf(or_terms)
            elif inner_op == 'or':
                and_terms = ['and']
                for term in inner_args:
                    and_terms.append(['not', term])
                return self._convert_to_cnf(and_terms)
            return formula
        processed_terms = [op]
        for term in formula[1:]:
            processed = self._convert_to_cnf(term)
            if processed is not None:
                processed_terms.append(processed)
        if len(processed_terms) <= 1:
            return None
        if op == 'or':
            and_indices = []
            for i, term in enumerate(processed_terms[1:], 1):
                if isinstance(term, list) and len(term) > 1 and term[0] == 'and':
                    and_indices.append(i)
            if and_indices:
                first_and_idx = and_indices[0]
                and_terms = processed_terms[first_and_idx][1:]
                other_terms = processed_terms[1:first_and_idx] + processed_terms[first_and_idx+1:]
                result = ['and']
                for and_term in and_terms:
                    new_or = ['or', and_term] + other_terms
                    cnf_or = self._convert_to_cnf(new_or)
                    if cnf_or is not None:
                        if isinstance(cnf_or, list) and len(cnf_or) > 1 and cnf_or[0] == 'and':
                            result.extend(cnf_or[1:])
                        else:
                            result.append(cnf_or)
                return result if len(result) > 1 else (result[1] if len(result) == 2 else None)
        if op in ['and', 'or']:
            flattened = [op]
            for term in processed_terms[1:]:
                if isinstance(term, list) and len(term) > 1 and term[0] == op:
                    flattened.extend(term[1:])
                else:
                    flattened.append(term)
            return flattened
        return processed_terms
    
    def _formula_to_clauses(self, formula):
        if formula is None:
            return []
        if not isinstance(formula, list):
            var_id = self._map_var(formula)
            return [[var_id]]
        if len(formula) <= 1:
            return []
        op = formula[0]
        if op == 'and':
            result = []
            for sub_f in formula[1:]:
                result.extend(self._formula_to_clauses(sub_f))
            return result
        elif op == 'or':
            clause = []
            is_valid = True
            for sub_f in formula[1:]:
                if not isinstance(sub_f, list):
                    clause.append(self._map_var(sub_f))
                elif isinstance(sub_f, list) and len(sub_f) > 1 and sub_f[0] == 'not':
                    if not isinstance(sub_f[1], list):
                        var_id = self._map_var(sub_f[1])
                        clause.append(-var_id)
                    else:
                        is_valid = False
                        break
                else:
                    is_valid = False
                    break
            return [clause] if is_valid and clause else []
        elif op == 'not':
            if len(formula) < 2:
                return []
            if not isinstance(formula[1], list):
                var_id = self._map_var(formula[1])
                return [[-var_id]]
            return []
        return []
    
    def _map_var(self, var):
        if var is None:
            return 1
        if isinstance(var, int):
            lit_id = var
            if lit_id == 0:
                return -1
            else:
                return lit_id
        if var == 'true':
            return 1
        elif var == 'false':
            return -1
        if isinstance(var, str) and var.startswith('-'):
            inner_var = var[1:]
            multiplier = -1
        else:
            inner_var = var
            multiplier = 1
        if inner_var not in self.var_map:
            try:
                var_id = int(inner_var)
            except ValueError:
                var_id = len(self.var_map) + 2
            self.var_map[inner_var] = var_id
        return multiplier * self.var_map[inner_var]
    
    def unit_propagation(self):
        if not self.cnf_clauses:
            return False
        unit_stack = []
        unit_values = {}
        for clause in self.cnf_clauses:
            if len(clause) == 1:
                unit_stack.append(clause[0])
        if not unit_stack:
            return False
        while unit_stack:
            lit = unit_stack.pop(0)
            self.unit_clauses.append([lit])
            var = abs(lit)
            value = lit > 0
            if var in unit_values:
                if unit_values[var] != value:
                    self.cnf_clauses = []
                    self.is_sat = 'UNSAT'
                    return True
                continue
            unit_values[var] = value
            i = 0
            while i < len(self.cnf_clauses):
                clause = self.cnf_clauses[i]
                is_satisfied = False
                new_clause = []
                for clause_lit in clause:
                    clause_var = abs(clause_lit)
                    if clause_var in unit_values:
                        if (clause_lit > 0 and unit_values[clause_var]) or (clause_lit < 0 and not unit_values[clause_var]):
                            is_satisfied = True
                            break
                    else:
                        new_clause.append(clause_lit)
                if is_satisfied:
                    self.cnf_clauses.pop(i)
                    continue
                if len(new_clause) == 0:
                    self.cnf_clauses = []
                    self.is_sat = 'UNSAT'
                    return True
                if len(new_clause) == 1 and new_clause[0] not in unit_stack:
                    unit_lit = new_clause[0]
                    unit_var = abs(unit_lit)
                    if unit_var not in unit_values:
                        unit_stack.append(unit_lit)
                self.cnf_clauses[i] = new_clause
                i += 1
        return True

    def remove_tautologies(self):
        if not self.cnf_clauses:
            return False
        changed = False
        i = 0
        while i < len(self.cnf_clauses):
            clause = self.cnf_clauses[i]
            seen = set()
            for lit in clause:
                if -lit in seen:
                    self.cnf_clauses.pop(i)
                    changed = True
                    break
                seen.add(lit)
            else:
                i += 1
        return changed

    def remove_subsumed_clauses(self):
        if not self.cnf_clauses:
            return False
        changed = False
        i = 0
        while i < len(self.cnf_clauses):
            clause_i = set(self.cnf_clauses[i])
            j = 0
            while j < len(self.cnf_clauses):
                if i != j:
                    clause_j = set(self.cnf_clauses[j])
                    if clause_j.issubset(clause_i):
                        self.cnf_clauses.pop(i)
                        changed = True
                        break
                j += 1
            if not changed:
                i += 1
        return changed

    def simplify_lemmas(self):
        if not self.cnf_clauses:
            return self.is_sat
        self.cnf_clauses = list(set(tuple(sorted(set(clause))) for clause in self.cnf_clauses))
        while True:
            changed = False
            if self.unit_propagation():
                changed = True
            if self.remove_tautologies():
                changed = True
            if self.remove_subsumed_clauses():
                changed = True
            if not changed:
                break
        self.cnf_clauses = list(set(tuple(sorted(clause)) for clause in self.cnf_clauses))
        return self.is_sat
    
    def get_simplified_lemmas(self):
        if self.is_sat == 'UNSAT':
            return [(ExpressionTree.LEAF(0), "bool")]
        result = []
        unit_set = set(tuple(clause) for clause in self.unit_clauses)
        cnf_set = set(tuple(clause) for clause in self.cnf_clauses)
        original_set = set(tuple(clause) for clause in self.original_clauses)
        clauses = list(unit_set.union(cnf_set) - original_set)
        for clause in clauses:
            if len(clause) == 1:
                lit = clause[0]
                if lit == 1:
                    continue
                var = abs(lit)
                if lit > 0:
                    result.append((ExpressionTree.LEAF(var), "re_in"))
                else:
                    result.append((ExpressionTree.NOT(ExpressionTree.LEAF(var)), "not"))
            else:
                or_elements = []
                lemma_type = "re_in"
                for lit in clause:
                    var = abs(lit)
                    if lit > 0:
                        or_elements.append(ExpressionTree.LEAF(var))
                    else:
                        or_elements.append(ExpressionTree.NOT(ExpressionTree.LEAF(var)))
                        lemma_type = "not"
                if or_elements:
                    result.append((ExpressionTree.OR(or_elements), lemma_type))
        return result
    
    def reset(self):
        self.var_map = {}
        self.lit_to_var = {}
        self.cnf_clauses = [[1]]

class ArithmeticProcessor:
    def __init__(self, info):
        self.info_manager = info
    
    def get_length_expr(self, lit):
        if lit.type != 'string' or lit.index is None:
            return None
        expr = lit.expr
        if not isinstance(expr, list) or expr[0] != 'str.in_re':
            return None
        str_length_expr = self._get_str_length_expr(expr[1])
        if isinstance(str_length_expr, int):
            str_length_expr = str(str_length_expr)
        bias_length_expr = self._get_bias_length_expr(expr[2])
        if isinstance(bias_length_expr, int):
            bias_length_expr = str(bias_length_expr)
        base_length_expr = self._get_base_length_expr(expr[2])
        if isinstance(base_length_expr, int):
            base_length_expr = str(base_length_expr)
        if str_length_expr and bias_length_expr and base_length_expr:
            result = ['=', ['mod', ['-', str_length_expr, bias_length_expr], base_length_expr], '0']
            return result
        return None
        
    def _get_str_length_expr(self, expr):
        if isinstance(expr, str):
            if expr.startswith('"') and expr.endswith('"'):
                result = str(len(expr) - 2)
                return result
            else:
                result = ['str.len', expr]
                return result
        elif isinstance(expr, list):
            if expr[0] == 'str.++':
                lengths = []
                for sub_expr in expr[1:]:
                    sub_length = self._get_str_length_expr(sub_expr)
                    if sub_length is None:
                        return None
                    lengths.append(sub_length)
                
                result = ['+']
                for length in lengths:
                    if isinstance(length, int):
                        result.append(str(length))
                    else:
                        result.append(length)
                
                if len(result) == 2:
                    result = result[1]
                
                return result
        return None
    
    def _get_bias_length_expr(self, expr):
        if isinstance(expr, str):
            if expr.startswith('"') and expr.endswith('"'):
                result = str(len(expr) - 2)
                return result
            return None
        if not isinstance(expr, list):
            return None
        if expr[0] == 're.++':
            total_length = 0
            for sub_expr in expr[1:]:
                sub_length = self._get_bias_length_expr(sub_expr)
                if sub_length is None:
                    return None
                if isinstance(sub_length, str):
                    sub_length = int(sub_length)
                total_length += sub_length
            result = str(total_length)
            return result
        elif expr[0] == 're.union':
            lengths = []
            for sub_expr in expr[1:]:
                sub_length = self._get_bias_length_expr(sub_expr)
                if sub_length is None:
                    return None
                if isinstance(sub_length, str):
                    sub_length = int(sub_length)
                lengths.append(sub_length)
            
            if all(length == lengths[0] for length in lengths):
                result = str(lengths[0])
                return result
            return None
        elif expr[0] == 're.*':
            return "0"
        elif expr[0] == 'str.to_re':
            if len(expr) > 1 and isinstance(expr[1], str):
                if expr[1].startswith('"') and expr[1].endswith('"'):
                    result = str(len(expr[1]) - 2)
                    return result
            return None
            
        return None
        
    def _get_base_length_expr(self, expr):
        base_set = self._get_base_set(expr)
        if not base_set:
            return "1"
        result = self._calculate_base_from_set(base_set)
        return result
    
    def _get_base_set(self, expr):
        if not isinstance(expr, list):
            return []
        if expr[0] == 're.++':
            result_set = []
            for sub_expr in expr[1:]:
                sub_set = self._get_base_set(sub_expr)
                if sub_set is None:
                    return None
                result_set.extend(sub_set)
            return result_set
        elif expr[0] == 're.*':
            if isinstance(expr[1], str) and expr[1].startswith('"') and expr[1].endswith('"'):
                str_length = len(expr[1]) - 2
                if str_length > 0:
                    return [str_length]
                return []
            elif isinstance(expr[1], list):
                if expr[1][0] == 're.union':
                    union_set = []
                    for sub_expr in expr[1][1:]:
                        length = self._get_bias_length_expr(sub_expr)
                        if length is None:
                            return None
                        if isinstance(length, str):
                            length = int(length)
                        if length > 0:
                            union_set.append(length)
                    return union_set
                elif expr[1][0] == 'str.to_re':
                    if len(expr[1]) > 1 and isinstance(expr[1][1], str) and expr[1][1].startswith('"') and expr[1][1].endswith('"'):
                        str_length = len(expr[1][1]) - 2
                        if str_length > 0:
                            return [str_length]
                    return []
                elif expr[1][0] == 're.++':
                    length = self._get_bias_length_expr(expr[1])
                    if length is None:
                        return None
                    if isinstance(length, str):
                        length = int(length)
                    if length > 0:
                        return [length]
                    return []
        elif expr[0] == 'str.to_re':
            return []

        return []
    
    def _calculate_base_from_set(self, base_set):
        def gcd(a, b):
            return math.gcd(a, b)
        
        if not base_set:
            return "1"
        base = reduce(gcd, base_set)
        result = str(base)
        return result

class LemmaGenerator:
    def __init__(self, info, regex_processor, bool_processor, arith_processor):
        self.info_manager = info
        self.regex_processor = regex_processor
        self.bool_processor = bool_processor
        self.arith_processor = arith_processor
    
    def create_literal(self, expr):
        lit = SMTLit(expr)
        logging.debug(f"Create literal: {Parser.to_str(expr)}")
        lit = self.rewrite_lit(lit)
        logging.debug(f"Rewrite literal: {Parser.to_str(lit.expr)}")
        lit_find = self.info_manager.find_literal(lit)
        if lit_find is None:
            return self.info_manager.add_literal(lit)
        return lit_find.index
    
    def create_lemma(self, expr_tree, lemma_type, comment=None):
        if expr_tree:
            expr_tree.set_info_manager(self.info_manager)
        lemma = SMTLemma(expr_tree, lemma_type, comment)
        lemma_index = self.info_manager.add_lemma(lemma)
        lits = expr_tree.get_all_leaf_indices()
        for lit_index in lits:
            self.info_manager.literals[lit_index].add_lemma(lemma_index)
        return lemma_index
    
    def rewrite_lit(self, lit):
        expr = lit.expr
        if lit.type == 'string':
            left_expr, right_expr = expr[1], expr[2]
            vars_found = self.regex_processor.get_variables(left_expr)
            if len(vars_found) == 0:
                val = self.regex_processor.is_constant_in_regex(left_expr, right_expr)
                if val is not None:
                    lit.expr = val
                    return lit
            constants = self.regex_processor.get_parikh_image(left_expr)
            allowed_chars = set()
            for var_name in vars_found:
                var = self.info_manager.get_var(var_name)
                allowed_chars.update(var.allow)
            for char, count in constants.items():
                allowed_chars.add(char)
            if not allowed_chars:
                allowed_chars = set(chr(c) for c in range(32, 127))
            right_expr_filtered = self.regex_processor.filter_by_allowed_chars(right_expr, allowed_chars)
            right_expr_filtered = self.regex_processor.remove_redundant_constants(right_expr_filtered)
            right_expr_filtered = self.regex_processor.remove_empty_strings(right_expr_filtered)
            right_expr_filtered = self.regex_processor.reorder_union(right_expr_filtered)
            if len(allowed_chars) == 1:
                right_expr_filtered = self.regex_processor.rebuild_expr(right_expr_filtered)
            if right_expr_filtered:
                lit.expr = ['str.in_re', left_expr, right_expr_filtered]
            else:
                lit.expr = 'false'
        elif lit.type == 'arith':
            pass
        return lit
    
    def rewrite_lemmas(self, clauses, lemmas):
        for clause in clauses:
            self.bool_processor.read_clause(clause)
        for lemma in lemmas:
            self.bool_processor.read_lemma(lemma)
        is_sat = self.bool_processor.simplify_lemmas()
        simplified_lemmas = self.bool_processor.get_simplified_lemmas()
        self.info_manager.reset_lemmas()
        for lemma in simplified_lemmas:
            tree, lemma_type = lemma
            if tree.op == 'not':
                self.create_lemma(tree, lemma_type=lemma_type)
            else:
                self.create_lemma(tree, lemma_type=lemma_type)
        return is_sat

    def get_lemmas_length(self, lit):
        if lit.type != 'string':
            return
        length_expr = self.arith_processor.get_length_expr(lit)
        if length_expr:
            lit_length_index = self.create_literal(length_expr)
            left_expr = lit.expr[1]
            vars_found = self.regex_processor.get_variables(left_expr)
            constants = self.regex_processor.get_parikh_image(left_expr)
            allowed_chars = set()
            for var_name in vars_found:
                var = self.info_manager.get_var(var_name)
                allowed_chars.update(var.allow)
            for char, count in constants.items():
                allowed_chars.add(char)
            if len(allowed_chars) == 1:
                expr_tree = ExpressionTree.OR([ExpressionTree.NOT(ExpressionTree.LEAF(lit_length_index)), ExpressionTree.LEAF(lit.index)])
                lemma_index = self.create_lemma(expr_tree, lemma_type='arith')
                logging.debug3(f"Lemma({lemma_index}): {expr_tree.get_comment()}")
            expr_tree = ExpressionTree.OR([ExpressionTree.NOT(ExpressionTree.LEAF(lit.index)), ExpressionTree.LEAF(lit_length_index)])
            lemma_index = self.create_lemma(expr_tree, lemma_type='arith')
            logging.debug3(f"Lemma({lemma_index}): {expr_tree.get_comment()}")
    
    def get_lemmas_split(self, lit):
        if lit.type != 'string':
            return
        logging.debug3(f"Processing clause: {Parser.to_str(lit.expr)}")
        expr_tree = self.get_exptree_split(lit.expr)
        if expr_tree:
            expr_tree_lemma_left = ExpressionTree.OR([ExpressionTree.NOT(ExpressionTree.LEAF(lit.index)), expr_tree])
            expr_tree_lemma_right = ExpressionTree.OR([ExpressionTree.NOT(expr_tree), ExpressionTree.LEAF(lit.index)])
            lemma_index_left = self.create_lemma(expr_tree_lemma_left, lemma_type='re_in')
            lemma_index_right = self.create_lemma(expr_tree_lemma_right, lemma_type='re_in')
            logging.debug3(f"Lemma({lemma_index_left}): {expr_tree_lemma_left.get_comment()}")
            logging.debug3(f"Lemma({lemma_index_right}): {expr_tree_lemma_right.get_comment()}")

    def get_exptree_split(self, expr):
        logging.debug1(f"Processing exptree: {Parser.to_str(expr)}")
        left_expr, right_expr = expr[1], expr[2]
        left_expr = left_expr[1:] if left_expr[0] == 'str.++' else [left_expr]
        right_expr = right_expr[1:] if right_expr[0] == 're.++' else [right_expr]
        if len(right_expr) == 1 and isinstance(right_expr[0], list) and right_expr[0][0] == 're.union' and len(right_expr[0]) >= 3:
            trees = []
            left_expr = self.regex_processor.normalize_expr(left_expr)
            for e in right_expr[0][1:]:
                expr = ['str.in_re', left_expr, e]
                trees.append(self.get_exptree_split(expr))
            return ExpressionTree.OR(trees)
        vars_found = self.regex_processor.get_variables(left_expr)
        if len(vars_found) == 0:
            lit_index = self.create_literal(expr)
            logging.debug(f"Got expr({lit_index}): {Parser.to_str(expr)}, reason: no variables")
            return ExpressionTree.LEAF(lit_index)
        allowed_chars = set()
        for var_name in vars_found:
            var = self.info_manager.get_var(var_name)
            allowed_chars.update(var.allow)
        constants = self.regex_processor.get_parikh_image(left_expr)
        if not constants:
            lit_index = self.create_literal(expr)
            logging.debug(f"Got expr({lit_index}): {Parser.to_str(expr)}, reason: no char in left_expr")
            return ExpressionTree.LEAF(lit_index)
        unique_chars = set()
        for key, value in constants.items():
            if value == 1 and key not in allowed_chars:
                unique_chars.add(key)
        if not unique_chars:
            if left_expr[0].startswith('"') or left_expr[-1].startswith('"'):
                reversed = False
                if not left_expr[0].startswith('"') and left_expr[-1].startswith('"'):
                    left_expr = self.regex_processor.get_reverse_expr(left_expr)
                    right_expr = self.regex_processor.get_reverse_expr(right_expr)
                    reversed = True
                logging.debug(f"left_expr: {Parser.to_str(self.regex_processor.normalize_expr(left_expr))}")
                logging.debug(f"right_expr: {Parser.to_str(self.regex_processor.normalize_expr(right_expr))}")
                constant_in_indices = self.regex_processor.get_index_constant_in_pattern(right_expr, left_expr[0])
                if not constant_in_indices:
                    lit_index = self.create_literal('false')
                    logging.debug(f"Got expr({lit_index}): {Parser.to_str(expr)} which is false, reason: no constant in right_expr")
                    return ExpressionTree.LEAF(lit_index)
                exptrees = []
                for constant_in_index in constant_in_indices:
                    re_expr_list = self.regex_processor.get_remove_constant_pattern(left_expr, right_expr, constant_in_index)
                    for re_expr in re_expr_list:
                        if reversed and len(re_expr) == 3 and re_expr[0] == 'str.in_re':
                            left_expr, right_expr = re_expr[1], re_expr[2]
                            left_expr = self.regex_processor.get_reverse_expr(left_expr)
                            right_expr = self.regex_processor.get_reverse_expr(right_expr)
                            re_expr = ['str.in_re', left_expr, right_expr]
                        exptrees.append(self.get_exptree_split(re_expr))
                if len(exptrees) == 1:
                    return exptrees[0]
                if exptrees:
                    return ExpressionTree.OR(exptrees)
            lit_index = self.create_literal(expr)
            logging.debug(f"Got expr({lit_index}): {Parser.to_str(expr)}, reason: no unique char and can't split")
            return ExpressionTree.LEAF(lit_index)
        unique_char = next(iter(unique_chars))
        constant_index = self.regex_processor.get_index_unique_constant(left_expr, unique_char)
        constant_in_index = self.regex_processor.get_index_constant_must_in_pattern(right_expr, left_expr[constant_index])
        if constant_in_index is None:
            lit_index = self.create_literal(expr)
            logging.debug(f"Got expr({lit_index}): {Parser.to_str(expr)}, reason: no constant in index")
            return ExpressionTree.LEAF(lit_index)
        paired_list = self.regex_processor.get_split_pattern(left_expr, right_expr, constant_index, constant_in_index)
        if not paired_list:
            lit_index = self.create_literal(expr)
            return ExpressionTree.LEAF(lit_index)
        paired_trees = []
        for left_re_expr, right_re_expr in paired_list:
            left_tree = self.get_exptree_split(left_re_expr)
            right_tree = self.get_exptree_split(right_re_expr)
            paired_trees.append(ExpressionTree.AND([left_tree, right_tree]))
        if len(paired_trees) == 1:
            return paired_trees[0]
        return ExpressionTree.OR(paired_trees)

class SMTProcessor:
    def __init__(self, tree=False):
        self.info_manager = InfoManager()
        self.lemma_generator = LemmaGenerator(
            self.info_manager, 
            RegexProcessor(self.info_manager),
            BoolProcessor(self.info_manager),
            ArithmeticProcessor(self.info_manager))
        self.tree = tree
        Parser.set_tree_format(tree)
    
    def get_lemmas(self):
        for index in range(len(self.info_manager.literals)):
            lit = self.info_manager.literals[index]
            self.lemma_generator.get_lemmas_split(lit)
        for lit in self.info_manager.literals:
            self.lemma_generator.get_lemmas_length(lit)
        logging.debug4(f"Got {len(self.info_manager.lemmas)} lemmas")
        is_sat = self.lemma_generator.rewrite_lemmas(self.info_manager.clauses, self.info_manager.lemmas)
        return is_sat
    
    def process_file(self, input_file, output_file=None):
        with open(input_file, 'r') as f:
            lines = f.readlines()
            for line in lines:
                self.info_manager.process_line(line)
        self.info_manager.update_info()
        is_sat = self.get_lemmas()
        print(is_sat)
        outputs = []
        outputs.extend(self.info_manager.preamble)
        for var in self.info_manager.vars:
            var_smt2 = var.get_smt2()
            if var_smt2:
                outputs.append(var_smt2)
        for tmp_var in self.info_manager.tmp_vars:
            tmp_var_smt2 = tmp_var.get_smt2()
            if tmp_var_smt2:
                outputs.append(tmp_var_smt2)
        for clause in self.info_manager.clauses:
            outputs.append(clause.get_smt2())
        outputs.append("")
        for lemma in self.info_manager.lemmas:
            lemma_smt2 = lemma.get_smt2()
            if lemma_smt2:
                outputs.append(lemma_smt2)
        outputs.extend(self.info_manager.postamble)
        outputs.append("; ========================== [comments] ==========================")
        outputs.append("; Clause comments")
        for clause in self.info_manager.clauses:
            comment = str(clause)
            if comment:
                outputs.append(comment)
        outputs.append("; Lemma comments")
        for lemma in self.info_manager.lemmas:
            comment = str(lemma)
            if comment:
                outputs.append(comment)
        out = output_file if output_file else input_file
        with open(out, 'w') as f:
            for o in outputs:
                f.write(o + '\n')

if __name__=='__main__':
    parser = argparse.ArgumentParser(description='Process SMT2 files with regex preprocessing')
    parser.add_argument('input_file', help='Input SMT2 file')
    parser.add_argument('output_file', nargs='?', help='Output file (optional)')
    parser.add_argument('-l', '--level', type=int, default=20, help='Set logging level (default: 20, info level)')
    parser.add_argument('-t', '--tree', action='store_true', help='Enable tree-style output format')
    args = parser.parse_args()
    setup_logger(args.level)
    SMTProcessor(tree=args.tree).process_file(args.input_file, args.output_file)