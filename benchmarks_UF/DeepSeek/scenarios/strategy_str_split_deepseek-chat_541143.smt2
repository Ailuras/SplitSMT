; CSV Processing: Validate field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare CSV string and delimiter
(declare-const csv String)
(declare-const delimiter String)
(assert (= delimiter ","))

; Declare field variables
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)

; Use str_split interface functions

; Constraint 1: CSV must have exactly 4 fields
(assert (= (num_splits csv delimiter) 4))

; Constraint 2: Define each field using split_at
(assert (= field0 (split_at csv delimiter 0)))
(assert (= field1 (split_at csv delimiter 1)))
(assert (= field2 (split_at csv delimiter 2)))
(assert (= field3 (split_at csv delimiter 3)))

; Constraint 3: Field 0 must not be empty
(assert (> (str.len field0) 0))

; Constraint 4: Field 2 must contain the substring "ID"
(assert (str.contains field2 "ID"))

; Constraint 5: Field 1 and field 3 must have equal lengths
(assert (= (str.len field1) (str.len field3)))

; Constraint 6: The concatenation of all fields (with delimiters) must equal the original CSV
(assert (= csv (str.++ field0 delimiter field1 delimiter field2 delimiter field3)))

; Constraint 7: At least one field must be empty (to test detection)
(assert (or (= (str.len field1) 0) (= (str.len field2) 0) (= (str.len field3) 0)))

; Constraint 8: Field 0 must start with an alphabetic character
(assert (>= (str.to_code (str.at field0 0)) 65))
(assert (<= (str.to_code (str.at field0 0)) 122))

; Constraint 9: Total characters in all fields must be at least 10
(assert (>= (+ (str.len field0) (str.len field1) (str.len field2) (str.len field3)) 10))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
