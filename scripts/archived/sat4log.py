import sys
from pysat.solvers import Glucose4

def parse_clause(clause_str):
    tokens = clause_str.split()
    literals = []
    # print(tokens)
    for token in tokens:
        if token.startswith("~"):
            literal = int(token[1:]) + 1
            literals.append(-literal)
        elif token.isdigit():
            literal = int(token) + 1
            literals.append(literal)

    return literals

def process_input_file(file_path):
    with open(file_path, 'r') as file:
        input_text = file.readlines()
        return input_text

def get_var_map(lines):
    var_map = {}
    for line in lines:
        if line.startswith("New lit:"):
            key = int(line.split(" => ")[0].split(" ")[-1].strip())
            val = line.split(" => ")[1].strip()
            var_map[key] = val
    return var_map

def main(lines):
    solver = Glucose4()
    var_map = get_var_map(lines)
    for line in lines:
        if line.startswith("clause:"):
            clause_str = line.replace("clause:", "").strip()[:-1]
            literals = parse_clause(clause_str)
            solver.add_clause(literals)
            result = solver.solve()
            if not result:
                print("Unsatisfiable")
                print("Conflicting literals:")
                for literal in literals:
                    if literal < 0:
                        print(str(literal+1), "=> ~", var_map[-literal-1])
                    else:
                        print(str(literal-1), "=> ", var_map[literal-1])
                break
            else:
                print("Satisfiable", [i-1 if i > 0 else i+1 for i in literals])
                model = solver.get_model()
                print("Solution:", [i-1 if i > 0 else i+1 for i in model])
        
    # if solver.solve():
    #     print("Satisfiable, Solution:")
    #     model = solver.get_model()
    #     for literal in model:
    #         if literal < 0:
    #             print(str(literal+1), "=> ~", var_map[-literal-1])
    #         else:
    #             print(str(literal-1), "=> ", var_map[literal-1])
            
if __name__ == "__main__":
    file_path = sys.argv[1]
    input_text = process_input_file(file_path)
    main(input_text)
