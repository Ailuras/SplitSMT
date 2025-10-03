(set-logic QF_S)
(declare-const x String)
(declare-const y String)
(declare-const z String)

(assert (= x "hello,world;test:example"))
(assert (= y (str.split_rest x "," 1)))
(assert (= z (str.split_rest x ";" 1)))

(check-sat)
(get-model) 