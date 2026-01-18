(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
; Scenario: CSV Processing
; Goal: process comma-separated data fields, ensure correct field counts, detect empty fields.

; Uninterpreted interface functions for split

; Boolean guards (preserve core seed structure with T_*)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)

; Additional booleans for CSV-specific checks
(declare-fun T_9 () Bool)
(declare-fun T_10 () Bool)
(declare-fun T_11 () Bool)
(declare-fun T_12 () Bool)

; Input CSV line
(declare-fun var_0xINPUT_239267 () String)

; Derived fields
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)

; Seed-like basic sanity constraints (mutated)
(assert (= T_1 (not (= "AA1ND6MEXd" var_0xINPUT_239267))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_239267))))
(assert T_2)
(assert (= T_3 (>= (str.len var_0xINPUT_239267) 3)))
(assert T_3)
(assert (= T_4 (not (= var_0xINPUT_239267 ""))))
(assert T_4)
(assert (= T_5 (= var_0xINPUT_239267 "")))
(assert (= T_6 (not T_5)))
(assert T_6)
(assert (= T_7 (str.contains var_0xINPUT_239267 ",")))
(assert T_7)

; Mutate T_8 to tie to CSV header prefix rather than exact equality
(assert (= T_8 (str.prefixof "Example:" var_0xINPUT_239267)))
(assert T_8)

; CSV splitting constraints
(assert (>= (num_splits var_0xINPUT_239267 ",") 4))
(assert (= field0 (split_at var_0xINPUT_239267 "," 0)))
(assert (= field1 (split_at var_0xINPUT_239267 "," 1)))
(assert (= field2 (split_at var_0xINPUT_239267 "," 2)))
(assert (= field3 (split_at var_0xINPUT_239267 "," 3)))

; Detect empty fields: require field1 empty (empty middle field)
(assert (= T_9 (= field1 "")))
(assert T_9)

; Also require no trailing empty after the 3rd comma: field3 is non-empty
(assert (= T_10 (not (= field3 ""))))
(assert T_10)

; Ensure there is at least one non-empty among field0 and field2
(assert (= T_11 (or (not (= field0 "")) (not (= field2 "")))))
(assert T_11)

; UNSAT-inducing consistency check: forbid consecutive commas while also requiring an empty field1
; If field1 is empty, there must be a ",," pattern between field0 and field2.
(assert (= T_12 (not (str.contains var_0xINPUT_239267 ",,"))))
(assert T_12)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
