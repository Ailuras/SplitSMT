(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

(declare-const sentence String)
(assert (= sentence "a b c"))

; Assert out of bounds check matches "d" (likely UNSAT in semantics)
(assert (= (split_at sentence " " 3) "d"))

(check-sat)
(exit)
