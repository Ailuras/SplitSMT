(set-logic ALL)

; CSV Processing: validate comma-separated fields, count, and empty-field detection

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed variables (kept core structure)
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_396639 () String)

; Additional variables for CSV fields
(declare-const comma String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest2 String)
(declare-const has_empty Bool)
(declare-const no_empty Bool)
(declare-const want_three_fields Bool)

(assert (= comma ","))

; Preserve core structure: non-empty input
(assert (= T_1 (str.len var_0xINPUT_396639)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; Basic CSV sanity: length bounds and at least one split segment
(assert (>= T_1 1))
(assert (>= (num_splits var_0xINPUT_396639 comma) 1))

; Extract first three fields and the rest
(assert (= f0 (split_at var_0xINPUT_396639 comma 0)))
(assert (= f1 (split_at var_0xINPUT_396639 comma 1)))
(assert (= f2 (split_at var_0xINPUT_396639 comma 2)))
(assert (= rest2 (split_rest var_0xINPUT_396639 comma 2)))

; Indices must be natural; additionally require enough fields for these accesses
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))
(assert (>= (num_splits var_0xINPUT_396639 comma) 3))

; Empty field detection (empty string between commas or leading/trailing comma)
(assert (= has_empty (or (= f0 "") (= f1 "") (= f2 ""))))
(assert (= no_empty (not has_empty)))

; Require exactly three fields: the rest from index 2 should equal the third field
; (i.e., there is no comma after the third field)
(assert (= want_three_fields (= rest2 f2)))
(assert want_three_fields)

; Instance A (SAT): enforce no empty fields
(assert no_empty)

; Instance B (UNSAT): simultaneously demand an empty field (contradiction with no_empty)
(assert has_empty)

(check-sat)


; [GENERATION STATUS: SUCCESS]