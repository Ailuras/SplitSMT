(set-logic QF_SLIA)
(declare-fun input () String)
(declare-fun temp () String)

(assert (not (= (str.num_splits input "/") 1)))
(assert (= (str.split_at input "/" 1) temp))
(assert (= (str.num_splits temp ":") 2))

(check-sat)
(get-model)
(exit)