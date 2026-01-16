(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (str.to_re "RequestWindowszzzvmkituktgr/etieencoder\u{a}"))))

; --- START CONSTRAINT ---
; Declare interface function signatures for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter "/"))
(assert (= segment0 (str.split_at X delimiter 0)))
(assert (= segment1 (str.split_at X delimiter 1)))
(assert (= total_segments (str.num_splits X delimiter)))
(assert (>= total_segments 2))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
