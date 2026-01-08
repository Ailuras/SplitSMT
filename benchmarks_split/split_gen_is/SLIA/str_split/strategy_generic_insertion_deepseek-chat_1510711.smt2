(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "/") (re.union (str.to_re "\u{19}\u{0}") (str.to_re "\u{0}\u{5c}")) (str.to_re "\u{0}n\u{0}w\u{0}d\u{0}b\u{0}l\u{0}i\u{0}b\u{0}.\u{0}d\u{0}l\u{0}l\u{0}\u{0}\u{0}/i\u{a}"))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const delimiter String)
(assert (= delimiter "/"))
(assert (>= (num_splits X delimiter) 3))
(assert (= (split_at X delimiter 0) ""))
(assert (str.contains (split_at X delimiter 1) "n"))
(assert (str.contains (split_rest X delimiter 2) "dll"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)