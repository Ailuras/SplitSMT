(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "/") (re.union (str.to_re "\u{19}\u{0}") (str.to_re "\u{0}\u{5c}")) (str.to_re "\u{0}n\u{0}w\u{0}d\u{0}b\u{0}l\u{0}i\u{0}b\u{0}.\u{0}d\u{0}l\u{0}l\u{0}\u{0}\u{0}/i\u{a}"))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "/"))
(assert (>= (str.num_splits X delimiter) 3))
(assert (= (str.split_at X delimiter 0) ""))
(assert (str.contains (str.split_at X delimiter 1) "n"))
(assert (str.contains (str.split_rest X delimiter 2) "dll"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
