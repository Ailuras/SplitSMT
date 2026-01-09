(set-logic ALL)
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_37713 () String)
(assert (= T_1 (str.len var_0xINPUT_37713)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-fun delimiter () String)
(assert (>= (num_splits var_0xINPUT_37713 delimiter) 2))
(assert (= (split_at var_0xINPUT_37713 delimiter 0) "prefix"))
(assert (= (split_rest var_0xINPUT_37713 delimiter 1) "suffix"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
