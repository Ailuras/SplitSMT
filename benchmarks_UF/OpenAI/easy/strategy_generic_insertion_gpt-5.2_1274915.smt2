(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_113268 () String)
(assert (= T_1 (= "-" var_0xINPUT_113268)))
(assert T_1)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun seg0 () String)
(declare-fun seg1 () String)

(assert (= seg0 (split_at var_0xINPUT_113268 "-" 0)))
(assert (= seg1 (split_at var_0xINPUT_113268 "-" 1)))
(assert (= (num_splits var_0xINPUT_113268 "-") 2))
(assert (= seg0 ""))
(assert (= seg1 ""))
(assert (= (split_rest var_0xINPUT_113268 "-" 0) var_0xINPUT_113268))
(assert (= (split_rest var_0xINPUT_113268 "-" 1) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
