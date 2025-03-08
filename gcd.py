import math
from sympy.ntheory.residue_ntheory import discrete_log
from sympy import symbols, solve, Eq

def generate_length_constraint(var_name, base_length, coefficients):
    g = math.gcd(*coefficients) if coefficients else 0
    
    if g > 1:
        return f"(not (= (mod (- (str.len {var_name}) {base_length}) {g}) 0))"
    
    unrep_lengths = compute_unrep_lengths(base_length, coefficients)
    
    if len(unrep_lengths) == 1:
        return f"(= (str.len {var_name}) {unrep_lengths[0]})"
    elif len(unrep_lengths) > 1:
        constraints = []
        for length in unrep_lengths:
            constraints.append(f"(= (str.len {var_name}) {length})")
        return f"(or {' '.join(constraints)})"
    else:
        return "false"

def compute_unrep_lengths(base, coeffs):
    if not coeffs:
        return [i for i in range(base) if i != base]
    
    if len(coeffs) == 2 and math.gcd(coeffs[0], coeffs[1]) == 1:
        a, b = coeffs
        frobenius_num = a * b - a - b
        
        unrep = []
        for i in range(frobenius_num + 1):
            representable = False
            for x in range(i // a + 1):
                if (i - x * a) % b == 0 and (i - x * a) >= 0:
                    representable = True
                    break
            if not representable and i != base and i != base + a and i != base + b:
                unrep.append(i)
        return unrep
    
    if len(coeffs) == 1:
        upper_bound = base + coeffs[0] - 1
    else:
        upper_bound = base + max(coeffs) * len(coeffs) * 2
        
    dp = [False] * (upper_bound + 1)
    dp[0] = True
    
    for c in coeffs:
        for i in range(c, upper_bound + 1):
            dp[i] = dp[i] or dp[i - c]
    
    dp_with_base = [False] * (upper_bound + 1)
    for i in range(upper_bound + 1):
        if i >= base and dp[i - base]:
            dp_with_base[i] = True
    
    unrep = [i for i in range(upper_bound + 1) if not dp_with_base[i]]
    return unrep

examples = [
    ("x7", 1, [2]),
    ("x7", 1, [2, 1]),
    ("x7", 2, [3, 5]),
    ("x7", 0, [3, 5, 7]),
]

print("生成的SMT2约束表达式：")
for var, base, coeffs in examples:
    pattern_str = f'"{base * "a"}" + ' + ' + '.join([f'["{c * "a"}"]* ' for c in coeffs])
    constraint = generate_length_constraint(var, base, coeffs)
    print(f"{var} not in {pattern_str}:")
    print(f"  {constraint}")
    print()

def generate_smt2_file(var_name, base_length, coefficients, filename="constraint.smt2"):
    constraint = generate_length_constraint(var_name, base_length, coefficients)
    
    smt2_content = f"""(set-logic QF_SLIA)
(declare-fun {var_name} () String)
(assert {constraint})
(check-sat)
(get-model)"""
    
    with open(filename, "w") as f:
        f.write(smt2_content)
    
    print(f"已生成SMT2文件: {filename}")

generate_smt2_file("x7", 2, [3, 5], "complex_constraint.smt2")