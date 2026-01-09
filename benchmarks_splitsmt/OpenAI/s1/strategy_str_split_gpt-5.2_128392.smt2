(set-logic ALL)

; CSV Processing: ensure correct field counts and detect empty fields

; Interface operations (uninterpreted)

; Booleans (preserve core structure)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

; Inputs
(declare-fun var_0xINPUT_238239 () String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest1 String)

; Delimiter is comma
(assert (= delim ","))

; Preserve core structure: input is not empty
(assert (= T_1 (= var_0xINPUT_238239 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; Split-derived fields
(assert (= field0 (str.split_at var_0xINPUT_238239 delim 0)))
(assert (= field1 (str.split_at var_0xINPUT_238239 delim 1)))
(assert (= field2 (str.split_at var_0xINPUT_238239 delim 2)))
(assert (= rest1 (str.split_rest var_0xINPUT_238239 delim 1)))

; Indices natural and within a small bound for this scenario
(assert (and (<= 0 0) (<= 0 1) (<= 0 2)))

; Field count constraint: exactly 3 CSV fields -> 2 commas => num_splits = 3
(assert (= (str.num_splits var_0xINPUT_238239 delim) 3))

; Detect empty fields: require at least one empty field, and also require at least one non-empty field
(assert (= T_3 (or (= field0 "") (= field1 "") (= field2 ""))))
(assert (= T_4 (or (not (= field0 "")) (not (= field1 "")) (not (= field2 "")))))
(assert T_3)
(assert T_4)

; Structural sanity: rest from index 1 should contain field1 as a substring
(assert (str.contains rest1 field1))

; Additional concrete constraint: first field is "id"
(assert (= field0 "id"))

; UNSAT twist: make field1 simultaneously empty and equal to a non-empty literal
(assert (= field1 ""))
(assert (= field1 "name"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
