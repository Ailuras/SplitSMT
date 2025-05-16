(set-logic ALL)

(declare-const x String)
(declare-const y String)

; Uninterpreted functions with different return types
(declare-fun boolFunc (String) Bool)
(declare-fun intFunc (String) Int)
(declare-fun stringFunc (String String) String)

; Test boolean atoms with uninterpreted functions
(assert (boolFunc x))

; Test arithmetic terms with uninterpreted functions
(assert (= (intFunc x) 5))

; Test string operations with uninterpreted functions
(assert (= (stringFunc x y) "result"))

(check-sat) 