(set-logic ALL)
(declare-fun x () String)
(assert (let ((_let_0 (re.* re.allchar ))) (let ((_let_1 (str.++ "B" (str.++ "B" "A")))) (and (str.in_re x (re.++ _let_0 re.allchar  _let_0 (str.to_re (str.++ "B" (str.++ "A" (str.++ "B" "B")))) _let_0 re.allchar  _let_0)) (not (= (str.in_re x (re.++ _let_0 re.allchar  _let_0 (str.to_re (str.++ "A" _let_1)) _let_0 re.allchar  _let_0)) (str.in_re x (re.++ _let_0 re.allchar  _let_0 re.allchar  _let_0 (re.++ (str.to_re _let_1) re.allchar ) _let_0))))))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "A"))
(assert (>= (str.num_splits x delimiter) 1))
(assert (= (str.split_at x delimiter 0) "B"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
