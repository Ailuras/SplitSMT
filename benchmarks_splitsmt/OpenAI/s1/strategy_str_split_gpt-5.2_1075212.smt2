(set-logic ALL)

; Scenario: CSV Processing
; Goal: process comma-separated data fields, ensure correct field counts, detect empty fields

; Seed core structure preserved: T_1 and var_0xINPUT_529787 used
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_529787 () String)

; str_split interface (uninterpreted)

; Additional variables
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const trailing String)

(declare-const has_empty_mid Bool)
(declare-const has_empty_trailing Bool)

; Connect the seed variable to a CSV line
(assert (= var_0xINPUT_529787 "Search"))
(assert (= csv_line (str.++ var_0xINPUT_529787 "," "" "," "42" "," "")))
(assert (= delim ","))

; Core structure: T_1 equates and is asserted
(assert (= T_1 (= (str.split_at csv_line delim 0) "Search")))
(assert T_1)

; Field extraction and reconstruction constraints
(assert (= f0 (str.split_at csv_line delim 0)))
(assert (= f1 (str.split_at csv_line delim 1)))
(assert (= f2 (str.split_at csv_line delim 2)))
(assert (= trailing (str.split_rest csv_line delim 3)))

; Ensure there are exactly 4 segments: Search, "" , 42, ""
(assert (= (str.num_splits csv_line delim) 4))

; Detect empty fields
(assert (= has_empty_mid (= f1 "")))
(assert has_empty_mid)
(assert (= has_empty_trailing (= trailing "")))
(assert has_empty_trailing)

; Some sanity checks about non-empty constraints on other fields
(assert (not (= f0 "")))
(assert (= f2 "42"))

; Create an UNSAT corner: require no empty fields while also asserting empties
(assert (not (= f1 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
