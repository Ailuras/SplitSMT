(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (str.to_re "$") (re.* (str.to_re "y"))))))
(assert (str.in_re y (re.* (re.++ (re.* (str.to_re "y")) (str.to_re "$")))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "$"))
(assert (>= (str.num_splits x delimiter) 1))
(assert (>= (str.num_splits y delimiter) 1))
(assert (= (str.split_at x delimiter 0) (str.split_at y delimiter 0)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
