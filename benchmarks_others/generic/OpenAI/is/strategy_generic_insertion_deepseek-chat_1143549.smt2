(set-logic ALL)
(declare-fun x () String)
(declare-fun y () String)
(assert (not (= (str.contains (str.replace x y x) y) (str.contains x y))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun delim () String)
(declare-fun seg0 () String)
(declare-fun seg1 () String)

(assert (= delim y))
(assert (= seg0 (split_at x delim 0)))
(assert (= seg1 (split_at x delim 1)))
(assert (>= (num_splits x delim) 2))
(assert (= x (str.++ seg0 delim (split_rest x delim 1))))
(assert (or (= seg0 "") (= seg1 "") (not (str.contains seg0 delim))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
