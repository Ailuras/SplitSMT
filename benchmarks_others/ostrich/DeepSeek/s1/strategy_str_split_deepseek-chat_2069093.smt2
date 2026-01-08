; CSV Processing: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)

; Declare variables
(declare-const csv_line String)
(declare-const field_count Int)
(declare-const first_field String)
(declare-const last_field String)
(declare-const has_empty_field Bool)
(declare-const is_valid Bool)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Core constraints
; Constraint 1: CSV line must have exactly 5 fields
(assert (= field_count (num_splits csv_line ",")))
(assert (= field_count 5))

; Constraint 2: First field must be non-empty and not equal to "ID"
(assert (= first_field (split_at csv_line "," 0)))
(assert (not (= first_field "")))
(assert (not (= first_field "ID")))

; Constraint 3: Last field must be non-empty and contain only digits
(assert (= last_field (split_at csv_line "," 4)))
(assert (not (= last_field "")))
(assert (str.in_re last_field (re.+ (re.range "0" "9"))))

; Constraint 4: Check for any empty fields in the middle (indices 1,2,3)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(assert (= field1 (split_at csv_line "," 1)))
(assert (= field2 (split_at csv_line "," 2)))
(assert (= field3 (split_at csv_line "," 3)))
(assert (= has_empty_field (or (= field1 "") (= field2 "") (= field3 ""))))

; Constraint 5: Overall validity - must have 5 fields, no empty middle fields, and valid first/last fields
(assert (= is_valid (and (= field_count 5) (not has_empty_field) (not (= first_field "")) (not (= last_field "")))))
(assert is_valid)

; Additional constraint: The concatenation of all fields (excluding commas) should equal the original line without commas
(declare-const reconstructed String)
(assert (= reconstructed (str.++ first_field field1 field2 field3 last_field)))
(declare-const line_without_commas String)
(assert (= line_without_commas (str.replace_all csv_line "," "")))
(assert (= reconstructed line_without_commas))

; Ensure the line is not trivial (e.g., not all same field)
(assert (not (= first_field field1)))
(assert (not (= first_field field2)))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
