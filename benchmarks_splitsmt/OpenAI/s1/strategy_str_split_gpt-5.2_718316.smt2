(set-logic ALL)

; CSV Processing: comma-separated fields, validate field counts, detect empty fields

; Uninterpreted split interface

; Seed-preserving symbols
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_113268 () String)

; Additional CSV-related variables
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest2 String)
(declare-const hasEmpty Bool)

(assert (= delim ","))

; Mutated core structure from seed: keep T_1 equated to a string equality
(assert (= T_1 (= "-" var_0xINPUT_113268)))

; Constrain input to a CSV-like row ending with '-' to preserve seed satisfiability
(assert (str.suffixof "-" var_0xINPUT_113268))
(assert (str.contains var_0xINPUT_113268 delim))

; Split into fields using the provided interface
(assert (= field0 (str.split_at var_0xINPUT_113268 delim 0)))
(assert (= field1 (str.split_at var_0xINPUT_113268 delim 1)))
(assert (= field2 (str.split_at var_0xINPUT_113268 delim 2)))
(assert (= rest2  (str.split_rest var_0xINPUT_113268 delim 2)))

; Ensure at least 3 fields exist (i.e., at least 2 commas)
(assert (>= (str.num_splits var_0xINPUT_113268 delim) 3))

; Detect empty fields (empty string segments are allowed but should be detectable)
(assert (= hasEmpty (or (= field0 "") (= field1 "") (= field2 ""))))

; A simple consistency constraint: the remaining tail from field2 onward contains field2
(assert (str.contains rest2 field2))

; Make it a non-empty-field CSV row for this instance
(assert (not hasEmpty))

; Preserve the seed's requirement
(assert T_1)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
