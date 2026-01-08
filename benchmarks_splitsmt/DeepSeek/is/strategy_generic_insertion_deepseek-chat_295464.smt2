(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (str.to_re "WindowsAcmeReferer:\u{a}")))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (>= (str.num_splits X delimiter) 2))
(assert (= (str.split_at X delimiter 0) "WindowsAcmeReferer"))
(assert (= (str.split_at X delimiter 1) "\u{a}"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
