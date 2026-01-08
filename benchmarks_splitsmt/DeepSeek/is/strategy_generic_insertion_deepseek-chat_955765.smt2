(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (str.to_re "'\r'["))))
(assert (str.in_re y (re.* (str.to_re "'\r'["))))
(assert (= (str.len x) 2))
(assert (= (str.len y) 4))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "'
'["))
(assert (>= (str.num_splits x delimiter) 1))
(assert (>= (str.num_splits y delimiter) 2))
(assert (= (str.split_at x delimiter 0) x))
(assert (= (str.split_at y delimiter 1) (str.substr y 2 2)))
(assert (= (str.split_rest y delimiter 2) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
