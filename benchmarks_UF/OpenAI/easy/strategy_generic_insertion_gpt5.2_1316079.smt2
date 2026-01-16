(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_81724 () String)
(assert (= T_1 (not (= "qXdHDo7IZR" var_0xINPUT_81724))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(declare-const delim_81724 String)

(assert (= delim_81724 ""))
(assert (>= (num_splits var_0xINPUT_81724 delim_81724) 1))
(assert (= (split_at var_0xINPUT_81724 delim_81724 0) var_0xINPUT_81724))
(assert (= (split_rest var_0xINPUT_81724 delim_81724 0) var_0xINPUT_81724))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
