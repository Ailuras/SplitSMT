(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/.wk4") (re.union (str.to_re "?") (str.to_re "\u{5c}") (str.to_re "/")) (str.to_re "/smiU\u{a}")))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "/"))
(assert (>= (str.num_splits X delimiter) 3))
(assert (str.contains (str.split_at X delimiter 1) "wk4"))
(assert (str.contains (str.split_at X delimiter 2) "smiU"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
