(set-logic QF_SLIA)
(declare-fun x () String)
; If length is less than 5, it's impossible to have more than 5 explicit splits with non-empty delimiter ";"
(assert (> (str.num_splits x ";") 5))
(assert (< (str.len x) 5))
(check-sat)
