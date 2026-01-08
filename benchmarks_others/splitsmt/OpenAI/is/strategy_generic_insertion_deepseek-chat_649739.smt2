(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_49585 () String)
(assert (= T_1 (= var_0xINPUT_49585 "Search")))
(assert T_1)

; --- START CONSTRAINT ---

(assert (>= (str.num_splits var_0xINPUT_49585 "a") 1))
(assert (= (str.split_at var_0xINPUT_49585 "a" 0) "Se"))
(assert (= (str.split_rest var_0xINPUT_49585 "a" 1) "rch"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
