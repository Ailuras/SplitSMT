(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (str.to_re "6atPZ2")))

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
(assert (= delimiter "at"))
(assert (= segment0 (split_at x delimiter 0)))
(assert (= segment1 (split_at x delimiter 1)))
(assert (= total_segments (num_splits x delimiter)))
(assert (>= total_segments 2))
(assert (str.in_re segment0 (str.to_re "6")))
(assert (str.in_re segment1 (str.to_re "PZ2")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]