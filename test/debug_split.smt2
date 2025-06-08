(set-logic QF_S)
(declare-fun x () String)

(assert (= (str.split_at x "," 0) "hello"))

(check-sat)
(exit) 