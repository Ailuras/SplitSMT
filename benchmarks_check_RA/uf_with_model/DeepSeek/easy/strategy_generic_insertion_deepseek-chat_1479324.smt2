(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const x String)
(declare-const y String)
(assert (str.in_re (str.++ y x) (re.+ (str.to_re "!!$$bbaa"))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "!!"))
(assert (>= (num_splits (str.++ y x) delimiter) 3))
(assert (= (split_at (str.++ y x) delimiter 0) "aa"))
(assert (= (split_at (str.++ y x) delimiter 1) "bb"))
(assert (= (split_rest (str.++ y x) delimiter 2) "$$"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
