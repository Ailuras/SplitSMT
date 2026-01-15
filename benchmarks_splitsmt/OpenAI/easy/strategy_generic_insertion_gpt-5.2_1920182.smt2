(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_89849 () String)
(assert (= T_1 (= "-" var_0xINPUT_89849)))
(assert T_1)

; --- START CONSTRAINT ---

(assert (>= (str.num_splits var_0xINPUT_89849 "-") 2))
(assert (= (str.split_at var_0xINPUT_89849 "-" 0) ""))
(assert (= (str.split_at var_0xINPUT_89849 "-" 1) ""))
(assert (= (str.split_rest var_0xINPUT_89849 "-" 2) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
