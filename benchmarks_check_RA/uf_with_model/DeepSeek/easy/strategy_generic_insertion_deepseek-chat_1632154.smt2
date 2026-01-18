(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_226630 () String)
(assert (= T_1 (str.len var_0xINPUT_226630)))
(assert (= T_2 (= T_1 0)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun delimiter () String)
(declare-fun segment_count () Int)
(declare-fun first_segment () String)
(declare-fun remaining_segments () String)
(assert (>= (num_splits var_0xINPUT_226630 delimiter) 1))
(assert (= first_segment (split_at var_0xINPUT_226630 delimiter 0)))
(assert (= remaining_segments (split_rest var_0xINPUT_226630 delimiter 1)))
(assert (= segment_count (num_splits var_0xINPUT_226630 delimiter)))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
