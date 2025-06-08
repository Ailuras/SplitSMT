(set-logic QF_S)
(declare-fun x () String)

(assert (= (str.split_at x "-" 0) "hello"))
(assert (str.prefixof (str.split_at x "-" 2) "w"))

(check-sat)
(get-model)