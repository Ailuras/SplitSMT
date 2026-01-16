(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_107312 () String)
(assert (= T_1 (= "-" var_0xINPUT_107312)))
(assert T_1)

; --- START CONSTRAINT ---

(declare-fun seg0 () String)
(declare-fun seg1 () String)

(assert (>= (str.num_splits var_0xINPUT_107312 "-") 2))
(assert (= seg0 (str.split_at var_0xINPUT_107312 "-" 0)))
(assert (= seg1 (str.split_at var_0xINPUT_107312 "-" 1)))
(assert (= "" seg0))
(assert (= "" seg1))
(assert (= "" (str.split_rest var_0xINPUT_107312 "-" 2)))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
