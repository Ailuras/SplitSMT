; CSV Processing: Validate CSV row structure with str_split operations
(set-logic ALL)

; Declare string variables for CSV row and fields
(declare-fun csv_row () String)
(declare-fun field1 () String)
(declare-fun field2 () String)
(declare-fun field3 () String)
(declare-fun field4 () String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core CSV constraints
; Ensure row has exactly 4 comma-separated fields
(assert (= (num_splits csv_row ",") 4))

; Extract individual fields using split_at
(assert (= field1 (split_at csv_row "," 0)))
(assert (= field2 (split_at csv_row "," 1)))
(assert (= field3 (split_at csv_row "," 2)))
(assert (= field4 (split_at csv_row "," 3)))

; Field-specific constraints
; Field1 must be non-empty and not contain commas
(assert (> (str.len field1) 0))
(assert (not (str.contains field1 ",")))

; Field2 can be empty (optional field)
(assert (or (= (str.len field2) 0) (not (str.contains field2 ","))))

; Field3 must contain at least one digit
(assert (str.contains field3 "0"))

; Field4 must be exactly "END"
(assert (= field4 "END"))

; Additional validation: No trailing commas in the row
(assert (not (str.suffixof "," csv_row)))
(assert (not (str.prefixof "," csv_row)))

; Ensure the concatenation of fields with commas reconstructs the original row
(assert (= csv_row (str.++ field1 "," field2 "," field3 "," field4)))

; Check for consistency: split_rest should match remaining fields
(assert (= (str.++ field2 "," field3 "," field4) (split_rest csv_row "," 1)))

; Final satisfiability check
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
