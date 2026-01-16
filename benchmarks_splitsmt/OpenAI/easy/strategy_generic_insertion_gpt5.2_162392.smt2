(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_57952 () String)
(assert (= T_1 (= var_0xINPUT_57952 "Search")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(declare-fun seg0 () String)
(declare-fun seg1 () String)

(assert (>= (str.num_splits var_0xINPUT_57952 "a") 1))
(assert (= seg0 (str.split_at var_0xINPUT_57952 "a" 0)))
(assert (= seg1 (str.split_rest var_0xINPUT_57952 "a" 1)))
(assert (= var_0xINPUT_57952 (str.++ seg0 seg1)))
(assert (= seg0 "Se"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
