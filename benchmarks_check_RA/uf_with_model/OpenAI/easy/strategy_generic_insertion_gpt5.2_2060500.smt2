(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_84736 () String)
(assert (= T_1 (not (= "" var_0xINPUT_84736))))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (not (= "" var_0xINPUT_84736))))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- START CONSTRAINT ---
(declare-fun seg0 () String)
(declare-fun seg1 () String)
(assert (= (num_splits var_0xINPUT_84736 "-") 1))
(assert (= seg0 (split_at var_0xINPUT_84736 "-" 0)))
(assert (= seg1 (split_rest var_0xINPUT_84736 "-" 1)))
(assert (= seg0 var_0xINPUT_84736))
(assert (= seg1 ""))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
