(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_49585 () String)
(assert (= T_1 (= var_0xINPUT_49585 "Search")))
(assert T_1)

; --- START CONSTRAINT ---

(assert (>= (num_splits var_0xINPUT_49585 "a") 1))
(assert (= (split_at var_0xINPUT_49585 "a" 0) "Se"))
(assert (= (split_rest var_0xINPUT_49585 "a" 1) "rch"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
