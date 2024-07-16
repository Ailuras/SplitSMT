(set-logic QF_S)

(declare-fun x () String)
(declare-fun y () String)
(declare-fun z () String)

(assert (str.in_re
    x
    (re.++
        (re.* (str.to_re "a"))
        (str.to_re "b")
    )
))
(assert (not (str.in_re
    x
    (re.++
        (re.* (str.to_re "a"))
        (str.to_re "b")
        (re.* (str.to_re "b"))
    )
)))
(assert (not (str.in_re
    x
    (let ((_let_1 (str.to_re "b")))
        (re.++
            (re.* (str.to_re "a"))
            _let_1
            (re.* _let_1)
        )
    )
)))

(check-sat)
(get-model)
