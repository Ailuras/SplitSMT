(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_100788 () String)
(assert (= T_1 (= "-" var_0xINPUT_100788)))
(assert T_1)

; --- START CONSTRAINT ---

(assert (>= (str.num_splits var_0xINPUT_100788 "-") 1))
(assert (= (str.split_at var_0xINPUT_100788 "-" 0) ""))
(assert (= (str.split_at var_0xINPUT_100788 "-" 1) ""))
(assert (= (str.split_rest var_0xINPUT_100788 "-" 1) ""))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
