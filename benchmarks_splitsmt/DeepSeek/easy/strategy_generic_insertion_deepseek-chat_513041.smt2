(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (re.opt (re.union (str.to_re "s-") (str.to_re "S-"))) ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "-"))
(assert (>= (str.num_splits X delimiter) 2))
(assert (str.contains (str.split_at X delimiter 0) "s"))
(assert (str.contains (str.split_at X delimiter 0) "S"))
(assert (= (str.len (str.split_at X delimiter 1)) 3))
(assert (str.in_re (str.split_at X delimiter 1) (re.++ ((_ re.loop 3 3) (re.range "0" "9")))))
(assert (str.in_re (str.split_rest X delimiter 2) (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "\u{a}"))))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
