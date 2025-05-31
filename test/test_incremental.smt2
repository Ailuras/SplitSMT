(set-logic QF_S)
(declare-const x String)

(assert (>= (str.num_splits x ";") 2))
(assert (= (str.split_at x ";" 0) "hello"))
(assert (= (str.split_at x ";" 1) "world"))
(assert (= (str.split_at x ";" 2) "test"))

(check-sat) 