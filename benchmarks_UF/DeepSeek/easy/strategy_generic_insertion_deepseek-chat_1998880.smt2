(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun x () String)
(assert (let ((_let_0 (re.* re.allchar ))) (let ((_let_1 (str.++ "B" (str.++ "B" "A")))) (and (str.in_re x (re.++ _let_0 re.allchar  _let_0 (str.to_re (str.++ "B" (str.++ "A" (str.++ "B" "B")))) _let_0 re.allchar  _let_0)) (not (= (str.in_re x (re.++ _let_0 re.allchar  _let_0 (str.to_re (str.++ "A" _let_1)) _let_0 re.allchar  _let_0)) (str.in_re x (re.++ _let_0 re.allchar  _let_0 re.allchar  _let_0 (re.++ (str.to_re _let_1) re.allchar ) _let_0))))))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "A"))
(assert (>= (num_splits x delimiter) 1))
(assert (= (split_at x delimiter 0) "B"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
