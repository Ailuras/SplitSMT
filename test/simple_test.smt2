(set-logic ALL)
(declare-fun x () String)
(assert (= (str.split_at_re "hello" (re.union (str.to_re "l") (str.to_re "ll")) 0) x))
(check-sat)