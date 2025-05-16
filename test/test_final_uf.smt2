(set-logic ALL)

(declare-const s1 String)
(declare-const s2 String)

(define-fun dash () String "-")

(declare-fun numSplits (String String) Int)
(declare-fun splitAt (String String Int) String)

(assert (= (numSplits s1 dash) 2))
(assert (= (numSplits s2 dash) 2))

(assert (= (str.indexof (splitAt s1 dash 0) dash 0) -1))
(assert (= (str.indexof (splitAt s1 dash 1) dash 0) -1))

(check-sat) 