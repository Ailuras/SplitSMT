;=========================
;  Debug test
;=========================
(set-logic ALL)

(declare-const s1 String)

(define-fun dash () String "-")

(declare-fun numSplits (String String) Int)

; 这一行应该会产生错误
(assert (= (numSplits s1 (dash)) 2))

(check-sat)
(get-model) 