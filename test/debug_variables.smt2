(set-logic ALL)

(declare-const var1 String)
(declare-const var2 String)
(define-const var811 Int 10)

(assert (= var1 "hello"))
(assert (= var2 "world"))

(check-sat) 