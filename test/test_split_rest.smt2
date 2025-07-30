(set-logic QF_S)
(declare-const x String)
(declare-const y String)

(assert (= x "hello,world;test,end"))
(assert (= y (str.split_at_re x (re.union (str.to_re ",") (str.to_re ";")) 1)))

(check-sat)
(get-model)