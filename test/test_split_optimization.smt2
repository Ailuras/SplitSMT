(set-logic ALL)
(declare-fun x () String)
(declare-fun y () String)
(declare-fun z () String)
(declare-fun w () String)

(assert (= x (str.split_at y "," 0)))
(assert (= z (str.split_at y "," 1)))
(assert (= w (str.split_at "hello,world" "," 0)))
(assert (= (str.len x) 5))
(assert (= y "test,data"))

(check-sat) 