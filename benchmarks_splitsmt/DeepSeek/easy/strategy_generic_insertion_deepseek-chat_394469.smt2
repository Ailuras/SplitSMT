(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (str.to_re ".myway.com\u{1b}ToolbarUI2Host:Subject:toxbqyosoe/cpvm\u{a}"))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "."))
(assert (>= (str.num_splits X delimiter) 2))
(assert (= (str.split_at X delimiter 0) "www"))
(assert (str.contains (str.split_rest X delimiter 1) "myway"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
