(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (str.to_re "WindowsAcmeReferer:\u{a}")))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (>= (num_splits X delimiter) 2))
(assert (= (split_at X delimiter 0) "WindowsAcmeReferer"))
(assert (= (split_at X delimiter 1) "\u{a}"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
