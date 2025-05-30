(set-logic QF_S)

(declare-const s String)

(assert (= (str.len s) 5))
(assert (= s (str.split_at "hello world" " " 0)))

(check-sat)
(get-model) 