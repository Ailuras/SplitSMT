(set-logic ALL)

(declare-const s String)
(assert (= s "a:b:c"))

; Assert contradiction mimicking original: parts are NOT correct
(assert (not (and 
    (= (str.num_splits s ":") 3)
    (= (str.split_at s ":" 0) "a")
    (= (str.split_at s ":" 1) "b")
    (= (str.split_at s ":" 2) "c")
)))

(check-sat)
(exit)
