; CSV Processing scenario: comma-separated fields, field count, and empty-field detection
(set-logic ALL)

; Uninterpreted split interface

; Seed booleans preserved
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)

; Input CSV line
(declare-fun var_0xINPUT_124328 () String)

; Additional variables for CSV fields
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const has_empty Bool)
(declare-const expected_fields Int)

(assert (= delim ","))
(assert (= expected_fields 3))

; Mutated seed core constraints (kept structure, but now oriented to CSV emptiness)
(assert (= T_1 (= "-" var_0xINPUT_124328)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_124328)))
(assert T_3)

; CSV constraints
(assert (>= (str.num_splits var_0xINPUT_124328 delim) 1))

(assert (= f0 (str.split_at var_0xINPUT_124328 delim 0)))
(assert (= f1 (str.split_at var_0xINPUT_124328 delim 1)))
(assert (= f2 (str.split_at var_0xINPUT_124328 delim 2)))
(assert (= rest1 (str.split_rest var_0xINPUT_124328 delim 1)))
(assert (= rest2 (str.split_rest var_0xINPUT_124328 delim 2)))

; Detect empty fields
(assert (= has_empty (or (= f0 "") (= f1 "") (= f2 ""))))

; Intended CSV processing expectations
(assert (= (str.num_splits var_0xINPUT_124328 delim) expected_fields))

; Enforce that there is at least one empty field (common in malformed CSV)
(assert has_empty)

; Contradictory requirement: no field is empty
(assert (not (= f0 "")))
(assert (not (= f1 "")))
(assert (not (= f2 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
