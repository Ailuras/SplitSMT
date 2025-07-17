(set-logic ALL)
(declare-fun email_ () String)
(assert (= (str.num_splits email_ "@") 2))
(check-sat)