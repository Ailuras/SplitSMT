(set-logic QF_SLIA)
(declare-fun x7 () String)

;; 约束: x7 not in "aa" + ["aaa"]*  + ["aaaaa"]* 
(assert (or (= (str.len x7) 1) (= (str.len x7) 4)))

(check-sat)
(get-model)
