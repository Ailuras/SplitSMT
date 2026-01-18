(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (str.in_re X (str.to_re "WindowsAcmeReferer:\u{a}")))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (>= (num_splits X delimiter) 2))
(assert (= (split_at X delimiter 0) "WindowsAcmeReferer"))
(assert (= (split_at X delimiter 1) "\u{a}"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
