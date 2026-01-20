(set-logic ALL)
(declare-const s String)
(assert (= s "x,y,z"))
; This should be UNSAT: contradicts the actual split
(assert (not (and 
    (= (str.num_splits s ",") 3)
    (= (str.split_at s "," 0) "x")
    (= (str.split_at s "," 1) "y")
    (= (str.split_at s "," 2) "z")
)))
(check-sat)
(exit)
