import re
import sys
import logging
from collections import deque
from z3 import *

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class SMTInfo:
    def __init__(self):
        self.var_counter = 0
        self.vars = {}
        self.clause_counter = 0
        self.clauses = []

    def add_var(self, name, type):
        self.vars[name] = VarInfo(name, type, self.var_counter)
        self.var_counter += 1
        assert self.var_counter == len(self.vars)

    def get_var(self, name):
        return self.vars[name]
    
    def get_vars(self):
        return self.vars
    
    def get_var_name(self, name):
        return f"x_{self.vars[name].mapping}"
    
    def get_var_by_index(self, index):
        for v in self.vars.values():
            if v.mapping == index:
                return v
        return None
    
    def is_var(self, name):
        return name in self.vars
    
    def add_clause(self, clause):
        self.clauses.append(ClauseInfo(clause))
        self.clause_counter += 1
        assert self.clause_counter == len(self.clauses)
    
    def get_clause(self, index):
        return self.clauses[index]
    
    def get_clauses(self):
        return self.clauses
    
    def use_var(self, name):
        self.vars[name].used = True
    
class VarInfo:
    def __init__(self, var, type, index):
        self.var = var
        self.type = type
        self.used = False
        self.mapping = index

class ClauseInfo:
    def __init__(self, clause):
        self.clause = clause

class SMTLine:
    def __init__(self, line):
        self.line = line.strip()
        self.type = self.classify_line(line)
        if self.type in ['declare', 'assert']:
            self.expr = self.parse_expression(self.tokenize(self.line))
        else:
            self.expr = None
    
    @staticmethod
    def tokenize(expr):
        return re.findall(r'\(|\)|[^\s()]+', expr)
    
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

class SMTProcessor:
    def __init__(self):
        self.solver = Solver()
        self.info = SMTInfo()
        self.lines = []

    def process_declare(self, expr):
        var = expr[1]
        type = expr[3]
        self.info.add_var(var, type)
        return expr

    def simplify_let(self, expr):
        if isinstance(expr, list) and expr:
            h = expr[0]
            if h == 'let':
                b = expr[1]
                body = expr[2]
                while isinstance(body, list) and len(body) > 0 and body[0] == 'let':
                    b.extend(body[1])
                    body = body[2]
                return ['let', b, self.simplify_let(body)]
            return [self.simplify_let(e) for e in expr]
        return expr

    def simplify_re_ops(self, expr):
        if isinstance(expr, list) and expr:
            h = expr[0]
            if h in ['re.++','re.union']:
                merged = [h]
                for sub in expr[1:]:
                    simplified = self.simplify_re_ops(sub)
                    if isinstance(simplified, list) and len(simplified)>0 and simplified[0] == h:
                        merged.extend(simplified[1:])
                    else:
                        merged.append(simplified)
                return merged
            return [self.simplify_re_ops(e) for e in expr]
        return expr

    def simplify_variable(self, expr):
        for i in range(len(expr)):
            if isinstance(expr[i], list):
                self.simplify_variable(expr[i])
            elif self.info.is_var(expr[i]):
                self.info.use_var(expr[i])
                expr[i] = self.info.get_var_name(expr[i])
        return expr

    def simplify_assert(self, expr):
        self.info.add_clause(expr)
        expr = self.simplify_let(expr)
        expr = self.simplify_re_ops(expr)
        expr = self.simplify_variable(expr)
        return expr

    def classify_type(self, expr):
        if not expr:
            return None
        if isinstance(expr, list):
            head = expr[0] if expr else None
            if head == 'assert' and len(expr) == 2:
                return 'assert'
            if head == 'declare-fun' and len(expr) == 4:
                return 'declare'
            if head == 'not' and len(expr) == 2:
                return 'not'
            if head == 'let' and len(expr) == 3:
                return 'let'
            if head == 'str.in_re' and len(expr) == 3:
                return 'str_in_re'
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
            return 'default'
        if isinstance(expr, str):
            if expr.startswith('"'):
                return 'const'
            if expr[0] == 'x':
                return 'var'
            return 'str'
        return None

    def to_smt2_declare(self, expr, indent):
        var = expr[1]
        if self.info.get_var(var).used:
            return f'(declare-fun {self.info.get_var_name(var)} () {expr[3]})'
        return None

    def to_smt2_assert(self, expr, indent):
        res = self.to_smt2(expr[1], indent + 1)
        if not res:
            return None
        elif self.classify_type(expr[1]) == 'not':
            return f'(assert {self.to_smt2(expr[1], indent)})'
        s = '    ' * indent
        return (
            f'(assert\n'
            f'{s}    {res}\n'
            f'{s})'
        )
    
    def to_smt2_not(self, expr, indent):
        res = self.to_smt2(expr[1], indent + 1)
        if not res:
            return None
        s = '    ' * indent
        return (
            f'(not\n'
            f'{s}    {self.to_smt2(expr[1], indent + 1)}\n'
            f'{s})'
        )
    
    def to_smt2_let(self, expr, indent):
        s = '    ' * indent
        b = ' '.join([
            f'({self.to_smt2(x[0], 0)} {self.to_smt2(x[1], indent + 2)})' 
            for x in expr[1]
        ])
        body = self.to_smt2(expr[2], indent + 1)
        return (
            f'(let ({b})\n'
            f'{s}    {body}\n'
            f'{s})'
        )
    
    def to_smt2_str_in_re(self, expr, indent):
        if self.classify_type(expr[1]) == 'const':
            return None
        
        s = '    ' * indent
        return (
            f'(str.in_re\n'
            f'{s}    {self.to_smt2(expr[1], indent + 1)}\n'
            f'{s}    {self.to_smt2(expr[2], indent + 1)}\n'
            f'{s})'
        )
    
    def to_smt2_re_union(self, expr, indent):
        s = '    ' * indent
        lines = '\n'.join([
            f'{s}    {self.to_smt2(e, indent + 1)}' 
            for e in expr[1:]
        ])
        return (
            f'(re.union\n'
            f'{lines}\n'
            f'{s})'
        )
    
    def to_smt2_re_range(self, expr, indent):
        return (
            f'(re.range {self.to_smt2(expr[1], 0)} {self.to_smt2(expr[2], 0)})'
        )
    
    def to_smt2_cat(self, expr, indent):
        s = '    ' * indent
        lines = '\n'.join([
            f'{s}    {self.to_smt2(e, indent + 1)}' 
            for e in expr[1:]
        ])
        return (
            f'({expr[0]}\n'
            f'{lines}\n'
            f'{s})'
        )
    
    def to_smt2_re_closure(self, expr, indent):
        s = '    ' * indent
        return f'({expr[0]} {self.to_smt2(expr[1], indent)})'
    
    def to_smt2_default(self, expr, indent):
        s = ' '.join([self.to_smt2(e, indent) for e in expr])
        return f'({s})'

    def to_smt2(self, expr, indent=0):
        expr_type = self.classify_type(expr)
        if not expr_type:
            return None
        if expr_type in ['const', 'var', 'str']:
            return expr
        if expr_type == 'declare':
            return self.to_smt2_declare(expr, indent)
        if expr_type == 'assert':
            return self.to_smt2_assert(expr, indent)
        if expr_type == 'not':
            return self.to_smt2_not(expr, indent)
        if expr_type == 'let':
            return self.to_smt2_let(expr, indent)
        if expr_type == 'str_in_re':
            return self.to_smt2_str_in_re(expr, indent)
        if expr_type == 're_union':
            return self.to_smt2_re_union(expr, indent)
        if expr_type == 're_range':
            return self.to_smt2_re_range(expr, indent)
        if expr_type in ['str_cat', 're_cat']:
            return self.to_smt2_cat(expr, indent)
        if expr_type in ['re_star', 're_plus']:
            return self.to_smt2_re_closure(expr, indent)
        assert expr_type == 'default'
        return self.to_smt2_default(expr, indent)

    def process_line(self, line):
        if line.expr is None:
            return line.line
        if line.type == 'declare':
            return self.process_declare(line.expr)
        if line.type == 'assert':
            return self.simplify_assert(line.expr)

    def process_file(self, input_file, output_file=None):
        try:
            self.expressions = parse_smt2_file(input_file)
            for expr in self.expressions:
                self.solver.add(expr)
            
            with open(input_file,'r') as f:
                lines = f.readlines()
                for l in lines:
                    self.lines.append(SMTLine(l))
            expressions = [self.process_line(l) for l in self.lines]
            
            res = [result for x in expressions if (result := self.to_smt2(x)) is not None]
            out = output_file if output_file else input_file
            with open(out,'w') as f:
                for x in res:
                    f.write(x+'\n')
            logging.info(f"Processed file saved to: {out}")
        except Exception as e:
            logging.error(f"Error processing file: {input_file}")
            logging.error(f"Exception: {e}")

if __name__=='__main__':
    if len(sys.argv) not in [2,3]:
        print('Usage: python script.py <input_file> [output_file]')
        sys.exit(1)
    input = sys.argv[1]
    output = sys.argv[2] if len(sys.argv)==3 else None
    SMTProcessor().process_file(input, output)