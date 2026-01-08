(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.* (re.union (str.to_re "Ll$H") (str.to_re "123")))))
(assert (= 5 (str.len x)))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "Ll$H"))
(assert (>= (str.num_splits x delimiter) 1))
(assert (= (str.split_at x delimiter 0) x))
(assert (= (str.len (str.split_rest x delimiter 0)) (str.len x)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
