(set-logic ALL)
(declare-fun s () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (= (str.len s) 4) 1 0) 0)))) (not (not (= (ite (not (= (str.at s 2) (str.at s 3))) 1 0) 0)))) (not (= (ite (not (= (str.at s 4) (str.at s 5))) 1 0) 0))) (not (not (= (ite (not (= (str.at s 3) (str.at s 6))) 1 0) 0)))) (not (= (ite (<= (str.len s) 7) 1 0) 0))) (not (= (ite (= (str.len s) 7) 1 0) 0))) (not (not (= (ite (<= (str.len s) 6) 1 0) 0)))) (not (not (= (ite (= (str.len s) 6) 1 0) 0)))) (not (not (= (ite (not (= (str.at s 3) (str.at s 5))) 1 0) 0)))) (not (= (ite (not (= (str.at s 3) (str.at s 4))) 1 0) 0))) (not (= (ite (not (= (str.at s 4) (str.at s 6))) 1 0) 0))) (not (= (ite (not (= (str.at s 4) (str.at s 5))) 1 0) 0))) (not (= (ite (<= (str.len s) 7) 1 0) 0))) (not (= (ite (= (str.len s) 7) 1 0) 0))) (not (not (= (ite (not (= (str.at s 5) (str.at s 6))) 1 0) 0)))) (not (= (ite (<= (str.len s) 7) 1 0) 0))) (not (= (ite (= (str.len s) 7) 1 0) 0))) (not (not (= (ite (<= (str.len s) 6) 1 0) 0)))) (not (not (= (ite (= (str.len s) 6) 1 0) 0)))) (not (not (= (ite (<= (str.len s) 5) 1 0) 0)))) (not (not (= (ite (= (str.len s) 5) 1 0) 0)))) (not (not (= (ite (<= (str.len s) 4) 1 0) 0)))) (not (not (= (ite (= (str.len s) 4) 1 0) 0)))) (not (not (= (ite (<= (str.len s) 3) 1 0) 0)))) (not (not (= (ite (= (str.len s) 3) 1 0) 0)))) (not (not (= (ite (<= (str.len s) 2) 1 0) 0)))) (not (not (= (ite (= (str.len s) 2) 1 0) 0)))) (not (not (= (ite (<= (str.len s) 1) 1 0) 0)))) (not (not (= (ite (= (str.len s) 1) 1 0) 0)))) (not (not (= (ite (<= (str.len s) 0) 1 0) 0)))) (not (not (= (ite (= (str.len s) 0) 1 0) 0)))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= segment0 (split_at s delimiter 0)))
(assert (= segment1 (split_at s delimiter 1)))
(assert (= total_segments (num_splits s delimiter)))
(assert (>= total_segments 2))
(assert (>= (str.len segment0) 1))
(assert (>= (str.len segment1) 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
