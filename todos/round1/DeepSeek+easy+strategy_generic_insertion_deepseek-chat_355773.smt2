(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (str.to_re "+*"))))
(assert (str.in_re y (re.* (str.to_re "+*"))))
(assert (= (str.len x) 2))
(assert (= (str.len y) 4))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "+"))
(assert (>= (str.num_splits x delimiter) 1))
(assert (>= (str.num_splits y delimiter) 2))
(assert (= (str.split_at x delimiter 0) (str.substr x 0 1)))
(assert (= (str.split_at y delimiter 1) (str.substr y 2 2)))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
