(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_230341 () String)
(assert (= T_1 (= var_0xINPUT_230341 "chrome:")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(declare-fun scheme () String)
(declare-fun after_colon () String)

(assert (= scheme (split_at var_0xINPUT_230341 ":" 0)))
(assert (= after_colon (split_rest var_0xINPUT_230341 ":" 1)))
(assert (>= (num_splits var_0xINPUT_230341 ":") 1))
(assert (not (= scheme "chrome")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
