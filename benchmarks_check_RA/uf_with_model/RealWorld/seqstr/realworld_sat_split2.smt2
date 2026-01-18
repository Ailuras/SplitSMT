(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

(declare-const line String)
(assert (= line "Alice,25,Engineer"))

; Check fields
(assert (= (num_splits line ",") 3))
(assert (= (split_at line "," 0) "Alice"))
(assert (= (split_at line "," 1) "25"))
(assert (= (split_at line "," 2) "Engineer"))

(check-sat)
(get-model)
(exit)
