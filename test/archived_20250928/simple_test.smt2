(set-logic ALL)
(declare-fun x () String)
(assert (= (str.split_at "hello" "l" 0) x))
(check-sat)
