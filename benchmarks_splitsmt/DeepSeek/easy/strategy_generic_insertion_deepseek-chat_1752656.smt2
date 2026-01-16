(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_57953 () String)
(assert (= T_1 (= var_0xINPUT_57953 "Search")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ";"))
(assert (>= (str.num_splits var_0xINPUT_57953 delimiter) 3))
(assert (= (str.split_at var_0xINPUT_57953 delimiter 0) "Search"))
(assert (str.contains (str.split_rest var_0xINPUT_57953 delimiter 1) "data"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
