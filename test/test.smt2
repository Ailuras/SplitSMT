(set-logic QF_S)
(set-option :produce-models true)

; 声明字符串变量
(declare-const x7 String)
(declare-const x8 String)

; x7 in ["aa"]*
(assert (str.in_re x7 (re.* (str.to_re "aa"))))

; x8 in "a" + ["aa"]*
(assert (str.in_re x8 (re.++ (str.to_re "a") (re.* (str.to_re "aa")))))

; x7 not in "a" + ["a"]*
(assert (not (str.in_re x7 (re.++ (str.to_re "a") (re.* (str.to_re "a"))))))

; x7 not in ""
(assert (not (= x7 "")))

(check-sat)
(get-model)