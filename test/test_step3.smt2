;=========================
;  Step 3 test
;=========================
(set-logic ALL)

(declare-const s1 String)
(declare-const s2 String)

(define-fun dash () String "-")

(define-fun numSplits ((s String) (sep String)) Int 1)

(assert (= (numSplits s1 (dash)) 2))

(check-sat)
(get-model) 