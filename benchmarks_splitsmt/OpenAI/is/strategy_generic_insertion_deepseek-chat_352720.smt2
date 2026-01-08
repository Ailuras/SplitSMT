(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_112727 () String)
(assert (= T_1 (= "-" var_0xINPUT_112727)))
(assert T_1)

; --- START CONSTRAINT ---
(declare-fun seg0 () String)
(declare-fun seg1 () String)
(assert (>= (str.num_splits var_0xINPUT_112727 "-") 2))
(assert (= seg0 (str.split_at var_0xINPUT_112727 "-" 0)))
(assert (= seg1 (str.split_at var_0xINPUT_112727 "-" 1)))
(assert (= (str.split_rest var_0xINPUT_112727 "-" 1) seg1))
(assert (not (= seg0 "")))
(assert (not (= seg1 "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
