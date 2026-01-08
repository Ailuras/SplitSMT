(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_112727 () String)
(assert (= T_1 (= "-" var_0xINPUT_112727)))
(assert T_1)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const segment_0 String)
(declare-const segment_1 String)
(declare-const total_segments Int)
(assert (= segment_0 (split_at var_0xINPUT_112727 "-" 0)))
(assert (= segment_1 (split_at var_0xINPUT_112727 "-" 1)))
(assert (= total_segments (num_splits var_0xINPUT_112727 "-")))
(assert (>= total_segments 2))
(assert (= (split_rest var_0xINPUT_112727 "-" 2) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)