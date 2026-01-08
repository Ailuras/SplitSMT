(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (str.to_re "b") (re.* (str.to_re "a"))))))
(assert (str.in_re y (re.* (re.++ (str.to_re "b") (str.to_re "a")))))

; --- START CONSTRAINT ---
(declare-const delim String)
(assert (= delim "a"))
(assert (>= (str.num_splits x delim) 1))
(assert (>= (str.num_splits y delim) 1))
(assert (= (str.split_at x delim 0) "b"))
(assert (= (str.split_at y delim 0) "b"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
