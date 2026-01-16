(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "<b>") (re.+ (re.union (str.to_re "<") (str.to_re ">"))) (str.to_re "</b>\u{a}")))))

; --- START CONSTRAINT ---
(declare-const before_b_close String)
(declare-const after_b_close String)
(assert (>= (str.num_splits X "</b>\n") 2))
(assert (= before_b_close (str.split_at X "</b>\n" 0)))
(assert (= after_b_close (str.split_rest X "</b>\n" 1)))
(assert (str.contains before_b_close "<b>"))
(assert (not (str.contains after_b_close "<b>")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
