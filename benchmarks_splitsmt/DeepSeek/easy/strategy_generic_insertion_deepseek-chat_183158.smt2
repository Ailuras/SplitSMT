(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.* (re.++ (re.* (str.to_re "]")) (str.to_re "")))))
(assert (= (str.len x) 0))
(assert (not (= x "]]1' 'zz")))
(assert (not (= x "GhGGhG3a'\t'")))
(assert (not (= x "]'\r'*")))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (>= (str.num_splits x delimiter) 1))
(assert (= (str.split_at x delimiter 0) "example"))
(assert (str.contains (str.split_rest x delimiter 1) "data"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
