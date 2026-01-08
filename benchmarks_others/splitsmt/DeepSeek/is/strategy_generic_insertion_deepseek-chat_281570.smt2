(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (re.union (str.to_re "0") (str.to_re "+33")) (re.range "1" "9") ((_ re.loop 4 4) (re.++ (re.opt (re.union (str.to_re "-") (str.to_re ".") (str.to_re " "))) ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "-"))
(assert (>= (str.num_splits X delimiter) 2))
(assert (str.contains (str.split_at X delimiter 1) "33"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
