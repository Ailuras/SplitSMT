(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (str.to_re "g\\Md'p'\x0b'm91a1OVt3>iQi"))))
(assert (str.in_re y (re.* (str.to_re "V\\C""'1W\\(y\\tt<'TOy"))))
(assert (= (str.len x) 0))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (>= (str.num_splits x delimiter) 1))
(assert (= (str.split_at x delimiter 0) y))
(assert (= (str.split_rest x delimiter 1) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
