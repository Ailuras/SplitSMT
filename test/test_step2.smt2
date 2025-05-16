;=========================
;  Step 2 test
;=========================
(set-logic ALL)

(declare-const s1 String)
(declare-const s2 String)

(define-fun dash () String "-")

(declare-fun numSplits (String String) Int)
(declare-fun splitAt   (String String Int) String)

(assert (= (numSplits s1 (dash)) 2))

(check-sat)
(get-model) 