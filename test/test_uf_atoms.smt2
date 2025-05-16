(set-logic ALL)

(declare-const x String)
(declare-const y String)

; Uninterpreted functions with different return types
(declare-fun isValid (String) Bool)
(declare-fun hasProperty (String String) Bool)
(declare-fun computeLength (String) Int)

; Test assertions with uninterpreted functions
(assert (isValid x))
(assert (hasProperty x y))
(assert (= (computeLength x) 5))

; Combined with other atoms
(assert (and (isValid x) (>= (str.len x) 3)))
(assert (or (hasProperty x y) (str.contains x "test")))

(check-sat) 