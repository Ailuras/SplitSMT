(set-logic ALL)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_79104 () String)
(assert (= T_1 (not (= "labpixiesdata.appspot.com" var_0xINPUT_79104))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(assert (= (str.num_splits var_0xINPUT_79104 ".") 4))
(assert (= (str.split_at var_0xINPUT_79104 "." 0) "labpixiesdata"))
(assert (= (str.split_at var_0xINPUT_79104 "." 1) "appspot"))
(assert (= (str.split_at var_0xINPUT_79104 "." 2) "com"))
(assert (= (str.split_at var_0xINPUT_79104 "." 3) ""))
(assert (= (str.split_rest var_0xINPUT_79104 "." 1) "appspot.com."))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
