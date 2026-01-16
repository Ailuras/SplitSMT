(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".pkp/i\u{a}")))))

; --- START CONSTRAINT ---
(declare-const seg0 String)
(declare-const seg1 String)
(declare-const rest1 String)
(assert (>= (num_splits X "/filename=") 2))
(assert (= seg0 (split_at X "/filename=" 0)))
(assert (= seg1 (split_at X "/filename=" 1)))
(assert (= rest1 (split_rest X "/filename=" 1)))
(assert (str.contains seg1 ".pkp"))
(assert (not (str.contains seg1 "/")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
