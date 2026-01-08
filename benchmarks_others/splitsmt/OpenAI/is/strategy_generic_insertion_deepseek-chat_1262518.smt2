(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (re.union (re.++ (re.union (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (re.union (str.to_re "1") (str.to_re "2")) (re.range "0" "9")) (re.++ (str.to_re "3") (re.union (str.to_re "0") (str.to_re "1")))) (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (re.union (re.++ (str.to_re "0") (re.union (str.to_re "1") (str.to_re "3") (str.to_re "5") (str.to_re "7") (str.to_re "8"))) (str.to_re "10") (str.to_re "12")) (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (re.union (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (re.union (str.to_re "1") (str.to_re "2")) (re.range "0" "9")) (str.to_re "30")) (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (re.union (re.++ (str.to_re "0") (re.union (str.to_re "4") (str.to_re "6") (str.to_re "9"))) (str.to_re "11")) (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (re.union (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (str.to_re "1") (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "8"))) (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (str.to_re "02") (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (str.to_re "29") (re.union (str.to_re ".") (str.to_re "-") (str.to_re "/")) (str.to_re "02") (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (re.union (str.to_re "0") (str.to_re "2") (str.to_re "4") (str.to_re "6") (str.to_re "8")) (re.union (str.to_re "0") (str.to_re "4") (str.to_re "8")) (str.to_re "00")) (re.++ (str.to_re "29") (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (str.to_re "02") (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (re.union (str.to_re "1") (str.to_re "3") (str.to_re "5") (str.to_re "7") (str.to_re "9")) (re.union (str.to_re "2") (str.to_re "6")) (str.to_re "00")) (re.++ (str.to_re "29") (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (str.to_re "02") (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (re.range "0" "9") (re.range "0" "9") (str.to_re "0") (re.union (str.to_re "4") (str.to_re "8"))) (re.++ (str.to_re "29") (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (str.to_re "02") (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (re.range "0" "9") (re.range "0" "9") (re.union (str.to_re "2") (str.to_re "4") (str.to_re "6") (str.to_re "8")) (re.union (str.to_re "0") (str.to_re "4") (str.to_re "8"))) (re.++ (str.to_re "29") (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (str.to_re "02") (re.union (str.to_re "-") (str.to_re ".") (str.to_re "/")) (re.range "0" "9") (re.range "0" "9") (re.union (str.to_re "1") (str.to_re "3") (str.to_re "5") (str.to_re "7") (str.to_re "9")) (re.union (str.to_re "2") (str.to_re "6")))) (str.to_re "\u{a}"))))

; --- START CONSTRAINT ---

(declare-const delim String)
(declare-const day String)
(declare-const month String)
(declare-const year String)
(declare-const d0 String)
(declare-const d1 String)

(assert (or (= delim "-") (= delim ".") (= delim "/")))

; Force a consistent delimiter-based decomposition X = day<delim>month<delim>year
(assert (>= (str.num_splits X delim) 3))
(assert (= day (str.split_at X delim 0)))
(assert (= month (str.split_at X delim 1)))
(assert (= year (str.split_at X delim 2)))
(assert (= (str.split_rest X delim 0) (str.++ day delim month delim year)))

; Basic well-formedness of components
(assert (= (str.len day) 2))
(assert (= (str.len month) 2))
(assert (= (str.len year) 4))

; Day/month digits are numeric
(assert (= d0 (str.at day 0)))
(assert (= d1 (str.at day 1)))
(assert (str.in_re d0 (re.range "0" "9")))
(assert (str.in_re d1 (re.range "0" "9")))
(assert (str.in_re month ((_ re.loop 2 2) (re.range "0" "9"))))
(assert (str.in_re year ((_ re.loop 4 4) (re.range "0" "9"))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
