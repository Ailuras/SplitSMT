(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
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
(assert (>= (num_splits var_0xINPUT_99532 "a") 2))
(assert (= seg0 (split_at var_0xINPUT_99532 "a" 0)))
(assert (= seg1 (split_at var_0xINPUT_99532 "a" 1)))
(assert (= rest1 (split_rest var_0xINPUT_99532 "a" 1)))
(assert (= rest1 (str.++ seg1 (split_rest var_0xINPUT_99532 "a" 2))))
(assert (not (= seg0 "")))
(assert (not (= seg1 "")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
