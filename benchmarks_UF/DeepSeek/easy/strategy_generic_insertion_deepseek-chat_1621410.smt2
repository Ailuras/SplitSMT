(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.+ (re.union (str.to_re "b") (re.* (str.to_re "a["))))))
(assert (str.in_re y (re.+ (re.++ (str.to_re "b") (re.* (str.to_re "yK7"))))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const delimiter String)
(assert (= delimiter ","))
(assert (>= (num_splits x delimiter) 3))
(assert (str.contains (split_at x delimiter 1) "a"))
(assert (str.contains (split_at y delimiter 0) "b"))
(assert (>= (str.len (split_rest y delimiter 2)) 5))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
