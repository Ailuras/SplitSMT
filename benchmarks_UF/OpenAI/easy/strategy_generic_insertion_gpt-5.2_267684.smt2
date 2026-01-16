(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun var_0xINPUT_233086 () String)
(assert (= T_1 (not (= "" var_0xINPUT_233086))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_233086))))
(assert T_2)
(assert (= T_3 (= var_0xINPUT_233086 "Example:")))
(assert (= T_4 (not T_3)))
(assert T_4)
(assert (= T_5 (not (= var_0xINPUT_233086 "4PH2ujcENG"))))
(assert (= T_6 (not T_5)))
(assert T_6)

; --- START CONSTRAINT ---

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun seg_rest1 () String)

(assert (= seg0 (split_at var_0xINPUT_233086 "P" 0)))
(assert (= seg1 (split_at var_0xINPUT_233086 "P" 1)))
(assert (= seg_rest1 (split_rest var_0xINPUT_233086 "P" 1)))

(assert (>= (num_splits var_0xINPUT_233086 "P") 2))
(assert (= seg0 "4"))
(assert (= seg1 "H2ujcENG"))
(assert (= seg_rest1 "H2ujcENG"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
