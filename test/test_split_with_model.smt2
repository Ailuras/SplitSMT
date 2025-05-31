(set-logic QF_S)
(declare-const x String)

(assert (= (str.split_at x "," 0) "hello"))
(assert (= (str.split_at x "," 1) "world"))

(check-sat)
(get-model) 