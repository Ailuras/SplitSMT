(set-logic ALL)

; CSV Processing: comma-separated fields, enforce field counts, detect empty fields


(declare-fun T_1 () Bool)
(declare-fun T_has_empty () Bool)
(declare-fun T_fieldcount_ok () Bool)
(declare-fun T_nontrivial () Bool)

(declare-const var_0xINPUT_109017 String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)

(assert (= delim ","))

; Preserve core structure but adapt to CSV: previously "-" now a concrete CSV row
(assert (= T_1 (= "a,,c" var_0xINPUT_109017)))
(assert T_1)

; Basic sanity: non-empty overall CSV line
(assert (= T_nontrivial (> (str.len var_0xINPUT_109017) 0)))
(assert T_nontrivial)

; Split-derived fields
(assert (= f0 (str.split_at var_0xINPUT_109017 delim 0)))
(assert (= f1 (str.split_at var_0xINPUT_109017 delim 1)))
(assert (= f2 (str.split_at var_0xINPUT_109017 delim 2)))
(assert (= rest2 (str.split_rest var_0xINPUT_109017 delim 2)))

; Field count expectations for CSV row "a,,c" => 3 segments
(assert (= T_fieldcount_ok (= (str.num_splits var_0xINPUT_109017 delim) 3)))
(assert T_fieldcount_ok)

; Detect empty field: second field must be empty
(assert (= T_has_empty (= f1 "")))
(assert T_has_empty)

; Additional CSV consistency constraints
(assert (= f0 "a"))
(assert (= f2 "c"))
(assert (str.contains var_0xINPUT_109017 ",,"))

; rest2 should be the third field for 3 segments
(assert (= rest2 "c"))

; UNSAT branch: require a contradictory property on the same input
(assert (not (= (str.num_splits var_0xINPUT_109017 delim) 3)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
