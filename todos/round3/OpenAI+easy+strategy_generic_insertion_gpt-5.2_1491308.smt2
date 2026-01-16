(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_102192 () String)
(assert (= T_1 (= "-" var_0xINPUT_102192)))
(assert T_1)

; --- START CONSTRAINT ---
(assert (= (str.num_splits var_0xINPUT_102192 "-") 2))
(assert (= (str.split_at var_0xINPUT_102192 "-" 0) ""))
(assert (= (str.split_at var_0xINPUT_102192 "-" 1) ""))
(assert (= (str.split_rest var_0xINPUT_102192 "-" 1) ""))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
