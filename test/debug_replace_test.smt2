(set-logic ALL)
(declare-fun x () String)
(assert (= x (str.replace_re_all "hello" (re.* re.allchar) "world")))
(check-sat)
