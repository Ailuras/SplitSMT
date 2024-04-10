(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

(declare-fun var_4 () String)

(assert (str.in_re var_4 (re.++ (re.* (str.to_re "a")) (str.to_re "b"))))
(assert (not (str.in_re var_4 (re.++ (re.* (str.to_re "a")) (str.to_re "b") (re.* (str.to_re "b"))))))
(check-sat)
(exit)
