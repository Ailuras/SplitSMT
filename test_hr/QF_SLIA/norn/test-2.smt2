(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

(declare-fun var_3 () String)
(declare-fun var_4 () String)

(assert (str.in_re var_3 (re.* (re.range "a" "c"))))
(assert (not (str.in_re var_3 (re.* (re.union (re.union (str.to_re "a") (str.to_re "b")) (str.to_re "c"))))))
; (assert (<= 0  (str.len var_3)))
(check-sat)
(exit)
