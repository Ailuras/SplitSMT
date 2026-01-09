(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "/.jpe") (re.union (str.to_re "?") (str.to_re "\u{5c}") (str.to_re "/")) (str.to_re "/smiU\u{a}"))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const delimiter String)
(assert (= delimiter "/"))
(assert (>= (num_splits X delimiter) 1))
(assert (str.contains (split_at X delimiter 0) ".jpe"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]