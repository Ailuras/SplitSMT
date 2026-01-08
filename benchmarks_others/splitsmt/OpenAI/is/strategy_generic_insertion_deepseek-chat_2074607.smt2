(set-logic ALL)
(declare-fun var_7 () String)
(declare-fun var_8 () String)
(assert (str.in_re (str.++ var_7 "z" var_8 ) (re.* (re.union (str.to_re "b") (re.++ (str.to_re "a") (re.++ (re.* (str.to_re "z")) (str.to_re "b")))))))
(assert (str.in_re var_8 (re.* (re.range "a" "u"))))
(assert (str.in_re (str.++ var_8 "a" ) (re.* (re.range "a" "u"))))
(assert (str.in_re var_7 (re.* (re.range "a" "u"))))
(assert (not (str.in_re (str.++ var_7 "z" var_8 "a" ) re.none)))

; --- START CONSTRAINT ---

(declare-const whole String)
(declare-const delim String)

(assert (= delim "z"))
(assert (= whole (str.++ var_7 "z" var_8)))

(assert (>= (str.num_splits whole delim) 2))
(assert (= (str.split_at whole delim 0) var_7))
(assert (= (str.split_at whole delim 1) var_8))
(assert (= (str.split_rest whole delim 1) var_8))

(assert (>= (str.len whole) 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
