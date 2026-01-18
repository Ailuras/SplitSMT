(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_447217 () String)
(assert (= T_1 (not (= "" var_0xINPUT_447217))))
(assert T_1)
(assert (= T_2 (= var_0xINPUT_447217 "array")))
(assert T_2)

; --- START CONSTRAINT ---

(assert (>= (num_splits var_0xINPUT_447217 "r") 2))
(assert (= (split_at var_0xINPUT_447217 "r" 0) "a"))
(assert (= (split_rest var_0xINPUT_447217 "r" 1) "ay"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
