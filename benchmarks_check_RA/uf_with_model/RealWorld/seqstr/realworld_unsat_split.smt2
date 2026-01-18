(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

(declare-const s String)
(assert (= s "x,y,z"))

; Assert contradiction: parts are NOT properly split
(assert (not (and 
    (= (num_splits s ",") 3)
    (= (split_at s "," 0) "x")
    (= (split_at s "," 1) "y")
    (= (split_at s "," 2) "z")
)))

(check-sat)
(get-model)
(exit)
