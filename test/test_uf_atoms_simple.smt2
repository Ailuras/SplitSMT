(set-logic ALL)

(declare-const x String)
(declare-const y String)

; Boolean uninterpreted functions (should be atoms)
(declare-fun isValid (String) Bool)
(declare-fun hasProperty (String String) Bool)

; Non-boolean uninterpreted function
(declare-fun computeLength (String) Int)

; Test assertions
(assert (isValid x))
(assert (hasProperty x y))
(assert (= (computeLength x) 5))

(check-sat) 