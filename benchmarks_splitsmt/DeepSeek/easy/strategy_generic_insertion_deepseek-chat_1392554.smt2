(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_230341 () String)
(assert (= T_1 (= var_0xINPUT_230341 "chrome:")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const protocol String)
(declare-const path String)
(assert (= protocol (str.split_at var_0xINPUT_230341 ":" 0)))
(assert (= path (str.split_rest var_0xINPUT_230341 ":" 1)))
(assert (>= (str.num_splits var_0xINPUT_230341 ":") 2))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
