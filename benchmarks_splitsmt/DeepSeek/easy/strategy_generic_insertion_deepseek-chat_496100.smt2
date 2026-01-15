(set-logic ALL)
(declare-fun s () String)
(declare-fun t () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (= (str.at s 2) (str.at t (+ 2 (- (str.len t) (str.len s))))) 1 0) 0)))) (not (= (ite (> (str.len s) 2) 1 0) 0))) (not (not (= (ite (= (- (str.len t) (str.len s)) 0) 1 0) 0)))) (not (not (= (ite (= (str.len s) 2) 1 0) 0)))) (not (not (= (ite (= (str.at s 2) (str.at t 2)) 1 0) 0)))) (not (= (ite (> (str.len s) 2) 1 0) 0))) (not (= (ite (= (str.at s 1) (str.at t 1)) 1 0) 0))) (not (= (ite (> (str.len s) 1) 1 0) 0))) (not (= (ite (= (str.at s 0) (str.at t 0)) 1 0) 0))) (not (= (ite (> (str.len s) 0) 1 0) 0))) (not (not (= (ite (> (- (str.len t) (str.len s)) 1) 1 0) 0)))) (not (not (= (ite (> (str.len s) (str.len t)) 1 0) 0)))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= segment0 (str.split_at s delimiter 0)))
(assert (= segment1 (str.split_at s delimiter 1)))
(assert (= total_segments (str.num_splits s delimiter)))
(assert (>= total_segments 2))
(assert (str.contains s delimiter))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
