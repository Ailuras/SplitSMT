import re
import sys
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class SMTProcessor:
    def __init__(self):
        self.var_mapping = {}
        self.var_counter = 1
        self.declared_vars = set()
        self.used_vars = set()

    def classify_line(self, line):
        l = line.strip()
        if l.startswith(';'):
            return 'comment'
        if l.startswith('(set-logic'):
            return 'logic'
        if l.startswith('(check-sat'):
            return 'check_sat'
        if l.startswith('(exit'):
            return 'exit'
        if l.startswith('(declare-fun') or l.startswith('(define-fun'):
            return 'declare'
        if l.startswith('(assert'):
            return 'assert'
        return 'info'

    def tokenize(self, expr):
        return re.findall(r'\(|\)|[^\s()]+', expr)

    def get_var(self, var):
        if var in self.var_mapping:
            return self.var_mapping[var]
        self.var_mapping[var] = f'x{self.var_counter}'
        self.var_counter += 1
        return self.var_mapping[var]

    def is_str_const(self, expr):
        return isinstance(expr, str) and expr.startswith('"')

    def is_var(self, expr):
        return isinstance(expr, str) and expr[0] == 'x'

    def is_str_in_re(self, expr):
        return isinstance(expr, list) and len(expr) == 3 and expr[0] == 'str.in_re'
    
    def is_str_cat(self, expr):
        return isinstance(expr, list) and len(expr) > 1 and expr[0] == 'str.++'
    
    def is_re_cat(self, expr):
        return isinstance(expr, list) and len(expr) > 1 and expr[0] == 're.++'
    
    def is_re_union(self, expr):
        return isinstance(expr, list) and len(expr) > 1 and expr[0] == 're.union'
    
    def is_re_range(self, expr):
        return isinstance(expr, list) and len(expr) == 3 and expr[0] == 're.range'
    
    def is_re_star(self, expr):
        return isinstance(expr, list) and len(expr) == 2 and expr[0] == 're.*'
    
    def is_re_plus(self, expr):
        return isinstance(expr, list) and len(expr) == 2 and expr[0] == 're.+'
    
    def is_assert(self, expr):
        return isinstance(expr, list) and len(expr) == 2 and expr[0] == 'assert'
    
    def is_decl(self, expr):
        return isinstance(expr, list) and len(expr) == 4 and expr[0] == 'declare-fun'
    
    def is_let(self, expr):
        return isinstance(expr, list) and len(expr) == 3 and expr[0] == 'let'
    
    def is_not(self, expr):
        return isinstance(expr, list) and len(expr) == 2 and expr[0] == 'not'
    
    def parse_expression(self, tokens):
        stack = []
        while tokens:
            t = tokens.pop(0)
            if t == '(':
                sub = self.parse_expression(tokens)
                stack.append(sub)
            elif t == ')':
                return stack
            else:
                stack.append(t)
        return stack

    def process_declare(self, expr):
        var = expr[1]
        self.declared_vars.add(var)
        self.get_var(var)
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
            elif expr[i] in self.declared_vars:
                self.used_vars.add(expr[i])
                expr[i] = self.get_var(expr[i])
        return expr

    def simplify_assert(self, expr):
        expr = self.simplify_let(expr)
        expr = self.simplify_re_ops(expr)
        expr = self.simplify_variable(expr)
        return expr

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
        if self.is_str_const(expr[1]):
            return None
        
        s = '    ' * indent
        return (
            f'(str.in_re\n'
            f'{s}    {self.to_smt2(expr[1], indent + 1)}\n'
            f'{s}    {self.to_smt2(expr[2], indent + 1)}\n'
            f'{s})'
        )

    def to_smt2_str_plus(self, expr, indent):
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

    def to_smt2_declare(self, expr, indent):
        var = expr[1]
        if var not in self.used_vars:
            return None
        return f'(declare-fun {self.get_var(var)} () {expr[3]})'

    def to_smt2_assert(self, expr, indent):
        res = self.to_smt2(expr[1], indent + 1)
        if not res:
            return None
        elif self.is_not(expr[1]):
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

    def to_smt2_default(self, expr, indent):
        s = ' '.join([self.to_smt2(e, indent) for e in expr])
        return f'({s})'

    def to_smt2(self, expr, indent=0):
        if isinstance(expr, str):
            return expr
        if not isinstance(expr, list) or not expr:
            return ''
        if self.is_let(expr):
            return self.to_smt2_let(expr, indent)
        if self.is_str_in_re(expr):
            return self.to_smt2_str_in_re(expr, indent)
        if self.is_str_cat(expr) or self.is_re_cat(expr):
            return self.to_smt2_str_plus(expr, indent)
        if self.is_re_union(expr):
            return self.to_smt2_re_union(expr, indent)
        if self.is_re_star(expr) or self.is_re_plus(expr):
            return f'({expr[0]} {self.to_smt2(expr[1], indent)})'
        if self.is_re_range(expr):
            return self.to_smt2_re_range(expr, indent)
        if self.is_assert(expr):
            return self.to_smt2_assert(expr, indent)
        if self.is_decl(expr):
            return self.to_smt2_declare(expr, indent)
        if self.is_not(expr):
            return self.to_smt2_not(expr, indent)
        return self.to_smt2_default(expr, indent)

    def process_line(self, line):
        t = self.classify_line(line)
        if t in ['info','logic','check_sat','exit','comment']:
            return line.rstrip('\n')
        tokens = self.tokenize(line)
        if not tokens:
            return line.rstrip('\n')
        try:
            parsed = self.parse_expression(tokens)[0]
            if t == 'declare':
                return self.process_declare(parsed)
            elif t == 'assert':
                return self.simplify_assert(parsed)
        except Exception as e:
            logging.error(f"Error processing line: {line}")
            logging.error(f"Exception: {e}")
            return line.rstrip('\n')

    def process_file(self, input_file, output_file=None):
        try:
            with open(input_file,'r') as f:
                lines = f.readlines()
            expressions = [self.process_line(l) for l in lines]
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
    inp = sys.argv[1]
    outp = sys.argv[2] if len(sys.argv)==3 else None
    SMTProcessor().process_file(inp,outp)