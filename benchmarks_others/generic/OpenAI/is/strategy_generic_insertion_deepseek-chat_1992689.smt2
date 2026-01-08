(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_99582 () String)
(assert (= T_1 (= "-" var_0xINPUT_99582)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_99582)))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(assert (>= (str.len var_0xINPUT_99582) 1))
(assert (>= (num_splits var_0xINPUT_99582 "-") 1))
(assert (= (split_at var_0xINPUT_99582 "-" 0) var_0xINPUT_99582))
(assert (= (split_rest var_0xINPUT_99582 "-" 0) var_0xINPUT_99582))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
