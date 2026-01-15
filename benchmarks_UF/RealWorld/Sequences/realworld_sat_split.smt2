(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

(declare-const input String)
(assert (= input "x:y:z"))

; Check split properties directly
(assert (= (num_splits input ":") 3))
(assert (= (split_at input ":" 0) "x"))
(assert (= (split_at input ":" 1) "y"))
(assert (= (split_at input ":" 2) "z"))

(check-sat)
(exit)
