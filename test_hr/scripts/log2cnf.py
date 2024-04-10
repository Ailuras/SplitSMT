import sys

def parse_clause(clause_str):
    tokens = clause_str.split()
    literals = []
    # print(tokens)
    max_lit = 0
    for token in tokens:
        if token.startswith("~"):
            literal = int(token[1:]) + 1
            literals.append(f"-{literal}")
        elif token.isdigit():
            literal = int(token) + 1
            literals.append(f"{literal}")
        
        max_lit = max(literal, max_lit)

    return literals, max_lit

def process_input_file(file_path):
    with open(file_path, 'r') as file:
        input_text = file.readlines()
        return input_text

def main(lines):
    cnf_clauses = []
    var_num = 0
    for line in lines:
        if line.startswith("clause:"):
            clause_str = line.replace("clause:", "").strip()[:-1]
            literals, max_lit = parse_clause(clause_str)
            var_num = max(max_lit, var_num)
            # print(literals)
            cnf_clause = " ".join(literals)
            cnf_clause = cnf_clause + " 0"
            cnf_clauses.append(cnf_clause)

    cnf_formula = "\n".join(cnf_clauses)
    print(f"p cnf {var_num} {len(cnf_clauses)}")
    print(cnf_formula)

if __name__ == "__main__":
    file_path = sys.argv[1]
    input_text = process_input_file(file_path)
    main(input_text)
