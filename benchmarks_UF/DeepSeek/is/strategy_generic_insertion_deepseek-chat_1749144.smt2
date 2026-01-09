(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun var_0xINPUT_27511 () String)
(assert (= T_1 (not (= "" var_0xINPUT_27511))))
(assert T_1)
(assert (= T_2 (= "-" var_0xINPUT_27511)))
(assert (= T_3 (not T_2)))
(assert T_3)
(assert (= T_4 (= "" var_0xINPUT_27511)))
(assert (= T_5 (not T_4)))
(assert T_5)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const segment_0 String)
(declare-const segment_1 String)
(declare-const total_segments Int)
(assert (= segment_0 (split_at var_0xINPUT_27511 "-" 0)))
(assert (= segment_1 (split_at var_0xINPUT_27511 "-" 1)))
(assert (= total_segments (num_splits var_0xINPUT_27511 "-")))
(assert (>= total_segments 2))
(assert (not (= segment_0 "")))
(assert (not (= segment_1 "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]