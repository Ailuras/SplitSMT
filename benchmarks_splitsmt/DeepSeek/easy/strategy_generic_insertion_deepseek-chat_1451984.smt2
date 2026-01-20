(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_112727 () String)
(assert (= T_1 (= "-" var_0xINPUT_112727)))
(assert T_1)

; --- START CONSTRAINT ---
(declare-const segment_0 String)
(declare-const segment_1 String)
(declare-const total_segments Int)
(assert (= segment_0 (str.split_at var_0xINPUT_112727 "-" 0)))
(assert (= segment_1 (str.split_at var_0xINPUT_112727 "-" 1)))
(assert (= total_segments (str.num_splits var_0xINPUT_112727 "-")))
(assert (>= total_segments 2))
(assert (= (str.split_rest var_0xINPUT_112727 "-" 1) ""))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
