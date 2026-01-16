(set-logic ALL)

; CSV Processing scenario: comma-separated fields, field counts, and empty-field detection

; Uninterpreted split interface

; Seed-style boolean tracking
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)

; Input CSV line
(declare-fun var_0xINPUT_35287 () String)

; Additional derived variables
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const n Int)
(declare-const i Int)

(assert (= delim ","))

; Preserve core structure: input is not "-" and not empty
(assert (= T_1 (= "-" var_0xINPUT_35287)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_35287)))
(assert (= T_4 (not T_3)))
(assert T_4)

; CSV-specific constraints: at least 3 fields (2 commas) and no trailing comma
(assert (= n (str.num_splits var_0xINPUT_35287 delim)))
(assert (>= n 3))
(assert (not (str.suffixof delim var_0xINPUT_35287)))

; Bind fields via split interface
(assert (= f0 (str.split_at var_0xINPUT_35287 delim 0)))
(assert (= f1 (str.split_at var_0xINPUT_35287 delim 1)))
(assert (= f2 (str.split_at var_0xINPUT_35287 delim 2)))
(assert (= rest1 (str.split_rest var_0xINPUT_35287 delim 1)))
(assert (= rest2 (str.split_rest var_0xINPUT_35287 delim 2)))

; Index discipline for split_at/split_rest calls
(assert (>= i 0))
(assert (< i n))

; Detect empty fields (presence of ,,) and disallow it (SAT side)
(assert (= T_5 (str.contains var_0xINPUT_35287 ",,")))
(assert (= T_6 (not T_5)))
(assert T_6)

; Require each of first three fields non-empty and not just whitespace
(assert (not (= f0 "")))
(assert (not (= f1 "")))
(assert (not (= f2 "")))
(assert (not (= f0 " ")))
(assert (not (= f1 " ")))
(assert (not (= f2 " ")))

; Ensure rest concatenations are consistent with having delimiters
(assert (str.contains rest1 delim))
(assert (or (= n 3) (str.contains rest2 delim)))

; A small structured format: first field must be alphabetic prefix, second numeric-like, third arbitrary non-empty
(assert (str.in_re f0 (re.++ (re.+ (re.range "A" "Z")) (re.* (re.range "a" "z")))))
(assert (str.in_re f1 (re.+ (re.range "0" "9"))))

; Add an UNSAT branch condition guarded by a boolean, to diversify but keep overall satisfiable
; Force T_7 true, but make it consistent (do not contradict the SAT constraints)
(assert (= T_7 (<= (str.len var_0xINPUT_35287) 200)))
(assert T_7)

; Another boolean derived check: ensure the CSV line actually contains a comma
(assert (= T_8 (str.contains var_0xINPUT_35287 delim)))
(assert T_8)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
