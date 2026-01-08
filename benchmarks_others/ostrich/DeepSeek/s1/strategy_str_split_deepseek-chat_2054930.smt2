; CSV Processing: Validate comma-separated data fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and fields
(declare-const csv_line String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)
(declare-const total_fields Int)
(declare-const empty_field_count Int)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; CSV line must have exactly 4 fields when split by comma
(assert (= total_fields (num_splits csv_line ",")))
(assert (= total_fields 4))

; Extract individual fields using split_at
(assert (= field1 (split_at csv_line "," 0)))
(assert (= field2 (split_at csv_line "," 1)))
(assert (= field3 (split_at csv_line "," 2)))
(assert (= field4 (split_at csv_line "," 3)))

; Field constraints:
; Field1 must be non-empty and contain only alphanumeric characters
(assert (> (str.len field1) 0))
(assert (str.in_re field1 (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")))))

; Field2 must be a numeric string that converts to an integer > 100
(assert (str.in_re field2 (re.+ (re.range "0" "9"))))
(assert (> (str.to_int field2) 100))

; Field3 can be empty (empty string) or contain letters only
(assert (or (= field3 "") (str.in_re field3 (re.+ (re.union (re.range "a" "z") (re.range "A" "Z"))))))

; Field4 must end with the suffix "_end"
(assert (str.suffixof "_end" field4))

; Count empty fields: field3 may be empty, others must not be
(assert (= empty_field_count (ite (= field3 "") 1 0)))
(assert (<= empty_field_count 1))

; Additional constraint: The concatenation of all fields (with commas) must equal the original CSV line
(assert (= csv_line (str.++ field1 "," field2 "," field3 "," field4)))

; Ensure field lengths are reasonable (each ≤ 20 characters)
(assert (<= (str.len field1) 20))
(assert (<= (str.len field2) 20))
(assert (<= (str.len field3) 20))
(assert (<= (str.len field4) 20))

; Final check for satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
