(set-logic QF_S)
(declare-const w String)

(assert (>= (str.num_splits w ";") 1))
(assert (<= (str.num_splits w ";") 3))
(assert (= (str.split_at w ";" 0) "hello"))
(assert (= (str.split_at w ";" 1) "world"))
(assert (= (str.split_at w ";" 2) "test"))
(assert (not (= w "hello;world;test")))

(check-sat) 