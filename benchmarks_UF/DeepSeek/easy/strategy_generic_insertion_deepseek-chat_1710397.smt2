(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun s () String)
(declare-fun in0 () String)
(declare-fun in1 () String)
(assert (and (and (not (not (= (ite (<= (+ (- (str.len s) (* (str.len in0) 2)) 1) 0) 1 0) 0))) (not (= (ite (= in0 in1) 1 0) 0))) (not (= (ite (= in0 in1) 1 0) 0))))

; --- START CONSTRAINT ---
(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun seg2 () String)
(assert (= seg0 (split_at s in0 0)))
(assert (= seg1 (split_at s in0 1)))
(assert (= seg2 (split_rest s in0 2)))
(assert (>= (num_splits s in0) 3))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
