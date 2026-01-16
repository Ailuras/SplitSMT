(set-logic ALL)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.++ (re.+ (str.to_re "00")) (re.union (str.to_re "1") (str.to_re "22")))))
(assert (<= 15 (str.len var0)))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "00"))
(assert (>= (str.num_splits var0 delimiter) 1))
(assert (str.contains (str.split_at var0 delimiter 0) "1"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
