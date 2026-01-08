(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (str.to_re "b") (re.* (str.to_re "a"))))))
(assert (str.in_re y (re.* (re.++ (str.to_re "b") (str.to_re "a")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
(declare-const delim String)
(assert (= delim "a"))
(assert (>= (num_splits x delim) 1))
(assert (>= (num_splits y delim) 1))
(assert (= (split_at x delim 0) "b"))
(assert (= (split_at y delim 0) "b"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
