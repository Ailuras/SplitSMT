(set-logic QF_UFLIA)

(declare-fun g (Int) Int)
(declare-fun x () Int)
(declare-fun y () Int)

(assert (> (g x) 0))
(assert (= (g y) 0))
(assert (< x y))
(assert (= (g x) (g y)))

(check-sat)