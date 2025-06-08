(set-logic ALL)
(declare-fun x () String)
(declare-fun y () String)
(declare-fun z () String)

(assert (= x (str.split_at y "," 0)))
(assert (= z (str.split_at y "," 1)))
(assert (= (str.split_at y "," 2) "world"))
(assert (= (str.len x) 5))
(assert (= y "hello,world,test"))

(check-sat)
(get-model)