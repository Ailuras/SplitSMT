import re
import math
import logging
import argparse
from colorama import Fore, Back, Style, init
from collections import deque
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
        if line.startswith(('(declare-fun', '(define-fun', '(declare-const')):
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
    def __init__(self, var, var_type, name=None):
        self.index = None
        self.var = var
        self.type = var_type
        self._custom_name = name
        self.used = False
        self.allow = set(chr(c) for c in range(32, 127))
        self.original_line = None
        self.lit_indices = []
    
    @property
    def name(self):
        if self._custom_name is not None:
            return self._custom_name
            
        if self.type == "String":
            return f"x{self.index}"
        elif self.type == "Int":
            return f"i{self.index}"
        elif self.type == "Bool":
            return f"b{self.index}"
        return f"v{self.index}"

    def add_lit(self, lit_index):
        if lit_index not in self.lit_indices:
            self.lit_indices.append(lit_index)

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
        return f"{self.expr_tree.get_comment() if self.expr_tree else 'None'}"

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

    def is_unit(self):
        if self.op == 'not':
            return self.elements[0].is_unit()
        elif self.op == 'leaf':
            return True
        return False

    def get_unit_lit(self):
        if self.is_unit():
            if self.op == 'not':
                return self.elements[0].get_unit_lit()
            else:
                return self.elements[0]
        return None
    
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
    
    def update_literal_indices(self, before_index, after_index):
        if self.op == 'leaf':
            if self.elements and self.elements[0] == before_index:
                self.elements[0] = after_index
        elif self.op in ['and', 'or', 'not']:
            for element in self.elements:
                element.update_literal_indices(before_index, after_index)
    
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
    
    def is_unit(self):
        if self.expr_tree:
            return self.expr_tree.is_unit()
        return False

    def get_unit_lit(self):
        if self.is_unit():
            return self.expr_tree.get_unit_lit()
        return None
    
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
        self.clause_indices = []
        self.lemma_indices = []
        self.unit = None
        self.origin = False

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
    
    def add_clause(self, clause_index):
        if clause_index not in self.clause_indices:
            self.clause_indices.append(clause_index)
    
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
        self.tmp_var_map = {}
        self.lemma_counter = 0
        self.lemmas = []
        self.literal_counter = 0
        self.literals = []
        self.add_literal(SMTLit('false'))
        self.add_literal(SMTLit('true'))
        self.rewrite_processor = RewriteProcessor()

    def _process_declare(self, line):
        expr = Parser.parse_expression(Parser.tokenize(line))
        var = expr[1]
        type_info = expr[3] if expr[0] == 'declare-fun' else expr[2]
        v = SMTVar(var, type_info)
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
        if var in self.var_map:
            return self.vars[self.var_map[var]]
        if var in self.tmp_var_map:
            return self.tmp_vars[self.tmp_var_map[var]]
        return None

    def _get_expr_tree(self, expr):
        if not expr:
            return None
        if isinstance(expr, str):
            lit = SMTLit(expr)
            lit_find = self.find_literal(lit)
            if lit_find is None:
                lit_index = self.add_literal(lit)
                return ExpressionTree('leaf', [lit_index])
            return ExpressionTree('leaf', [lit_find.index])
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
        lit_find = self.find_literal(lit)
        lit_index = lit_find.index if lit_find else self.add_literal(lit)
        return ExpressionTree('leaf', [lit_index])

    def _process_assert(self, line):
        expr = Parser.parse_expression(Parser.tokenize(line))
        expr = self.rewrite_processor.split_string_constants(expr)
        expr = self.rewrite_processor.remove_re_nesting(expr)
        expr = self.rewrite_processor.deploy_union_in_kleene(expr)
        expr = self._rename_var(expr)
        if isinstance(expr, list) and len(expr) > 1 and isinstance(expr[1], list):
            clu_type = Parser.classify_type(expr[1]) if expr[1] else 'default'
        else:
            clu_type = 'default'
        expr_tree = self._get_expr_tree(expr[1])
        if expr_tree:
            expr_tree.set_info_manager(self)
        clause = SMTClause(self.clause_counter, expr_tree, clu_type)
        lits = expr_tree.get_all_leaf_indices()
        for lit_index in lits:
            self.literals[lit_index].add_clause(self.clause_counter)
        clause.original_line = line
        self.add_clause(clause)
        if expr_tree.is_unit():
            lit_index = expr_tree.get_unit_lit()
            lit = self.literals[lit_index]
            lit.unit = 'true' if expr_tree.op == 'leaf' else 'false'

    def process_line(self, line):
        line = line.strip()
        line_type = Parser.classify_line(line)
        if line_type == 'comment':
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
        var.index = self.var_counter
        self.vars.append(var)
        self.var_counter += 1
        self.var_map[var.var] = var.index
    
    def add_clause(self, clause):
        self.clauses.append(clause)
        self.clause_counter += 1

    def add_lemma(self, lemma):
        lemma.index = self.lemma_counter
        self.lemmas.append(lemma)
        self.lemma_counter += 1
        return lemma.index

    def add_tmp_var(self, var):
        var.index = self.tmp_var_counter
        self.tmp_vars.append(var)
        self.tmp_var_counter += 1
        self.tmp_var_map[var.var] = var.index
        return var.index

    def add_literal(self, lit):
        lit.index = self.literal_counter
        self.literals.append(lit)
        self.literal_counter += 1
        return lit.index

    def find_literal(self, lit):
        for l in self.literals:
            if (not l.origin) and str(lit) == str(l):
                return l
        return None

    def reset_lemmas(self):
        self.lemma_counter = 0
        self.lemmas = []
        for lit in self.literals:
            lit.lemma_indices = []

    def update_info(self):
        self.var_map = {var.name: var.index for var in self.vars}
        for clause in self.clauses:
            if clause.type != 're_in' or not clause.expr_tree:
                continue
            expr = clause.expr_tree.get_expr()
            if not expr or len(expr) < 3 or expr[0] != 'str.in_re':
                continue
            vars_found = self.rewrite_processor.extract_vars(expr[1])
            chars_found = self.rewrite_processor.extract_chars(expr[2])
            for var_name in vars_found:
                var = self.get_var(var_name)
                var.allow = var.allow.intersection(chars_found)
        for lit in self.literals:
            lit.origin = True

class RewriteProcessor:

    def extract_vars(self, exp):
        vars_found = set()
        if isinstance(exp, str) and exp.startswith('x'):
            vars_found.add(exp)
        elif isinstance(exp, list):
            for e in exp:
                vars_found.update(self.extract_vars(e))
        return vars_found

    def extract_chars(self, exp):
        chars = set()
        if isinstance(exp, str) and exp.startswith('"'):
            chars.update(exp[1:-1])
        elif isinstance(exp, list) and exp:
            op = exp[0]
            if op == 'not':
                return self.extract_chars(exp[1])
            elif len(exp) >= 3 and op == 're.range':
                start, end = exp[1][1:-1], exp[2][1:-1]
                chars.update(chr(c) for c in range(ord(start), ord(end) + 1))
            elif op in ['re.++', 're.union', 're.*', 're.+']:
                for e in exp[1:]:
                    chars.update(self.extract_chars(e))
            elif op == 'str.in_re' and len(exp) >= 3:
                chars.update(self.extract_chars(exp[2]))
            else:
                for e in exp:
                    chars.update(self.extract_chars(e))
        return chars

    def remove_tabu_chars(self, expr, allowed_chars):
        if not allowed_chars:
            return ['str.to_re', '""']
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
                    else:  # re.+
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

    def merge_kleene_star(self, expr):
        if not isinstance(expr, list):
            return expr
        if not expr:
            return expr
        op = expr[0]
        if op == 're.++':
            parts = [self.merge_kleene_star(part) for part in expr[1:]]
            groups = []
            current_kleene_group = []
            for part in parts:
                if isinstance(part, list) and part and part[0] in ['re.*', 're.+']:
                    current_kleene_group.append(part)
                else:
                    if current_kleene_group:
                        groups.append(('kleene', current_kleene_group))
                        current_kleene_group = []
                    groups.append(('other', part))
            if current_kleene_group:
                groups.append(('kleene', current_kleene_group))
            result = []
            for group_type, group_content in groups:
                if group_type == 'other':
                    result.append(group_content)
                else:
                    if len(group_content) == 1:
                        result.append(group_content[0])
                    else:
                        char_sets = []
                        for i, kleene in enumerate(group_content):
                            chars = self._get_chars_from_regex(kleene[1])
                            char_sets.append((i, kleene, chars))
                        all_chars = set()
                        for _, _, chars in char_sets:
                            all_chars.update(chars)
                        found_superset = False
                        char_sets.sort(key=lambda x: (-len(x[2]), x[0]))
                        for i, kleene, chars in char_sets:
                            if chars == all_chars:
                                result.append(kleene)
                                found_superset = True
                                break
                        if not found_superset:
                            char_sets.sort(key=lambda x: x[0])
                            for _, kleene, _ in char_sets:
                                result.append(kleene)
            if not result:
                return ['str.to_re', '""']
            if len(result) == 1:
                return result[0]
            return ['re.++'] + result
        elif op == 're.union':
            parts = [self.merge_kleene_star(part) for part in expr[1:]]
            return ['re.union'] + parts
        elif op in ['re.*', 're.+']:
            inner = self.merge_kleene_star(expr[1])
            return [op, inner]
        return [op] + [self.merge_kleene_star(part) for part in expr[1:]]

    def rebuild_single_char_expr(self, expr):
        if not isinstance(expr, list):
            return expr
        if not expr:
            return expr
        op = expr[0]
        if op == 're.++':
            result = []
            for part in expr[1:]:
                rebuilt_part = self.rebuild_single_char_expr(part)
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
                rebuilt_part = self.rebuild_single_char_expr(part)
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
            inner = self.rebuild_single_char_expr(expr[1])
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
        return [op] + [self.rebuild_single_char_expr(e) for e in expr[1:]]

    def split_string_constants(self,expr):
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
                inner = self.split_string_constants(expr[1])
                if isinstance(inner, list) and inner and inner[0] == 'str.++':
                    char_to_re = [['str.to_re', part] for part in inner[1:]]
                    return ['re.++'] + char_to_re
            return [h, self.split_string_constants(expr[1])]
        return [h] + [self.split_string_constants(e) for e in expr[1:]]
    
    def remove_re_nesting(self, expr):
        if not isinstance(expr, list) or not expr:
            return expr
        h = expr[0]
        if h in ['re.++', 're.union', 'str.++']:
            merged = [h]
            for sub in expr[1:]:
                simplified = self.remove_re_nesting(sub)
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
                                return self.remove_re_nesting(result)
                return result
            return merged
        elif h in ['re.*', 're.+']:
            body = self.remove_re_nesting(expr[1])
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
                                return [h, self.remove_re_nesting(new_union)]
            return [h, body]
        return [h] + [self.remove_re_nesting(e) for e in expr[1:]]
        
    def deploy_union_in_kleene(self, expr):
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
                sub_result = self.deploy_union_in_kleene(sub_expr)
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
                sub_result = self.deploy_union_in_kleene(part)
                if isinstance(sub_result, list) and sub_result and sub_result[0] == 're.union':
                    parts.append(sub_result[1:])
                else:
                    parts.append([sub_result])
            if not parts:
                return ['str.to_re', '""']
            result = self._cartesian_product_concat(parts)
            if len(result) == 1:
                return result[0]
            return ['re.union'] + result
        elif op in ['re.*', 're.+']:
            inner = self.deploy_union_in_kleene(expr[1])
            return [op, inner]
        return [op] + [self.deploy_union_in_kleene(e) for e in expr[1:]]

    def _cartesian_product_concat(self, parts_list):
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
    
    def _get_chars_from_regex(self, expr):
        if not isinstance(expr, list):
            return set()
        if not expr:
            return set()
        op = expr[0]
        if op == 'str.to_re':
            if len(expr) > 1 and isinstance(expr[1], str) and expr[1].startswith('"') and expr[1].endswith('"'):
                s = expr[1][1:-1]
                return set(s)
            return set()
        elif op == 're.union':
            result = set()
            for part in expr[1:]:
                result.update(self._get_chars_from_regex(part))
            return result
        elif op in ['re.*', 're.+']:
            return self._get_chars_from_regex(expr[1])
        elif op == 're.++':
            result = set()
            for part in expr[1:]:
                result.update(self._get_chars_from_regex(part))
            return result
        return set()

class RegexProcessor:
    def __init__(self, info):
        self.info_manager = info

    def is_direct_match(self, re_expr, constant):
        if isinstance(constant, str) and constant.startswith('"'):
            constant_value = constant[1:-1]
        else:
            constant_value = constant
        if not isinstance(re_expr, list):
            if isinstance(re_expr, str) and re_expr.startswith('"'):
                return re_expr[1:-1] == constant_value
            return re_expr == constant
        if re_expr and re_expr[0] == 'str.to_re' and len(re_expr) > 1:
            if isinstance(re_expr[1], str) and re_expr[1].startswith('"'):
                return re_expr[1][1:-1] == constant_value
            return re_expr[1] == constant
        return False

    def is_must_match(self, re_expr, constant):
        constant = constant[1:-1]
        if not isinstance(re_expr, list):
            if isinstance(re_expr, str) and re_expr.startswith('"'):
                return constant in re_expr
            return False
        if not re_expr:
            return False
        op = re_expr[0]
        if op == 'str.to_re':
            if len(re_expr) > 1 and isinstance(re_expr[1], str) and re_expr[1].startswith('"'):
                return constant in re_expr[1]
            return False
        if op in ['re.*', 're.+']:
            return False
        if op == 're.union':
            if len(re_expr) <= 1:
                return False
            return all(self.is_must_match(sub_expr, constant) for sub_expr in re_expr[1:])
        if op == 're.++':
            if len(re_expr) <= 1:
                return False
            return any(self.is_must_match(sub_expr, constant) for sub_expr in re_expr[1:])
        return False

    def is_contain_constant(self, re_expr, constant):
        if not re_expr:
            return False
        if self.is_direct_match(re_expr, constant):
            return True
        constant_value = constant[1:-1] if isinstance(constant, str) and constant.startswith('"') else constant
        if isinstance(re_expr, str) and re_expr.startswith('"'):
            return constant_value in re_expr[1:-1]
        op = re_expr[0]
        if op == 'str.to_re' and len(re_expr) > 1:
            if isinstance(re_expr[1], str) and re_expr[1].startswith('"'):
                return constant_value in re_expr[1][1:-1]
        if op == 're.range' and len(re_expr) > 2:
            if len(constant_value) == 1:
                range_start = re_expr[1][1:-1] if isinstance(re_expr[1], str) and re_expr[1].startswith('"') else re_expr[1]
                range_end = re_expr[2][1:-1] if isinstance(re_expr[2], str) and re_expr[2].startswith('"') else re_expr[2]
                return range_start <= constant_value <= range_end
            return False
        if op in ['re.*', 're.+'] and len(re_expr) > 1:
            return self.is_contain_constant(re_expr[1], constant)
        if op in ['re.++', 're.union']:
            for sub_expr in re_expr[1:]:
                if self.is_contain_constant(sub_expr, constant):
                    return True
        return False

    def is_str_in_regex(self, str_expr, re_expr):
        constant_str = ""
        if isinstance(str_expr, list) and str_expr[0] == 'str.++':
            if all(isinstance(e, str) and e.startswith('"') for e in str_expr[1:]):
                constant_str = ''.join(e[1:-1] for e in str_expr[1:])
            else:
                return None
        elif isinstance(str_expr, str):
            if str_expr.startswith('"'):
                constant_str = str_expr[1:-1]
            else:
                return None
        else:
            return None
        if constant_str == "":
            if re_expr == '""' or re_expr == ['str.to_re', '""']:
                return 'true'
            if isinstance(re_expr, list) and re_expr[0] == 're.++':
                if self.can_be_empty(re_expr):
                    return 'true'
                return 'false'
            if isinstance(re_expr, list) and re_expr[0] == 'str.to_re' and len(re_expr) > 1:
                if isinstance(re_expr[1], str) and re_expr[1] != '""':
                    return 'false'
                elif isinstance(re_expr[1], str) and re_expr[1] == '""':
                    return 'true'
            elif isinstance(re_expr, list) and re_expr[0] in ['re.range', 're.allchar']:
                return 'false'
            if isinstance(re_expr, str) and re_expr.startswith('"') and re_expr != '""':
                return 'false'
        if isinstance(re_expr, list) and len(re_expr) > 1:
            if re_expr[0] == 're.++' and any(isinstance(e, str) and e.startswith('"') and 'z' in e for e in re_expr[1:]):
                if constant_str == "" or 'z' not in constant_str:
                    return 'false'
            if re_expr[0] == 'str.to_re' and len(re_expr) == 2:
                if isinstance(re_expr[1], str) and re_expr[1].startswith('"'):
                    pattern_str = re_expr[1][1:-1]
                    if constant_str != pattern_str:
                        return 'false'
                    else:
                        return 'true'
        if isinstance(re_expr, list) and len(re_expr) == 1:
            re_expr = re_expr[0]
        regex_pattern = Parser.to_pyre(re_expr)
        if regex_pattern is None:
            return None
        try:
            if re.fullmatch(regex_pattern, constant_str):
                return 'true'
            else:
                return 'false'
        except Exception as e:
            logging.debug1(f"Exception in is_str_in_regex: {e}, for string '{constant_str}' and pattern '{regex_pattern}'")
            return 'false'

    def can_be_empty(self, re_expr):
        if not re_expr or len(re_expr) == 0:
            return True
        if re_expr[0] == 'str.to_re':
            return re_expr[1] == '""'
        elif re_expr[0] == 're.++':
            return all(self.can_be_empty(elem) for elem in re_expr[1:])
        elif re_expr[0] == 're.union':
            return any(self.can_be_empty(elem) for elem in re_expr[1:])
        elif re_expr[0] == 're.*':
            return True
        return False

    def get_variables(self, str_expr):
        vars_found = set()
        if isinstance(str_expr, str) and str_expr.startswith('x'):
            vars_found.add(str_expr)
        elif isinstance(str_expr, list):
            for e in str_expr:
                vars_found.update(self.get_variables(e))
        return vars_found
    
    def get_chars(self, expr):
        if isinstance(expr, str):
            if expr.startswith('"') and expr.endswith('"'):
                return set(expr[1:-1])
            elif expr.startswith('x'):
                var = self.info_manager.get_var(expr)
                if var and hasattr(var, 'allow') and var.allow is not None:
                    return var.allow
                return set()
            return set()
        if not isinstance(expr, list) or not expr:
            return set()
        op = expr[0]
        if op == 'str.++':
            result = set()
            for part in expr[1:]:
                result.update(self.get_chars(part))
            return result
        elif op == 'str.to_re':
            if len(expr) > 1:
                return self.get_chars(expr[1])
            return set()
        elif op == 're.union':
            result = set()
            for part in expr[1:]:
                result.update(self.get_chars(part))
            return result
        elif op in ['re.*', 're.+']:
            return self.get_chars(expr[1])
        elif op == 're.++':
            result = set()
            for part in expr[1:]:
                result.update(self.get_chars(part))
            return result
        elif op == 're.range' and len(expr) > 2:
            start_char = expr[1]
            end_char = expr[2]
            if isinstance(start_char, str) and len(start_char) == 1 and isinstance(end_char, str) and len(end_char) == 1:
                return set(chr(i) for i in range(ord(start_char), ord(end_char) + 1))
        return set()

    def get_parikh_image(self, expr, is_regex=False):
        if isinstance(expr, str):
            if expr.startswith('"') and len(expr) > 2:
                result = {}
                for char in expr[1:-1]:
                    result[char] = result.get(char, 0) + 1
                return result
            return {}
        if not isinstance(expr, list) or not expr:
            return {}
        if is_regex:
            if len(expr) <= 0:
                return {}
            op = expr[0]
            result = {}
            if op == 'str.to_re' and len(expr) > 1:
                return self.get_parikh_image(expr[1], False)
            elif op == 're.++':
                for sub_expr in expr[1:]:
                    sub_result = self.get_parikh_image(sub_expr, True)
                    for char, count in sub_result.items():
                        result[char] = result.get(char, 0) + count
            elif op == 're.union' and len(expr) > 1:
                result = self.get_parikh_image(expr[1], True)
                for sub_expr in expr[2:]:
                    sub_result = self.get_parikh_image(sub_expr, True)
                    chars_to_remove = []
                    for char in result:
                        if char in sub_result:
                            result[char] = min(result[char], sub_result[char])
                        else:
                            chars_to_remove.append(char)
                    for char in chars_to_remove:
                        result.pop(char)
            elif op == 're.+':
                return self.get_parikh_image(expr[1], True)
            return result
        constants = {}
        for e in expr:
            sub_constants = self.get_parikh_image(e, is_regex)
            for char, count in sub_constants.items():
                constants[char] = constants.get(char, 0) + count
        return constants
    
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
            if self.is_contain_constant(sub_expr, constant):
                indices.append(i)
        return indices
    
    def get_deploy_pattern(self, re_expr, constant, mode='once'):
        if not isinstance(re_expr, list):
            return None
        if not re_expr:
            return None
        op = re_expr[0]
        if op in ['str.to_re', 're.++']:
            result = self.get_filted_pattern(re_expr, constant, mode)
            if result:
                return [[], result, []]
            return None
        elif op == 're.union':
            filtered_elements = []
            for element in re_expr[1:]:
                result = self.get_filted_pattern(element, constant, mode)
                if result:
                    filtered_elements.append(result)
            if not filtered_elements:
                return None
            filtered_pattern = ['re.union'] + filtered_elements
            return [[], filtered_pattern, []]
        elif op == 're.range':
            if constant >= re_expr[1] and constant <= re_expr[2]:
                return [[], constant, []]
            return None
        elif op == 're.*':
            inner_result = self.get_deploy_pattern(re_expr[1], constant, mode)
            if inner_result is None:
                return None
            return [re_expr, inner_result[1], re_expr]
        return None

    def get_filted_pattern(self, re_expr, constant, mode='once'):
        def remove_kleene_and_union(re_expr, constant):
            re_expr = re_expr[1] if re_expr[0] == 're.*' else re_expr
            if re_expr[0] == 're.union':
                filtered_elements = []
                for sub_expr in re_expr[1:]:
                    if isinstance(sub_expr, list) and self.is_contain_constant(sub_expr, constant):
                        filtered_elements.append(sub_expr)
                if len(filtered_elements) == 1:
                    return filtered_elements[0]
                if filtered_elements:
                    return ['re.union'] + filtered_elements
            return re_expr

        if self.is_direct_match(re_expr, constant):
            return re_expr
        re_expr = re_expr[1:] if re_expr[0] == 're.++' else re_expr
        new_pattern = []
        if mode == 'once':
            index = self.get_index_constant_must_in_pattern(re_expr, constant)
            if index is None:
                return None
            indices = [i for i in self.get_index_constant_in_pattern(re_expr, constant) if i != index]
            for i in range(len(re_expr)):
                if i in indices:
                    continue
                elif i == index:
                    new_pattern.append(remove_kleene_and_union(re_expr[i], constant))
                else:
                    new_pattern.append(re_expr[i])
            return self.normalize_expr(new_pattern, is_regex=True)
        elif mode == 'first':
            indices = self.get_index_constant_in_pattern(re_expr, constant)
            if indices is None:
                return None
            for index in indices:
                new_sub_pattern = []
                for i in range(len(re_expr)):
                    if i < index and not self.can_be_empty(re_expr[i]):
                        break
                    elif i == index:
                        new_sub_pattern.append(remove_kleene_and_union(re_expr[i], constant))
                    else:
                        new_sub_pattern.append(re_expr[i])
                if new_sub_pattern:
                    new_pattern.append(self.normalize_expr(new_sub_pattern, is_regex=True))
            if not new_pattern:
                return None
            if len(new_pattern) == 1:
                return new_pattern[0]
            return ['re.union'] + new_pattern
    
    def get_split_pattern(self, str_expr, re_expr, constant_index, constant_in_index):
        left_left = self.normalize_expr(str_expr[:constant_index])
        left_mid = str_expr[constant_index]
        left_right = self.normalize_expr(str_expr[constant_index+1:])
        right_left = re_expr[:constant_in_index]
        right_mid = re_expr[constant_in_index]
        right_right = re_expr[constant_in_index+1:]
        deploy_pattern = self.get_deploy_pattern(right_mid, left_mid, mode='once')
        if not deploy_pattern:
            return None
        left_sides, right_sides = self.get_sides_pattern(deploy_pattern[1], left_mid)
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

    def get_sides_pattern(self, re_expr, constant):
        if self.is_direct_match(re_expr, constant):
            return [['str.to_re', '""']], [['str.to_re', '""']]
        if isinstance(re_expr, list) and re_expr and re_expr[0] == 're.++':
            left_parts = []
            right_parts = []
            for i, part in enumerate(re_expr[1:], 1):
                if self.is_direct_match(part, constant):
                    left_segment = re_expr[1:i]
                    right_segment = re_expr[i+1:] if i+1 < len(re_expr) else []
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
        if isinstance(re_expr, list) and re_expr and re_expr[0] == 're.union':
            left_parts = []
            right_parts = []
            for option in re_expr[1:]:
                if isinstance(option, list) and option and option[0] == 're.++':
                    option_left, option_right = self.get_sides_pattern(option, constant)
                    left_parts.extend(option_left)
                    right_parts.extend(option_right)
                elif self.is_direct_match(option, constant):
                    left_parts.append(['str.to_re', '""'])
                    right_parts.append(['str.to_re', '""'])
            if left_parts and right_parts:
                return left_parts, right_parts
        return [['str.to_re', '""']], [['str.to_re', '""']]

    def get_reverse_pattern(self, expr):
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
        elif expr[0] in ['re.++', 'str.++']:
            reversed_elements = [self.get_reverse_pattern(elem) for elem in expr[1:]]
            reversed_elements.reverse()
            return [expr[0]] + reversed_elements
        elif expr[0] == 're.union':
            return ['re.union'] + [self.get_reverse_pattern(elem) for elem in expr[1:]]
        elif expr[0] == 're.*':
            return ['re.*', self.get_reverse_pattern(expr[1])]
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
                    reversed_list.append(self.get_reverse_pattern(item))
                else:
                    reversed_list.append(item)
            reversed_list.reverse()
            return reversed_list
        return expr

    def get_remove_pattern(self, str_expr, re_expr, constant_in_index):
        constant = str_expr[0]
        left_norm = self.normalize_expr(str_expr[1:])
        logging.debug(f"re_expr: {re_expr}")
        right_left = self.normalize_expr(re_expr[:constant_in_index], is_regex=True)
        right_mid = re_expr[constant_in_index]
        right_right = re_expr[constant_in_index+1:]
        if not self.can_be_empty(right_left):
            logging.debug1(f"{Parser.to_str(right_left)} can't be empty")
            return []
        deploy_pattern = self.get_deploy_pattern(right_mid, constant, mode='first')
        if not deploy_pattern:
            return []
        _, right_side = self.get_sides_pattern(deploy_pattern[1], constant)
        result = []
        for right_part in right_side:
            right_norm = self.normalize_expr([right_part] + [deploy_pattern[2]] + right_right, is_regex=True)
            result.append(['str.in_re', left_norm, right_norm])
        return result

    def get_index_unique_constant(self, expr, unique_char):
        if not isinstance(expr, list):
            return None
        for i, e in enumerate(expr):
            if isinstance(e, str) and e.startswith('"'):
                char = e[1:-1]
                if char == unique_char:
                    return i
        return None

    def get_equal_expr(self, lit1, lit2):
        if isinstance(lit2, int):
            if 0 <= lit2 < len(self.info_manager.literals):
                lit2 = self.info_manager.literals[lit2]
            else:
                return None
        if lit1.type != 'string' or not isinstance(lit1.expr, list) or lit1.expr[0] != 'str.in_re':
            return None
        left_expr1, right_expr1 = lit1.expr[1], lit1.expr[2]
        vars_found1 = self.get_variables(left_expr1)
        if len(vars_found1) != 1:
            return None
        var_name1 = next(iter(vars_found1))
        if isinstance(lit2.expr, list) and lit2.expr[0] == '=':
            if len(lit2.expr) < 3:
                return None
            left_eq = lit2.expr[1]
            right_eq = lit2.expr[2]
            if left_eq == var_name1 and isinstance(right_eq, list) and right_eq[0] == 'str.++':
                return ['str.in_re', right_eq, right_expr1]
            else:
                return None
        if not isinstance(lit2.expr, list) or lit2.expr[0] != 'str.in_re':
            return None
        left_expr2 = lit2.expr[1]
        if not isinstance(left_expr2, list) or left_expr2[0] != 'str.++':
            return None
        if isinstance(left_expr1, str) and left_expr1 == var_name1:
            return ['str.in_re', left_expr2, right_expr1]
        return None

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
                    result.append((ExpressionTree.LEAF(var), "rewrite"))
                else:
                    result.append((ExpressionTree.NOT(ExpressionTree.LEAF(var)), "rewrite"))
            else:
                or_elements = []
                for lit in clause:
                    var = abs(lit)
                    if lit > 0:
                        or_elements.append(ExpressionTree.LEAF(var))
                    else:
                        or_elements.append(ExpressionTree.NOT(ExpressionTree.LEAF(var)))
                if or_elements:
                    result.append((ExpressionTree.OR(or_elements), 'rewrite'))
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
            if base_length_expr == '1' or base_length_expr == 1:
                return None
            simplified = self._simplify_arithmetic(str_length_expr, bias_length_expr)
            if simplified is None:
                return None
            result = ['=', ['mod', simplified, base_length_expr], '0']
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

    def get_chars_expr(self, var, char, count):
        if not var or not var.allow:
            return None
        allowed_chars = set(var.allow)
        if char not in allowed_chars:
            allowed_chars.add(char)
        allowed_except_char = allowed_chars - {char}
        expr_list = []
        for index in range(count):
            if index == 0:
                if allowed_except_char:
                    allowed_minus_char_union = ['re.union']
                    for c in allowed_except_char:
                        allowed_minus_char_union.append(['str.to_re', f'"{c}"'])
                    regex_expr = ['re.*', allowed_minus_char_union] if len(allowed_except_char) > 1 else ['re.*', ['str.to_re', f'"{next(iter(allowed_except_char))}"']]
                    lit_expr = ['str.in_re', var.name, regex_expr]
                    expr_list.append(lit_expr)
            elif index == 1:
                all_chars_union = ['re.union']
                for c in allowed_chars:
                    all_chars_union.append(['str.to_re', f'"{c}"'])
                if len(allowed_chars) == 1:
                    all_chars_expr = ['str.to_re', f'"{next(iter(allowed_chars))}"']
                else:
                    all_chars_expr = all_chars_union
                regex_expr = ['re.++', 
                              ['re.*', all_chars_expr], 
                              ['str.to_re', f'"{char}"'], 
                              ['re.*', all_chars_expr]]
                lit_expr = ['str.in_re', var.name, regex_expr]
                expr_list.append(lit_expr)
            else:
                all_chars_union = ['re.union']
                for c in allowed_chars:
                    all_chars_union.append(['str.to_re', f'"{c}"'])
                regex_expr = ['re.*', all_chars_union if len(allowed_chars) > 1 else ['str.to_re', f'"{next(iter(allowed_chars))}"']]
                lit_expr = ['str.in_re', var.name, regex_expr]
                expr_list.append(lit_expr)
                break
        if not expr_list:
            return None
        return expr_list

    def _simplify_arithmetic(self, expr, bias):
        if bias == '0' or bias == 0:
            return expr
        if isinstance(bias, (str, int)) and isinstance(expr, list) and expr[0] == '+':
            bias_val = int(bias) if isinstance(bias, str) and bias.isdigit() else bias
            if isinstance(bias_val, int):
                new_terms = []
                remaining_bias = bias_val
                for term in expr[1:]:
                    if isinstance(term, (str, int)) and str(term).isdigit():
                        term_val = int(term)
                        if remaining_bias >= term_val:
                            remaining_bias -= term_val
                        else:
                            new_terms.append(str(term_val - remaining_bias))
                            remaining_bias = 0
                    else:
                        new_terms.append(term)
                if remaining_bias > 0:
                    if new_terms:
                        if len(new_terms) == 1:
                            return ['-', new_terms[0], str(remaining_bias)]
                        else:
                            return ['-', ['+'] + new_terms, str(remaining_bias)]
                    else:
                        return ['-', '0', str(remaining_bias)]
                if not new_terms:
                    return '0'
                elif len(new_terms) == 1:
                    return new_terms[0]
                else:
                    return ['+'] + new_terms
        return ['-', expr, bias]

class LemmaGenerator:
    def __init__(self, info):
        self.info_manager = info
        self.rewrite_processor = info.rewrite_processor
        self.regex_processor = RegexProcessor(info)
        self.bool_processor = BoolProcessor(info)
        self.arith_processor = ArithmeticProcessor(info)
    
    def create_literal(self, expr):
        lit = SMTLit(expr)
        logging.debug(f"Create literal: {Parser.to_str(expr)}")
        lit = self.rewrite_lit(lit)
        logging.debug(f"Rewrite literal: {Parser.to_str(lit.expr)}")
        lit_find = self.info_manager.find_literal(lit)
        lit_index = lit_find.index if lit_find else self.info_manager.add_literal(lit)
        if lit.type == 'string':
            vars_found = self.regex_processor.get_variables(expr[1])
            for var_name in vars_found:
                var = self.info_manager.get_var(var_name)
                var.add_lit(lit_index)
        return lit_index
    
    def create_lemma(self, expr_tree, lemma_type, comment=None):
        if expr_tree:
            expr_tree.set_info_manager(self.info_manager)
        lemma = SMTLemma(expr_tree, lemma_type, comment)
        lemma_index = self.info_manager.add_lemma(lemma)
        lits = expr_tree.get_all_leaf_indices()
        for lit_index in lits:
            self.info_manager.literals[lit_index].add_lemma(lemma_index)
        return lemma_index
    
    def create_tmp_var(self, var, var_type, allowed_chars):
        tmp_var = SMTVar(var, var_type, name=var)
        tmp_var.allow = allowed_chars
        tmp_var.used = True
        tmp_var_index = self.info_manager.add_tmp_var(tmp_var)
        return tmp_var_index

    def rewrite_lit(self, lit):
        expr = lit.expr
        if lit.type == 'string':
            left_expr, right_expr = expr[1], expr[2]
            vars_found = self.regex_processor.get_variables(left_expr)
            if len(vars_found) == 0:
                val = self.regex_processor.is_str_in_regex(left_expr, right_expr)
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
            right_expr_filtered = self.rewrite_processor.remove_tabu_chars(right_expr, allowed_chars)
            right_expr_filtered = self.rewrite_processor.remove_empty_strings(right_expr_filtered)
            right_expr_filtered = self.rewrite_processor.remove_redundant_constants(right_expr_filtered)
            right_expr_filtered = self.rewrite_processor.reorder_union(right_expr_filtered)
            right_expr_filtered = self.rewrite_processor.merge_kleene_star(right_expr_filtered)
            chars_found = self.rewrite_processor.extract_chars(right_expr_filtered)
            for var_name in vars_found:
                var = self.info_manager.get_var(var_name)
                if chars_found.issubset(var.allow) and len(chars_found) != len(var.allow):
                    var.allow = var.allow.intersection(chars_found)
                    for lit_index in var.lit_indices:
                        lit = self.info_manager.literals[lit_index]
                        self.info_manager.literals[lit_index] = self.rewrite_lit(lit)
            if len(allowed_chars) == 1:
                right_expr_filtered = self.rewrite_processor.rebuild_single_char_expr(right_expr_filtered)
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
            self.create_lemma(tree, lemma_type=lemma_type)
            if tree.is_unit():
                lit_index = tree.get_unit_lit()
                lit = self.info_manager.literals[lit_index]
                lit.unit = 'true' if tree.op == 'leaf' else 'false'
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

    def get_exptree_length(self, expr):
        left_expr, right_expr = expr[1], expr[2]
        vars_found = self.regex_processor.get_variables(left_expr)
        constants = self.regex_processor.get_parikh_image(left_expr)
        if len(vars_found) == 0 or len(vars_found) > 1 or len(constants) > 0:
            lit_index = self.create_literal(expr)
            return ExpressionTree.LEAF(lit_index)
        var = self.info_manager.get_var(next(iter(vars_found)))
        constants = self.regex_processor.get_parikh_image(right_expr, is_regex=True)
        filtered_constants = {}
        for char, count in constants.items():
            if count == 1:
                filtered_constants[char] = count
        if len(filtered_constants) != 1:
            lit_index = self.create_literal(expr)
            return ExpressionTree.LEAF(lit_index)
        exptrees = []
        for char, count in filtered_constants.items():
            expr_list = self.arith_processor.get_chars_expr(var, char, count)
            if expr_list:
                expr_trees = []
                for i, char_expr in enumerate(expr_list):
                    lit_index = self.create_literal(char_expr)
                    expr_trees.append(ExpressionTree.LEAF(lit_index))
                expr_tree = ExpressionTree.OR(expr_trees)
                exptrees.append(expr_tree)
        if len(exptrees) == 1:
            return exptrees[0]
        expr_tree = ExpressionTree.OR(exptrees)
        return expr_tree
    
    def get_lemmas_split(self, lit):
        if lit.type != 'string':
            return
        logging.debug4(f"Processing clause: {Parser.to_str(lit.expr)}")
        expr_tree = self.get_exptree_split(lit.expr)
        if expr_tree:
            expr_tree_lemma_left = ExpressionTree.OR([ExpressionTree.NOT(ExpressionTree.LEAF(lit.index)), expr_tree])
            expr_tree_lemma_right = ExpressionTree.OR([ExpressionTree.NOT(expr_tree), ExpressionTree.LEAF(lit.index)])
            lemma_index_left = self.create_lemma(expr_tree_lemma_left, lemma_type='split')
            lemma_index_right = self.create_lemma(expr_tree_lemma_right, lemma_type='split')
            logging.debug3(f"Lemma({lemma_index_left}): {expr_tree_lemma_left.get_comment()}")
            logging.debug3(f"Lemma({lemma_index_right}): {expr_tree_lemma_right.get_comment()}")

    def get_exptree_split(self, expr):
        logging.debug1(f"Processing exptree: {Parser.to_str(expr)}")
        str_expr, re_expr = expr[1], expr[2]
        str_expr = str_expr[1:] if str_expr[0] == 'str.++' else [str_expr]
        re_expr = re_expr[1:] if re_expr[0] == 're.++' else [re_expr]
        if len(re_expr) == 1 and isinstance(re_expr[0], list) and re_expr[0][0] == 're.union' and len(re_expr[0]) >= 3:
            trees = []
            str_expr = self.regex_processor.normalize_expr(str_expr)
            for e in re_expr[0][1:]:
                expr = ['str.in_re', str_expr, e]
                trees.append(self.get_exptree_split(expr))
            return ExpressionTree.OR(trees)
        vars_found = self.regex_processor.get_variables(str_expr)
        if len(vars_found) == 0:
            lit_index = self.create_literal(expr)
            logging.debug(f"Got literal({lit_index}): {self.info_manager.literals[lit_index]}, reason: no variables")
            return ExpressionTree.LEAF(lit_index)
        if (isinstance(str_expr[0], str) and str_expr[0].startswith('"')) or (isinstance(str_expr[-1], str) and str_expr[-1].startswith('"')):
            reversed = False
            if not (isinstance(str_expr[0], str) and str_expr[0].startswith('"')) and (isinstance(str_expr[-1], str) and str_expr[-1].startswith('"')):
                str_expr = self.regex_processor.get_reverse_pattern(str_expr)
                re_expr = self.regex_processor.get_reverse_pattern(re_expr)
                reversed = True
            constant_in_indices = self.regex_processor.get_index_constant_in_pattern(re_expr, str_expr[0])
            if not constant_in_indices:
                lit_index = self.create_literal('false')
                logging.debug(f"Got literal({lit_index}): {self.info_manager.literals[lit_index]} which is false, reason: no constant in right_expr")
                return ExpressionTree.LEAF(lit_index)
            exptrees = []
            for constant_in_index in constant_in_indices:
                logging.debug(f"Processing constant_in_index: {constant_in_index}")
                re_expr_list = self.regex_processor.get_remove_pattern(str_expr, re_expr, constant_in_index)
                for new_expr in re_expr_list:
                    if reversed and len(new_expr) == 3 and new_expr[0] == 'str.in_re':
                        new_str_expr, new_re_expr = new_expr[1], new_expr[2]
                        new_str_expr = self.regex_processor.get_reverse_pattern(new_str_expr)
                        new_re_expr = self.regex_processor.get_reverse_pattern(new_re_expr)
                        new_expr = ['str.in_re', new_str_expr, new_re_expr]
                    exptrees.append(self.get_exptree_split(new_expr))
            if len(exptrees) == 1:
                return exptrees[0]
            if exptrees:
                return ExpressionTree.OR(exptrees)
        constants = self.regex_processor.get_parikh_image(str_expr)
        if len(constants) == 0 and len(vars_found) == 1:
            pass
        unique_chars = set()
        for key, value in constants.items():
            if value == 1:
                unique_chars.add(key)
        if unique_chars:
            unique_char = next(iter(unique_chars))
            constant_index = self.regex_processor.get_index_unique_constant(str_expr, unique_char)
            left_str_list = str_expr[:constant_index]
            right_str_list = str_expr[constant_index + 1:]
            allowed_chars_left = self.regex_processor.get_chars(left_str_list)
            allowed_chars_right = self.regex_processor.get_chars(right_str_list)
            if unique_char in allowed_chars_left and unique_char in allowed_chars_right:
                lit_index = self.create_literal(expr)
                logging.debug(f"Got literal({lit_index}): {self.info_manager.literals[lit_index]}, reason: str_expr can not split")
                return ExpressionTree.LEAF(lit_index)
            constant_in_index = self.regex_processor.get_index_constant_must_in_pattern(re_expr, unique_char)
            if constant_in_index is None:
                lit_index = self.create_literal(expr)
                logging.debug(f"Got literal({lit_index}): {self.info_manager.literals[lit_index]}, reason: re_expr can not split")
                return ExpressionTree.LEAF(lit_index)
            paired_list = self.regex_processor.get_split_pattern(str_expr, re_expr, constant_index, constant_in_index)
            paired_trees = []
            if paired_list == None:
                lit_index = self.create_literal('false')
                logging.debug(f"Got literal({lit_index}): {self.info_manager.literals[lit_index]} which is false, reason: still can not split")
                return ExpressionTree.LEAF(lit_index)
            for left_re_expr, right_re_expr in paired_list:
                left_tree = self.get_exptree_split(left_re_expr)
                right_tree = self.get_exptree_split(right_re_expr)
                paired_trees.append(ExpressionTree.AND([left_tree, right_tree]))
            if len(paired_trees) == 1:
                return paired_trees[0]
            return ExpressionTree.OR(paired_trees)
        lit_index = self.create_literal(expr)
        logging.debug(f"Got literal({lit_index}): {self.info_manager.literals[lit_index]}, reason: no rules matched")
        return ExpressionTree.LEAF(lit_index)

    def get_lemmas_var(self, var):
        if not var.lit_indices:
            return
        logging.debug3(f"Processing variable: {var.name} with {len(var.lit_indices)} literals")
        unit_none_lits = []
        unit_true_lits = []
        unit_false_lits = []
        for lit_index in var.lit_indices:
            lit = self.info_manager.literals[lit_index]
            if lit.expr[1] != var.name:
                continue
            logging.debug3(f"Got literal: {Parser.to_str(lit.expr)}, unit: {lit.unit if lit.unit else 'none'}")
            if lit.unit is None:
                unit_none_lits.append(lit_index)
            if lit.unit == 'true':
                unit_true_lits.append(lit_index)
            if lit.unit == 'false':
                unit_false_lits.append(lit_index)
        var_tree_list = []
        if unit_true_lits:
            index = 0
            for lit_index in unit_true_lits:
                lit = self.info_manager.literals[lit_index]
                logging.debug2(f"Processing true literal: {Parser.to_str(lit.expr)}")
                var_tree = self.get_exptree_var(lit, index)
                if var_tree:
                    var_tree.set_info_manager(self.info_manager)
                    logging.debug3(f"Got variable tree for literal {lit_index}: {var_tree}")
                    var_tree_list.append(var_tree)
                index += 1
        if var_tree_list:
            logging.debug2(f"Creating expression tree with {len(var_tree_list)} trees")
            expr_tree = ExpressionTree.AND(var_tree_list)
            lemma_index = self.create_lemma(expr_tree, lemma_type='equation')
            logging.debug4(f"Lemma({lemma_index}): {expr_tree.get_comment()}")
        for lit_index in unit_false_lits + unit_true_lits + unit_none_lits:
            lit = self.info_manager.literals[lit_index]
            logging.debug2(f"Processing lit {lit_index} for equation lemmas")
            for var_tree in var_tree_list:
                var_lit_index = var_tree.get_unit_lit()
                var_lit = self.info_manager.literals[var_lit_index]
                logging.debug3(f"Creating equal expression for lit {Parser.to_str(lit.expr)} and var_lit {Parser.to_str(var_lit.expr)}")
                expr = self.regex_processor.get_equal_expr(lit, var_lit)
                logging.debug3(f"Equal expression: {Parser.to_str(expr)}")
                if expr:
                    logging.debug3(f"Got equal expression: {Parser.to_str(expr)}")
                    expr_tree = self.get_exptree_split(expr)
                    if expr_tree:
                        expr_tree_lemma_left = ExpressionTree.OR([ExpressionTree.NOT(ExpressionTree.LEAF(lit.index)), expr_tree])
                        expr_tree_lemma_right = ExpressionTree.OR([ExpressionTree.NOT(expr_tree), ExpressionTree.LEAF(lit.index)])
                        lemma_index_left = self.create_lemma(expr_tree_lemma_left, lemma_type='split')
                        lemma_index_right = self.create_lemma(expr_tree_lemma_right, lemma_type='split')
                        logging.debug3(f"Lemma({lemma_index_left}): {expr_tree_lemma_left.get_comment()}")
                        logging.debug3(f"Lemma({lemma_index_right}): {expr_tree_lemma_right.get_comment()}")
        for lit_index in unit_none_lits + unit_false_lits:
            lit = self.info_manager.literals[lit_index]
            logging.debug2(f"Processing false literal {lit_index} for char lemmas")
            expr_tree = self.get_exptree_char(lit)
            if expr_tree:
                logging.debug3(f"Got char expression tree for literal {lit_index}")
                expr_tree_lemma_left = ExpressionTree.OR([ExpressionTree.LEAF(lit.index), expr_tree])
                expr_tree_lemma_right = ExpressionTree.OR([ExpressionTree.NOT(expr_tree), ExpressionTree.LEAF(lit.index)])
                lemma_index_left = self.create_lemma(expr_tree_lemma_left, lemma_type='char')
                lemma_index_right = self.create_lemma(expr_tree_lemma_right, lemma_type='char')
                logging.debug3(f"Lemma({lemma_index_left}): {expr_tree_lemma_left.get_comment()}")
                logging.debug3(f"Lemma({lemma_index_right}): {expr_tree_lemma_right.get_comment()}")
    
    def get_exptree_var(self, lit, index):
        if lit.type != 'string' or not isinstance(lit.expr, list) or lit.expr[0] != 'str.in_re':
            return None
        left_expr, right_expr = lit.expr[1], lit.expr[2]
        var = self.info_manager.get_var(left_expr)
        if isinstance(right_expr, list) and right_expr[0] == 're.++':
            const_indices = []
            for i, part in enumerate(right_expr[1:]):
                if (isinstance(part, list) and part[0] == 'str.to_re' and 
                    isinstance(part[1], str) and part[1].startswith('"') and 
                    len(part[1]) == 3):
                    const_indices.append(i)
            if const_indices:
                constant_in_index = const_indices[0]
                unique_char = right_expr[constant_in_index + 1][1][1:-1]
                left_parts = right_expr[1:constant_in_index + 1]
                right_parts = right_expr[constant_in_index + 2:]
                left_expr = ['re.++'] + left_parts if len(left_parts) > 1 else left_parts[0] if left_parts else ['str.to_re', '""']
                right_expr = ['re.++'] + right_parts if len(right_parts) > 1 else right_parts[0] if right_parts else ['str.to_re', '""']
                allowed_chars_left = self.regex_processor.get_chars(left_expr)
                allowed_chars_right = self.regex_processor.get_chars(right_expr)
                if unique_char not in allowed_chars_left or unique_char not in allowed_chars_right:
                    left_var_name = f"{var.name}_l{index}"
                    right_var_name = f"{var.name}_r{index}"
                    self.create_tmp_var(left_var_name, 'String', allowed_chars_left)
                    self.create_tmp_var(right_var_name, 'String', allowed_chars_right)
                    expr = ['=', var.name, ['str.++', left_var_name, f'"{unique_char}"', right_var_name]]
                    lit_index = self.create_literal(expr)
                    return ExpressionTree.LEAF(lit_index)
                else:
                    return None
            else:
                right_expr_list = right_expr[1:] if right_expr[0] == 're.++' else [right_expr]
                constants = self.regex_processor.get_parikh_image(right_expr_list, is_regex=True)
                unique_chars = set()
                for char, count in constants.items():
                    if count == 1:
                        unique_chars.add(char)
                if unique_chars:
                    unique_char = next(iter(unique_chars))
                    constant_in_index = self.regex_processor.get_index_constant_must_in_pattern(right_expr_list, unique_char)
                    if constant_in_index is None:
                        return None
                    left_expr = right_expr_list[:constant_in_index]
                    right_expr = right_expr_list[constant_in_index + 1:]
                    allowed_chars_left = self.regex_processor.get_chars(left_expr)
                    allowed_chars_right = self.regex_processor.get_chars(right_expr)
                    if unique_char not in allowed_chars_left or unique_char not in allowed_chars_right:
                        left_var_name = f"{var.name}_left_{index}"
                        right_var_name = f"{var.name}_right_{index}"
                        self.create_tmp_var(left_var_name, 'String', allowed_chars_left)
                        self.create_tmp_var(right_var_name, 'String', allowed_chars_right)
                        expr = ['=', var.name, ['str.++', left_var_name, f'"{unique_char}"', right_var_name]]
                        lit_index = self.create_literal(expr)
                        return ExpressionTree.LEAF(lit_index)
                    else:
                        return None
                else:
                    return None
        else:
            return None

    def get_exptree_char(self, lit):
        if lit.type != 'string' or not isinstance(lit.expr, list) or lit.expr[0] != 'str.in_re':
            return None
        left_expr, right_expr = lit.expr[1], lit.expr[2]
        vars_found = self.regex_processor.get_variables(left_expr)
        if len(vars_found) != 1:
            return None
        var_name = next(iter(vars_found))
        var = self.info_manager.get_var(var_name)
        if not var.allow:
            return None
        if not isinstance(right_expr, list) or len(right_expr) < 2:
            return None
        if right_expr[0] == 're.*' and isinstance(right_expr[1], list) and right_expr[1][0] == 're.union':
            re_chars = self.regex_processor.get_chars(right_expr)
            allowed_chars = var.allow
            missing_chars = set(allowed_chars) - set(re_chars)
            if not missing_chars:
                return None
            missing_expr_trees = []
            for missing_char in missing_chars:
                missing_char_str = f'"{missing_char}"'
                pattern1_left = ['re.*', right_expr[1]]
                pattern1_middle = ['str.to_re', missing_char_str]
                pattern1_right = ['re.*', ['re.union'] + [['str.to_re', f'"{c}"'] for c in allowed_chars]]
                pattern1 = ['re.++', pattern1_left, pattern1_middle, pattern1_right]
                expr1 = ['str.in_re', left_expr, pattern1]
                lit_index1 = self.create_literal(expr1)
                pattern2_left = ['re.*', ['re.union'] + [['str.to_re', f'"{c}"'] for c in allowed_chars]]
                pattern2_middle = ['str.to_re', missing_char_str]
                pattern2_right = ['re.*', right_expr[1]]
                pattern2 = ['re.++', pattern2_left, pattern2_middle, pattern2_right]
                expr2 = ['str.in_re', left_expr, pattern2]
                lit_index2 = self.create_literal(expr2)
                missing_expr_trees.append(ExpressionTree.OR([
                    ExpressionTree.LEAF(lit_index1),
                    ExpressionTree.LEAF(lit_index2)
                ]))
            if len(missing_expr_trees) == 1:
                return missing_expr_trees[0]
            return ExpressionTree.OR(missing_expr_trees)
        return None

class SMTProcessor:
    def __init__(self, tree=False):
        self.info_manager = InfoManager()
        self.lemma_generator = LemmaGenerator(self.info_manager)
        self.tree = tree
        Parser.set_tree_format(tree)
    
    def get_lemmas(self):
        for index in range(len(self.info_manager.literals)):
            lit = self.info_manager.literals[index]
            self.lemma_generator.get_lemmas_split(lit)
        for index in range(len(self.info_manager.literals)):
            lit = self.info_manager.literals[index]
            self.lemma_generator.get_lemmas_length(lit)
        logging.debug4(f"Got {len(self.info_manager.lemmas)} lemmas")
        return
        is_sat = self.lemma_generator.rewrite_lemmas(self.info_manager.clauses, self.info_manager.lemmas)
        if is_sat == 'unsat':
            return is_sat
        for index in range(len(self.info_manager.vars)):
            var = self.info_manager.vars[index]
            self.lemma_generator.get_lemmas_var(var)
        is_sat = self.lemma_generator.rewrite_lemmas(self.info_manager.clauses, self.info_manager.lemmas)
        return is_sat
    
    def process_file(self, input_file, output_file=None):
        with open(input_file, 'r') as f:
            lines = f.readlines()
            for line in lines:
                self.info_manager.process_line(line)
        self.info_manager.update_info()
        for lit in self.info_manager.literals:
            logging.debug(f"lit({lit.index}): {lit}")
        for clause in self.info_manager.clauses:
            logging.debug(f"clause({clause.index}): {clause.get_comment()}")
        is_sat = self.get_lemmas()
        print(is_sat)
        outputs = []
        outputs.extend(self.info_manager.preamble)
        outputs.append("")
        for var in self.info_manager.vars:
            var_smt2 = var.get_smt2()
            if var_smt2:
                outputs.append(var_smt2)
        for tmp_var in self.info_manager.tmp_vars:
            tmp_var_smt2 = tmp_var.get_smt2()
            if tmp_var_smt2:
                outputs.append(tmp_var_smt2)
        outputs.append("")
        for clause in self.info_manager.clauses:
            outputs.append(clause.get_smt2())
        outputs.append("")
        for lemma in self.info_manager.lemmas:
            lemma_smt2 = lemma.get_smt2()
            if lemma_smt2:
                outputs.append(lemma_smt2)
        outputs.extend(self.info_manager.postamble)
        outputs.append("\n; ========================== [comments] ==========================")
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