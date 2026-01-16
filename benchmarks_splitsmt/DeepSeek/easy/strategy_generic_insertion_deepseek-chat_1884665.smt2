(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "/.jpe") (re.union (str.to_re "?") (str.to_re "\u{5c}") (str.to_re "/")) (str.to_re "/smiU\u{a}"))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "/"))
(assert (>= (str.num_splits X delimiter) 1))
(assert (str.contains (str.split_at X delimiter 0) ".jpe"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
