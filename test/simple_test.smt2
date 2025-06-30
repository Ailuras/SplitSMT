(set-logic ALL)
(declare-fun x () String)  
(assert (= x "hello"))
(check-sat)
