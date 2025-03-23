import re
import sys
import logging
import argparse
from colorama import Fore, Back, Style, init
from collections import deque, defaultdict


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
            return ''.join(parts)
        elif op == 're.union':
            parts = []
            for e in expr[1:]:
                part = Parser.to_pyre(e)
                if part is None:
                    return None
                parts.append(part)
            if not parts:
                return ''
            return '|'.join(['(?:' + p + ')' for p in parts])
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
        self.expr = expr
        self.type = expr_type
        self.vars = self._extract_vars(self.expr)
        self.chars = self._extract_chars(self.expr)
        self.original_line = None
    
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
        return Parser.to_smt2(['assert', self.expr])
    
    def get_comment(self):
        return f"Clause({self.index})"

    def __eq__(self, other):
        if not isinstance(other, SMTClause):
            return False
        return self.index == other.index
    
    def __hash__(self):
        return hash(self.index)
    
    def __str__(self):
        return f"; {Parser.to_str(self.expr)}"

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
        return [h] + [self._simplify_expr(e) for e in expr[1:]]

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
            clu_type = Parser.classify_type(expr[1]) if expr[1] else 'default'
        else:
            clu_type = 'default'
        clause = SMTClause(self.clause_counter, expr[1], clu_type)
        clause.original_line = line
        self.add_clause(clause)

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
    
    def get_re_elements(self, expr):
        if not isinstance(expr, list):
            return None, None
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
        return [expr]
    
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
        if not isinstance(expr, list):
            return {}
        if expr and expr[0] == 'str.to_re' and len(expr) > 1:
            if isinstance(expr[1], str) and expr[1].startswith('"'):
                result = {}
                for char in expr[1][1:-1]:
                    result[char] = result.get(char, 0) + 1
                return result
            return {}
        constants = {}
        for e in expr:
            if isinstance(e, str) and e.startswith('"') and len(e) > 2:
                for char in e[1:-1]:
                    constants[char] = constants.get(char, 0) + 1
            elif isinstance(e, list):
                sub_constants = self.get_parikh_image(e)
                for char, count in sub_constants.items():
                    constants[char] = constants.get(char, 0) + count
        return constants

    def is_constant_contain(self, expr, constant):
        constant = constant[1:-1]
        if not isinstance(expr, list):
            return constant in expr
        if expr[0] == 'str.to_re' and len(expr) > 1:
            return constant in expr[1]
        for sub_expr in expr[1:]:
            if self.is_constant_contain(sub_expr, constant):
                return True
        return False
    
    def is_direct_match(self, expr, constant):
        if isinstance(expr, list) and expr[0] == 'str.to_re' and len(expr) > 1:
            return expr[1] == constant
        return expr == constant
    
    def is_must_contain(self, expr, constant):
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
            return all(self.is_must_contain(sub_expr, constant) for sub_expr in expr[1:])
        if op == 're.++':
            if len(expr) <= 1:
                return False
            return any(self.is_must_contain(sub_expr, constant) for sub_expr in expr[1:])
        return False
    
    def is_complex_match(self, expr, constant):
        if not isinstance(expr, list):
            return False
        const_count = self.get_parikh_image(expr).get(constant[1:-1], 0)
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
    
    def get_index_constant_in_pattern(self, re_expr, constant):
        if not isinstance(re_expr, list) or not re_expr:
            return None
        indices = []
        for i, sub_expr in enumerate(re_expr):
            if self.is_constant_contain(sub_expr, constant):
                indices.append(i)
        if len(indices) == 1:
            return indices[0]
        must_contain_indices = []
        for i in indices:
            if self.is_must_contain(re_expr[i], constant):
                must_contain_indices.append(i)
        if len(must_contain_indices) == 1:
            return must_contain_indices[0]
        return None

    def get_deploy_pattern(self, pattern, constant):
        if not isinstance(pattern, list) or len(pattern) < 2:
            return None
        if pattern[0] not in ['re.*', 're.+']:
            return [['str.to_re', '""'], pattern, ['str.to_re', '""']]
        body = pattern[1]
        original_pattern = pattern.copy()
        if isinstance(body, list) and body[0] == 're.++':
            result = self.extract_constant_from_concat(body, constant, pattern[0])
            if result:
                return result
        elif isinstance(body, list) and body[0] == 're.union':
            direct_matches = []
            complex_matches = []
            for i, term in enumerate(body[1:], 1):
                const_count = self.get_parikh_image(term).get(constant[1:-1], 0)
                if const_count == 1:
                    if self.is_direct_match(term, constant):
                        direct_matches.append(term)
                    elif self.is_complex_match(term, constant):
                        complex_matches.append(term)
            if direct_matches or complex_matches:
                middle_part = ['re.union']
                middle_part.extend(direct_matches)
                middle_part.extend(complex_matches)
                if len(middle_part) == 2:
                    middle_part = middle_part[1]
                return [original_pattern, middle_part, original_pattern]
        else:
            const_free_pattern = self.replace_constant_with_empty(body, constant)
            if const_free_pattern is not None:
                middle_part = self.create_one_occurrence_pattern(body, constant)
                if middle_part:
                    return [pattern, middle_part, pattern]
        return None

    def extract_constant_from_concat(self, concat_expr, constant, kleene_op):
        if not isinstance(concat_expr, list) or concat_expr[0] != 're.++':
            return None
        for i, part in enumerate(concat_expr[1:], 1):
            if self.is_direct_match(part, constant):
                left_parts = concat_expr[1:i]
                right_parts = concat_expr[i+1:]
                left_concat = self.make_concat(left_parts)
                right_concat = self.make_concat(right_parts)
                const_free_pattern = self.make_concat([left_concat, right_concat])
                const_free_pattern = self.simplify_pattern(const_free_pattern)
                if kleene_op == 're.*':
                    kleene_pattern = ['re.*', self.clone_pattern(concat_expr)]
                else:
                    kleene_pattern = ['re.+', self.clone_pattern(concat_expr)]
                middle_part = self.make_concat([left_concat, part, right_concat])
                middle_part = self.simplify_pattern(middle_part)
                return [kleene_pattern, middle_part, kleene_pattern]
            elif isinstance(part, list) and self.is_constant_contain(part, constant):
                if part[0] in ['re.*', 're.+']:
                    inner_deploy = self.get_deploy_pattern(part, constant)
                    if inner_deploy:
                        left_parts = concat_expr[1:i]
                        right_parts = concat_expr[i+1:]
                        left_concat = self.make_concat(left_parts)
                        right_concat = self.make_concat(right_parts)
                        left_pattern = self.make_concat([left_concat, inner_deploy[0]])
                        right_pattern = self.make_concat([inner_deploy[2], right_concat])
                        if kleene_op == 're.*':
                            outer_left = ['re.*', self.clone_pattern(concat_expr)]
                            outer_right = ['re.*', self.clone_pattern(concat_expr)]
                        else:
                            outer_left = ['re.+', self.clone_pattern(concat_expr)]
                            outer_right = ['re.+', self.clone_pattern(concat_expr)]
                        middle_part = self.make_concat([left_pattern, inner_deploy[1], right_pattern])
                        middle_part = self.simplify_pattern(middle_part)
                        return [outer_left, middle_part, outer_right]
                elif part[0] == 're.++':
                    inner_result = self.extract_constant_from_concat(part, constant, None)
                    if inner_result:
                        middle_part = inner_result[1]
                        left_parts = concat_expr[1:i]
                        right_parts = concat_expr[i+1:]
                        left_concat = self.make_concat(left_parts)
                        right_concat = self.make_concat(right_parts)
                        new_middle = self.make_concat([left_concat, middle_part, right_concat])
                        new_middle = self.simplify_pattern(new_middle)
                        if kleene_op == 're.*':
                            outer_pattern = ['re.*', self.clone_pattern(concat_expr)]
                        else:
                            outer_pattern = ['re.+', self.clone_pattern(concat_expr)]
                        return [outer_pattern, new_middle, outer_pattern]
                elif part[0] == 're.union':
                    inner_parts = self.extract_constant_from_union(part, constant)
                    if inner_parts:
                        left_parts = concat_expr[1:i]
                        right_parts = concat_expr[i+1:]
                        left_concat = self.make_concat(left_parts)
                        right_concat = self.make_concat(right_parts)
                        middle_part = self.make_concat([left_concat, inner_parts, right_concat])
                        middle_part = self.simplify_pattern(middle_part)
                        if kleene_op == 're.*':
                            outer_pattern = ['re.*', self.clone_pattern(concat_expr)]
                        else:
                            outer_pattern = ['re.+', self.clone_pattern(concat_expr)]
                        return [outer_pattern, middle_part, outer_pattern]
        return None

    def extract_constant_from_union(self, union_expr, constant):
        if not isinstance(union_expr, list) or union_expr[0] != 're.union':
            return None
        direct_matches = []
        for i, term in enumerate(union_expr[1:], 1):
            const_count = self.get_parikh_image(term).get(constant[1:-1], 0)
            if const_count == 1:
                if self.is_direct_match(term, constant) or self.is_complex_match(term, constant):
                    direct_matches.append(term)
        if direct_matches:
            return direct_matches[0] if len(direct_matches) == 1 else ['re.union'] + direct_matches
        return None

    def replace_constant_with_empty(self, expr, constant):
        if not isinstance(expr, list):
            if expr == constant:
                return ['str.to_re', '""']
            return expr
        if expr[0] == 'str.to_re' and len(expr) > 1 and expr[1] == constant:
            return ['str.to_re', '""']
        result = [expr[0]]
        for sub_expr in expr[1:]:
            replaced = self.replace_constant_with_empty(sub_expr, constant)
            if replaced:
                result.append(replaced)
        if len(result) == 1:  # 只剩下操作符
            return ['str.to_re', '""']
        return result

    def create_one_occurrence_pattern(self, expr, constant):
        if not isinstance(expr, list):
            if expr == constant:
                return expr
            return None
        if expr[0] == 'str.to_re' and len(expr) > 1 and expr[1] == constant:
            return expr
        for i, sub_expr in enumerate(expr[1:], 1):
            one_occurrence = self.create_one_occurrence_pattern(sub_expr, constant)
            if one_occurrence:
                if expr[0] == 're.++':
                    result = [expr[0]]
                    for j, part in enumerate(expr[1:], 1):
                        if j == i:
                            result.append(one_occurrence)
                        else:
                            result.append(self.replace_constant_with_empty(part, constant))
                    return result
                return one_occurrence
        return None

    def make_concat(self, parts):
        parts = [p for p in parts if p is not None and p != ['str.to_re', '""']]
        if not parts:
            return ['str.to_re', '""']
        if len(parts) == 1:
            return parts[0]
        return ['re.++'] + parts

    def simplify_pattern(self, pattern):
        if not isinstance(pattern, list):
            return pattern
        if not pattern:
            return ['str.to_re', '""']
        if pattern[0] == 're.++':
            result = ['re.++']
            for part in pattern[1:]:
                if part == ['str.to_re', '""']:
                    continue
                if isinstance(part, list) and part and part[0] == 're.++':
                    result.extend(part[1:])
                else:
                    result.append(part)
            if len(result) == 1:
                return ['str.to_re', '""']
            if len(result) == 2:
                return result[1]
            return result
        return pattern

    def clone_pattern(self, pattern):
        if not isinstance(pattern, list):
            return pattern
        return [pattern[0]] + [self.clone_pattern(p) for p in pattern[1:]]

    def get_split_pattern(self, left_expr, right_expr, constant_index, constant_in_index):
        left_left = left_expr[:constant_index]
        left_mid = left_expr[constant_index]
        left_right = left_expr[constant_index+1:]
        right_left = right_expr[:constant_in_index]
        right_mid = right_expr[constant_in_index]
        right_right = right_expr[constant_in_index+1:]
        deploy_pattern = self.get_deploy_pattern(right_mid, left_mid)
        if not deploy_pattern:
            return None
        middle_pattern = deploy_pattern[1]
        right_left_extended = right_left + [deploy_pattern[0]]
        right_right_extended = [deploy_pattern[2]] + right_right
        left_left = self.normalize_expr(left_left)
        left_right = self.normalize_expr(left_right)
        left_side, right_side = self.extract_sides_from_pattern(middle_pattern, left_mid)
        left_left_list = []
        left_right_list = []
        for left_part in left_side:
            right_left_norm = self.normalize_expr(right_left_extended + [left_part], is_regex=True)
            left_left_list.append(['str.in_re', left_left, right_left_norm])
        for right_part in right_side:
            right_right_norm = self.normalize_expr([right_part] + right_right_extended, is_regex=True)
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
    
    def normalize_expr(self, expr, is_regex=False):
        if not expr and not is_regex:
            return "\"\""
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
                    return ['str.to_re', '""'], False
                if len(intersection) == len(chars_in_range):
                    return e, True
                optimized = optimize_range(start, end, allowed_chars)
                if optimized:
                    return optimized, True
                return ['str.to_re', '""'], False
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
                    return ['str.to_re', '""'], False
                if not filtered:
                    return ['str.to_re', '""'], True
                if len(filtered) == 1:
                    return filtered[0], True
                return ['re.++'] + filtered, True
            elif op == 're.union':
                filtered = []
                for sub_e in e[1:]:
                    sub_result, sub_valid = process_expr(sub_e)
                    if sub_valid and sub_result != ['str.to_re', '""']:
                        filtered.append(sub_result)
                if not filtered:
                    return ['str.to_re', '""'], False
                if len(filtered) == 1:
                    return filtered[0], True
                return ['re.union'] + filtered, True
            elif op in ['re.*', 're.+']:
                body_result, body_valid = process_expr(e[1])
                if not body_valid or body_result == ['str.to_re', '""']:
                    if op == 're.*':
                        return ['str.to_re', '""'], True
                    else:
                        return ['str.to_re', '""'], False
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
        return result

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
                    # Handle nested unions by extracting their elements
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
            return None

    def rebuild_expr(self, expr):
        if not isinstance(expr, list):
            return expr
        if not expr:
            return expr
        op = expr[0]
        if op == 're.++':
            constant_parts = []
            variable_parts = []
            for part in expr[1:]:
                if isinstance(part, str) and part.startswith('"'):
                    constant_parts.append(part)
                elif isinstance(part, list) and part and part[0] == 'str.to_re' and len(part) > 1 and isinstance(part[1], str) and part[1].startswith('"'):
                    constant_parts.append(part[1])
                else:
                    rebuilt_part = self.rebuild_expr(part)
                    if rebuilt_part != ['str.to_re', '""']:
                        variable_parts.append(rebuilt_part)
            combined_constant = ""
            for const in constant_parts:
                if isinstance(const, str) and const.startswith('"'):
                    combined_constant += const[1:-1]
                else:
                    combined_constant += const[1:-1]
            result = []
            if combined_constant:
                result.append(['str.to_re', f'"{combined_constant}"'])
            result.extend(variable_parts)
            if not result:
                return ['str.to_re', '""']
            if len(result) == 1:
                return result[0]
            return ['re.++'] + result
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

class BoolProcessor:
    def __init__(self, info):
        self.info_manager = info
        self.var_map = {}
        self.unit_clauses = []
        self.cnf_clauses = [[1]]
        self.is_sat = 'UNKNOWN'
    
    def read_lemma(self, lemma):
        if not lemma.expr_tree:
            return
        bool_structure = self._extract_bool_structure(lemma.expr_tree)
        if bool_structure:
            lemma_clauses = self._expr_to_cnf(bool_structure)
            for clause in lemma_clauses:
                self.cnf_clauses.append(clause)
    
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
        else:  # 'and' or 'or'
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
    
    def simplify_lemmas(self):
        if not self.cnf_clauses:
            return self.is_sat
        self.cnf_clauses = list(set(tuple(sorted(set(clause))) for clause in self.cnf_clauses))
        unit_stack = []
        unit_values = {}
        for clause in self.cnf_clauses:
            if len(clause) == 1:
                unit_stack.append(clause[0])
        while unit_stack:
            lit = unit_stack.pop(0)
            self.unit_clauses.append([lit])
            var = abs(lit)
            value = lit > 0
            if var in unit_values:
                if unit_values[var] != value:
                    self.cnf_clauses = []
                    self.is_sat = 'UNSAT'
                    return self.is_sat
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
                    return self.is_sat
                if len(new_clause) == 1 and new_clause[0] not in unit_stack:
                    unit_lit = new_clause[0]
                    unit_var = abs(unit_lit)
                    if unit_var not in unit_values:
                        unit_stack.append(unit_lit)
                self.cnf_clauses[i] = new_clause
                i += 1
        self.cnf_clauses = list(set(tuple(sorted(clause)) for clause in self.cnf_clauses))
        return self.is_sat
    
    def get_simplified_lemmas(self):
        if self.is_sat == 'UNSAT':
            return [(ExpressionTree.LEAF(0), "bool")]
        result = []
        for clause in self.unit_clauses + self.cnf_clauses:
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
        self.tmp_var_counter = 0
    
    def get_length_info_from_lit(self, lit):
        if lit.type != 'string' or lit.index is None:
            return None, None, None
        expr = lit.expr
        if not isinstance(expr, list) or expr[0] != 'str.in_re':
            return None, None, None
        left_expr, right_expr = expr[1], expr[2]
        tmp_vars, tmp_vars_expr, str_length_expr = self._extract_arith_constraints(left_expr, right_expr, self.tmp_var_counter)
        self.tmp_var_counter += len(tmp_vars) if tmp_vars else 0
        return tmp_vars, tmp_vars_expr, str_length_expr
    
    def _calculate_pattern_length(self, pattern):
        if isinstance(pattern, str) and pattern.startswith('"'):
            return len(pattern[1:-1])
        if isinstance(pattern, list):
            op = pattern[0] if pattern else None
            if op == 'str.to_re' and len(pattern) > 1:
                if isinstance(pattern[1], str) and pattern[1].startswith('"'):
                    return len(pattern[1][1:-1])
            elif op == 're.range':
                return 1
            elif op == 're.++':
                total_len = 0
                for p in pattern[1:]:
                    p_len = self._calculate_pattern_length(p)
                    if p_len is None:
                        return None
                    total_len += p_len
                return total_len
            elif op == 're.union':
                lengths = set()
                for p in pattern[1:]:
                    p_len = self._calculate_pattern_length(p)
                    if p_len is not None:
                        lengths.add(p_len)
                if len(lengths) == 1:
                    return next(iter(lengths))
                return None
        return None
    
    def _extract_variables(self, expr):
        vars_found = set()
        if isinstance(expr, str) and expr.startswith('x'):
            vars_found.add(expr)
        elif isinstance(expr, list):
            for e in expr:
                vars_found.update(self._extract_variables(e))
        return vars_found
    
    def _find_var_by_name(self, var_name):
        for var in self.info_manager.vars:
            if var.name == var_name:
                return var
        return None
    
    def _get_constant_length(self, expr):
        if isinstance(expr, str):
            if expr.startswith('"'):
                return len(expr[1:-1])
            return None
        if not isinstance(expr, list) or not expr:
            return None
        op = expr[0]
        if op == 'str.++':
            total_len = 0
            for e in expr[1:]:
                part_len = self._get_constant_length(e)
                if part_len is None:
                    return None
                total_len += part_len
            return total_len
        return None
    
    def _get_constant_char_length(self, expr, allowed_char):
        if isinstance(expr, str):
            if expr.startswith('"'):
                content = expr[1:-1]
                return len(content) if all(c == allowed_char for c in content) else None
            return None
        if not isinstance(expr, list) or not expr:
            return None
        op = expr[0]
        if op == 'str.to_re' and len(expr) > 1:
            if isinstance(expr[1], str) and expr[1].startswith('"'):
                content = expr[1][1:-1]
                return len(content) if all(c == allowed_char for c in content) else None
        elif op == 're.range' and len(expr) == 3:
            start, end = expr[1][1:-1], expr[2][1:-1]
            return 1 if start <= allowed_char <= end else None
        return None
    
    def _extract_arith_constraints(self, left_expr, right_expr, tmp_index):
        if (isinstance(right_expr, list) and 
            ((right_expr[0] == 'str.to_re' and len(right_expr) > 1 and right_expr[1] == '""') or
             right_expr == ['str.to_re', '""'])):
            if isinstance(left_expr, str) and left_expr.startswith('x'):
                var_len = ['str.len', left_expr]
                return [], None, ['=', var_len, '0']
            elif isinstance(left_expr, list) and left_expr[0] == 'str.++':
                vars_terms = []
                constants_len = 0
                for item in left_expr[1:]:
                    if isinstance(item, str) and item.startswith('x'):
                        vars_terms.append(['str.len', item])
                    elif isinstance(item, str) and item.startswith('"'):
                        constants_len += len(item[1:-1])
                if not vars_terms and constants_len == 0:
                    return [], None, None
                if constants_len == 0:
                    if len(vars_terms) == 1:
                        return [], None, ['=', vars_terms[0], '0']
                    else:
                        return [], None, ['=', ['+'] + vars_terms, '0']
                elif not vars_terms:
                    return [], None, ['=', str(constants_len), '0']
                else:
                    if len(vars_terms) == 1:
                        return [], None, ['=', ['+', vars_terms[0], str(constants_len)], '0']
                    else:
                        return [], None, ['=', ['+'] + vars_terms + [str(constants_len)], '0']
            return [], None, None
        if isinstance(left_expr, str) and left_expr.startswith('x'):
            var = self._find_var_by_name(left_expr)
            if var:
                var_len = ['str.len', var.name]
                if len(var.allow) == 1:
                    allowed_char = next(iter(var.allow))
                    var_tmp_vars, constraint_expr, var_length_expr = self._process_regex_constraints(var, right_expr, tmp_index)
                    if var_tmp_vars is not None and var_length_expr is not None:
                        return var_tmp_vars, constraint_expr, var_length_expr
                if isinstance(right_expr, list) and right_expr[0] in ['re.*', 're.+']:
                    inner = right_expr[1]
                    pattern_len = self._calculate_pattern_length(inner)
                    if pattern_len is not None and pattern_len > 0:
                        tmp_var_name = f"len_tmp{tmp_index}"
                        tmp_var = SMTVar(tmp_index, tmp_var_name, "Int", name=tmp_var_name)
                        tmp_var.used = True
                        if right_expr[0] == 're.*':
                            tmp_vars_expr = ['>=', tmp_var_name, '0']
                        else:
                            tmp_vars_expr = ['>=', tmp_var_name, '1']
                        str_length_expr = ['=', var_len, ['*', str(pattern_len), tmp_var_name]]
                        return [tmp_var], tmp_vars_expr, str_length_expr
                return [], None, None
        if isinstance(left_expr, list) and left_expr[0] == 'str.++':
            vars_in_expr = []
            constants_len = 0
            for item in left_expr[1:]:
                if isinstance(item, str):
                    if item.startswith('x'):
                        vars_in_expr.append(item)
                    elif item.startswith('"'):
                        constants_len += len(item[1:-1])
            var_len_terms = [['str.len', var_name] for var_name in vars_in_expr]
            if isinstance(right_expr, list) and right_expr[0] in ['re.*', 're.+']:
                inner = right_expr[1]
                if isinstance(inner, list) and inner[0] == 're.union':
                    pattern_lengths = []
                    for branch in inner[1:]:
                        branch_len = self._calculate_pattern_length(branch)
                        if branch_len is not None:
                            pattern_lengths.append((branch, branch_len))
                    if len(pattern_lengths) > 1 and len(set(length for _, length in pattern_lengths)) > 1:
                        tmp_vars = []
                        tmp_constraints = []
                        right_terms = []
                        for i, (branch, branch_len) in enumerate(pattern_lengths):
                            if branch_len > 0:
                                tmp_var_name = f"len_tmp{tmp_index+i}"
                                tmp_var = SMTVar(tmp_index+i, tmp_var_name, "Int", name=tmp_var_name)
                                tmp_var.used = True
                                if right_expr[0] == 're.*':
                                    tmp_constraints.append(['>=', tmp_var_name, '0'])
                                else:
                                    tmp_constraints.append(['>=', tmp_var_name, '1'])
                                if branch_len == 1:
                                    right_terms.append(tmp_var_name)
                                else:
                                    right_terms.append(['*', str(branch_len), tmp_var_name])
                                tmp_vars.append(tmp_var)
                        if right_terms:
                            if len(var_len_terms) == 0 and constants_len == 0:
                                left_side = '0'
                            elif len(var_len_terms) == 0:
                                left_side = str(constants_len)
                            elif len(var_len_terms) == 1 and constants_len == 0:
                                left_side = var_len_terms[0]
                            elif len(var_len_terms) == 1:
                                left_side = ['+', var_len_terms[0], str(constants_len)]
                            elif constants_len == 0:
                                left_side = ['+'] + var_len_terms
                            else:
                                left_side = ['+'] + var_len_terms + [str(constants_len)]
                            if len(right_terms) == 1:
                                right_side = right_terms[0]
                            else:
                                right_side = ['+'] + right_terms
                            str_length_expr = ['=', left_side, right_side]
                            tmp_vars_expr = tmp_constraints[0] if tmp_constraints else None
                            return tmp_vars, tmp_vars_expr, str_length_expr
                pattern_len = self._calculate_pattern_length(inner)
                if pattern_len is not None and pattern_len > 0:
                    tmp_var_name = f"len_tmp{tmp_index}"
                    tmp_var = SMTVar(tmp_index, tmp_var_name, "Int", name=tmp_var_name)
                    tmp_var.used = True
                    if right_expr[0] == 're.*':
                        tmp_vars_expr = ['>=', tmp_var_name, '0']
                    else:
                        tmp_vars_expr = ['>=', tmp_var_name, '1']
                    if len(var_len_terms) == 0 and constants_len == 0:
                        str_length_expr = ['=', '0', ['*', str(pattern_len), tmp_var_name]]
                    elif len(var_len_terms) == 0:
                        str_length_expr = ['=', str(constants_len), ['*', str(pattern_len), tmp_var_name]]
                    elif len(var_len_terms) == 1 and constants_len == 0:
                        str_length_expr = ['=', var_len_terms[0], ['*', str(pattern_len), tmp_var_name]]
                    elif len(var_len_terms) == 1:
                        str_length_expr = ['=', ['+', var_len_terms[0], str(constants_len)], ['*', str(pattern_len), tmp_var_name]]
                    elif constants_len == 0:
                        str_length_expr = ['=', ['+'] + var_len_terms, ['*', str(pattern_len), tmp_var_name]]
                    else:
                        str_length_expr = ['=', ['+'] + var_len_terms + [str(constants_len)], ['*', str(pattern_len), tmp_var_name]]
                    return [tmp_var], tmp_vars_expr, str_length_expr
            constant_pattern_len = self._calculate_pattern_length(right_expr)
            if constant_pattern_len is not None:
                if len(var_len_terms) == 0 and constants_len == 0:
                    return [], None, ['=', '0', str(constant_pattern_len)]
                elif len(var_len_terms) == 0:
                    return [], None, ['=', str(constants_len), str(constant_pattern_len)]
                elif len(var_len_terms) == 1 and constants_len == 0:
                    return [], None, ['=', var_len_terms[0], str(constant_pattern_len)]
                elif len(var_len_terms) == 1:
                    return [], None, ['=', ['+', var_len_terms[0], str(constants_len)], str(constant_pattern_len)]
                elif constants_len == 0:
                    return [], None, ['=', ['+'] + var_len_terms, str(constant_pattern_len)]
                else:
                    return [], None, ['=', ['+'] + var_len_terms + [str(constants_len)], str(constant_pattern_len)]
        return [], None, None
    
    def _process_regex_constraints(self, var, regex_expr, tmp_index):
        if not var.allow or len(var.allow) != 1:
            return None, None, None
        allowed_char = next(iter(var.allow))
        var_name = var.name
        var_len = ['str.len', var_name]
        if not isinstance(regex_expr, list):
            if isinstance(regex_expr, str) and regex_expr.startswith('"'):
                content = regex_expr[1:-1]
                if all(c == allowed_char for c in content):
                    return [], None, ['=', var_len, str(len(content))]
            return None, None, None
        op = regex_expr[0] if regex_expr else None
        if op == 'str.to_re':
            if len(regex_expr) > 1 and isinstance(regex_expr[1], str) and regex_expr[1].startswith('"'):
                content = regex_expr[1][1:-1]
                if content == '':
                    return [], None, ['=', var_len, '0']
                if all(c == allowed_char for c in content):
                    return [], None, ['=', var_len, str(len(content))]
            return None, None, None
        elif op == 're.*':
            inner = regex_expr[1]
            inner_len = self._get_constant_char_length(inner, allowed_char)
            if inner_len is not None:
                if inner_len == 0:
                    return [], None, ['=', var_len, '0']
                tmp_var_name = f"len_tmp{tmp_index}"
                tmp_var = SMTVar(tmp_index, tmp_var_name, "Int", name=tmp_var_name)
                tmp_var.used = True
                constraint_expr = ['>=', tmp_var_name, '0']
                if inner_len == 1:
                    length_expr = ['=', var_len, tmp_var_name]
                else:
                    length_expr = ['=', var_len, ['*', str(inner_len), tmp_var_name]]
                return [tmp_var], constraint_expr, length_expr
            return None, None, None
        elif op == 're.+':
            inner = regex_expr[1]
            inner_len = self._get_constant_char_length(inner, allowed_char)
            if inner_len is not None:
                if inner_len == 0:
                    return [], None, ['=', var_len, '0']
                tmp_var_name = f"len_tmp{tmp_index}"
                tmp_var = SMTVar(tmp_index, tmp_var_name, "Int", name=tmp_var_name)
                tmp_var.used = True
                constraint_expr = ['>=', tmp_var_name, '1']
                if inner_len == 1:
                    length_expr = ['=', var_len, tmp_var_name]
                else:
                    length_expr = ['=', var_len, ['*', str(inner_len), tmp_var_name]]
                return [tmp_var], constraint_expr, length_expr
            return None, None, None
        elif op == 're.++':
            total_len = 0
            var_terms = []
            current_tmp_index = tmp_index
            tmp_vars = []
            tmp_constraints = []
            for p in regex_expr[1:]:
                part_len = self._get_constant_char_length(p, allowed_char)
                if part_len is not None:
                    total_len += part_len
                    continue
                if isinstance(p, list) and p[0] in ['re.*', 're.+']:
                    inner = p[1]
                    inner_len = self._get_constant_char_length(inner, allowed_char)
                    if inner_len is not None and inner_len > 0:
                        tmp_var_name = f"len_tmp{current_tmp_index}"
                        current_tmp_index += 1
                        tmp_var = SMTVar(current_tmp_index, tmp_var_name, "Int", name=tmp_var_name)
                        tmp_var.used = True
                        if p[0] == 're.*':
                            tmp_constraints.append(['>=', tmp_var_name, '0'])
                        else:
                            tmp_constraints.append(['>=', tmp_var_name, '1'])
                        if inner_len == 1:
                            var_terms.append(tmp_var_name)
                        else:
                            var_terms.append(['*', str(inner_len), tmp_var_name])
                        tmp_vars.append(tmp_var)
                    else:
                        return None, None, None
                else:
                    return None, None, None
            constraint_expr = tmp_constraints[0] if tmp_constraints else None
            if not var_terms:
                return [], constraint_expr, ['=', var_len, str(total_len)]
            elif total_len == 0:
                if len(var_terms) == 1:
                    return tmp_vars, constraint_expr, ['=', var_len, var_terms[0]]
                else:
                    sum_expr = ['+'] + var_terms
                    return tmp_vars, constraint_expr, ['=', var_len, sum_expr]
            else:
                if len(var_terms) == 1:
                    return tmp_vars, constraint_expr, ['=', var_len, ['+', str(total_len), var_terms[0]]]
                else:
                    sum_expr = ['+', str(total_len)] + var_terms
                    return tmp_vars, constraint_expr, ['=', var_len, sum_expr]
        elif op == 're.range':
            if len(regex_expr) == 3:
                start, end = regex_expr[1][1:-1], regex_expr[2][1:-1]
                if start <= allowed_char <= end:
                    return [], None, ['=', var_len, '1']
        elif op == 're.union':
            for p in regex_expr[1:]:
                part_result = self._process_regex_constraints(var, p, tmp_index)
                if part_result and part_result[2]:
                    return part_result
        return None, None, None

class LemmaGenerator:
    def __init__(self, info, regex_processor, bool_processor, arith_processor):
        self.info_manager = info
        self.regex_processor = regex_processor
        self.bool_processor = bool_processor
        self.arith_processor = arith_processor
    
    def create_literal(self, expr):
        lit = SMTLit(expr)
        lit = self.rewrite_lit(lit)
        lit_find = self.info_manager.find_literal(lit)
        if lit_find is None:
            return self.info_manager.add_literal(lit)
        return lit_find.index
    
    def create_lemma(self, expr_tree, lemma_type, comment=None):
        lemma = SMTLemma(expr_tree, lemma_type, comment)
        if expr_tree:
            expr_tree.set_info_manager(self.info_manager)
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
            lit.expr = ['str.in_re', left_expr, right_expr_filtered]
        elif lit.type == 'arith':
            pass
        return lit
    
    def rewrite_lemmas(self, lemmas):
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
    
    def get_lemmas_length(self, lemmas):
        lits_total = set()
        lemmas_re = [lemma for lemma in lemmas if lemma.type == 're_in']
        for lemma in lemmas_re:
            lits_index = lemma.get_lits_indices()
            lits_total.update(lits_index)
        lit_lengthlit_map = {}
        for lit_index in lits_total:
            lit = self.info_manager.literals[lit_index]
            tmp_vars, tmp_vars_expr, str_length_expr = self.arith_processor.get_length_info_from_lit(lit)
            if tmp_vars:
                for tmp_var in tmp_vars:
                    self.info_manager.add_tmp_var(tmp_var)
            if tmp_vars_expr:
                lit_tmp_index = self.create_literal(tmp_vars_expr)
                self.create_lemma(ExpressionTree.LEAF(lit_tmp_index), lemma_type='arith')
            if str_length_expr:
                lit_str_length_index = self.create_literal(str_length_expr)
                lit_lengthlit_map[lit_index] = lit_str_length_index
        for lemma in lemmas_re:
            tree = self.get_exptree_length(lemma, lit_lengthlit_map)
            if tree:
                self.create_lemma(tree, lemma_type='arith')

    def get_exptree_length(self, lemma, lit_lengthlit_map):
        if not lemma.expr_tree:
            return None
        if lemma.expr_tree.op == 'leaf':
            lit_index = lemma.expr_tree.elements[0]
            if lit_index in lit_lengthlit_map:
                length_lit_index = lit_lengthlit_map[lit_index]
                return ExpressionTree.LEAF(length_lit_index)
            return None
        elif lemma.expr_tree.op == 'not':
            if not lemma.expr_tree.elements:
                return None
            inner_tree = self.get_exptree_length(SMTLemma(lemma.expr_tree.elements[0], 're_in'), lit_lengthlit_map)
            if inner_tree:
                return ExpressionTree.NOT(inner_tree)
            return None
        elif lemma.expr_tree.op == 'and':
            length_trees = []
            for element in lemma.expr_tree.elements:
                inner_lemma = SMTLemma(element, 're_in')
                inner_tree = self.get_exptree_length(inner_lemma, lit_lengthlit_map)
                if inner_tree:
                    length_trees.append(inner_tree)
            if length_trees:
                if len(length_trees) == 1:
                    return length_trees[0]
                return ExpressionTree.AND(length_trees)
            return None
        elif lemma.expr_tree.op == 'or':
            length_trees = []
            for element in lemma.expr_tree.elements:
                inner_lemma = SMTLemma(element, 're_in')
                inner_tree = self.get_exptree_length(inner_lemma, lit_lengthlit_map)
                if inner_tree:
                    length_trees.append(inner_tree)
            if length_trees:
                if len(length_trees) == 1:
                    return length_trees[0]
                return ExpressionTree.OR(length_trees)
            return None
        return None
    
    def get_lemmas_split(self, clause):
        clause_type = clause.type
        if clause_type == 'not':
            expr_tree = self.get_exptree_split(clause.expr[1])
            self.create_lemma(ExpressionTree.NOT(expr_tree), lemma_type='not')
        else:
            expr_tree = self.get_exptree_split(clause.expr)
            self.create_lemma(expr_tree, lemma_type='re_in')

    def get_exptree_split(self, expr):
        left_expr, right_expr = self.regex_processor.get_re_elements(expr)
        vars_found = self.regex_processor.get_variables(left_expr)
        if len(vars_found) == 0:
            lit_index = self.create_literal(expr)
            return ExpressionTree.LEAF(lit_index)
        allowed_chars = set()
        for var_name in vars_found:
            var = self.info_manager.get_var(var_name)
            allowed_chars.update(var.allow)
        domain_quota = self.regex_processor.get_parikh_image(left_expr)
        unique_chars = set()
        for key, value in domain_quota.items():
            if value == 1 and key not in allowed_chars:
                unique_chars.add(key)
        if not unique_chars:
            lit_index = self.create_literal(expr)
            return ExpressionTree.LEAF(lit_index)
        constant_index = self.regex_processor.get_index_first_unique_constant(left_expr)
        constant_in_index = self.regex_processor.get_index_constant_in_pattern(right_expr, left_expr[constant_index])
        if constant_in_index is None:
            lit_index = self.create_literal(expr)
            return ExpressionTree.LEAF(lit_index)
        paired_list = self.regex_processor.get_split_pattern(left_expr, right_expr, constant_index, constant_in_index)
        if not paired_list:
            lit_index = self.create_literal(expr)
            return ExpressionTree.LEAF(lit_index)
        paired_trees = []
        for left_expr, right_expr in paired_list:
            left_tree = self.get_exptree_split(left_expr)
            right_tree = self.get_exptree_split(right_expr)
            paired_trees.append(ExpressionTree.AND([left_tree, right_tree]))
        if len(paired_trees) == 1:
            return paired_trees[0]
        return ExpressionTree.OR(paired_trees)

class SMTProcessor:
    def __init__(self, verbose=False, tree=False):
        self.info_manager = InfoManager()
        self.lemma_generator = LemmaGenerator(
            self.info_manager, 
            RegexProcessor(self.info_manager),
            BoolProcessor(self.info_manager),
            ArithmeticProcessor(self.info_manager))
        self.verbose = verbose
        self.tree = tree
        Parser.set_tree_format(tree)
    
    def get_lemmas(self):
        self.info_manager.add_literal(SMTLit('false'))
        self.info_manager.add_literal(SMTLit('true'))
        for clause in self.info_manager.clauses:
            self.lemma_generator.get_lemmas_split(clause)
        is_sat = self.lemma_generator.rewrite_lemmas(self.info_manager.lemmas)
        self.lemma_generator.get_lemmas_length(self.info_manager.lemmas)
        
        if self.verbose:
            logging.info(f"Got {len(self.info_manager.lemmas)} lemmas")
            for lemma in self.info_manager.lemmas:
                print(Fore.BLUE + Back.YELLOW + str(lemma) + Style.RESET_ALL)
                print(lemma.get_comment())
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
        if self.verbose:
            logging.info(f"Processed file saved to: {out}")

if __name__=='__main__':
    parser = argparse.ArgumentParser(description='Process SMT2 files with regex preprocessing')
    parser.add_argument('input_file', help='Input SMT2 file')
    parser.add_argument('output_file', nargs='?', help='Output file (optional)')
    parser.add_argument('-v', '--verbose', action='store_true', help='Enable silent mode (no output)')
    parser.add_argument('-t', '--tree', action='store_true', help='Enable tree-style output format')
    args = parser.parse_args()
    log_level = logging.WARNING if args.verbose else logging.INFO
    logging.basicConfig(
        level=log_level,
        format='%(asctime)s - %(levelname)s - %(message)s',
        force=True
    )
    init()
    SMTProcessor(verbose=not args.verbose, tree=args.tree).process_file(args.input_file, args.output_file)