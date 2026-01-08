(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (str.to_re "%%XX3311xxMMHHQQss%%jj"))))
(assert (str.in_re y (re.+ (re.+ (str.to_re "--!!tt''\\\\xx00cc''yy//nnQQ??qqvv<<??((VV,,11rree**TTtthh")))))
(assert (= (str.len x) 4))
(assert (= (str.to_int y) 14))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const delimiter String)
(assert (= delimiter "%%"))
(assert (>= (num_splits x delimiter) 2))
(assert (= (split_at x delimiter 0) "XX3311xxMMHHQQss"))
(assert (= (split_rest x delimiter 1) "jj"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
