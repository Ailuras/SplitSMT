(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.+ (re.++ (re.++ (str.to_re "23") (str.to_re "AB")) (str.to_re "4b![~oj'")))))
(assert (= (str.len x) 3))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const d String)

(assert (= d "A"))
(assert (>= (str.len x) 0))
(assert (>= (num_splits x d) 1))
(assert (>= (num_splits x d) 0))
(assert (>= (num_splits x d) 1))
(assert (= (split_at x d 0) (split_at x d 0)))
(assert (= (split_rest x d 0) (split_rest x d 0)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]