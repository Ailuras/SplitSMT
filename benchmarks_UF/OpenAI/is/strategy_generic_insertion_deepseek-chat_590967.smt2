(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun s () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (= (ite (>= (- (- (str.len s) 1) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 0) 1 0) 0))) (not (not (= (ite (<= (- (- (str.len s) 1) 1) 2) 1 0) 0)))) (not (not (= (ite (< (- (- (str.len s) 1) 1) 0) 1 0) 0)))) (not (not (= (ite (<= (str.len s) 2) 1 0) 0)))) (not (not (= (ite (= (str.at s 2) (str.at s (- (- (str.len s) 1) 1))) 1 0) 0)))) (not (= (ite (>= (- (- (str.len s) 1) 1) 2) 1 0) 0))) (not (= (ite (>= (- (- (str.len s) 1) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 2) 1 0) 0))) (not (= (ite (= (str.at s 1) (str.at s (- (str.len s) 1))) 1 0) 0))) (not (= (ite (>= (- (str.len s) 1) 1) 1 0) 0))) (not (= (ite (>= (- (str.len s) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 1) 1 0) 0))) (not (not (= (ite (<= (- (str.len s) 1) 0) 1 0) 0)))) (not (not (= (ite (< (- (str.len s) 1) 0) 1 0) 0)))) (not (not (= (ite (<= (str.len s) 0) 1 0) 0)))) (not (not (= (ite (= (str.at s 0) (str.at s (- (str.len s) 1))) 1 0) 0)))) (not (= (ite (>= (- (str.len s) 1) 0) 1 0) 0))) (not (= (ite (>= (- (str.len s) 1) 0) 1 0) 0))) (not (= (ite (> (str.len s) 0) 1 0) 0))))

; --- START CONSTRAINT ---
; str_split interface declarations

; helper variables
(declare-fun delim () String)
(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

; constraints using the interface
(assert (= delim "a"))
(assert (>= (num_splits s delim) 2))
(assert (= seg0 (split_at s delim 0)))
(assert (= seg1 (split_at s delim 1)))
(assert (= rest1 (split_rest s delim 1)))
(assert (= s (str.++ seg0 delim rest1)))
(assert (= rest1 (str.++ seg1 delim (split_rest s delim 2))))
(assert (>= (str.len seg0) 0))
(assert (>= (str.len seg1) 0))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
