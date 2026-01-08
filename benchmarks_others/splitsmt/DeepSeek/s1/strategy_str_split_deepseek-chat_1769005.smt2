; CSV Processing scenario: Validate CSV format with str_split operations
(set-logic ALL)

; Declare string variables for CSV data
(declare-const csv_line String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)

; Declare str_split interface functions

; Constraint 1: CSV line must have exactly 4 fields when split by comma
(assert (= (str.num_splits csv_line ",") 4))

; Constraint 2: Extract individual fields using split_at
(assert (= field1 (str.split_at csv_line "," 0)))
(assert (= field2 (str.split_at csv_line "," 1)))
(assert (= field3 (str.split_at csv_line "," 2)))
(assert (= field4 (str.split_at csv_line "," 3)))

; Constraint 3: No field should be empty (minimum length 1)
(assert (> (str.len field1) 0))
(assert (> (str.len field2) 0))
(assert (> (str.len field3) 0))
(assert (> (str.len field4) 0))

; Constraint 4: Field1 must start with alphabetic character
(assert (str.in_re field1 (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") (str.to_re "_"))))))

; Constraint 5: Field2 must be numeric (digits only)
(assert (str.in_re field2 (re.+ (re.range "0" "9"))))

; Constraint 6: Field3 must contain only alphanumeric characters or hyphens
(assert (str.in_re field3 (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))

; Constraint 7: Field4 must be a valid email-like pattern (simplified)
(assert (str.in_re field4 (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") (str.to_re "_"))) (str.to_re "@") (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))) (str.to_re ".") (re.union (str.to_re "com") (str.to_re "org") (str.to_re "net")))))

; Constraint 8: The concatenation of split_rest from index 2 should equal field3 and field4 with comma
(assert (= (str.split_rest csv_line "," 2) (str.++ field3 "," field4)))

; Constraint 9: Ensure CSV line doesn't contain consecutive commas (no empty fields in middle)
(assert (not (str.contains csv_line ",,")))

; Constraint 10: Additional validation - total characters in CSV line must be at least 20
(assert (>= (str.len csv_line) 20))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
