import re
import sys
import logging
from collections import deque

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class ExprFormatter:
    @staticmethod
    def to_smt2(expr, indent=0):
        if expr is None:
            return None
        expr_type = ExprFormatter.classify_type(expr)
        if not expr_type:
            return None
        if expr_type in ('const', 'var', 'str'):
            return expr
        indent_str = '    ' * indent
        indent_next_str = '    ' * (indent + 1)
        if expr_type == 'assert':
            res = ExprFormatter.to_smt2(expr[1], indent + 1)
            if not res:
                return None
            return f'(assert {ExprFormatter.to_smt2(expr[1], indent)})' if ExprFormatter.classify_type(expr[1]) == 'not' else f'(assert\n{indent_next_str}{res}\n{indent_str})'
        elif expr_type == 'not':
            inner_expr = ExprFormatter.to_smt2(expr[1], indent + 1)
            return None if not inner_expr else f'(not\n{indent_next_str}{inner_expr}\n{indent_str})'
        elif expr_type == 'let':
            bindings = ' '.join([f'({ExprFormatter.to_smt2(x[0], 0)} {ExprFormatter.to_smt2(x[1], indent + 2)})' for x in expr[1]])
            body = ExprFormatter.to_smt2(expr[2], indent + 1)
            return f'(let ({bindings})\n{indent_next_str}{body}\n{indent_str})'
        elif expr_type == 're_in':
            str_expr = ExprFormatter.to_smt2(expr[1], indent + 1)
            re_expr = ExprFormatter.to_smt2(expr[2], indent + 1)
            return f'(str.in_re\n{indent_next_str}{str_expr}\n{indent_next_str}{re_expr}\n{indent_str})'
        elif expr_type == 're_range':
            return f'(re.range {ExprFormatter.to_smt2(expr[1], 0)} {ExprFormatter.to_smt2(expr[2], 0)})'
        elif expr_type in ('re_star', 're_plus'):
            return f'({expr[0]} {ExprFormatter.to_smt2(expr[1], indent)})'
        elif expr_type in ('re_union', 'str_cat', 're_cat'):
            op = 're.union' if expr_type == 're_union' else expr[0]
            parts = [f'{indent_next_str}{ExprFormatter.to_smt2(e, indent + 1)}' for e in expr[1:]]
            return f'({op}\n{chr(10).join(parts)}\n{indent_str})'
        if isinstance(expr, list) and len(expr) > 0:
            op = expr[0]
            if op in ('and', 'or'):
                parts = [f'{indent_next_str}{ExprFormatter.to_smt2(e, indent + 1)}' for e in expr[1:]]
                return f'({op}\n{chr(10).join(parts)}\n{indent_str})'
            elif op in ('=', '>=', '<=', '>', '<'):
                parts = [ExprFormatter.to_smt2(e, indent) for e in expr[1:]]
                return f'({op} {" ".join(parts)})'
            elif op in ('+', '-', '*', '/'):
                parts = [ExprFormatter.to_smt2(e, indent) for e in expr[1:]]
                return f'({op} {" ".join(parts)})'
            elif op == 'str.len':
                arg = ExprFormatter.to_smt2(expr[1], indent) if len(expr) > 1 else ""
                return f'(str.len {arg})'
            elif op == 'declare-fun':
                if len(expr) >= 4:
                    name = expr[1]
                    params = expr[2]
                    ret_type = expr[3]
                    params_str = " ".join([ExprFormatter.to_smt2(p, indent) for p in params])
                    return f'(declare-fun {name} ({params_str}) {ret_type})'
        parts = [ExprFormatter.to_smt2(e, indent) for e in expr]
        return f'({" ".join(parts)})'

    @staticmethod
    def to_comment(expr):
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

class Parser:
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
        return ExprFormatter.to_smt2(expr)

class SMTClause:
    def __init__(self, index, expr, expr_type):
        self.index = index
        self.expr = expr
        self.type = expr_type
        self.vars = self._extract_vars(self.expr)
        self.chars = self._extract_chars(self.expr)
        self.original_line = None
    
    def __eq__(self, other):
        if not isinstance(other, SMTClause):
            return False
        return self.index == other.index
        
    def __hash__(self):
        return hash(self.index)
    
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
    
    def get_smt2(self):
        return ExprFormatter.to_smt2(['assert', self.expr])
    
    def get_comment(self):
        return f"; {ExprFormatter.to_comment(self.expr)}"

class SMTLemma:
    def __init__(self, index, expr, comment=None):
        self.index = index
        self.expr = expr
        self.type = ExprFormatter.classify_type(expr)
        self.comment = comment
    
    def __eq__(self, other):
        if not isinstance(other, SMTLemma):
            return False
        return self.index == other.index
        
    def __hash__(self):
        return hash(self.index)
    
    def get_smt2(self):
        return ExprFormatter.to_smt2(['assert', self.expr])
    
    def get_comment(self):
        return f"; {ExprFormatter.to_comment(self.expr)}"

class SMTInfo:
    def __init__(self):
        self.preamble = []
        self.postamble = []
        self.var_counter = 0
        self.vars = []
        self.var_map = {}
        self.clause_counter = 0
        self.clauses = []
        self.lemma_counter = 0
        self.lemmas = []
        self.tmp_var_counter = 0
        self.tmp_vars = []

    def _process_declare(self, line):
        expr = Parser.parse_expression(Parser.tokenize(line))
        var = expr[1]
        type_info = expr[3]
        v = SMTVar(self.var_counter, var, type_info)
        v.original_line = line
        self.add_var(v)

    def _simplify_expr(self, expr):
        if not isinstance(expr, list) or not expr:
            return expr
        h = expr[0]
        if h == 'let':
            b = expr[1]
            body = expr[2]
            while isinstance(body, list) and body and body[0] == 'let':
                b.extend(body[1])
                body = body[2]
            return ['let', b, self._simplify_expr(body)]
        elif h in ['re.++', 're.union']:
            merged = [h]
            for sub in expr[1:]:
                simplified = self._simplify_expr(sub)
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
                                return self._simplify_expr(result)
                return result
            return merged
        elif h in ['re.*', 're.+']:
            body = self._simplify_expr(expr[1])
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
                                return [h, self._simplify_expr(new_union)]
            return [h, body]
        return [self._simplify_expr(e) for e in expr]

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

    def _process_assert(self, line):
        expr = Parser.parse_expression(Parser.tokenize(line))
        expr = self._simplify_expr(expr)
        expr = self._rename_var(expr)
        if isinstance(expr, list) and len(expr) > 1 and isinstance(expr[1], list):
            clu_type = ExprFormatter.classify_type(expr[1]) if expr[1] else 'default'
        else:
            clu_type = 'default'
        clause = SMTClause(self.clause_counter, expr[1], clu_type)
        clause.original_line = line
        self.add_clause(clause)

    def process_line(self, line):
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
        self.lemmas.append(lemma)
        self.lemma_counter += 1
        
    def add_tmp_var(self, var):
        self.tmp_vars.append(var)
        self.tmp_var_counter += 1

    def update_info(self):
        self.var_map = {var.name: var.index for var in self.vars}
        for clause in self.clauses:
            if clause.type == 'not':
                continue
            variables = clause.vars
            characters = clause.chars
            for var_name in variables:
                var = self.get_var(var_name)
                var.allow = var.allow.intersection(characters)

class SMTProcessor:
    def __init__(self):
        self.info = SMTInfo()

    def _get_re_elements(self, clause):
        if not isinstance(clause.expr, list):
            return None, None
        expr = clause.expr
        if expr[0] == 'not':
            expr = expr[1]
        if expr[0] == 'str.in_re':
            left_expr = expr[1]
            right_expr = expr[2]
            left_expr = self._split_string_constants(left_expr)
            if isinstance(right_expr, list) and right_expr[0] == 're.++':
                right_expr = right_expr[1:]
            else:
                right_expr = [right_expr]
            return left_expr, right_expr
        return None, None

    def _get_variables(self, expr):
        vars_found = set()
        if isinstance(expr, str) and expr.startswith('x'):
            vars_found.add(expr)
        elif isinstance(expr, list):
            for e in expr:
                vars_found.update(self._get_variables(e))
        return vars_found

    def _get_var_map(self, lemmas):
        var_map = {}
        for lemma in lemmas:
            if not isinstance(lemma.expr, list) or lemma.expr[0] != 'str.in_re' or len(lemma.expr) < 3:
                continue
            left_expr = lemma.expr[1]
            right_expr = lemma.expr[2]
            left_expr, right_expr = self._get_re_elements(lemma)
            if len(left_expr) == 1 and isinstance(left_expr[0], str) and left_expr[0].startswith('x'):
                var_name = left_expr[0]
                if var_name not in var_map:
                    var_map[var_name] = []
                var_map[var_name].append(right_expr)
        return var_map

    def _get_lits(self, re_expr):
        if not re_expr:
            return []
        if not isinstance(re_expr, list):
            return [re_expr]
        op = re_expr[0] if re_expr else None
        if op == 're.union':
            results = []
            for p in re_expr[1:]:
                sub_results = self._get_lits(p)
                results.extend(sub_results)
            return results
        elif op == 're.++':
            parts = []
            for p in re_expr[1:]:
                sub_results = self._get_lits(p)
                if sub_results:
                    parts.append(sub_results)
                else:
                    parts.append([p])
            if len(parts) == 1:
                return parts[0]
            def cartesian_product(lists, i=0):
                if i == len(lists):
                    return [[]]
                result = []
                for elem in lists[i]:
                    for rest in cartesian_product(lists, i+1):
                        result.append([elem] + rest)
                return result
            combos = cartesian_product(parts)
            results = []
            for combo in combos:
                if len(combo) == 1:
                    results.append(combo[0])
                else:
                    new_expr = ['re.++']
                    for item in combo:
                        if isinstance(item, list) and item and item[0] == 're.++':
                            new_expr.extend(item[1:])
                        else:
                            new_expr.append(item)
                    results.append(new_expr)
            return results
        elif op in ['re.*', 're.+']:
            inner = re_expr[1]
            inner_results = self._get_lits(inner)
            if len(inner_results) <= 1:
                return [re_expr]
            results = []
            for inner_result in inner_results:
                results.append([op, inner_result])
            return results
        return [re_expr]

    def _get_constant(self, expr):
        if isinstance(expr, str):
            if expr.startswith('"') and len(expr) > 2:
                char = expr[1:-1]
                return {char: 1}
            return {}
        if not isinstance(expr, list):
            return {}
        if expr and expr[0] == 'str.to_re' and len(expr) > 1:
            if isinstance(expr[1], str) and expr[1].startswith('"'):
                char = expr[1][1:-1]
                return {char: 1}
            return {}
        constants = {}
        var_allows = set()
        vars_in_expr = []
        for e in expr:
            if isinstance(e, str) and e.startswith('x'):
                vars_in_expr.append(e)
        for var_name in vars_in_expr:
            try:
                var = self.info.get_var(var_name)
                var_allows.update(var.allow)
            except KeyError:
                continue
        for e in expr:
            if isinstance(e, str) and e.startswith('"') and len(e) > 2:
                char = e[1:-1]
                if not any(c in var_allows for c in char):
                    constants[char] = constants.get(char, 0) + 1
            elif isinstance(e, list):
                sub_constants = self._get_constant(e)
                for char, count in sub_constants.items():
                    if not any(c in var_allows for c in char):
                        constants[char] = constants.get(char, 0) + count
        return constants

    def _split_string_constants(self, expr):
        if isinstance(expr, str):
            if expr.startswith('"'):
                chars = []
                for char in expr[1:-1]:
                    chars.append(f'"{char}"')
                return chars
            return [expr]
        if isinstance(expr, list) and expr and expr[0] == 'str.++':
            result = []
            for e in expr[1:]:
                result.extend(self._split_string_constants(e))
            return result
        return [self._split_string_constants(e) for e in expr]

    def _contains_constant(self, expr, constant):
        if not isinstance(expr, list):
            return expr == constant
        if expr[0] == 'str.to_re' and len(expr) > 1:
            return expr[1] == constant
        for sub_expr in expr[1:]:
            if self._contains_constant(sub_expr, constant):
                return True
        return False

    def _create_lemma(self, constraint, type="in"):
        if type == "in" or type == "not":
            var_expr, re_expr = constraint[0], constraint[1]
            if not re_expr:
                re_expr = ['re.none']
            if not var_expr or not re_expr:
                return None
            if type == "in":
                expr = ['str.in_re', var_expr, re_expr]
                comment = f"{ExprFormatter.to_comment(var_expr)} in {ExprFormatter.to_comment(re_expr)}"
            else:  # type == "not"
                expr = ['not', ['str.in_re', var_expr, re_expr]]
                comment = f"{ExprFormatter.to_comment(var_expr)} not in {ExprFormatter.to_comment(re_expr)}"
        elif type == "arith":
            expr = constraint
            comment = f"Length constraint: {ExprFormatter.to_comment(constraint)}"
        else:
            return None
        lemma = SMTLemma(self.info.lemma_counter, expr, comment)
        return lemma

    def _normalize_expr(self, expr, is_regex=False):
        if not expr:
            return []
        if len(expr) == 1:
            return expr[0]
        concat_op = 're.++' if is_regex else 'str.++'
        return [concat_op] + expr

    def _find_first_unique_constant(self, expr):
        if not isinstance(expr, list):
            if isinstance(expr, str) and expr.startswith('"'):
                char = expr[1:-1]
                for var_name in self._get_variables(expr):
                    var = self.info.get_var(var_name)
                    if var.allow is not None and char in var.allow:
                        return None
                return 0
            return None
        for i, e in enumerate(expr):
            if isinstance(e, str) and e.startswith('"'):
                char = e[1:-1]
                is_unique = True
                for var_name in self._get_variables(expr):
                    var = self.info.get_var(var_name)
                    if var.allow is not None and char in var.allow:
                        is_unique = False
                        break
                if is_unique:
                    return i
        return None

    def _get_constant_in_pattern(self, re_expr, constant):
        if not isinstance(re_expr, list) or not re_expr:
            return []
        indices = []
        for i, sub_expr in enumerate(re_expr):
            if isinstance(sub_expr, list) and sub_expr and sub_expr[0] in ['re.*', 're.+']:
                if self._contains_constant(sub_expr[1], constant):
                    indices.append(i)
            elif self._contains_constant(sub_expr, constant):
                indices.append(i)
        return indices

    def _is_direct_match(self, expr, constant):
        if isinstance(expr, list) and expr[0] == 'str.to_re' and len(expr) > 1:
            return expr[1] == constant
        return expr == constant

    def _is_complex_match(self, expr, constant):
        if not isinstance(expr, list):
            return False
        const_count = self._get_constant(expr).get(constant[1:-1], 0)
        if const_count != 1:
            return False
        if expr[0] == 're.++':
            for i in range(1, len(expr)):
                if self._is_direct_match(expr[i], constant):
                    return True
                if isinstance(expr[i], list) and self._is_complex_match(expr[i], constant):
                    return True
        elif expr[0] == 're.union':
            for i in range(1, len(expr)):
                if self._is_complex_match(expr[i], constant):
                    return True
        elif expr[0] in ['re.*', 're.+']:
            return self._is_complex_match(expr[1], constant)
        return False

    def _get_deploy_pattern(self, pattern, constant):
        if not isinstance(pattern, list) or len(pattern) < 2:
            return None
        if pattern[0] not in ['re.*', 're.+']:
            return None
        body = pattern[1]
        if not isinstance(body, list) or body[0] != 're.union':
            return None
        direct_matches = []
        complex_matches = []
        for i, term in enumerate(body[1:], 1):
            const_count = self._get_constant(term).get(constant[1:-1], 0)
            if const_count == 1:
                if self._is_direct_match(term, constant):
                    direct_matches.append(term)
                elif self._is_complex_match(term, constant):
                    complex_matches.append(term)
        if not direct_matches and not complex_matches:
            return None
        middle_part = ['re.union']
        middle_part.extend(direct_matches)
        middle_part.extend(complex_matches)
        if len(middle_part) == 2:
            middle_part = middle_part[1]
        return [pattern, middle_part, pattern]
    
    def _get_sides_pattern(self, pattern, constant):
        if not isinstance(pattern, list):
            if self._is_direct_match(pattern, constant):
                return [['str.to_re', '""']], [['str.to_re', '""']]
            return [], []
        if pattern[0] != 're.union':
            if pattern[0] == 're.++':
                left_parts = []
                right_parts = []
                for i, part in enumerate(pattern[1:]):
                    if self._is_direct_match(part, constant):
                        left_expr = pattern[1:i+1]
                        right_expr = pattern[i+2:] if i+2 < len(pattern) else []
                        if not left_expr:
                            left_parts.append(['str.to_re', '""'])
                        elif len(left_expr) == 1:
                            left_parts.append(left_expr[0])
                        else:
                            left_parts.append(['re.++'] + left_expr)
                        if not right_expr:
                            right_parts.append(['str.to_re', '""'])
                        elif len(right_expr) == 1:
                            right_parts.append(right_expr[0])
                        else:
                            right_parts.append(['re.++'] + right_expr)
                return left_parts, right_parts
            return [], []
        left_parts = []
        right_parts = []
        for option in pattern[1:]:
            if isinstance(option, list) and option[0] == 're.++':
                for i, part in enumerate(option[1:]):
                    if self._is_direct_match(part, constant):
                        left_expr = option[1:i+1]
                        right_expr = option[i+2:] if i+2 < len(option) else []
                        if not left_expr:
                            left_parts.append(['str.to_re', '""'])
                        elif len(left_expr) == 1:
                            left_parts.append(left_expr[0])
                        else:
                            left_parts.append(['re.++'] + left_expr)
                        if not right_expr:
                            right_parts.append(['str.to_re', '""'])
                        elif len(right_expr) == 1:
                            right_parts.append(right_expr[0])
                        else:
                            right_parts.append(['re.++'] + right_expr)
            elif self._is_direct_match(option, constant):
                left_parts.append(['str.to_re', '""'])
                right_parts.append(['str.to_re', '""'])
        if not left_parts:
            return [], []
        if len(left_parts) == 1:
            return left_parts, right_parts
        return [['re.union'] + left_parts], [['re.union'] + right_parts]

    def _get_split_pattern(self, left_expr, right_expr, constant_index, constant_in_index):
        left_left, _, left_right = left_expr[:constant_index], left_expr[constant_index], left_expr[constant_index+1:]
        left_mid = left_expr[constant_index]
        right_mid = right_expr[constant_in_index]
        deploy_pattern = self._get_deploy_pattern(right_mid, left_mid)
        if not deploy_pattern:
            return None
        right_left, right_right = right_expr[:constant_in_index], right_expr[constant_in_index+1:]
        right_left = right_left + [deploy_pattern[0]]
        right_right = [deploy_pattern[2]] + right_right
        constant_in_left, constant_in_right = self._get_sides_pattern(deploy_pattern[1], left_mid)
        right_left.extend(constant_in_left)
        right_right = constant_in_right + right_right
        left_left = self._normalize_expr(left_left)
        left_right = self._normalize_expr(left_right)
        right_left = self._normalize_expr(right_left, is_regex=True)
        right_right = self._normalize_expr(right_right, is_regex=True)
        return [left_left, left_right, right_left, right_right]

    def _get_lemmas_re_in_split(self, clause):
        lemmas = []
        left_expr, right_expr = self._get_re_elements(clause)
        if not left_expr or not right_expr:
            return lemmas
        domain_quota = self._get_constant(left_expr)
        unique_chars = set()
        for key, value in domain_quota.items():
            if value == 1:
                unique_chars.add(key)
        if not unique_chars:
            return lemmas
        constant_index = self._find_first_unique_constant(left_expr)
        constant_in_index = self._get_constant_in_pattern(right_expr, left_expr[constant_index])
        if len(constant_in_index) == 0 or len(constant_in_index) > 1:
            return lemmas
        constant_in_index = constant_in_index[0]
        result = self._get_split_pattern(left_expr, right_expr, constant_index, constant_in_index)
        if not result:
            return lemmas
        left_left, left_right, right_left, right_right = result
        if isinstance(left_left, str) and left_left.startswith('x') or (isinstance(left_left, list) and left_left[0] == 'str.++' and left_left[1].startswith('x')):
            lemmas.append(self._create_lemma([left_left, right_left]))
        else:
            new_clause = SMTClause(self.info.clause_counter, ['str.in_re', left_left, right_left], 're_in')
            sub_lemmas = self._get_lemmas_re_in(new_clause)
            lemmas.extend(sub_lemmas)
        if isinstance(left_right, str) and left_right.startswith('x') or (isinstance(left_right, list) and left_right[0] == 'str.++' and left_right[1].startswith('x')):
            lemmas.append(self._create_lemma([left_right, right_right]))
        else:
            new_clause = SMTClause(self.info.clause_counter, ['str.in_re', left_right, right_right], 're_in')
            sub_lemmas = self._get_lemmas_re_in(new_clause)
            lemmas.extend(sub_lemmas)
        return lemmas
    
    def _get_lemmas_re_in(self, clause):
        lemmas = []
        lemmas.extend(self._get_lemmas_re_in_split(clause))
        for lemma in lemmas:
            self.info.add_lemma(lemma)
    
    def _get_lemmas_not_in_split(self, clause):
        lemmas = []
        left_expr, right_expr = self._get_re_elements(clause)
        if not left_expr or not right_expr:
            return lemmas
        domain_quota = self._get_constant(left_expr)
        unique_chars = set()
        for key, value in domain_quota.items():
            if value == 1:
                unique_chars.add(key)
        if not unique_chars:
            return lemmas
        constant_index = self._find_first_unique_constant(left_expr)
        constant_in_index = self._get_constant_in_pattern(right_expr, left_expr[constant_index])
        if len(constant_in_index) == 0 or len(constant_in_index) > 1:
            return lemmas
        constant_in_index = constant_in_index[0]
        result = self._get_split_pattern(left_expr, right_expr, constant_index, constant_in_index)
        if not result:
            return lemmas
        left_left, left_right, right_left, right_right = result
        if isinstance(left_left, str) and left_left.startswith('x') or (isinstance(left_left, list) and left_left[0] == 'str.++' and left_left[1].startswith('x')):
            lemmas.append(self._create_lemma([left_left, right_left], type="not"))
        else:
            new_clause = SMTClause(self.info.clause_counter, ['str.in_re', left_left, right_left], 're_in')
            sub_lemmas = self._get_lemmas_re_in(new_clause)
            lemmas.extend(sub_lemmas)
        if isinstance(left_right, str) and left_right.startswith('x') or (isinstance(left_right, list) and left_right[0] == 'str.++' and left_right[1].startswith('x')):
            lemmas.append(self._create_lemma([left_right, right_right], type="not"))
        else:
            new_clause = SMTClause(self.info.clause_counter, ['str.in_re', left_right, right_right], 're_in')
            sub_lemmas = self._get_lemmas_re_in(new_clause)
            lemmas.extend(sub_lemmas)
        return lemmas
        
    def _get_lemmas_not_in(self, clause):
        lemmas = []
        lemmas.extend(self._get_lemmas_not_in_split(clause))
        for lemma in lemmas:
            self.info.add_lemma(lemma)

    def _filter_by_allowed_chars(self, expr, allowed_chars):
        if not allowed_chars:
            return expr
        if not isinstance(expr, list):
            if isinstance(expr, str) and expr.startswith('"'):
                char = expr[1:-1]
                if not char:
                    return expr
                if not all(c in allowed_chars for c in char):
                    return ['str.to_re', '""']
            return expr
        if not expr:
            return ['str.to_re', '""']
        if expr[0] == 'str.to_re' and len(expr) > 1:
            if isinstance(expr[1], str) and expr[1].startswith('"'):
                char = expr[1][1:-1]
                if not char:
                    return expr
                if not all(c in allowed_chars for c in char):
                    return ['str.to_re', '""']
            return expr
        elif expr[0] == 're.range' and len(expr) == 3:
            start, end = expr[1][1:-1], expr[2][1:-1]
            chars_in_range = set(chr(c) for c in range(ord(start), ord(end) + 1))
            if not chars_in_range.intersection(allowed_chars):
                return ['str.to_re', '""']
            return expr
        elif expr[0] == 're.++':
            filtered = []
            for e in expr[1:]:
                filtered_e = self._filter_by_allowed_chars(e, allowed_chars)
                if filtered_e == ['str.to_re', '""']:
                    return ['str.to_re', '""']
                filtered.append(filtered_e)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.++'] + filtered
        elif expr[0] == 're.union':
            filtered = []
            for e in expr[1:]:
                filtered_e = self._filter_by_allowed_chars(e, allowed_chars)
                if filtered_e != ['str.to_re', '""']:
                    filtered.append(filtered_e)
                elif filtered_e == ['str.to_re', '""'] and (e == ['str.to_re', '""'] or e == '""'):
                    filtered.append(filtered_e)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.union'] + filtered
        elif expr[0] in ['re.*', 're.+']:
            body = self._filter_by_allowed_chars(expr[1], allowed_chars)
            if body == ['str.to_re', '""']:
                return ['str.to_re', '""'] 
            return [expr[0], body]
        return [expr[0]] + [self._filter_by_allowed_chars(e, allowed_chars) for e in expr[1:]]

    def _remove_redundant_constants(self, expr):
        if not isinstance(expr, list):
            return expr
        if not expr:
            return expr
        if expr[0] == 're.union':
            seen_empty = False
            filtered = []
            for e in expr[1:]:
                e_simplified = self._remove_redundant_constants(e)
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
        elif expr[0] == 're.++':
            filtered = []
            for e in expr[1:]:
                e_simplified = self._remove_redundant_constants(e)
                filtered.append(e_simplified)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.++'] + filtered
        elif expr[0] in ['re.*', 're.+']:
            body = self._remove_redundant_constants(expr[1])
            return [expr[0], body]
        return [expr[0]] + [self._remove_redundant_constants(e) for e in expr[1:]]

    def _remove_empty_strings(self, expr):
        if not isinstance(expr, list):
            return expr
        if not expr:
            return expr
        if expr[0] == 're.++':
            filtered = []
            for e in expr[1:]:
                e_simplified = self._remove_empty_strings(e)
                if e_simplified == ['str.to_re', '""']:
                    continue
                if isinstance(e_simplified, list) and e_simplified[0] in ['re.*', 're.+'] and e_simplified[1] == ['str.to_re', '""']:
                    continue
                filtered.append(e_simplified)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.++'] + filtered
        elif expr[0] == 're.union':
            filtered = []
            for e in expr[1:]:
                e_simplified = self._remove_empty_strings(e)
                filtered.append(e_simplified)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.union'] + filtered
        elif expr[0] in ['re.*', 're.+']:
            body = self._remove_empty_strings(expr[1])
            return [expr[0], body]
        return [expr[0]] + [self._remove_empty_strings(e) for e in expr[1:]]

    def _get_lemma_arith(self, var, lit, tmp_index):
        allowed_char = next(iter(var.allow))
        var_name = var.name
        var_len = ['str.len', var_name]
        tmp_vars = []
        tmp_constraints = []
        if not isinstance(lit, list):
            if isinstance(lit, str) and lit.startswith('"'):
                content = lit[1:-1]
                if all(c == allowed_char for c in content):
                    return [], [], ['=', var_len, str(len(content))]
            return None, None, None
        op = lit[0] if lit else None
        if op == 'str.to_re':
            if len(lit) > 1 and isinstance(lit[1], str) and lit[1].startswith('"'):
                content = lit[1][1:-1]
                if all(c == allowed_char for c in content) or content == '':
                    return [], [], ['=', var_len, str(len(content))]
            return None, None, None
        elif op == 're.++':
            total_len = 0
            var_terms = []
            current_tmp_index = tmp_index
            for p in lit[1:]:
                if isinstance(p, str) and p.startswith('"'):
                    content = p[1:-1]
                    if all(c == allowed_char for c in content):
                        total_len += len(content)
                    else:
                        return None, None, None
                elif isinstance(p, list):
                    if p[0] == 'str.to_re' and len(p) > 1 and isinstance(p[1], str) and p[1].startswith('"'):
                        content = p[1][1:-1]
                        if all(c == allowed_char for c in content) or content == '':
                            total_len += len(content)
                        else:
                            return None, None, None
                    elif p[0] == 're.*':
                        inner = p[1]
                        if isinstance(inner, list) and inner[0] == 're.++':
                            inner_len = 0
                            all_valid = True
                            for inner_part in inner[1:]:
                                inner_part_len = self._get_constant_length(inner_part, allowed_char)
                                if inner_part_len is None:
                                    all_valid = False
                                    break
                                inner_len += inner_part_len
                            if all_valid and inner_len > 0:
                                tmp_var_name = f"len_tmp{current_tmp_index}"
                                current_tmp_index += 1
                                tmp_var = SMTVar(current_tmp_index, tmp_var_name, "Int", name = tmp_var_name)
                                tmp_var.used = True
                                tmp_vars.append(tmp_var)
                                tmp_constraints.append(['>=', tmp_var_name, '0'])
                                var_terms.append(['*', str(inner_len), tmp_var_name])
                            else:
                                return None, None, None
                        else:
                            k = self._get_constant_length(inner, allowed_char)
                            if k is not None:
                                if k == 0:
                                    continue
                                tmp_var_name = f"len_tmp{current_tmp_index}"
                                current_tmp_index += 1
                                tmp_var = SMTVar(current_tmp_index, tmp_var_name, "Int", name = tmp_var_name)
                                tmp_var.used = True
                                tmp_vars.append(tmp_var)
                                tmp_constraints.append(['>=', tmp_var_name, '0'])
                                if k == 1:
                                    var_terms.append(tmp_var_name)
                                else:
                                    var_terms.append(['*', str(k), tmp_var_name])
                            else:
                                return None, None, None
                    elif p[0] == 're.+':
                        inner = p[1]
                        if isinstance(inner, list) and inner[0] == 're.++':
                            inner_len = 0
                            all_valid = True
                            for inner_part in inner[1:]:
                                inner_part_len = self._get_constant_length(inner_part, allowed_char)
                                if inner_part_len is None:
                                    all_valid = False
                                    break
                                inner_len += inner_part_len
                            if all_valid and inner_len > 0:
                                tmp_var_name = f"len_tmp{current_tmp_index}"
                                current_tmp_index += 1
                                tmp_var = SMTVar(current_tmp_index, tmp_var_name, "Int", name = tmp_var_name)
                                tmp_var.used = True
                                tmp_vars.append(tmp_var)
                                tmp_constraints.append(['>=', tmp_var_name, '1'])
                                var_terms.append(['*', str(inner_len), tmp_var_name])
                            else:
                                return None, None, None
                        else:
                            k = self._get_constant_length(inner, allowed_char)
                            if k is not None:
                                if k == 0:
                                    continue
                                tmp_var_name = f"len_tmp{current_tmp_index}"
                                current_tmp_index += 1
                                tmp_var = SMTVar(current_tmp_index, tmp_var_name, "Int", name = tmp_var_name)
                                tmp_var.used = True
                                tmp_vars.append(tmp_var)
                                tmp_constraints.append(['>=', tmp_var_name, '1'])
                                if k == 1:
                                    var_terms.append(tmp_var_name)
                                else:
                                    var_terms.append(['*', str(k), tmp_var_name])
                            else:
                                return None, None, None
                    else:
                        return None, None, None
                else:
                    return None, None, None
            if total_len > 0 or var_terms:
                if not var_terms:
                    return [], [], ['=', var_len, str(total_len)]
                elif total_len == 0:
                    if len(var_terms) == 1:
                        return tmp_vars, tmp_constraints, ['=', var_len, var_terms[0]]
                    else:
                        sum_expr = ['+'] + var_terms
                        return tmp_vars, tmp_constraints, ['=', var_len, sum_expr]
                else:
                    if len(var_terms) == 1:
                        return tmp_vars, tmp_constraints, ['=', var_len, ['+', str(total_len), var_terms[0]]]
                    else:
                        sum_expr = ['+', str(total_len)] + var_terms
                        return tmp_vars, tmp_constraints, ['=', var_len, sum_expr]
            return [], [], ['=', var_len, '0']
        elif op == 're.*':
            inner = lit[1]
            if isinstance(inner, list) and inner[0] == 're.++':
                inner_len = 0
                all_valid = True
                for part in inner[1:]:
                    part_len = self._get_constant_length(part, allowed_char)
                    if part_len is None:
                        all_valid = False
                        break
                    inner_len += part_len
                if all_valid and inner_len > 0:
                    tmp_var_name = f"len_tmp{tmp_index}"
                    tmp_var = SMTVar(tmp_index, tmp_var_name, "Int", name = tmp_var_name)
                    tmp_var.used = True
                    tmp_constraint = ['>=', tmp_var_name, '0']
                    length_expr = ['=', var_len, ['*', str(inner_len), tmp_var_name]]
                    return [tmp_var], [tmp_constraint], length_expr
            else:
                k = self._get_constant_length(inner, allowed_char)
                if k is not None:
                    if k == 0:
                        return [], [], ['=', var_len, '0']
                    tmp_var_name = f"len_tmp{tmp_index}"
                    tmp_var = SMTVar(tmp_index, tmp_var_name, "Int", name = tmp_var_name)
                    tmp_var.used = True
                    tmp_constraint = ['>=', tmp_var_name, '0']
                    if k == 1:
                        length_expr = ['=', var_len, tmp_var_name]
                    else:
                        length_expr = ['=', var_len, ['*', str(k), tmp_var_name]]
                    return [tmp_var], [tmp_constraint], length_expr
        elif op == 're.+':
            inner = lit[1]
            if isinstance(inner, list) and inner[0] == 're.++':
                inner_len = 0
                all_valid = True
                for part in inner[1:]:
                    part_len = self._get_constant_length(part, allowed_char)
                    if part_len is None:
                        all_valid = False
                        break
                    inner_len += part_len
                if all_valid and inner_len > 0:
                    tmp_var_name = f"len_tmp{tmp_index}"
                    tmp_var = SMTVar(tmp_index, tmp_var_name, "Int", name = tmp_var_name)
                    tmp_var.used = True
                    tmp_constraint = ['>=', tmp_var_name, '1']
                    length_expr = ['=', var_len, ['*', str(inner_len), tmp_var_name]]
                    return [tmp_var], [tmp_constraint], length_expr
            else:
                k = self._get_constant_length(inner, allowed_char)
                if k is not None:
                    if k == 0:
                        return [], [], ['=', var_len, '0']
                    tmp_var_name = f"len_tmp{tmp_index}"
                    tmp_var = SMTVar(tmp_index, tmp_var_name, "Int", name = tmp_var_name)
                    tmp_var.used = True
                    tmp_constraint = ['>=', tmp_var_name, '1']
                    if k == 1:
                        length_expr = ['=', var_len, tmp_var_name]
                    else:
                        length_expr = ['=', var_len, ['*', str(k), tmp_var_name]]
                    return [tmp_var], [tmp_constraint], length_expr
        elif op == 're.range':
            if len(lit) == 3:
                start, end = lit[1][1:-1], lit[2][1:-1]
                if start <= allowed_char <= end:
                    return [], [], ['=', var_len, '1']
        elif op == 're.union':
            union_constraints = []
            for p in lit[1:]:
                part_result = self._get_lemma_arith(var, p, tmp_index)
                if part_result and part_result[2]:
                    union_constraints.append(part_result[2])
            if union_constraints:
                if len(union_constraints) == 1:
                    return [], [], union_constraints[0]
                else:
                    return [], [], ['or'] + union_constraints
        return None, None, None

    def _get_constant_length(self, pattern, allowed_char):
        if isinstance(pattern, str):
            if pattern.startswith('"'):
                content = pattern[1:-1]
                if all(c == allowed_char for c in content) or content == '':
                    return len(content)
            return None
        if not isinstance(pattern, list) or not pattern:
            return None
        op = pattern[0]
        if op == 'str.to_re' and len(pattern) > 1:
            if isinstance(pattern[1], str) and pattern[1].startswith('"'):
                content = pattern[1][1:-1]
                if all(c == allowed_char for c in content) or content == '':
                    return len(content)
        elif op == 're.range' and len(pattern) == 3:
            start, end = pattern[1][1:-1], pattern[2][1:-1]
            if start <= allowed_char <= end:
                return 1
        return None

    def _merge_lemmas(self, var_name, re_exprs, declares_index):
        var = self.info.get_var(var_name)
        if len(var.allow) != 1:
            return [], []
        all_tmp_vars = []
        all_lemmas = []
        all_constraints = []
        for re_expr in re_exprs:
            constraints = []
            if len(re_expr) >= 2 and all(isinstance(e, list) for e in re_expr):
                if not any(e and isinstance(e, list) and e[0] == 're.++' for e in re_expr):
                    re_expr = ['re.++'] + re_expr
            lits = self._get_lits(re_expr)
            for lit in lits:
                result = self._get_lemma_arith(var, lit, declares_index + len(all_tmp_vars))
                if result is None:
                    continue
                tmp_vars, tmp_constraints, length_expr = result
                if tmp_vars and tmp_constraints:
                    all_tmp_vars.extend(tmp_vars)
                    combined_constraint = length_expr
                    for constraint in tmp_constraints:
                        combined_constraint = ['and', constraint, combined_constraint]
                    constraints.append(combined_constraint)
                elif length_expr:
                    constraints.append(length_expr)
            if len(constraints) > 1:
                combined_constraint = ['or'] + constraints
            all_constraints.append(combined_constraint)
        if all_constraints:
            for constraint in all_constraints:
                lemma = self._create_lemma(constraint, type = "arith")
                all_lemmas.append(lemma)
        return all_tmp_vars, all_lemmas

    def _simplify_lemma(self, lemma):
        if not isinstance(lemma.expr, list) or lemma.expr[0] != 'str.in_re':
            return lemma.expr
        left_expr, right_expr = self._get_re_elements(lemma)
        if not left_expr or not right_expr:
            return lemma.expr
        allowed_chars = set()
        for expr in left_expr:
            if isinstance(expr, str) and expr.startswith('x'):
                var = self.info.get_var(expr)
                if var.allow:
                    allowed_chars.update(var.allow)
        right_expr = [self._filter_by_allowed_chars(expr, allowed_chars) for expr in right_expr]
        right_expr = [self._remove_redundant_constants(expr) for expr in right_expr]
        right_expr = [self._remove_empty_strings(expr) for expr in right_expr]
        right_expr = [expr for expr in right_expr if expr != ['str.to_re', '""']]
        if not right_expr:
            right_expr = [['str.to_re', '""']]
        return ['str.in_re', self._normalize_expr(left_expr), self._normalize_expr(right_expr, is_regex=True)]

    def _simplify_lemmas(self):
        for lemma in self.info.lemmas:
            lemma.expr = self._simplify_lemma(lemma)
        lemmas_var_map = self._get_var_map(self.info.lemmas)
        declares_index = 0
        declares_new = []
        lemmas_new = []
        for key, value in lemmas_var_map.items():
            if len(value) > 1:
                var = self.info.get_var(key)
                if len(var.allow) == 1:
                    new_declares, new_lemmas = self._merge_lemmas(key, value, declares_index)
                    declares_new.extend(new_declares)
                    declares_index += len(new_declares)
                    lemmas_new.extend(new_lemmas)
        for declare in declares_new:
            self.info.add_tmp_var(declare)
        for lemma in lemmas_new:
            self.info.add_lemma(lemma)

        for var in self.info.tmp_vars:
            print(var.get_smt2())
        for lemma in self.info.lemmas:
            print(lemma.get_comment())

    def _solve(self):
        pass

    def process_file(self, input_file, output_file=None):
        # try:
        with open(input_file, 'r') as f:
            lines = f.readlines()
            for line in lines:
                self.info.process_line(line)
        self.info.update_info()
        
        clauses_re = [clu for clu in self.info.clauses if clu.type == 're_in']
        clauses_nre = [clu for clu in self.info.clauses if clu.type == 'not']
        # for clause in clauses_re:
        #     self._get_lemmas_re_in(clause)
        for clause in clauses_nre:
            self._get_lemmas_not_in(clause)
        self._simplify_lemmas()
        
        outputs = []
        outputs.extend(self.info.preamble)
        for var in self.info.vars:
            var_smt2 = var.get_smt2()
            if var_smt2:
                outputs.append(var_smt2)
        for clause in self.info.clauses:
            outputs.append(clause.get_smt2())
        outputs.extend(self.info.postamble)
        outputs.append("; ========================== [comments] ==========================")
        for clause in self.info.clauses:
            comment = clause.get_comment()
            if comment:
                outputs.append(comment)
        out = output_file if output_file else input_file
        with open(out, 'w') as f:
            for o in outputs:
                f.write(o + '\n')
        logging.info(f"Processed file saved to: {out}")
        self._solve()
        # except Exception as e:
        #     logging.error(f"Error processing file: {input_file}")
        #     logging.error(f"Exception: {e}")


if __name__=='__main__':
    if len(sys.argv) not in [2,3]:
        print('Usage: python script.py <input_file> [output_file]')
        sys.exit(1)
    input_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv)==3 else None
    SMTProcessor().process_file(input_file, output_file)