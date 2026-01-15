(set-logic ALL)
(declare-fun I0_2 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_2 () String)
(declare-fun T1_2 () String)
(declare-fun T2_2 () String)
(declare-fun T3_2 () String)
(declare-fun T4_2 () String)
(declare-fun T5_2 () String)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun var_0xINPUT_179806 () String)
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1 (and (= PCTEMP_LHS_1 (+ I0_2 0)) (= var_0xINPUT_179806 (str.++ T0_2 T1_2)) (= I0_2 (str.len T4_2)) (= 0 (str.len T0_2)) (= T1_2 (str.++ T2_2 T3_2)) (= T2_2 (str.++ T4_2 T5_2)) (= T5_2 "ptrackp=") (not (str.in_re T4_2 (re.++ (str.to_re "p") (str.to_re "t") (str.to_re "r") (str.to_re "a") (str.to_re "c") (str.to_re "k") (str.to_re "p") (str.to_re "="))))) (and (= PCTEMP_LHS_1 (- 1)) (= var_0xINPUT_179806 (str.++ T0_2 T1_2)) (= 0 (str.len T0_2)) (not (str.in_re T1_2 (re.++ (str.to_re "p") (str.to_re "t") (str.to_re "r") (str.to_re "a") (str.to_re "c") (str.to_re "k") (str.to_re "p") (str.to_re "=")))))))
(assert (= T_2 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (= T_3 (not T_2)))
(assert T_3)

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-fun delimiter () String)
(declare-fun segment0 () String)
(declare-fun segment1 () String)
(declare-fun total_segments () Int)
; Assert constraints using str_split operations
(assert (= delimiter "ptrackp="))
(assert (= segment0 (str.split_at var_0xINPUT_179806 delimiter 0)))
(assert (= segment1 (str.split_at var_0xINPUT_179806 delimiter 1)))
(assert (= total_segments (str.num_splits var_0xINPUT_179806 delimiter)))
(assert (>= total_segments 2))
(assert (str.contains var_0xINPUT_179806 delimiter))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
