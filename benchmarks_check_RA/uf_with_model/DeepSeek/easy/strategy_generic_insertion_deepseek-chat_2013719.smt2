(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_351516 () String)
(assert (= T_1 (not (= "" var_0xINPUT_351516))))
(assert T_1)
(assert (= T_2 (= var_0xINPUT_351516 "array")))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun segment_0 () String)
(declare-fun segment_1 () String)
(assert (= segment_0 (split_at var_0xINPUT_351516 "," 0)))
(assert (= segment_1 (split_at var_0xINPUT_351516 "," 1)))
(assert (>= (num_splits var_0xINPUT_351516 ",") 2))
(assert (not (= segment_0 "")))
(assert (not (= segment_1 "")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
