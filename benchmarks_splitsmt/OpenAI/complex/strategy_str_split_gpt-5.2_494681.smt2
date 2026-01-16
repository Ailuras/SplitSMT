(set-logic ALL)

; Scenario: CSV Processing
; Goal: ensure correct field counts and detect empty fields


(declare-const T_1 Bool)
(declare-const T_2 Bool)
(declare-const var_0xINPUT_78913 String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest_after1 String)

(assert (= delim ","))

; Preserve core structure: input is non-empty
(assert (= T_1 (not (= "" var_0xINPUT_78913))))
(assert T_1)

; CSV field extraction via split interface
(assert (= field0 (str.split_at var_0xINPUT_78913 delim 0)))
(assert (= field1 (str.split_at var_0xINPUT_78913 delim 1)))
(assert (= field2 (str.split_at var_0xINPUT_78913 delim 2)))
(assert (= rest_after1 (str.split_rest var_0xINPUT_78913 delim 1)))

; Field count constraints: exactly 3 fields
(assert (>= (str.num_splits var_0xINPUT_78913 delim) 3))
(assert (<= (str.num_splits var_0xINPUT_78913 delim) 3))

; Indices are natural (interface requirement)
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))

; Detect empty fields: at least one field is empty
(assert (= T_2 (or (= field0 "") (= field1 "") (= field2 ""))))
(assert T_2)

; Also require first field to be non-empty (forces emptiness to occur in later fields)
(assert (not (= field0 "")))

; Structural sanity: rest_after1 should contain a comma because it covers fields 1 and 2
(assert (str.contains rest_after1 ","))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
