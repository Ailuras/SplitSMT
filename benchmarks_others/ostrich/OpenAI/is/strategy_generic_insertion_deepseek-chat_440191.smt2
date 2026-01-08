(set-logic ALL)
(declare-fun x () String)
(assert (not (= (str.contains (str.substr x 1 0) x) (= x ""))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
(declare-fun d () String)
(declare-fun k () Int)
(assert (>= (str.len d) 1))
(assert (>= k 0))
(assert (< k (num_splits x d)))
(assert (= x (str.++ (split_at x d 0) d (split_rest x d 1))))
(assert (= (split_rest x d k) (str.++ (split_at x d k) (split_rest x d (+ k 1)))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
