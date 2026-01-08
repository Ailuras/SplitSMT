; CSV Processing: Validate comma-separated data fields with str_split operations
(set-logic ALL)

; Declare string variables for CSV data and delimiter
(declare-const csv_data String)
(declare-const delimiter String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const middle_fields String)

; Define uninterpreted functions for str_split interface

; Set delimiter to comma for CSV
(assert (= delimiter ","))

; Constraint 1: CSV data must contain at least 4 fields
(assert (>= (str.num_splits csv_data delimiter) 4))

; Constraint 2: First field must be non-empty (length > 0)
(assert (= first_field (str.split_at csv_data delimiter 0)))
(assert (> (str.len first_field) 0))

; Constraint 3: Last field must be non-empty
(assert (= last_field (str.split_at csv_data delimiter (- (str.num_splits csv_data delimiter) 1))))
(assert (> (str.len last_field) 0))

; Constraint 4: Middle fields (from index 1 to second-to-last) concatenated must contain at least one non-comma character
(assert (= middle_fields (str.split_rest csv_data delimiter 1)))
(assert (str.contains middle_fields "A")) ; Example: ensure some content

; Constraint 5: Total field count must be even
(assert (= field_count (str.num_splits csv_data delimiter)))
(assert (= (mod field_count 2) 0))

; Constraint 6: CSV data must not start or end with delimiter (no leading/trailing commas)
(assert (not (str.prefixof delimiter csv_data)))
(assert (not (str.suffixof delimiter csv_data)))

; Constraint 7: No two consecutive delimiters (no empty fields except possibly allowed ones)
(assert (not (str.contains csv_data (str.++ delimiter delimiter))))

; Additional regex constraint: CSV data must match a pattern with alphanumeric fields separated by commas
(assert (str.in_re csv_data (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))) (re.* (re.++ (str.to_re ",") (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))))) )))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
