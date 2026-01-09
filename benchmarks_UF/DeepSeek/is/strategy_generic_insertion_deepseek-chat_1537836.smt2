(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/.wk4") (re.union (str.to_re "?") (str.to_re "\u{5c}") (str.to_re "/")) (str.to_re "/smiU\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const delimiter String)
(assert (= delimiter "/"))
(assert (>= (num_splits X delimiter) 3))
(assert (str.contains (split_at X delimiter 1) "wk4"))
(assert (str.contains (split_at X delimiter 2) "smiU"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]