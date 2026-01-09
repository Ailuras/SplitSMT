(set-logic ALL)

; CSV Processing scenario: enforce field counts and detect empty fields

; Boolean trackers (kept from seed, repurposed)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

; Input CSV line
(declare-fun var_0xINPUT_351516 () String)

; str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Helper vars for fields
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)

(assert (= delim ","))

; Non-empty input
(assert (= T_1 (not (= "" var_0xINPUT_351516))))
(assert T_1)

; Exactly three fields (two commas)
(assert (= T_2 (= (num_splits var_0xINPUT_351516 delim) 3)))
(assert T_2)

; Bind field extractions
(assert (= f0 (split_at var_0xINPUT_351516 delim 0)))
(assert (= f1 (split_at var_0xINPUT_351516 delim 1)))
(assert (= f2 (split_at var_0xINPUT_351516 delim 2)))
(assert (= rest1 (split_rest var_0xINPUT_351516 delim 1)))

; Ensure split indices are natural and within bounds implied by num_splits
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))
(assert (>= (num_splits var_0xINPUT_351516 delim) 3))

; Detect an empty middle field
(assert (= T_3 (= f1 "")))
(assert T_3)

; Additionally, require the line to have at least one comma and to include ",,"
(assert (str.contains var_0xINPUT_351516 delim))
(assert (str.contains var_0xINPUT_351516 ",,"))

; Core structure mutation: remove old "array" equality, add a new constraint about first field
(assert (= T_4 (not (= f0 ""))))
(assert T_4)

; UNSAT condition: forbid any empty field while simultaneously requiring empty middle field
(assert (not (= f1 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]