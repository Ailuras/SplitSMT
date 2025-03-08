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
    def __init__(self, index, expr=None, comment=None):
        self.index = index
        self.expr = expr
        self.type = ExprFormatter.classify_type(expr) if expr else None
        self.comment = comment
        self.literals = []
    
    def __eq__(self, other):
        if not isinstance(other, SMTLemma):
            return False
        return self.index == other.index
        
    def __hash__(self):
        return hash(self.index)
    
    def add_literal(self, lit):
        if lit not in self.literals:
            self.literals.append(lit)
    
    def get_smt2(self):
        if self.expr:
            return ExprFormatter.to_smt2(['assert', self.expr])
        elif self.literals:
            combined_expr = None
            for lit in self.literals:
                if combined_expr is None:
                    combined_expr = lit.get_expr()
                else:
                    combined_expr = ['and', combined_expr, lit.get_expr()]
            return ExprFormatter.to_smt2(['assert', combined_expr])
        return None
    
    def get_comment(self):
        if self.comment:
            return f"; {self.comment}"
        elif self.expr:
            return f"; {ExprFormatter.to_comment(self.expr)}"
        elif self.literals:
            lit_comments = [ExprFormatter.to_comment(lit.get_expr()) for lit in self.literals]
            return f"; {' and '.join(lit_comments)}"
        return None

class SMTLit:
    def __init__(self, expr, is_negated=False, index=None):
        self.expr = expr
        self.is_negated = is_negated
        self.type = self._determine_type()
        self.index = index
        self.lemmas = []
        
    def __eq__(self, other):
        if not isinstance(other, SMTLit):
            return False
        if self.index is not None and other.index is not None:
            return self.index == other.index
        return str(self.expr) == str(other.expr) and self.is_negated == other.is_negated
        
    def __hash__(self):
        if self.index is not None:
            return hash(self.index)
        return hash((str(self.expr), self.is_negated))
    
    def _determine_type(self):
        if isinstance(self.expr, list):
            if len(self.expr) > 0:
                if self.expr[0] == 'str.in_re':
                    return 're_in'
                elif self.expr[0] == 'not' and len(self.expr) > 1 and isinstance(self.expr[1], list) and self.expr[1][0] == 'str.in_re':
                    return 're_not_in'
                elif self.expr[0] in ['=', '>=', '<=', '>', '<']:
                    return 'arith'
                elif self.expr[0] in ['and', 'or']:
                    return 'boolean'
        return 'unknown'
    
    def add_lemma(self, lemma):
        if lemma not in self.lemmas:
            self.lemmas.append(lemma)
            lemma.add_literal(self)
    
    def negate(self):
        return SMTLit(self.expr, not self.is_negated)
    
    def __and__(self, other):
        if not isinstance(other, SMTLit):
            return NotImplemented
        if self.is_negated and other.is_negated:
            return SMTLit(['or', ['not', self.expr], ['not', other.expr]], False)
        elif self.is_negated:
            return SMTLit(['and', ['not', self.expr], other.expr], False)
        elif other.is_negated:
            return SMTLit(['and', self.expr, ['not', other.expr]], False)
        else:
            return SMTLit(['and', self.expr, other.expr], False)
    
    def __or__(self, other):
        if not isinstance(other, SMTLit):
            return NotImplemented
        if self.is_negated and other.is_negated:
            return SMTLit(['and', ['not', self.expr], ['not', other.expr]], False)
        elif self.is_negated:
            return SMTLit(['or', ['not', self.expr], other.expr], False)
        elif other.is_negated:
            return SMTLit(['or', self.expr, ['not', other.expr]], False)
        else:
            return SMTLit(['or', self.expr, other.expr], False)
    
    def get_expr(self):
        if self.is_negated:
            return ['not', self.expr]
        return self.expr
    
    def simplify(self):
        if not isinstance(self.expr, list) or len(self.expr) <= 2:
            return self
        op = self.expr[0]
        if op in ['and', 'or']:
            if len(self.expr) == 2:
                return SMTLit(self.expr[1], self.is_negated, self.index)
            flattened = [op]
            for subexpr in self.expr[1:]:
                if isinstance(subexpr, list) and len(subexpr) > 0 and subexpr[0] == op:
                    flattened.extend(subexpr[1:])
                else:
                    flattened.append(subexpr)
            if len(flattened) == 2:
                return SMTLit(flattened[1], self.is_negated, self.index)
            return SMTLit(flattened, self.is_negated, self.index)
        return self
    
    def __str__(self):
        return f"{'not ' if self.is_negated else ''}{self.expr}"
    
    def __repr__(self):
        return str(self)

class SMTLitProcessor:
    @staticmethod
    def combine_literals(left_lits, right_lits, op='or'):
        if op == 'or':
            result = []
            for l_lit in left_lits:
                for r_lit in right_lits:
                    combined = SMTLit(['and', l_lit.get_expr(), r_lit.get_expr()], False)
                    result.append(combined)
            if len(result) == 1:
                return result[0]
            combined_expr = ['or']
            for lit in result:
                combined_expr.append(lit.get_expr())
            return SMTLit(combined_expr, False)
        elif op == 'and':
            if not left_lits or not right_lits:
                return None
            left_combined = left_lits[0] if len(left_lits) == 1 else SMTLit(['or'] + [l.get_expr() for l in left_lits], False)
            right_combined = right_lits[0] if len(right_lits) == 1 else SMTLit(['or'] + [r.get_expr() for r in right_lits], False)
            return [left_combined, right_combined]
        return None
    
    @staticmethod
    def create_re_in_lit(var_expr, re_expr, index=None):
        return SMTLit(['str.in_re', var_expr, re_expr], False, index)
    
    @staticmethod
    def create_re_not_in_lit(var_expr, re_expr, index=None):
        return SMTLit(['not', ['str.in_re', var_expr, re_expr]], False, index)
    
    @staticmethod
    def convert_to_lemmas(lit, index, info_manager=None):
        if lit.type == 'boolean' and lit.expr[0] == 'and':
            lemmas = []
            for subexpr in lit.expr[1:]:
                lemma = SMTLemma(index)
                if info_manager:
                    info_manager.add_lemma(lemma)
                sub_lit = SMTLit(subexpr, False, info_manager.literal_counter if info_manager else None)
                if info_manager:
                    info_manager.add_literal(sub_lit)
                sub_lit.add_lemma(lemma)
                lemmas.append(lemma)
                index += 1
            return lemmas
        lemma = SMTLemma(index)
        if info_manager:
            info_manager.add_lemma(lemma)
        lit.add_lemma(lemma)
        return [lemma]

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

    def add_literal(self, lit):
        if lit.index is None:
            lit.index = self.literal_counter
            self.literal_counter += 1
        self.literals.append(lit)

    def find_literal(self, expr, is_negated=False):
        for lit in self.literals:
            if str(lit.expr) == str(expr) and lit.is_negated == is_negated:
                return lit
        return None

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

class RegexProcessor:
    def __init__(self, info):
        self.info_manager = info
    
    def get_re_elements(self, clause):
        if not isinstance(clause.expr, list):
            return None, None
        expr = clause.expr
        if expr[0] == 'not':
            expr = expr[1]
        if expr[0] == 'str.in_re':
            left_expr = expr[1]
            right_expr = expr[2]
            left_expr = self.split_string_constants(left_expr)
            if isinstance(right_expr, list) and right_expr[0] == 're.++':
                right_expr = right_expr[1:]
            else:
                right_expr = [right_expr]
            return left_expr, right_expr
        return None, None
    
    def split_string_constants(self, expr):
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
                result.extend(self.split_string_constants(e))
            return result
        return [expr]
    
    def get_variables(self, expr):
        vars_found = set()
        if isinstance(expr, str) and expr.startswith('x'):
            vars_found.add(expr)
        elif isinstance(expr, list):
            for e in expr:
                vars_found.update(self.get_variables(e))
        return vars_found
    
    def get_lits(self, re_expr):
        if not re_expr:
            return []
        if not isinstance(re_expr, list):
            return [re_expr]
        op = re_expr[0] if re_expr else None
        if op == 're.union':
            results = []
            for p in re_expr[1:]:
                sub_results = self.get_lits(p)
                results.extend(sub_results)
            return results
        elif op == 're.++':
            parts = []
            for p in re_expr[1:]:
                sub_results = self.get_lits(p)
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
            inner_results = self.get_lits(inner)
            if len(inner_results) <= 1:
                return [re_expr]
            results = []
            for inner_result in inner_results:
                results.append([op, inner_result])
            return results
        return [re_expr]
    
    def get_constant(self, expr):
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
                var = self.info_manager.get_var(var_name)
                var_allows.update(var.allow)
            except KeyError:
                continue
        for e in expr:
            if isinstance(e, str) and e.startswith('"') and len(e) > 2:
                char = e[1:-1]
                if not any(c in var_allows for c in char):
                    constants[char] = constants.get(char, 0) + 1
            elif isinstance(e, list):
                sub_constants = self.get_constant(e)
                for char, count in sub_constants.items():
                    if not any(c in var_allows for c in char):
                        constants[char] = constants.get(char, 0) + count
        return constants
    
    def contains_constant(self, expr, constant):
        if not isinstance(expr, list):
            return expr == constant
        if expr[0] == 'str.to_re' and len(expr) > 1:
            return expr[1] == constant
        for sub_expr in expr[1:]:
            if self.contains_constant(sub_expr, constant):
                return True
        return False
    
    def is_direct_match(self, expr, constant):
        if isinstance(expr, list) and expr[0] == 'str.to_re' and len(expr) > 1:
            return expr[1] == constant
        return expr == constant
    
    def is_complex_match(self, expr, constant):
        if not isinstance(expr, list):
            return False
        const_count = self.get_constant(expr).get(constant[1:-1], 0)
        if const_count != 1:
            return False
        if expr[0] == 're.++':
            for i in range(1, len(expr)):
                if self.is_direct_match(expr[i], constant):
                    return True
                if isinstance(expr[i], list) and self.is_complex_match(expr[i], constant):
                    return True
        elif expr[0] == 're.union':
            for i in range(1, len(expr)):
                if self.is_complex_match(expr[i], constant):
                    return True
        elif expr[0] in ['re.*', 're.+']:
            return self.is_complex_match(expr[1], constant)
        return False
    
    def find_first_unique_constant(self, expr):
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
    
    def get_constant_in_pattern(self, re_expr, constant):
        if not isinstance(re_expr, list) or not re_expr:
            return []
        indices = []
        for i, sub_expr in enumerate(re_expr):
            if isinstance(sub_expr, list) and sub_expr and sub_expr[0] in ['re.*', 're.+']:
                if self.contains_constant(sub_expr[1], constant):
                    indices.append(i)
            elif self.contains_constant(sub_expr, constant):
                indices.append(i)
        return indices
    
    def get_deploy_pattern(self, pattern, constant):
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
            const_count = self.get_constant(term).get(constant[1:-1], 0)
            if const_count == 1:
                if self.is_direct_match(term, constant):
                    direct_matches.append(term)
                elif self.is_complex_match(term, constant):
                    complex_matches.append(term)
        if not direct_matches and not complex_matches:
            return None
        middle_part = ['re.union']
        middle_part.extend(direct_matches)
        middle_part.extend(complex_matches)
        if len(middle_part) == 2:
            middle_part = middle_part[1]
        return [pattern, middle_part, pattern]
    
    def get_sides_pattern(self, pattern, constant):
        if not isinstance(pattern, list):
            if self.is_direct_match(pattern, constant):
                return [['str.to_re', '""']], [['str.to_re', '""']]
            return [], []
        if pattern[0] != 're.union':
            if pattern[0] == 're.++':
                left_parts = []
                right_parts = []
                for i, part in enumerate(pattern[1:]):
                    if self.is_direct_match(part, constant):
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
                    if self.is_direct_match(part, constant):
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
            elif self.is_direct_match(option, constant):
                left_parts.append(['str.to_re', '""'])
                right_parts.append(['str.to_re', '""'])
        return left_parts, right_parts
    
    def get_split_pattern(self, left_expr, right_expr, constant_index, constant_in_index):
        left_left = left_expr[:constant_index]
        left_mid = left_expr[constant_index]
        left_right = left_expr[constant_index+1:]
        right_mid = right_expr[constant_in_index]
        deploy_pattern = self.get_deploy_pattern(right_mid, left_mid)
        if not deploy_pattern:
            return None
        right_left = right_expr[:constant_in_index]
        right_right = right_expr[constant_in_index+1:]
        right_left = right_left + [deploy_pattern[0]]
        right_right = [deploy_pattern[2]] + right_right
        constant_in_left, constant_in_right = self.get_sides_pattern(deploy_pattern[1], left_mid)
        if not constant_in_left or not constant_in_right:
            return None
        left_left_list = []
        left_right_list = []
        if not isinstance(left_left, list):
            left_left = [left_left]
        if not isinstance(left_right, list):
            left_right = [left_right]
        left_left = self.normalize_expr(left_left)
        left_right = self.normalize_expr(left_right)
        for left_part in constant_in_left:
            right_left_extended = right_left.copy() if isinstance(right_left, list) else [right_left]
            right_left_extended.append(left_part)
            right_left_norm = self.normalize_expr(right_left_extended, is_regex=True)
            left_left_list.append(['str.in_re', left_left, right_left_norm])
        for right_part in constant_in_right:
            right_right_extended = [right_part]
            right_right_extended.extend(right_right if isinstance(right_right, list) else [right_right])
            right_right_norm = self.normalize_expr(right_right_extended, is_regex=True)
            left_right_list.append(['str.in_re', left_right, right_right_norm])
        return [left_left_list, left_right_list]
    
    def normalize_expr(self, expr, is_regex=False):
        if not expr:
            return []
        if len(expr) == 1:
            return expr[0]
        concat_op = 're.++' if is_regex else 'str.++'
        return [concat_op] + expr

class LemmaGenerator:
    def __init__(self, info, regex_processor):
        self.info_manager = info
        self.regex_processor = regex_processor
    
    def get_lemmas_split(self, clause):
        left_expr, right_expr = self.regex_processor.get_re_elements(clause)
        if not left_expr or not right_expr:
            return [], []
        domain_quota = self.regex_processor.get_constant(left_expr)
        unique_chars = set()
        for key, value in domain_quota.items():
            if value == 1:
                unique_chars.add(key)
        if not unique_chars:
            return [], []
        constant_index = self.regex_processor.find_first_unique_constant(left_expr)
        if constant_index is None:
            return [], []
        constant_in_indices = self.regex_processor.get_constant_in_pattern(right_expr, left_expr[constant_index])
        if len(constant_in_indices) == 0 or len(constant_in_indices) > 1:
            return [], []
        constant_in_index = constant_in_indices[0]
        split_patterns = self.regex_processor.get_split_pattern(left_expr, right_expr, constant_index, constant_in_index)
        if not split_patterns:
            return [], []
        return split_patterns
    
    def create_lemma(self, constraint, type="in"):
        if type == "in" or type == "not":
            var_expr, re_expr = constraint[0], constraint[1]
            if not re_expr:
                re_expr = ['re.none']
            if not var_expr or not re_expr:
                return None
            
            lit = None
            if type == "in":
                expr = ['str.in_re', var_expr, re_expr]
                existing_lit = self.info_manager.find_literal(expr, False)
                if existing_lit:
                    lit = existing_lit
                else:
                    lit = SMTLit(expr, False, self.info_manager.literal_counter)
                    self.info_manager.add_literal(lit)
                comment = f"{ExprFormatter.to_comment(var_expr)} in {ExprFormatter.to_comment(re_expr)}"
            else:  # type == "not"
                expr = ['str.in_re', var_expr, re_expr]
                existing_lit = self.info_manager.find_literal(expr, True)
                if existing_lit:
                    lit = existing_lit
                else:
                    lit = SMTLit(expr, True, self.info_manager.literal_counter)
                    self.info_manager.add_literal(lit)
                comment = f"{ExprFormatter.to_comment(var_expr)} not in {ExprFormatter.to_comment(re_expr)}"
        elif type == "arith":
            expr = constraint
            existing_lit = self.info_manager.find_literal(expr, False)
            if existing_lit:
                lit = existing_lit
            else:
                lit = SMTLit(expr, False, self.info_manager.literal_counter)
                self.info_manager.add_literal(lit)
            comment = f"Length constraint: {ExprFormatter.to_comment(constraint)}"
        else:
            return None
        
        lemma = SMTLemma(self.info_manager.lemma_counter, comment=comment)
        self.info_manager.add_lemma(lemma)
        lit.add_lemma(lemma)
        
        return lemma

class ExpressionSimplifier:
    def __init__(self, info):
        self.info_manager = info
    
    def filter_by_allowed_chars(self, expr, allowed_chars):
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
        
        op = expr[0]
        if op == 'str.to_re' and len(expr) > 1:
            if isinstance(expr[1], str) and expr[1].startswith('"'):
                char = expr[1][1:-1]
                if not char:
                    return expr
                if not all(c in allowed_chars for c in char):
                    return ['str.to_re', '""']
            return expr
        elif op == 're.range' and len(expr) == 3:
            start, end = expr[1][1:-1], expr[2][1:-1]
            chars_in_range = set(chr(c) for c in range(ord(start), ord(end) + 1))
            if not chars_in_range.intersection(allowed_chars):
                return ['str.to_re', '""']
            return expr
        elif op == 're.++':
            filtered = []
            for e in expr[1:]:
                filtered_e = self.filter_by_allowed_chars(e, allowed_chars)
                if filtered_e == ['str.to_re', '""']:
                    return ['str.to_re', '""']
                filtered.append(filtered_e)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.++'] + filtered
        elif op == 're.union':
            filtered = []
            for e in expr[1:]:
                filtered_e = self.filter_by_allowed_chars(e, allowed_chars)
                if filtered_e != ['str.to_re', '""']:
                    filtered.append(filtered_e)
                elif filtered_e == ['str.to_re', '""'] and (e == ['str.to_re', '""'] or e == '""'):
                    filtered.append(filtered_e)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.union'] + filtered
        elif op in ['re.*', 're.+']:
            body = self.filter_by_allowed_chars(expr[1], allowed_chars)
            if body == ['str.to_re', '""']:
                return ['str.to_re', '""'] 
            return [op, body]
        
        return [op] + [self.filter_by_allowed_chars(e, allowed_chars) for e in expr[1:]]
    
    def remove_redundant_constants(self, expr):
        if not isinstance(expr, list):
            return expr
        if not expr:
            return expr
        
        op = expr[0]
        if op == 're.union':
            seen_empty = False
            filtered = []
            for e in expr[1:]:
                e_simplified = self.remove_redundant_constants(e)
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
        elif op == 're.++':
            filtered = []
            for e in expr[1:]:
                e_simplified = self.remove_redundant_constants(e)
                filtered.append(e_simplified)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.++'] + filtered
        elif op in ['re.*', 're.+']:
            body = self.remove_redundant_constants(expr[1])
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
                if isinstance(e_simplified, list) and e_simplified[0] in ['re.*', 're.+'] and e_simplified[1] == ['str.to_re', '""']:
                    continue
                filtered.append(e_simplified)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.++'] + filtered
        elif op == 're.union':
            filtered = []
            for e in expr[1:]:
                e_simplified = self.remove_empty_strings(e)
                filtered.append(e_simplified)
            if not filtered:
                return ['str.to_re', '""']
            if len(filtered) == 1:
                return filtered[0]
            return ['re.union'] + filtered
        elif op in ['re.*', 're.+']:
            body = self.remove_empty_strings(expr[1])
            return [op, body]
        
        return [op] + [self.remove_empty_strings(e) for e in expr[1:]]
    
    def simplify_lemma(self, lemma):
        if not isinstance(lemma.expr, list):
            return lemma.expr
        is_re_in = lemma.expr[0] == 'str.in_re'
        is_re_not_in = (lemma.expr[0] == 'not' and len(lemma.expr) > 1 and isinstance(lemma.expr[1], list) and lemma.expr[1][0] == 'str.in_re')
        if not (is_re_in or is_re_not_in):
            return lemma.expr
        if is_re_in:
            left_expr = lemma.expr[1]
            right_expr = lemma.expr[2]
            is_negated = False
        else:
            left_expr = lemma.expr[1][1]
            right_expr = lemma.expr[1][2]
            is_negated = True
        if not isinstance(left_expr, list):
            left_expr = [left_expr]
        if not isinstance(right_expr, list):
            right_expr = [right_expr]
        
        allowed_chars = set()
        for expr in left_expr:
            if isinstance(expr, str) and expr.startswith('x'):
                try:
                    var = self.info_manager.get_var(expr)
                    if var.allow:
                        allowed_chars.update(var.allow)
                except KeyError:
                    continue
        simplified_right = self.filter_by_allowed_chars(right_expr, allowed_chars)
        simplified_right = self.remove_redundant_constants(simplified_right)
        simplified_right = self.remove_empty_strings(simplified_right)
        if simplified_right == ['str.to_re', '""'] or simplified_right == []:
            if is_negated:
                return ['not', ['=', left_expr[0] if len(left_expr) == 1 else left_expr, '""']]
            else:
                return ['=', left_expr[0] if len(left_expr) == 1 else left_expr, '""']
        normalized_left = self.normalize_expr(left_expr)
        normalized_right = self.normalize_expr(simplified_right, is_regex=True)
        
        if is_negated:
            return ['not', ['str.in_re', normalized_left, normalized_right]]
        else:
            return ['str.in_re', normalized_left, normalized_right]
    
    def normalize_expr(self, expr, is_regex=False):
        if not expr:
            return []
        if len(expr) == 1:
            return expr[0]
        concat_op = 're.++' if is_regex else 'str.++'
        return [concat_op] + expr
    
    def get_var_map(self, lemmas):
        var_map = {}
        for lemma in lemmas:
            expr = lemma.expr
            if not isinstance(expr, list):
                continue
            if expr[0] == 'str.in_re' and len(expr) >= 3:
                left_expr = expr[1]
                right_expr = expr[2]
            elif expr[0] == 'not' and len(expr) > 1 and isinstance(expr[1], list) and expr[1][0] == 'str.in_re':
                left_expr = expr[1][1]
                right_expr = expr[1][2]
            else:
                continue
            variables = self._extract_vars(left_expr)
            for var_name in variables:
                if var_name not in var_map:
                    var_map[var_name] = []
                var_map[var_name].append(right_expr)
                
        return var_map
    
    def _extract_vars(self, expr):
        vars_found = set()
        if isinstance(expr, str) and expr.startswith('x'):
            vars_found.add(expr)
        elif isinstance(expr, list):
            for e in expr:
                vars_found.update(self._extract_vars(e))
        return vars_found

class ArithmeticLemmaGenerator:
    def __init__(self, info, regex_processor):
        self.info_manager = info
        self.regex_processor = regex_processor
    
    def get_constant_length(self, expr, allowed_char):
        if isinstance(expr, str):
            if expr.startswith('"'):
                content = expr[1:-1]
                return len(content) if all(c == allowed_char for c in content) else None
            return None
        if not isinstance(expr, list) or not expr:
            return None
        op = expr[0]
        if op == 'str.to_re':
            if len(expr) > 1 and isinstance(expr[1], str) and expr[1].startswith('"'):
                content = expr[1][1:-1]
                return len(content) if all(c == allowed_char for c in content) else None
            return None
        elif op == 're.range':
            if len(expr) == 3:
                start, end = expr[1][1:-1], expr[2][1:-1]
                return 1 if start <= allowed_char <= end else None
            return None
        return None
    
    def get_lemma_arith(self, var, re_expr, tmp_index):
        if len(var.allow) != 1:
            return None, None, None
            
        allowed_char = next(iter(var.allow))
        var_name = var.name
        var_len = ['str.len', var_name]
        if isinstance(re_expr, str) or not isinstance(re_expr, list):
            return None, None, None
        op = re_expr[0] if re_expr else None
        
        if op == 'str.to_re':
            if len(re_expr) > 1 and isinstance(re_expr[1], str) and re_expr[1].startswith('"'):
                content = re_expr[1][1:-1]
                if all(c == allowed_char for c in content) or content == '':
                    return [], [], ['=', var_len, str(len(content))]
            return None, None, None
        elif op == 're.++':
            total_len = 0
            var_terms = []
            current_tmp_index = tmp_index
            tmp_vars = []
            tmp_constraints = []
            for p in re_expr[1:]:
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
                    elif p[0] in ['re.*', 're.+']:
                        inner = p[1]
                        is_plus = p[0] == 're.+' 
                        min_repeats = 1 if is_plus else 0
                        
                        # Handle nested concatenation
                        if isinstance(inner, list) and inner[0] == 're.++':
                            inner_len = 0
                            all_valid = True
                            for inner_part in inner[1:]:
                                inner_part_len = self.get_constant_length(inner_part, allowed_char)
                                if inner_part_len is None:
                                    all_valid = False
                                    break
                                inner_len += inner_part_len
                                
                            if all_valid and inner_len > 0:
                                tmp_var_name = f"len_tmp{current_tmp_index}"
                                current_tmp_index += 1
                                tmp_var = SMTVar(current_tmp_index, tmp_var_name, "Int", name=tmp_var_name)
                                tmp_var.used = True
                                tmp_vars.append(tmp_var)
                                tmp_constraints.append(['>=', tmp_var_name, str(min_repeats)])
                                var_terms.append(['*', str(inner_len), tmp_var_name])
                            else:
                                return None, None, None
                        else:
                            # Handle simple repetition
                            k = self.get_constant_length(inner, allowed_char)
                            if k is not None:
                                if k == 0:
                                    continue
                                tmp_var_name = f"len_tmp{current_tmp_index}"
                                current_tmp_index += 1
                                tmp_var = SMTVar(current_tmp_index, tmp_var_name, "Int", name=tmp_var_name)
                                tmp_var.used = True
                                tmp_vars.append(tmp_var)
                                tmp_constraints.append(['>=', tmp_var_name, str(min_repeats)])
                                
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
        elif op in ['re.*', 're.+']:
            inner = re_expr[1]
            is_plus = op == 're.+' 
            min_repeats = 1 if is_plus else 0
            if isinstance(inner, list) and inner[0] == 're.++':
                inner_len = 0
                all_valid = True
                for part in inner[1:]:
                    part_len = self.get_constant_length(part, allowed_char)
                    if part_len is None:
                        all_valid = False
                        break
                    inner_len += part_len
                if all_valid and inner_len > 0:
                    tmp_var_name = f"len_tmp{tmp_index}"
                    tmp_var = SMTVar(tmp_index, tmp_var_name, "Int", name=tmp_var_name)
                    tmp_var.used = True
                    tmp_constraint = ['>=', tmp_var_name, str(min_repeats)]
                    length_expr = ['=', var_len, ['*', str(inner_len), tmp_var_name]]
                    return [tmp_var], [tmp_constraint], length_expr
            else:
                k = self.get_constant_length(inner, allowed_char)
                if k is not None:
                    if k == 0:
                        return [], [], ['=', var_len, '0']
                    tmp_var_name = f"len_tmp{tmp_index}"
                    tmp_var = SMTVar(tmp_index, tmp_var_name, "Int", name=tmp_var_name)
                    tmp_var.used = True
                    tmp_constraint = ['>=', tmp_var_name, str(min_repeats)]
                    if k == 1:
                        length_expr = ['=', var_len, tmp_var_name]
                    else:
                        length_expr = ['=', var_len, ['*', str(k), tmp_var_name]]
                    return [tmp_var], [tmp_constraint], length_expr
        elif op == 're.range':
            if len(re_expr) == 3:
                start, end = re_expr[1][1:-1], re_expr[2][1:-1]
                if start <= allowed_char <= end:
                    return [], [], ['=', var_len, '1']
        elif op == 're.union':
            union_constraints = []
            for p in re_expr[1:]:
                part_result = self.get_lemma_arith(var, p, tmp_index)
                if part_result and part_result[2]:
                    union_constraints.append(part_result[2])
            if union_constraints:
                if len(union_constraints) == 1:
                    return [], [], union_constraints[0]
                else:
                    return [], [], ['or'] + union_constraints
        return None, None, None
    
    def analyze_regex_constraints(self, var_name, regex_constraints, tmp_index_start):
        var = self.info_manager.get_var(var_name)
        if len(var.allow) != 1:
            return [], []
        tmp_vars = []
        lemmas = []
        current_tmp_index = tmp_index_start
        for re_expr in regex_constraints:
            result = self.get_lemma_arith(var, re_expr, current_tmp_index)
            if result:
                new_tmp_vars, tmp_constraints, constraint_expr = result
                if new_tmp_vars:
                    tmp_vars.extend(new_tmp_vars)
                    current_tmp_index += len(new_tmp_vars)
                    combined_expr = constraint_expr
                    for constraint in tmp_constraints:
                        combined_expr = ['and', constraint, combined_expr]
                    lemma = LemmaGenerator(self.info_manager, self.regex_processor).create_lemma(
                        combined_expr, type="arith")
                    if lemma:
                        lemmas.append(lemma)
                elif constraint_expr:
                    lemma = LemmaGenerator(self.info_manager, self.regex_processor).create_lemma(
                        constraint_expr, type="arith")
                    if lemma:
                        lemmas.append(lemma)
        
        return tmp_vars, lemmas

class SMTProcessor:
    def __init__(self):
        self.info_manager = InfoManager()
        self.regex_processor = RegexProcessor(self.info_manager)
        self.lemma_generator = LemmaGenerator(self.info_manager, self.regex_processor)
        self.expression_simplifier = ExpressionSimplifier(self.info_manager)
        self.arithmetic_lemma_generator = ArithmeticLemmaGenerator(self.info_manager, self.regex_processor)
    
    def simplify_lemmas(self):
        for lemma in self.info_manager.lemmas:
            lemma.expr = self.expression_simplifier.simplify_lemma(lemma)
        var_regex_map = self.expression_simplifier.get_var_map(self.info_manager.lemmas)
        declares_index = self.info_manager.var_counter
        for var_name, regex_exprs in var_regex_map.items():
            if len(regex_exprs) > 1:
                try:
                    var = self.info_manager.get_var(var_name)
                    if len(var.allow) == 1:
                        new_tmp_vars, new_lemmas = self.arithmetic_lemma_generator.analyze_regex_constraints(
                            var_name, regex_exprs, declares_index)
                        for tmp_var in new_tmp_vars:
                            self.info_manager.add_tmp_var(tmp_var)
                        declares_index += len(new_tmp_vars)
                        for lemma in new_lemmas:
                            self.info_manager.add_lemma(lemma)
                except KeyError:
                    continue
    
    def get_lemmas(self):
        for clause in self.info_manager.clauses:
            left_lits, right_lits = self.lemma_generator.get_lemmas_split(clause)
            for lit in left_lits:
                lit = self.lemma_generator.create_literal(lit, self.info_manager.literal_counter)
                self.info_manager.add_literal(lit)
            for lit in right_lits:
                lit = self.lemma_generator.create_literal(lit, self.info_manager.literal_counter)
                self.info_manager.add_literal(lit)
            if clause.type == 're_in':
                if left_lits and right_lits:
                    for left_lit in left_lits:
                        for right_lit in right_lits:
                            lemma = self.lemma_generator.create_lemma(OR(left_lit, right_lit), self.info_manager.lemma_counter)
                            self.info_manager.add_lemma(lemma)
            elif clause.type == 'not':
                if left_lits and right_lits:
                    lits_expr = []
                    for left_lit in left_lits:
                        for right_lit in right_lits:
                            lits_expr.append(AND(left_lit, right_lit))
                    if lits_expr:
                        lemma = self.lemma_generator.create_lemma(NOT(OR(lits_expr)), self.info_manager.lemma_counter)
                        self.info_manager.add_lemma(lemma)
    
    def process_file(self, input_file, output_file=None):
        # try:
        with open(input_file, 'r') as f:
            lines = f.readlines()
            for line in lines:
                self.info_manager.process_line(line)
        
        self.info_manager.update_info()
        self.get_lemmas()
        self.simplify_lemmas()
        
        outputs = []
        outputs.extend(self.info_manager.preamble)
        for var in self.info_manager.vars:
            var_smt2 = var.get_smt2()
            if var_smt2:
                outputs.append(var_smt2)
        for clause in self.info_manager.clauses:
            outputs.append(clause.get_smt2())
        outputs.append("; ========================== [comments] ==========================")
        for clause in self.info_manager.clauses:
            comment = clause.get_comment()
            if comment:
                outputs.append(comment)
        out = output_file if output_file else input_file
        with open(out, 'w') as f:
            for o in outputs:
                f.write(o + '\n')
        logging.info(f"Processed file saved to: {out}")
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