(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

(declare-fun var_3 () String)
(declare-fun var_4 () String)

(assert (str.in_re (str.++ var_3 "z" var_4 ) (re.* (re.union (str.to_re "z") (re.union (re.union (str.to_re "a") (str.to_re "b")) (str.to_re "c"))))))
(assert (str.in_re var_4 (re.* (re.range "a" "u"))))
(assert (str.in_re var_3 (re.* (re.range "a" "u"))))
(assert (not (str.in_re var_3 (re.* (re.union (re.union (str.to_re "a") (str.to_re "b")) (str.to_re "c"))))))
(assert (<= 0  (str.len var_3)))
(check-sat)
(exit)
