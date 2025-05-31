(set-logic QF_S)
(declare-const w String)

(assert (= (str.num_splits w ";") 3))
(assert (= (str.split_at w ";" 0) "a"))
(assert (= (str.split_at w ";" 1) "b"))
(assert (= (str.split_at w ";" 2) "c"))
(assert (= (str.split_at w ";" 3) "d"))

(check-sat) 