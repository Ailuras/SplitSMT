(set-logic QF_S)
(declare-const s String)
(assert (= s (str.replace "hello world" "world" "SMT")))
(assert (= s (str.replace "hello world" "world" "SMT"))) => (assert (= s (str.replace "hello world" "world" "SMT")))

(check-sat)