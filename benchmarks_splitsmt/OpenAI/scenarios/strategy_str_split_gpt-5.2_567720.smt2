(set-logic ALL)

; Uninterpreted functions for str_split interface

; -----------------------------
; SAT instance: well-formed CSV line with 4 fields, no empty fields
; -----------------------------
(declare-const csv_line_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)
(declare-const ok_rest1 String)
(declare-const ok_rest2 String)

(assert (= (str.num_splits csv_line_ok ",") 4))
(assert (= ok_f0 (str.split_at csv_line_ok "," 0)))
(assert (= ok_f1 (str.split_at csv_line_ok "," 1)))
(assert (= ok_f2 (str.split_at csv_line_ok "," 2)))
(assert (= ok_f3 (str.split_at csv_line_ok "," 3)))
(assert (= ok_rest1 (str.split_rest csv_line_ok "," 1)))
(assert (= ok_rest2 (str.split_rest csv_line_ok "," 2)))

; Natural index constraints (interface discipline)
(assert (>= (str.num_splits csv_line_ok ",") 1))

; No empty fields
(assert (> (str.len ok_f0) 0))
(assert (> (str.len ok_f1) 0))
(assert (> (str.len ok_f2) 0))
(assert (> (str.len ok_f3) 0))

; Simple content sanity: first field is an ID made of digits only
(assert (str.in_re ok_f0 (re.+ (re.range "0" "9"))))

; Second field: name contains no comma and no newline
(assert (not (str.contains ok_f1 ",")))
(assert (not (str.contains ok_f1 "\n")))

; Third field: must contain an '@' (email-like)
(assert (str.contains ok_f2 "@"))

; Fourth field: a country code of exactly 2 uppercase letters
(assert (= (str.len ok_f3) 2))
(assert (str.in_re ok_f3 (re.++ (re.range "A" "Z") (re.range "A" "Z"))))

; Example concrete witness constraint for SAT diversity
(assert (= csv_line_ok "123,ALICE,alice@example.com,US"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
