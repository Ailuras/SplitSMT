(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (str.to_re "g\\Md'p'\x0b'm91a1OVt3>iQi"))))
(assert (str.in_re y (re.* (str.to_re "V\\C""'1W\\(y\\tt<'TOy"))))
(assert (= (str.len x) 0))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (>= (num_splits x delimiter) 1))
(assert (= (split_at x delimiter 0) y))
(assert (= (split_rest x delimiter 1) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
