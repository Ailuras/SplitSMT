(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.+ (re.union (re.* (str.to_re "")) (str.to_re "t")))))
(assert (= (str.len x) 6))
(assert (not (= x "#,?a")))
(assert (not (= x "a.k*b")))
(assert (not (= x "B5'' ''b")))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const delimiter String)
(assert (= delimiter ","))
(assert (>= (num_splits x delimiter) 2))
(assert (= (split_at x delimiter 0) "a"))
(assert (= (split_rest x delimiter 1) "bc"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
