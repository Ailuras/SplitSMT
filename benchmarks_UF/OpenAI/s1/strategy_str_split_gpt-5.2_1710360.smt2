; CSV Processing scenario: comma-separated fields, count validation, empty-field detection
(set-logic ALL)

; Original boolean scaffold retained (core structure)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)
(declare-fun T_a () Bool)
(declare-fun T_b () Bool)
(declare-fun T_c () Bool)
(declare-fun T_d () Bool)
(declare-fun T_e () Bool)
(declare-fun T_f () Bool)
(declare-fun T_10 () Bool)
(declare-fun T_11 () Bool)
(declare-fun T_12 () Bool)

; str_split interface (uninterpreted as required)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Input CSV line
(declare-fun var_0xINPUT_253192 () String)

; Additional CSV-related variables
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const has_empty Bool)
(declare-const no_empty Bool)
(declare-const expected_fields Int)

(assert (= delim ","))
(assert (= expected_fields 3))

; Mutated/extended core constraints: non-empty input and not equal to a specific constant
(assert (= T_1 (not (= "6JX7G3VKFq" var_0xINPUT_253192))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_253192))))
(assert T_2)
(assert (= T_3 (not (= var_0xINPUT_253192 ""))))
(assert T_3)
(assert (= T_4 (not (= "" var_0xINPUT_253192))))
(assert T_4)
(assert (= T_5 (= var_0xINPUT_253192 "")))
(assert (= T_6 (not T_5)))
(assert T_6)
(assert (= T_7 (not (= "" var_0xINPUT_253192))))
(assert T_7)
(assert (= T_8 (not (= "" var_0xINPUT_253192))))
(assert T_8)
(assert (= T_9 (not (= var_0xINPUT_253192 ""))))
(assert T_9)
(assert (= T_a (= var_0xINPUT_253192 "")))
(assert (= T_b (not T_a)))
(assert T_b)
(assert (= T_c (not (= "" var_0xINPUT_253192))))
(assert T_c)
(assert (= T_d (not (= var_0xINPUT_253192 ""))))
(assert T_d)
(assert (= T_e (not (= "" var_0xINPUT_253192))))
(assert T_e)
(assert (= T_f (= var_0xINPUT_253192 "")))
(assert (= T_10 (not T_f)))
(assert T_10)
(assert (= T_11 (not (= "" var_0xINPUT_253192))))
(assert T_11)

; CSV parsing core: enforce exactly 3 fields (2 commas => 3 splits)
(assert (= (num_splits var_0xINPUT_253192 delim) expected_fields))

; Bind split components
(assert (= f0 (split_at var_0xINPUT_253192 delim 0)))
(assert (= f1 (split_at var_0xINPUT_253192 delim 1)))
(assert (= f2 (split_at var_0xINPUT_253192 delim 2)))
(assert (= rest1 (split_rest var_0xINPUT_253192 delim 1)))
(assert (= rest2 (split_rest var_0xINPUT_253192 delim 2)))

; Indices natural and within split bounds (interface-style constraints)
(assert (and (<= 0 0) (< 0 (num_splits var_0xINPUT_253192 delim))))
(assert (and (<= 0 1) (< 1 (num_splits var_0xINPUT_253192 delim))))
(assert (and (<= 0 2) (< 2 (num_splits var_0xINPUT_253192 delim))))

; Detect empty fields
(assert (= has_empty (or (= f0 "") (= f1 "") (= f2 ""))))
(assert (= no_empty (not has_empty)))

; Ensure at least one empty field exists (to model detecting empty fields)
(assert has_empty)

; Ensure commas are present given the field count
(assert (str.contains var_0xINPUT_253192 delim))

; Link rest strings to imply additional delimiters exist in rest1 for 3 fields
(assert (str.contains rest1 delim))

; Add a concrete-but-conflicting example marker: CSV line must be exactly "Example:" (UNSAT with split count 3)
(assert (= T_12 (= var_0xINPUT_253192 "Example:")))
(assert T_12)

(check-sat)


; [GENERATION STATUS: SUCCESS]