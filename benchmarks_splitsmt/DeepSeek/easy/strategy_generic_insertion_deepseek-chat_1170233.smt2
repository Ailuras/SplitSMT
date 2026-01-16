(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "EFError") (re.* re.allchar) (str.to_re "Host:") (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (str.to_re "www.malware-stopper.com\u{a}")))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "Host:"))
(assert (>= (str.num_splits X delimiter) 1))
(assert (str.contains (str.split_at X delimiter 0) "EFError"))
(assert (str.contains (str.split_rest X delimiter 1) "www.malware-stopper.com"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
