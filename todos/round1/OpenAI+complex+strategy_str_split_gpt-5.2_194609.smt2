(set-logic ALL)

; CSV Processing: comma-separated field validation and empty-field detection

(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

(declare-const var_0xINPUT_40963 String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const n Int)

; str_split interface

(assert (= delim ","))

; Preserve core structure: input must be non-empty and not equal to a specific token
(assert (= T_1 (not (= "" var_0xINPUT_40963))))
(assert T_1)
(assert (= T_2 (not (= var_0xINPUT_40963 "6JX7G3VKFq"))))
(assert T_2)

; CSV constraints: exactly 3 fields and split projections
(assert (= n (str.num_splits var_0xINPUT_40963 delim)))
(assert (= T_3 (= n 3)))
(assert T_3)

(assert (= f0 (str.split_at var_0xINPUT_40963 delim 0)))
(assert (= f1 (str.split_at var_0xINPUT_40963 delim 1)))
(assert (= f2 (str.split_at var_0xINPUT_40963 delim 2)))
(assert (= rest1 (str.split_rest var_0xINPUT_40963 delim 1)))
(assert (= rest2 (str.split_rest var_0xINPUT_40963 delim 2)))

; Reconstructability checks (relaxation-friendly sanity constraints)
(assert (= var_0xINPUT_40963 (str.++ f0 delim rest1)))
(assert (= rest1 (str.++ f1 delim rest2)))
(assert (= rest2 f2))

; Detect empty fields: require at least one empty field among the 3
(assert (= T_4 (or (= f0 "") (= f1 "") (= f2 ""))))
(assert T_4)

; Additional CSV hygiene: disallow delimiter inside individual fields
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))

; Example quality constraints: first field looks like an ID and third field is numeric-ish
(assert (>= (str.len f0) 1))
(assert (or (= f2 "") (and (>= (str.len f2) 1) (<= (str.len f2) 5))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
