(set-logic ALL)

(declare-const x String)
(declare-const y String)

; Uninterpreted functions with different return types
(declare-fun boolFunc (String) Bool)
(declare-fun intFunc (String) Int)
(declare-fun stringFunc (String String) String)

; Test arithmetic terms with uninterpreted functions
(assert (= (intFunc x) 5))
(assert (>= (intFunc y) 0))

; Test string operations with uninterpreted functions
(assert (>= (str.len (stringFunc x y)) 3))
(assert (str.contains (stringFunc x y) "test"))

; Test boolean atoms with uninterpreted functions
(assert (boolFunc x))
(assert (or (boolFunc x) (boolFunc y)))

; Combined expressions
(assert (and (boolFunc x) (= (intFunc x) (str.len (stringFunc x y)))))

(check-sat) 