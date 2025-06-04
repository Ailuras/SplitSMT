(set-logic QF_SLIA)
(set-info :status sat)

(declare-const x String)
(declare-const y String)

(assert (= (str.num_splits x ",") 4))
(assert (= (str.split_at x "," 1) y))

(check-sat)