(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_21136 () String)
(assert (= T_1 (not (= "" var_0xINPUT_21136))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const num_segments Int)
(assert (= segment0 (split_at var_0xINPUT_21136 "," 0)))
(assert (= segment1 (split_at var_0xINPUT_21136 "," 1)))
(assert (= num_segments (num_splits var_0xINPUT_21136 ",")))
(assert (>= num_segments 2))
(assert (not (= segment0 "")))
(assert (not (= segment1 "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]