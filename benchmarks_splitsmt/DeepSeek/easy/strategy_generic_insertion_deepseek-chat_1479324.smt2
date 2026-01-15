(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re (str.++ y x) (re.+ (str.to_re "!!$$bbaa"))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "!!"))
(assert (>= (str.num_splits (str.++ y x) delimiter) 3))
(assert (= (str.split_at (str.++ y x) delimiter 0) "aa"))
(assert (= (str.split_at (str.++ y x) delimiter 1) "bb"))
(assert (= (str.split_rest (str.++ y x) delimiter 2) "$$"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
