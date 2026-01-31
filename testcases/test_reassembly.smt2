(set-logic QF_SLIA)
(declare-fun x () String)
(declare-fun d () String)
(assert (= d ","))
(assert (= x "part1,part2"))
; Reassembling the string from its split parts
(assert (= x (str.++ (str.split_at x d 0) d (str.split_rest x d 0))))
(check-sat)