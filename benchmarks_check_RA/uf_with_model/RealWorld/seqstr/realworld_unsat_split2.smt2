(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

(declare-const s String)
(assert (= s "a:b:c"))

; Assert contradiction mimicking original: parts are NOT correct
(assert (not (and 
    (= (num_splits s ":") 3)
    (= (split_at s ":" 0) "a")
    (= (split_at s ":" 1) "b")
    (= (split_at s ":" 2) "c")
)))

(check-sat)
(get-model)
(exit)
