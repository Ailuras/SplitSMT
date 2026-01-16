(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (re.union (re.range "a" "z") (re.range "A" "Z")) (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_"))) (str.to_re "\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "/") ((_ re.loop 7 7) (str.to_re "\u{0}")) (str.to_re "S") ((_ re.loop 3 3) (str.to_re "\u{0}")) (str.to_re "\u{16}") ((_ re.loop 8 8) re.allchar) (re.* (re.comp (str.to_re "\u{0}"))) (re.union (str.to_re "\u{22}") (str.to_re "'") (str.to_re ")") (str.to_re ";")) (str.to_re "/\u{a}"))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter " "))
(assert (>= (str.num_splits X delimiter) 3))
(assert (str.contains (str.split_at X delimiter 1) "S"))
(assert (str.contains (str.split_rest X delimiter 2) "\u{16}"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
