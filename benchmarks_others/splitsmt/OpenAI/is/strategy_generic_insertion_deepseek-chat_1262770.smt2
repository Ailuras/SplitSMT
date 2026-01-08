(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_4701 () String)
(assert (= T_1 (not (= "file:" var_0xINPUT_4701))))
(assert T_1)

; --- START CONSTRAINT ---

(declare-fun scheme_part () String)
(declare-fun after_colon () String)

(assert (>= (str.len var_0xINPUT_4701) 0))
(assert (>= (str.num_splits var_0xINPUT_4701 ":") 1))
(assert (= scheme_part (str.split_at var_0xINPUT_4701 ":" 0)))
(assert (= after_colon (str.split_rest var_0xINPUT_4701 ":" 1)))
(assert (= scheme_part "file"))
(assert (= var_0xINPUT_4701 (str.++ scheme_part ":" after_colon)))
(assert (= (str.num_splits var_0xINPUT_4701 ":") 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
