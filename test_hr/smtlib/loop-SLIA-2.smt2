(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

(declare-fun var_4 () String)

; a+var_4 in a*b* should be simplified to var_4 in a*b*, membership check is used for it but only for re, not for re.not

; (assert (str.in_re
;     var_4
;     (re.++
;         (re.* (str.to_re "a"))
;         (re.* (str.to_re "b"))
;     )
; ))
; (assert (not (str.in_re
;     (str.++ "a" var_4 )
;     (re.++
;         (re.* (str.to_re "a"))
;         (re.* (str.to_re "b"))
;     )
; )))

(assert (not (str.in_re
    var_4
    (re.++
        (re.* (str.to_re "a"))
        (re.* (str.to_re "b"))
    )
)))
(assert (str.in_re
    (str.++ "a" var_4 )
    (re.++
        (re.* (str.to_re "a"))
        (re.* (str.to_re "b"))
    )
))

(check-sat)
(exit)

; Done