(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".avi/i\u{a}"))))
(assert (not (str.in_re X (str.to_re "www.makemesearch.comLOGOnevclxatmlhavj/vsy\u{a}"))))
(assert (not (str.in_re X (re.++ (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---
(declare-const filename String)
(declare-const extension String)
(assert (= filename (split_at X "=" 1)))
(assert (= extension (split_at filename "." 1)))
(assert (>= (num_splits X "=") 2))
(assert (>= (num_splits filename ".") 2))
(assert (str.contains extension "avi"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
