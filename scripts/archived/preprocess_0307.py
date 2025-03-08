import re
import sys
import logging
from collections import deque
from z3 import *

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    
class SMTVar:
    def __init__(self, index, var, var_type):
        self.index = index
        self.name = f"x{index}"
        self.var = var
        self.type = var_type
        self.used = False
        self.map = None
        self.allow = None # None表示不限制
        self.tabu = []

class SMTClause:
    def __init__(self, index, clause, clu_type):
        self.index = index
        self.clause = clause
        self.type = clu_type
        self.map = None

class SMTLemma:
    def __init__(self, index, expr, comment=None):
        self.index = index
        self.expr = expr
        self.comment = comment

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
                return 'not_in'
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
        elif expr_type == 'not_in':
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

    def _process_declare(self, line):
        var = line.expr[1]
        type = line.expr[3]
        v = SMTVar(self.var_counter, var, type)
        v.map = line
        line.map = v
        self.add_var(v)
        line.expr[1] = v.name

    def _simplify_expr(self, expr):
        if not isinstance(expr, list) or not expr:
            return expr
        h = expr[0]
        if h == 'let':
            b = expr[1]
            body = expr[2]
            while isinstance(body, list) and len(body) > 0 and body[0] == 'let':
                b.extend(body[1])
                body = body[2]
            return ['let', b, self._simplify_expr(body)]
        elif h in ['re.++', 're.union']:
            merged = [h]
            for sub in expr[1:]:
                simplified = self._simplify_expr(sub)
                if isinstance(simplified, list) and len(simplified) > 0 and simplified[0] == h:
                    merged.extend(simplified[1:])
                else:
                    merged.append(simplified)
            return merged
        return [self._simplify_expr(e) for e in expr]

    def _rename_var(self, expr):
        for i in range(len(expr)):
            if isinstance(expr[i], list):
                self._rename_var(expr[i])
            elif expr[i] in self.var_map:
                index = self.var_map[expr[i]]
                self.vars[index].used = True
                expr[i] = self.vars[index].name
        return expr

    def _process_assert(self, line):
        line.expr = self._simplify_expr(line.expr)
        line.expr = self._rename_var(line.expr)
        clu_type = SMTLine.classify_type(SMTLine.classify_type(line.expr[1][0]))
        clause = SMTClause(self.clause_counter, line.exp, clu_type)
        line.map = clause
        clause.map = line
        self.add_clause(clause)

    def add_line(self, line):
        l = SMTLine(self.line_counter, line)
        if l.type == 'declare':
            self.process_declare(l)
        if l.type == 'assert':
            self._process_assert(l)
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
        """
        如有需要，可以调整SMTInfo相关的代码，使其更加符合实际需求
        也可以增加相关的函数和数据结构，以处理更多的约束类型
        """
        self.solver = Solver()
        self.info = SMTInfo()

    def _get_domain(self, clause):
        """
        第一步：检查约束，得到约束中涉及的变量的取值范围
        
        首先，检查约束是否属于re.in约束，若是not in约束则跳过。
        之后，检查re.in约束的两侧，从左侧得到涉及的变量，从右侧得到涉及的字符。
        例如，x7 + z + x8 in [b + z* + b]*，则变量为x7, x8，字符为b, z。
        从而，x7 可以取值的字符为b, z，x8 可以取🈯值的字符为b, z。
        又例如，另一个约束为x8 in [a-u]*，则x8 可以取值的字符为a到u之间的字符。
        最后一步便是整合这些信息，对可取值的范围做交集，得到x7, x8 可以取值的字符只有b。
        """
        expr = clause.map.expr
        if not isinstance(expr, list) or len(expr) < 2 or not isinstance(expr[1], list):
            return
        in_expr = expr[1]
        if in_expr[0] != 'str.in_re' or len(in_expr) != 3:
            return
        
        def extract_vars(exp):
            vars_found = set()
            if isinstance(exp, str) and exp.startswith('x'):
                vars_found.add(exp)
            elif isinstance(exp, list):
                for e in exp:
                    vars_found.update(extract_vars(e))
            return vars_found
        
        def extract_chars(exp):
            chars = set()
            if isinstance(exp, str) and exp.startswith('"'):
                for char in exp[1:-1]:
                    chars.add(char)
            elif isinstance(exp, list):
                if exp[0] == 're.range' and len(exp) == 3:
                    start = exp[1][1:-1]
                    end = exp[2][1:-1]
                    for c in range(ord(start), ord(end) + 1):
                        chars.add(chr(c))
                else:
                    for e in exp:
                        chars.update(extract_chars(e))
            return chars
        
        variables = extract_vars(in_expr[1])
        characters = extract_chars(in_expr[2])
        for var_name in variables:
            var = self.info.get_var(var_name)
            if var.allow is None:
                var.allow = characters
            else:
                var.allow = var.allow.intersection(characters)

    def _get_lemmas_re_in(self, clause):
        """
        第二步：重新遍历约束，得到几个关于单一变量的引理；
        
        这一部分比较复杂，我现在想到了一种情况，即约束中的变量是一个字符串的拼接，并且包含一个不属于变量的字符。
        例如 c1: x7 + z + x8 in [b + z* + b]*，在第一步我们得到x7和x8的组成元素为a、b
        由c2和c3可知，x7和x8的组成元素为a到u之间的字符，不包括字符z。
        观察c1的循环部分，可以分为不包含z、包含一个z、包含多个z的三种情况：
        ; bb
        ; bzb
        ; b + z* + zz + z* + b
        其中，第三种情况不会出现，第二种情况只出现一次，整理可得到：
        ; x7 + z + x8 in [bb]* + bzb + [bb]*
        从而，可以得到：
        ; x7 in [bb]* + b
        ; x8 in b + [bb]*
        """
        pass
    
    def _get_lemmas_not_in(self, clause):
        """
        第四步：处理not in约束，这部分暂时不处理，返回空
        """
        pass

    def _get_lemmas(self, clause):
        if clause.type != 're_in':
            return self._get_lemmas_re_in(clause)
        if clause.type != 'not_in':
            return self._get_lemmas_not_in(clause)
    
    def _simplify_lemmas(self, lemmas):
        """
        第三步：在第二步得到引理时，对于每个变量的引理，进行简化
        这一步涉及的代码量可能较多，请针对每一步实现一个调用函数，以便于调试和维护
        对于较复杂的情况，可以在相关函数里写注释，跳过实现，我后面自己实现。
        
        首先，要去掉重复的引理
        其次，要去掉冗余的引理，例如x7 in aa* 和 x7 in a*，则只保留x7 in aa*，因为a*包含了aa*，我们要保留最小的引理。
        最后，还要基于约束之间的关系，对引理进行合并。
        例如，对于以下约束：
        ; c1: x7 in [a | b + b* + a]* + b*
        ; c2: x7 in [bb | ab]* + [b | a | ""]
        ; c3: x7 in [bb]* + b
        由c3约束可得，x7只由b组成，从而我们回顾前两个约束，去掉其中不可行的部分。
        ; c1: x7 in b* 两个分支a和b + b* + a都不行。
        ; c2: x7 in [bb]* + [b | ""]
        之后，进行合并。得到：
        ; c3: x7 in [bb]* + [b | ""]
        考虑c3，可知x7的长度为2x+1 or 2x => 任意长度，从而得到：
        ; c3: x7 in b*
        """
        pass 
    
    def _solve(self):
        pass

    def process_file(self, input_file, output_file=None):
        try:
            self.expressions = parse_smt2_file(input_file)
            for expr in self.expressions:
                self.solver.add(expr)
            
            with open(input_file,'r') as f:
                lines = f.readlines()
                for line in lines:
                    self.info.add_line(line)
            clauses_re = [clu for clu in self.info.clauses if clu.type == 're_in']
            for clause in clauses_re:
                self._get_domain(clause)
            for clause in clauses_re:
                lemmas = self._get_lemmas(clause)
                for lemma in lemmas:
                    self.info.add_lemma(lemma)
            self._simplify_lemmas(self.info.lemmas)
            clauses_nre = [clu for clu in self.info.clauses if clu.type == 'not_in']
            self._get_lemmas(clauses_nre)
            
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
            
            self._solve()
            
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