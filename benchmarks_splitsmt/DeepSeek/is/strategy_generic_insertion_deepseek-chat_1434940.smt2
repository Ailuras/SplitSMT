(set-logic ALL)
(declare-const x String)
(assert (not (str.in_re x (str.to_re "zzooBB"))))
(assert (= x "zzooBB"))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "o"))
(assert (>= (str.num_splits x delimiter) 1))
(assert (= (str.split_at x delimiter 0) "zz"))
(assert (= (str.split_rest x delimiter 1) "BB"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
