(set-logic ALL)
(declare-fun x () String)
(assert (not (= (str.contains (str.substr x 1 0) x) (= x ""))))

; --- START CONSTRAINT ---
(declare-fun d () String)
(declare-fun k () Int)
(assert (>= (str.len d) 1))
(assert (>= k 0))
(assert (< k (str.num_splits x d)))
(assert (= x (str.++ (str.split_at x d 0) d (str.split_rest x d 1))))
(assert (= (str.split_rest x d k) (str.++ (str.split_at x d k) (str.split_rest x d (+ k 1)))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
