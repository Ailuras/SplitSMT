(set-logic QF_S)

(declare-const input_string String)
(declare-const csv_data String)
(declare-const path_string String)
(declare-const email String)

(assert (= (str.split_at input_string ";" 0) "header"))
(assert (= (str.split_at input_string ";" 1) "data1"))
(assert (= (str.split_at input_string ";" 2) "data2"))
(assert (= (str.split_at input_string ";" 3) "footer"))

(assert (= (str.num_splits input_string ";") 4))

(assert (>= (str.num_splits csv_data ",") 3))
(assert (<= (str.num_splits csv_data ",") 6))
(assert (= (str.split_at csv_data "," 0) "name"))
(assert (= (str.split_at csv_data "," 1) "age"))
; (assert (= (str.split_at csv_data "," 2) "city"))

; (assert (= (str.num_splits path_string "/") 3))
; (assert (= (str.split_at path_string "/" 0) "home"))
; (assert (= (str.split_at path_string "/" 1) "user"))
; (assert (= (str.split_at path_string "/" 2) "documents"))

; (assert (= (str.num_splits email "@") 2))
; (assert (= (str.split_at email "@" 0) "username"))
; (assert (= (str.split_at email "@" 1) "domain.com"))

; (assert (>= (str.num_splits email ".") 2))
; (assert (= (str.split_at email "." 1) "domain"))
; (assert (= (str.split_at email "." 2) "com"))

; (assert (str.contains input_string "data"))
; (assert (not (str.contains (str.split_at csv_data "," 0) ",")))
; (assert (>= (str.len (str.split_at path_string "/" 0)) 1))

(check-sat)
(get-model)