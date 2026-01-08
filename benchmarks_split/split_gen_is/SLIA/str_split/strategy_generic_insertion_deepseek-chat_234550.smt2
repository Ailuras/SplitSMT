(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (str.to_re "onBetaHost:youRootReferer:\u{a}")))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split results
(declare-const delimiter String)
(declare-const first_segment String)
(declare-const total_segments Int)
(declare-const remaining String)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= first_segment (split_at X delimiter 0)))
(assert (= total_segments (num_splits X delimiter)))
(assert (>= total_segments 2))
(assert (= remaining (split_rest X delimiter 1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)