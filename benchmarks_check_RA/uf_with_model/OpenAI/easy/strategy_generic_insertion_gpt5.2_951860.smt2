(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun s () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (>= (- (- (- (- (- (str.len s) 1) 1) 1) 1) 1) 4) 1 0) 0)))) (not (= (ite (>= (- (- (- (- (- (str.len s) 1) 1) 1) 1) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 4) 1 0) 0))) (not (= (ite (= (str.at s 3) (str.at s (- (- (- (- (str.len s) 1) 1) 1) 1))) 1 0) 0))) (not (= (ite (>= (- (- (- (- (str.len s) 1) 1) 1) 1) 3) 1 0) 0))) (not (= (ite (>= (- (- (- (- (str.len s) 1) 1) 1) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 3) 1 0) 0))) (not (= (ite (= (str.at s 2) (str.at s (- (- (- (str.len s) 1) 1) 1))) 1 0) 0))) (not (= (ite (>= (- (- (- (str.len s) 1) 1) 1) 2) 1 0) 0))) (not (= (ite (>= (- (- (- (str.len s) 1) 1) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 2) 1 0) 0))) (not (= (ite (= (str.at s 1) (str.at s (- (- (str.len s) 1) 1))) 1 0) 0))) (not (= (ite (>= (- (- (str.len s) 1) 1) 1) 1 0) 0))) (not (= (ite (>= (- (- (str.len s) 1) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 1) 1 0) 0))) (not (= (ite (= (str.at s 0) (str.at s (- (str.len s) 1))) 1 0) 0))) (not (= (ite (>= (- (str.len s) 1) 0) 1 0) 0))) (not (= (ite (>= (- (str.len s) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 0) 1 0) 0))))

; --- START CONSTRAINT ---

(declare-fun delim () String)
(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

(assert (= delim "|"))
(assert (>= (num_splits s delim) 2))
(assert (= seg0 (split_at s delim 0)))
(assert (= seg1 (split_at s delim 1)))
(assert (= rest1 (split_rest s delim 1)))
(assert (= rest1 (str.++ seg1 delim (split_rest s delim 2))))
(assert (not (= seg0 "")))
(assert (not (= seg1 "")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
