(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
 CSV/TSV processing with strict validation
 Focus: Field count consistency, empty field handling, and multi-delimiter support
|)

; Declare delimiters and test strings
(declare-const comma String)
(declare-const tab String)
(declare-const pipe String)
(declare-const semicolon String)
(assert (= comma ","))
(assert (= tab "\t"))
(assert (= semicolon ";"))
(assert (= pipe "|"))

; Test CSV line with variable delimiters
(declare-const data_row1 String)
(declare-const data_row2 String)
(assert (= data_row1 "John,Doe,30,New York"))
(assert (= data_row2 "Jane\tSmith\t28\tLos Angeles"))

; ; Validate field counts match expected schema
(assert (= (str.num_splits data_row1 comma) 4))
(assert (= (str.num_splits data_row2 tab) 4))

; ; Extract and constrain individual fields
(declare-const first_name1 String)
(declare-const last_name1 String)
(declare-const age1 String)
(declare-const city1 String)
(assert (= first_name1 (str.split_at data_row1 comma 0)))
(assert (= last_name1 (str.split_at data_row1 comma 1)))
(assert (= age1 (str.split_at data_row1 comma 2)))
(assert (= city1 (str.split_at data_row1 comma 3)))

; Field constraints
(assert (> (str.len first_name1) 0))
(assert (> (str.len last_name1) 0))
(assert (str.is_digit age1))
(assert (>= (str.to_int age1) 18))

; Handle empty fields case
(declare-const partial_row String)
(assert (= partial_row "Alice,,25,Chicago"))
(assert (= (str.num_splits partial_row comma) 4))
(assert (= (str.len (str.split_at partial_row comma 1)) 0)) ; Empty last name

; Multi-delimiter validation
(declare-const complex_row String)
(assert (= complex_row "id123;2023-01-15|completed\t100.00"))
(assert (= (str.num_splits complex_row semicolon) 2))
(assert (= (str.num_splits (str.split_at complex_row semicolon 1) pipe) 2))
(assert (= (str.num_splits (str.split_at complex_row semicolon 1) tab) 1))

; Negative test case (should be unsat)
(declare-const invalid_row String)
(assert (= invalid_row "Bob,Johnson,thirtyfive,Seattle"))
(assert (str.is_digit (str.split_at invalid_row comma 2))) ; Age not numeric

(check-sat)
(exit)