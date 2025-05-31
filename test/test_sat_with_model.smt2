(set-logic QF_S)
(declare-const s String)
(declare-const t String)

(assert (str.contains s "hello"))
(assert (str.contains t "world"))

(check-sat)
(get-model) 