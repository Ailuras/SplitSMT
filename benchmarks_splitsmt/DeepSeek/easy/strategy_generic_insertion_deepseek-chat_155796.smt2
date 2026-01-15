(set-logic ALL)
(declare-fun T1_3 () String)
(declare-fun T2_3 () String)
(declare-fun T_1 () String)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_125039 () String)
(assert (= T_1 (str.++ T1_3 T2_3)))
(assert (= T2_3 var_0xINPUT_125039))
(assert (= T1_3 ""))
(assert (= T_2 (= "-" T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun segment_0 () String)
(declare-fun segment_1 () String)
(assert (= segment_0 (str.split_at var_0xINPUT_125039 "-" 0)))
(assert (= segment_1 (str.split_at var_0xINPUT_125039 "-" 1)))
(assert (>= (str.num_splits var_0xINPUT_125039 "-") 2))
(assert (= (str.split_rest var_0xINPUT_125039 "-" 0) var_0xINPUT_125039))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
