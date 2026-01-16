(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const x String)
(assert (str.in_re x (re.* (re.++ (str.to_re "O") (re.* (str.to_re "?"))))))
(assert (= (str.len x) 3))
(assert (not (= x "?OO")))
(assert (not (= x "??O")))
(assert (not (= x "?O?")))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "O"))
(assert (>= (num_splits x delimiter) 1))
(assert (= (split_at x delimiter 0) "?"))
(assert (= (split_rest x delimiter 1) "??"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
