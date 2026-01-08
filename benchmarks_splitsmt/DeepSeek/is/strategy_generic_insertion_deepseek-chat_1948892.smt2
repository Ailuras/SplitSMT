(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (str.to_re "onBetaHost:youRootReferer:\u{a}")))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".xwd/i\u{a}")))))
(assert (str.in_re X (re.++ (re.union (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (str.to_re "1") (re.range "0" "2"))) (str.to_re "\u{a}"))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "\u{a}"))
(assert (>= (str.num_splits X delimiter) 3))
(assert (= (str.split_at X delimiter 0) "onBetaHost:youRootReferer:"))
(assert (str.contains (str.split_at X delimiter 1) ".xwd"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
