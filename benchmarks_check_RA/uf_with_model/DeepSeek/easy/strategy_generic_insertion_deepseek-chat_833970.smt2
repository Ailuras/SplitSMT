(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_58219 () String)
(assert (= T_1 (= var_0xINPUT_58219 "Search")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
(assert (= segment0 (split_at var_0xINPUT_58219 "," 0)))
(assert (= segment1 (split_at var_0xINPUT_58219 "," 1)))
(assert (= total_segments (num_splits var_0xINPUT_58219 ",")))
(assert (>= total_segments 2))
(assert (not (str.contains segment0 "Search")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
