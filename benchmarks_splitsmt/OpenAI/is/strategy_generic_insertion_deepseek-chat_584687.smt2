(set-logic ALL)
(declare-fun x () String)
(declare-fun y () String)
(assert (not (= (str.replace (str.replace "" x y) "A" "") (str.replace "" x (str.replace y "A" x)))))

; --- START CONSTRAINT ---

(declare-fun delim () String)
(declare-fun k () Int)

(assert (= delim "A"))
(assert (>= k 0))
(assert (<= k (str.num_splits y delim)))
(assert (>= (str.num_splits y delim) 1))
(assert (= (str.split_rest y delim k) (str.++ (str.split_at y delim k) (str.split_rest y delim (+ k 1)))))
(assert (= (str.split_at x delim 0) (str.replace x "A" "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
