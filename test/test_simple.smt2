;=========================
;  Simple test
;=========================
(set-logic ALL)

(declare-const s1 String)
(declare-const s2 String)

(define-fun dash () String "-")

(assert (= s1 (dash)))

(check-sat)
(get-model) 