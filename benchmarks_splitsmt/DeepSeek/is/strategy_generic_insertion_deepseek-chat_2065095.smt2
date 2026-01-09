(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.+ (re.union (re.* (str.to_re "")) (str.to_re "t")))))
(assert (= (str.len x) 6))
(assert (not (= x "#,?a")))
(assert (not (= x "a.k*b")))
(assert (not (= x "B5'' ''b")))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ","))
(assert (>= (str.num_splits x delimiter) 2))
(assert (= (str.split_at x delimiter 0) "a"))
(assert (= (str.split_rest x delimiter 1) "bc"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
