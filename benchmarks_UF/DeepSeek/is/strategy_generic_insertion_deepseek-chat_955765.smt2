(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (str.to_re "'\r'["))))
(assert (str.in_re y (re.* (str.to_re "'\r'["))))
(assert (= (str.len x) 2))
(assert (= (str.len y) 4))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "'
'["))
(assert (>= (num_splits x delimiter) 1))
(assert (>= (num_splits y delimiter) 2))
(assert (= (split_at x delimiter 0) x))
(assert (= (split_at y delimiter 1) (str.substr y 2 2)))
(assert (= (split_rest y delimiter 2) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
