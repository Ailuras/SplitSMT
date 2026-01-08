(set-logic ALL)
(declare-fun x () String)
(assert (not (= (str.contains (str.substr x 1 0) x) (= x ""))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-fun d () String)
(assert (= d ""))
(assert (>= (num_splits x d) 1))
(assert (= (split_at x d 0) x))
(assert (= (split_rest x d 0) x))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]