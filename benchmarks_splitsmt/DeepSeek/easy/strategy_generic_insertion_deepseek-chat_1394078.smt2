(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_135600 () String)
(assert (= T_1 (= var_0xINPUT_135600 "GymH2acGCa")))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ";"))
(assert (>= (str.num_splits var_0xINPUT_135600 delimiter) 3))
(assert (= (str.split_at var_0xINPUT_135600 delimiter 0) "Gym"))
(assert (= (str.split_at var_0xINPUT_135600 delimiter 1) "H2acGCa"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
