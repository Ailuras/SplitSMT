(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "-") (re.union (re.range "1" "9") (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (str.to_re "1") (re.range "0" "2"))) (str.to_re "-") (re.union (re.++ (str.to_re "3") (re.range "0" "1")) (re.++ (re.range "0" "2") (re.range "0" "9")) (re.range "0" "9")) (str.to_re "\u{a}") (re.union (str.to_re "19") (str.to_re "20")) ((_ re.loop 2 2) (re.range "0" "9"))))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "-"))
(assert (>= (str.num_splits X delimiter) 3))
(assert (= (str.split_at X delimiter 0) ""))
(assert (= (str.split_at X delimiter 1) (str.substr X 1 2)))
(assert (= (str.split_at X delimiter 2) (str.substr X 4 2)))
(assert (= (str.split_rest X delimiter 3) (str.substr X 7 4)))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
