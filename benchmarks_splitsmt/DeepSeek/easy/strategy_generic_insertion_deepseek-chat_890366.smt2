(set-logic ALL)
(declare-fun var_4 () String)
(declare-fun var_5 () String)
(assert (str.in_re (str.++ var_4 "z" var_5 ) (re.* (re.union (str.to_re "b") (re.++ (str.to_re "a") (re.++ (re.* (str.to_re "z")) (str.to_re "b")))))))
(assert (str.in_re var_5 (re.* (re.range "a" "u"))))
(assert (str.in_re var_5 (re.* (str.to_re "b"))))
(assert (str.in_re var_4 (re.* (re.range "a" "u"))))
(assert (str.in_re var_4 (re.* (str.to_re "a"))))
(assert (not (str.in_re "" re.none)))
(assert (<= 0  (str.len var_5)))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const split_result String)
; Assert constraints using str_split operations
(assert (= delimiter "z"))
(assert (= split_result (str.split_at (str.++ var_4 "z" var_5) delimiter 1)))
(assert (>= (str.num_splits (str.++ var_4 "z" var_5) delimiter) 2))
(assert (str.in_re split_result (re.* (re.range "a" "u"))))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
