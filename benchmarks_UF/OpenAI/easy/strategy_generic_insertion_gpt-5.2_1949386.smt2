(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "<b>") (re.+ (re.union (str.to_re "<") (str.to_re ">"))) (str.to_re "</b>\u{a}")))))

; --- START CONSTRAINT ---
(declare-const before_b_close String)
(declare-const after_b_close String)
(assert (>= (num_splits X "</b>\n") 2))
(assert (= before_b_close (split_at X "</b>\n" 0)))
(assert (= after_b_close (split_rest X "</b>\n" 1)))
(assert (str.contains before_b_close "<b>"))
(assert (not (str.contains after_b_close "<b>")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
