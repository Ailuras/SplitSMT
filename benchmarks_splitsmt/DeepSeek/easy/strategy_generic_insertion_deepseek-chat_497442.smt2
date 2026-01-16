(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (str.to_re "_") (re.* (str.to_re "^"))))))
(assert (str.in_re y (re.* (re.++ (str.to_re "_") (re.* (str.to_re "^"))))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "_"))
(assert (>= (str.num_splits x delimiter) 1))
(assert (>= (str.num_splits y delimiter) 1))
(assert (= (str.split_at x delimiter 0) (str.split_at y delimiter 0)))
(assert (str.contains (str.split_rest x delimiter 1) "^"))
(assert (str.contains (str.split_rest y delimiter 1) "^"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
