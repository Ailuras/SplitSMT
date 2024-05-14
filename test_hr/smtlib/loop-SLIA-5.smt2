(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

(declare-fun var_4 () String)


; a+r4+ab not in a*bb* cannot deduce r4 not in a*, should change reason rules

; (assert (str.in_re
;     var_4
;     (re.++ (re.* (str.to_re "a")) (str.to_re "b"))
; ))
; (assert (not (str.in_re
;     var_4
;     (re.++ (re.* (str.to_re "a")) (str.to_re "b") (re.* (str.to_re "b")))
; )))

; Same as above, a+r4+a not in a*b* cannot deduce r4 not in a*, should change reason rules

(assert (str.in_re 
    var_4
    (re.* (str.to_re "a"))
))

(assert (not (str.in_re 
    (str.++ var_4 "ab")
    (re.++ (re.* (str.to_re "a")) (str.to_re "b") (re.* (str.to_re "b")))
)))

; this can be solved, because a+r4+a not in a*b* can deduce r4 not in a*

; (assert (str.in_re 
;     var_4
;     (re.* (str.to_re "a"))
; ))
; (assert (not (str.in_re 
;     var_4
;     (re.++ (re.* (str.to_re "a")) (re.* (str.to_re "b")))
; )))

; this can be solved, because r4 in a*b can deduce r4 in a*b*, lead to conflict

; (assert (str.in_re 
;     var_4
;     (re.++ (re.* (str.to_re "a")) (str.to_re "b"))
; ))
; (assert (not (str.in_re 
;     var_4
;     (re.++ (re.* (str.to_re "a")) (re.* (str.to_re "b")))
; )))

(check-sat)
(exit)
