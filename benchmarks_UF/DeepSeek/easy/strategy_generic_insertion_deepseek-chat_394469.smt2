(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (not (str.in_re X (str.to_re ".myway.com\u{1b}ToolbarUI2Host:Subject:toxbqyosoe/cpvm\u{a}"))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "."))
(assert (>= (num_splits X delimiter) 2))
(assert (= (split_at X delimiter 0) "www"))
(assert (str.contains (split_rest X delimiter 1) "myway"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
