(set-logic QF_S)
(declare-const x String)
(declare-const y String)

(assert (= x "hello,world;test:example"))
(assert (= y (str.split_at x "," 0)))

(check-sat)
(get-model) 