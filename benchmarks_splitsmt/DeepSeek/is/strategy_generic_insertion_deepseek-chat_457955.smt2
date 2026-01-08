(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (str.to_re "%%XX3311xxMMHHQQss%%jj"))))
(assert (str.in_re y (re.+ (re.+ (str.to_re "--!!tt''\\\\xx00cc''yy//nnQQ??qqvv<<??((VV,,11rree**TTtthh")))))
(assert (= (str.len x) 4))
(assert (= (str.to_int y) 14))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "%%"))
(assert (>= (str.num_splits x delimiter) 2))
(assert (= (str.split_at x delimiter 0) "XX3311xxMMHHQQss"))
(assert (= (str.split_rest x delimiter 1) "jj"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
