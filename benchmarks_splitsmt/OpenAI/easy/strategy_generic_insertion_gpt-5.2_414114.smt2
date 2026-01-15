(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "\u{a}") (re.union (re.++ (str.to_re "0") (re.union (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))) (str.to_re "10") (str.to_re "11") (str.to_re "12")) (re.union (re.++ (str.to_re "19") (re.range "0" "9") (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9")))))))

; --- START CONSTRAINT ---

(declare-const delim String)
(declare-const head String)
(declare-const tail String)

(assert (= delim "_"))
(assert (>= (str.len X) 0))
(assert (>= (str.num_splits X delim) 1))
(assert (= head (str.split_at X delim 0)))
(assert (= tail (str.split_rest X delim 1)))
(assert (= X (str.++ head (str.++ delim tail))))
(assert (>= (str.len head) 0))
(assert (>= (str.len tail) 0))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
