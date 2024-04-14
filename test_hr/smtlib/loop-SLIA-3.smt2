(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

; can be solved by membership check

(declare-fun var_4 () String)

; (assert (str.in_re
;     (str.++ "a" var_4 )
;     (re.* (re.++
;         (str.to_re "a")
;         (str.to_re "a")
;     ))
; ))
(assert (str.in_re
    var_4
    (re.* (str.to_re "aa"))
))
(assert (not (str.in_re
    var_4
    (re.* (str.to_re "a"))
)))
(check-sat)

(exit)

; Done