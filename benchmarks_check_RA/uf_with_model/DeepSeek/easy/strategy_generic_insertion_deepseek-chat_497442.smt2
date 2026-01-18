(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (str.to_re "_") (re.* (str.to_re "^"))))))
(assert (str.in_re y (re.* (re.++ (str.to_re "_") (re.* (str.to_re "^"))))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "_"))
(assert (>= (num_splits x delimiter) 1))
(assert (>= (num_splits y delimiter) 1))
(assert (= (split_at x delimiter 0) (split_at y delimiter 0)))
(assert (str.contains (split_rest x delimiter 1) "^"))
(assert (str.contains (split_rest y delimiter 1) "^"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
