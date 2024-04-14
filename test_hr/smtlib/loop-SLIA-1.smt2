(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

(declare-fun x () String)

(assert (str.in_re x (re.++ (str.to_re "a") (re.* (str.to_re "a")) )))
; (assert (str.in_re x  (re.* (str.to_re "a")) ))
; (assert (str.in_re x (re.++ (str.to_re "a") (re.union (str.to_re "a") (str.to_re "b")) )))
(assert (not (str.in_re x (re.* (re.union (str.to_re "a") (str.to_re "b")) ) )))
; (assert (not (str.in_re x (re.++ (re.* (str.to_re "a")) (str.to_re "b") (re.* (str.to_re "b"))))))
; (assert (str.in_re x (str.to_re "b")))
; (assert (not (str.in_re x (re.++ (re.* (str.to_re "a")) (re.* (str.to_re "b"))))))
(check-sat)
(exit)

; Done