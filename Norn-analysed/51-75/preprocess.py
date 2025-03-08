import re
import sys
import logging
from collections import deque
from z3 import *

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    
class SMTVar:
    def __init__(self, index, var, type):
        self.index = index
        self.name = f"x{index}"
        self.var = var
        self.type = type
        self.used = False
        self.map = None

class SMTClause:
    def __init__(self, index, clause):
        self.index = index
        self.clause = clause
        self.map = None

class SMTLine:
    def __init__(self, index, line):
        self.index = index
        self.line = line.strip()
        self.type = self.classify_line(self.line)
        self.map = None
        if self.type in ['declare', 'assert']:
            self.expr = self.parse_expression(self.tokenize(self.line))
        else:
            self.expr = self.line
    
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

    @staticmethod
    def classify_type(expr):
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
            if expr == "":
                return None
            if expr.startswith('"'):
                return 'const'
            if expr[0] == 'x':
                return 'var'
            return 'str'
        return None

    def to_smt2(self, expr, indent=0):
        expr_type = self.classify_type(expr)
        if not expr_type:
            return None
        if expr_type in ('const', 'var', 'str'):
            return expr
        
        indent_str = '    ' * indent
        indent_next_str = '    ' * (indent + 1)
        if expr_type == 'assert':
            res = self.to_smt2(expr[1], indent + 1)
            if not res:
                return None
            return f'(assert {self.to_smt2(expr[1], indent)})' if self.classify_type(expr[1]) == 'not' else f'(assert\n{indent_next_str}{res}\n{indent_str})'
        elif expr_type == 'not':
            inner_expr = self.to_smt2(expr[1], indent + 1)
            return None if not inner_expr else f'(not\n{indent_next_str}{inner_expr}\n{indent_str})'
        elif expr_type == 'let':
            bindings = ' '.join([f'({self.to_smt2(x[0], 0)} {self.to_smt2(x[1], indent + 2)})' for x in expr[1]])
            body = self.to_smt2(expr[2], indent + 1)
            return f'(let ({bindings})\n{indent_next_str}{body}\n{indent_str})'
        elif expr_type == 'str_in_re':
            str_expr = self.to_smt2(expr[1], indent + 1)
            re_expr = self.to_smt2(expr[2], indent + 1)
            return f'(str.in_re\n{indent_next_str}{str_expr}\n{indent_next_str}{re_expr}\n{indent_str})'
        elif expr_type == 're_range':
            return f'(re.range {self.to_smt2(expr[1], 0)} {self.to_smt2(expr[2], 0)})'
        elif expr_type in ('re_star', 're_plus'):
            return f'({expr[0]} {self.to_smt2(expr[1], indent)})'
        if expr_type in ('re_union', 'str_cat', 're_cat'):
            op = 're.union' if expr_type == 're_union' else expr[0]
            parts = [f'{indent_next_str}{self.to_smt2(e, indent + 1)}' for e in expr[1:]]
            return f'({op}\n{chr(10).join(parts)}\n{indent_str})'
        parts = [self.to_smt2(e, indent) for e in expr]
        return f'({" ".join(parts)})'

    def get_comment(self):  
        if self.type != 'assert':
            return None  
            
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
            return False  
            
        def process_expr(expr, parent_op=None):  
            if not isinstance(expr, list):  
                if isinstance(expr, str) and expr.startswith('"'):  
                    return expr[1:-1]  
                return expr  
            if not expr:  
                return ""  
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
                result = ' | '.join(parts)  
                return f"[{result}]"  
            if op == 're.*':  
                inner = process_expr(expr[1], op)  
                if inner.startswith('[') and inner.endswith(']'):  
                    return f"{inner}*"  
                return f"[{inner}]*"  
            if op == 're.range':  
                start = expr[1][1:-1]  
                end = expr[2][1:-1]  
                return f"[{start}-{end}]"  
            if op == 'str.to_re':  
                return process_expr(expr[1], op)  
            return str(expr)  

        comment = process_expr(self.expr[1])  
        return f"; {comment}"

    def get_smt2(self):
        if self.type == 'declare' and self.map and not self.map.used:
            return None
        return self.to_smt2(self.expr)

class SMTInfo:
    def __init__(self):
        self.line_counter = 0
        self.lines = []
        self.var_counter = 0
        self.vars = []
        self.var_map = {}
        self.clause_counter = 0
        self.clauses = []
        self.lemma_counter = 0
        self.lemmas = []

    def process_declare(self, line):
        var = line.expr[1]
        type = line.expr[3]
        v = SMTVar(self.var_counter, var, type)
        v.map = line
        line.map = v
        self.add_var(v)
        line.expr[1] = v.name

    def simplify_expr(self, expr):
        if not isinstance(expr, list) or not expr:
            return expr
        h = expr[0]
        if h == 'let':
            b = expr[1]
            body = expr[2]
            while isinstance(body, list) and len(body) > 0 and body[0] == 'let':
                b.extend(body[1])
                body = body[2]
            return ['let', b, self.simplify_expr(body)]
        elif h in ['re.++', 're.union']:
            merged = [h]
            for sub in expr[1:]:
                simplified = self.simplify_expr(sub)
                if isinstance(simplified, list) and len(simplified) > 0 and simplified[0] == h:
                    merged.extend(simplified[1:])
                else:
                    merged.append(simplified)
            return merged
        return [self.simplify_expr(e) for e in expr]

    def rename_var(self, expr):
        for i in range(len(expr)):
            if isinstance(expr[i], list):
                self.rename_var(expr[i])
            elif expr[i] in self.var_map:
                index = self.var_map[expr[i]]
                self.vars[index].used = True
                expr[i] = self.vars[index].name
        return expr

    def process_assert(self, line):
        line.expr = self.simplify_expr(line.expr)
        line.expr = self.rename_var(line.expr)
        clause = SMTClause(self.clause_counter, line.expr)
        line.map = clause
        clause.map = line
        self.add_clause(clause)

    def add_line(self, line):
        l = SMTLine(self.line_counter, line)
        if l.type == 'declare':
            self.process_declare(l)
        if l.type == 'assert':
            self.process_assert(l)
        self.lines.append(l)
        self.line_counter += 1
        assert self.line_counter == len(self.lines)
    
    def add_var(self, var):
        self.vars.append(var)
        self.var_map[var.var] = var.index
        self.var_counter += 1
        assert self.var_counter == len(self.vars)
    
    def add_clause(self, clause):
        self.clauses.append(clause)
        self.clause_counter += 1
        assert self.clause_counter == len(self.clauses)

    def add_lemma(self, lemma):
        self.lemmas.append(lemma)
        self.lemma_counter += 1
        assert self.lemma_counter == len(self.lemmas)

class SMTProcessor:
    def __init__(self):
        self.solver = Solver()
        self.info = SMTInfo()

    def update_info(self):
        pass

    def get_lemmas(self, line):
        return []
    
    def simplify_lemmas(self, lemmas):
        return []

    def process_file(self, input_file, output_file=None):
        try:
            self.expressions = parse_smt2_file(input_file)
            for expr in self.expressions:
                self.solver.add(expr)
            
            with open(input_file,'r') as f:
                lines = f.readlines()
                for line in lines:
                    self.info.add_line(line)
            for clause in self.info.clauses:
                lemmas = self.get_lemmas(clause)
                for lemma in lemmas:
                    self.info.add_lemma(lemma)
            self.info.lemmas = self.simplify_lemmas(self.info.lemmas)
            self.update_info()
            
            outputs = [result for line in self.info.lines if (result := line.get_smt2()) is not None]
            comments = [result for line in self.info.lines if (result := line.get_comment()) is not None]
            out = output_file if output_file else input_file
            with open(out,'w') as f:
                for o in outputs:
                    f.write(o+'\n')
                f.write("; ========================== [comments] ==========================\n")
                for c in comments:
                    f.write(c+'\n')
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