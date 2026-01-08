(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const x String)
(assert (not (str.in_re x (str.to_re "zzooBB"))))
(assert (= x "zzooBB"))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "o"))
(assert (>= (num_splits x delimiter) 1))
(assert (= (split_at x delimiter 0) "zz"))
(assert (= (split_rest x delimiter 1) "BB"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
