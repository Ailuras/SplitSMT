(set-logic ALL)

(declare-const sentence String)
(assert (= sentence "a b c"))

; Assert out of bounds check matches "d" (likely UNSAT in semantics)
(assert (= (str.split_at sentence " " 3) "d"))

(check-sat)
(exit)
