(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun var_0xINPUT_79104 () String)
(assert (= T_1 (not (= "labpixiesdata.appspot.com" var_0xINPUT_79104))))
(assert (= T_2 (not T_1)))
(assert T_2)

; --- START CONSTRAINT ---

(assert (= (num_splits var_0xINPUT_79104 ".") 4))
(assert (= (split_at var_0xINPUT_79104 "." 0) "labpixiesdata"))
(assert (= (split_at var_0xINPUT_79104 "." 1) "appspot"))
(assert (= (split_at var_0xINPUT_79104 "." 2) "com"))
(assert (= (split_at var_0xINPUT_79104 "." 3) ""))
(assert (= (split_rest var_0xINPUT_79104 "." 1) "appspot.com."))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
