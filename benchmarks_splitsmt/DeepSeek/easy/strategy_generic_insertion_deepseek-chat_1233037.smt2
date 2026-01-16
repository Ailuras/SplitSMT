(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_102266 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_102266))))
(assert T_1)

; --- START CONSTRAINT ---
(declare-const protocol String)
(declare-const path String)
(assert (= protocol (str.split_at var_0xINPUT_102266 ":" 0)))
(assert (>= (str.num_splits var_0xINPUT_102266 ":") 2))
(assert (= path (str.split_rest var_0xINPUT_102266 ":" 1)))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
