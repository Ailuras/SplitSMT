(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :status unknown)

(declare-fun var_4 () String)

(assert (str.in_re var_4 (re.* (re.union (str.to_re "a") (str.to_re "b")))))
(assert (not (str.in_re var_4 (re.* (re.union (str.to_re "z") (re.union (re.union (str.to_re "a") (str.to_re "b")) (str.to_re "c")))))))

(check-sat)
(exit)

; Done