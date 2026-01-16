(set-logic ALL)

(declare-const line String)
(assert (= line "Alice,25,Engineer"))

; Check fields
(assert (= (str.num_splits line ",") 3))
(assert (= (str.split_at line "," 0) "Alice"))
(assert (= (str.split_at line "," 1) "25"))
(assert (= (str.split_at line "," 2) "Engineer"))

(check-sat)
(exit)
