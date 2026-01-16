(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (not (str.in_re X (re.++ ((_ re.loop 4 4) (re.union (re.range "A" "Z") (str.to_re "|") (re.range "a" "z"))) (str.to_re "0") ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "|"))
(assert (>= (num_splits X delimiter) 2))
(assert (str.contains (split_at X delimiter 0) "A"))
(assert (str.contains (split_at X delimiter 1) "Z"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
