(set-logic ALL)
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_450212 () String)
(assert (= T_1 (str.len var_0xINPUT_450212)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-fun delimiter () String)
(declare-fun segment0 () String)
(declare-fun segment1 () String)
(declare-fun total_segments () Int)
(assert (= delimiter ","))
(assert (= segment0 (split_at var_0xINPUT_450212 delimiter 0)))
(assert (= segment1 (split_at var_0xINPUT_450212 delimiter 1)))
(assert (= total_segments (num_splits var_0xINPUT_450212 delimiter)))
(assert (>= total_segments 2))
(assert (not (= segment0 segment1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
