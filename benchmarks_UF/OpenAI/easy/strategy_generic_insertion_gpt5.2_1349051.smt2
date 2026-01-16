(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_283257 () String)
(assert (= T_1 (= var_0xINPUT_283257 "Search")))
(assert T_1)

; --- START CONSTRAINT ---

(declare-fun seg0 () String)
(declare-fun seg1 () String)

(assert (>= (num_splits var_0xINPUT_283257 "e") 2))
(assert (= seg0 (split_at var_0xINPUT_283257 "e" 0)))
(assert (= seg1 (split_at var_0xINPUT_283257 "e" 1)))
(assert (= seg0 "S"))
(assert (= seg1 "arch"))
(assert (= (split_rest var_0xINPUT_283257 "e" 1) "arch"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
