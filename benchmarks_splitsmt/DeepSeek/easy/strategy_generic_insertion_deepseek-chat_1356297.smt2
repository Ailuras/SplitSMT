(set-logic ALL)
(declare-fun s2 () String)
(declare-fun s3 () String)
(declare-fun s1 () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (= (str.at s2 2) (str.at s3 2)) 1 0) 0)))) (not (= (ite (> (str.len s2) 2) 1 0) 0))) (not (= (ite (= (str.at s1 0) (str.at s3 2)) 1 0) 0))) (not (= (ite (> (str.len s1) 0) 1 0) 0))) (not (not (= (ite (= (str.len s1) 0) 1 0) 0)))) (not (not (= (ite (= (str.len s1) (- 1)) 1 0) 0)))) (not (= (ite (= (str.at s2 1) (str.at s3 1)) 1 0) 0))) (not (= (ite (> (str.len s2) 1) 1 0) 0))) (not (not (= (ite (= (str.at s1 0) (str.at s3 1)) 1 0) 0)))) (not (= (ite (> (str.len s1) 0) 1 0) 0))) (not (not (= (ite (= (str.len s1) 0) 1 0) 0)))) (not (not (= (ite (= (str.len s1) (- 1)) 1 0) 0)))) (not (= (ite (= (str.at s2 0) (str.at s3 0)) 1 0) 0))) (not (= (ite (> (str.len s2) 0) 1 0) 0))) (not (not (= (ite (= (str.at s1 0) (str.at s3 0)) 1 0) 0)))) (not (= (ite (> (str.len s1) 0) 1 0) 0))) (not (not (= (ite (= (str.len s1) 0) 1 0) 0)))) (not (not (= (ite (not (= (+ (str.len s1) (str.len s2)) (str.len s3))) 1 0) 0)))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-fun delimiter () String)
(declare-fun segment0 () String)
(declare-fun segment1 () String)
(declare-fun total_segments () Int)
; Assert constraints using str_split operations
(assert (= delimiter ","))
(assert (= segment0 (str.split_at s1 delimiter 0)))
(assert (= segment1 (str.split_at s1 delimiter 1)))
(assert (= total_segments (str.num_splits s1 delimiter)))
(assert (>= total_segments 2))
(assert (str.contains s2 (str.split_rest s1 delimiter 2)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
