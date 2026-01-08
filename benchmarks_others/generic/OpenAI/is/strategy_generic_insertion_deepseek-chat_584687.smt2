(set-logic ALL)
(declare-fun x () String)
(declare-fun y () String)
(assert (not (= (str.replace (str.replace "" x y) "A" "") (str.replace "" x (str.replace y "A" x)))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun delim () String)
(declare-fun k () Int)

(assert (= delim "A"))
(assert (>= k 0))
(assert (<= k (num_splits y delim)))
(assert (>= (num_splits y delim) 1))
(assert (= (split_rest y delim k) (str.++ (split_at y delim k) (split_rest y delim (+ k 1)))))
(assert (= (split_at x delim 0) (str.replace x "A" "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
