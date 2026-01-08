(set-logic ALL)
(declare-fun T1_3 () String)
(declare-fun T2_3 () String)
(declare-fun T_1 () String)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_36505 () String)
(assert (= T_1 (str.++ T1_3 T2_3)))
(assert (= T2_3 var_0xINPUT_36505))
(assert (= T1_3 ""))
(assert (= T_2 (= "" T_1)))
(assert T_2)

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun delim_empty () String)

(assert (= delim_empty ""))
; since T_1 is constrained to be "", splitting it by "" yields exactly one segment
(assert (= (num_splits T_1 delim_empty) 1))
(assert (= (split_at T_1 delim_empty 0) ""))
(assert (= (split_rest T_1 delim_empty 0) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
