(set-logic QF_S)
(declare-const s String)

(assert (>= (str.num_splits s ",") 2))
(assert (= (str.split_at s "," 0) "hello"))
(assert (= (str.split_at s "," 1) "world"))

(check-sat) 