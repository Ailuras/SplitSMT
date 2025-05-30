(set-logic QF_S)

(declare-const x String)

(assert (= x (str.split_at "hello world" " " 0)))

(check-sat) 