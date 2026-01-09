(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_99532 () String)
(assert (= T_1 (not (= "" var_0xINPUT_99532))))
(assert T_1)
(assert (= T_2 (not (= var_0xINPUT_99532 "A9jaaDKZbG"))))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)
(assert (>= (str.num_splits var_0xINPUT_99532 "a") 2))
(assert (= seg0 (str.split_at var_0xINPUT_99532 "a" 0)))
(assert (= seg1 (str.split_at var_0xINPUT_99532 "a" 1)))
(assert (= rest1 (str.split_rest var_0xINPUT_99532 "a" 1)))
(assert (= rest1 (str.++ seg1 (str.split_rest var_0xINPUT_99532 "a" 2))))
(assert (not (= seg0 "")))
(assert (not (= seg1 "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
