(set-logic QF_S)
(set-info :status sat)

(declare-const x String)
(declare-const y String)
(declare-const z Int)

(assert (= (str.split_at "apple,banana,cherry" "," 1) "banana"))
(assert (= (str.split_at "apple,banana,cherry" "," 2) "cherry"))
; (assert (= (str.split_at "apple,banana,cherry" "," 3) "no_such_index"))
(assert (= z (str.num_splits "apple,banana,cherry" ",")))

; (assert (= (str.len (str.split_at "hello world" " " 0)) 5))
; (assert (= x (str.split_at "foo:bar:baz" ":" 2)))

(check-sat)
(get-model)