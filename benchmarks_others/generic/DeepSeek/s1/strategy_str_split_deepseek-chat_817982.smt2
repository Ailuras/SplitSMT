; CSV Processing: Validate comma-separated data fields with str_split operations
(set-logic ALL)

; Declare string variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_fields String)

; Define str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must contain at least 3 fields
(assert (>= (num_splits csv_data delimiter) 3))

; Constraint 2: First field must be non-empty (length > 0)
(assert (= first_field (split_at csv_data delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field must be non-empty
(assert (= last_field (split_at csv_data delimiter (- (num_splits csv_data delimiter) 1))))
(assert (> (str.len last_field) 0))

; Constraint 4: Middle fields (from index 1 to second-to-last) must not contain empty strings
; This is enforced by checking that the concatenation of middle fields has no "" segments
(assert (= middle_fields (split_rest csv_data delimiter 1)))
(assert (not (str.contains middle_fields ",,")))

; Constraint 5: Total field count must be exactly 5
(assert (= field_count (num_splits csv_data delimiter)))
(assert (= field_count 5))

; Constraint 6: CSV data must not contain newline characters to ensure single-line format
(assert (not (str.contains csv_data "\u{a}")))
(assert (not (str.contains csv_data "\u{d}")))

; Constraint 7: CSV data must match a pattern: alphanumeric fields separated by commas
; This regex ensures each field is alphanumeric (letters/digits) and non-empty
(assert (str.in_re csv_data (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))) (re.* (re.++ (str.to_re ",") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))))))))

; Constraint 8: Specific example: third field must be "price"
(assert (= (split_at csv_data delimiter 2) "price"))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
