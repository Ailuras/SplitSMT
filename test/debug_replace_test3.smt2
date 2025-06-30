(set-logic ALL)
(declare-fun x () String)
(assert (= x (str.replace_all_re "hello" (re.* re.allchar) "world")))
(check-sat)
