(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_76237 () String)
(assert (= T_1 (= var_0xINPUT_76237 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(declare-const delim_76237 String)

(assert (= delim_76237 ","))
(assert (>= (num_splits var_0xINPUT_76237 delim_76237) 1))
(assert (= (split_at var_0xINPUT_76237 delim_76237 0) var_0xINPUT_76237))
(assert (= (split_rest var_0xINPUT_76237 delim_76237 0) var_0xINPUT_76237))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
