(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.+ (re.union (str.to_re "b") (re.* (str.to_re "a["))))))
(assert (str.in_re y (re.+ (re.++ (str.to_re "b") (re.* (str.to_re "yK7"))))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ","))
(assert (>= (str.num_splits x delimiter) 3))
(assert (str.contains (str.split_at x delimiter 1) "a"))
(assert (str.contains (str.split_at y delimiter 0) "b"))
(assert (>= (str.len (str.split_rest y delimiter 2)) 5))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
