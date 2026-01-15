; CSV Processing: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare string variables for CSV data
(declare-fun csv_line () String)
(declare-fun field1 () String)
(declare-fun field2 () String)
(declare-fun field3 () String)
(declare-fun field4 () String)
(declare-fun field5 () String)

; Declare str_split interface functions

; CSV line must contain exactly 5 fields when split by comma
(assert (= (str.num_splits csv_line ",") 5))

; Extract individual fields using split_at
(assert (= field1 (str.split_at csv_line "," 0)))
(assert (= field2 (str.split_at csv_line "," 1)))
(assert (= field3 (str.split_at csv_line "," 2)))
(assert (= field4 (str.split_at csv_line "," 3)))
(assert (= field5 (str.split_at csv_line "," 4)))

; Field constraints: first field cannot be empty, third field must be numeric
(assert (> (str.len field1) 0))
(assert (str.in_re field3 (re.+ (re.range "0" "9"))))

; At least one field must be empty (detection requirement)
(assert (or (= (str.len field2) 0) (= (str.len field4) 0) (= (str.len field5) 0)))

; Field length constraints
(assert (<= (str.len field1) 10))
(assert (<= (str.len field2) 8))
(assert (<= (str.len field3) 5))
(assert (<= (str.len field4) 6))
(assert (<= (str.len field5) 7))

; Additional constraint: field2 and field5 cannot both be empty
(assert (not (and (= (str.len field2) 0) (= (str.len field5) 0))))

; Verify split_rest functionality: concatenation of last two fields equals split_rest from index 3
(assert (= (str.++ field4 field5) (str.split_rest csv_line "," 3)))

; Ensure CSV line contains only valid characters: alphanumeric and commas
(assert (str.in_re csv_line (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ",")))))

; Final consistency check: total characters in fields plus separators equals line length
(assert (= (str.len csv_line) (+ (str.len field1) (str.len field2) (str.len field3) (str.len field4) (str.len field5) 4)))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
