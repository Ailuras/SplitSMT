(set-logic ALL)

(declare-const x String)
(declare-fun f (String) Int)

(assert (= (f x) 5))

(check-sat) 