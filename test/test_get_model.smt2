(set-logic QF_S)
(declare-const s String)
(declare-const t String)

(assert (= (str.split_at s "," 0) "hello"))
(assert (= (str.split_at s "," 1) "world"))
(assert (= (str.split_at t ";" 0) "foo"))
(assert (= (str.split_at t ";" 1) "bar"))

(check-sat)
(get-model) 