(set-logic ALL)
(declare-fun x () String)
(assert (not (= (str.contains (str.substr x 1 0) x) (= x ""))))

; --- START CONSTRAINT ---
(declare-fun d () String)
(assert (= d ""))
(assert (>= (str.num_splits x d) 1))
(assert (= (str.split_at x d 0) x))
(assert (= (str.split_rest x d 0) x))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
