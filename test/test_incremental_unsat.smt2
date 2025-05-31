(set-logic QF_S)
(declare-const x String)

(assert (>= (str.num_splits x ";") 1))
(assert (<= (str.num_splits x ";") 4))
(assert (= (str.split_at x ";" 0) "hello"))
(assert (= (str.split_at x ";" 1) "world"))
(assert (= (str.split_at x ";" 2) "test"))
(assert (= (str.split_at x ";" 3) "extra"))
(assert (not (= x "hello;world;test")))

(check-sat) 