(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/") ((_ re.loop 4 4) (re.union (re.range " " "~") (str.to_re "\u{d}") (str.to_re "\u{a}"))) (str.to_re "/P\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const delimiter String)
(assert (= delimiter "/"))
(assert (>= (num_splits X delimiter) 2))
(assert (str.contains (split_at X delimiter 1) "P"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]