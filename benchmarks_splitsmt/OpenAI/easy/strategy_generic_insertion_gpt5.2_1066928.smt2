(set-logic ALL)
(declare-fun I0_5 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_5 () String)
(declare-fun T1_5 () String)
(declare-fun T2_5 () String)
(declare-fun T3_5 () String)
(declare-fun T4_5 () String)
(declare-fun T5_5 () String)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun var_0xINPUT_96023 () String)
(assert (= T_1 (= "-" var_0xINPUT_96023)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_96023)))
(assert T_3)
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1 (and (= PCTEMP_LHS_1 (+ I0_5 0)) (= var_0xINPUT_96023 (str.++ T0_5 T1_5)) (= I0_5 (str.len T4_5)) (= 0 (str.len T0_5)) (= T1_5 (str.++ T2_5 T3_5)) (= T2_5 (str.++ T4_5 T5_5)) (= T5_5 "__utmv=16886264.") (not (str.in_re T4_5 (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "v") (str.to_re "=") (str.to_re "1") (str.to_re "6") (str.to_re "8") (str.to_re "8") (str.to_re "6") (str.to_re "2") (str.to_re "6") (str.to_re "4") (str.to_re "."))))) (and (= PCTEMP_LHS_1 (- 1)) (= var_0xINPUT_96023 (str.++ T0_5 T1_5)) (= 0 (str.len T0_5)) (not (str.in_re T1_5 (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "v") (str.to_re "=") (str.to_re "1") (str.to_re "6") (str.to_re "8") (str.to_re "8") (str.to_re "6") (str.to_re "2") (str.to_re "6") (str.to_re "4") (str.to_re ".")))))))
(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert (= T_6 (not T_5)))
(assert T_6)

; --- START CONSTRAINT ---
; str_split interface declarations

; New helper variables
(declare-fun delim_utmv () String)

; Use split constraints consistent with the existing suffix "__utmv=16886264."
(assert (= delim_utmv "__utmv="))
(assert (>= (str.num_splits T1_5 delim_utmv) 2))
(assert (= (str.split_at T1_5 delim_utmv 0) T2_5))
(assert (= (str.split_rest T1_5 delim_utmv 1) T3_5))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
