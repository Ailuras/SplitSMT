(set-logic QF_S)
(declare-const x String)
(declare-const y String)

(assert (= x "hello,world"))
(assert (= y (str.split_rest x "," 0)))

(check-sat)
(get-model) 