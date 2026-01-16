; CSV Processing: Ensure correct field counts and detect empty fields using str_split interface
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare variables for CSV data and fields
(declare-const csv_line String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)
(declare-const field5 String)
(declare-const num_fields Int)

; Declare uninterpreted functions for str_split interface

; Constraint 1: CSV line must contain at least 5 fields separated by commas
(assert (>= (num_splits csv_line ",") 5))
(assert (= num_fields (num_splits csv_line ",")))

; Constraint 2: Extract specific fields using split_at
(assert (= field1 (split_at csv_line "," 0)))
(assert (= field2 (split_at csv_line "," 1)))
(assert (= field3 (split_at csv_line "," 2)))
(assert (= field4 (split_at csv_line "," 3)))
(assert (= field5 (split_at csv_line "," 4)))

; Constraint 3: Field1 must be non-empty and start with an alphabetic character
(assert (> (str.len field1) 0))
(assert (str.in_re field1 (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_"))))))

; Constraint 4: Field2 must be a numeric string (digits only)
(assert (str.in_re field2 (re.+ (re.range "0" "9"))))

; Constraint 5: Field3 must contain at least one comma or be empty (simulating optional field)
(assert (or (= (str.len field3) 0) (str.contains field3 ",")))

; Constraint 6: Field4 must not be empty and must not contain spaces
(assert (> (str.len field4) 0))
(assert (not (str.contains field4 " ")))

; Constraint 7: Field5 must be exactly "END" or "FINISH"
(assert (or (= field5 "END") (= field5 "FINISH")))

; Constraint 8: Additional regex constraint from seed for diversity (modified to fit CSV context)
(assert (str.in_re csv_line (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ",") (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "\u{a}"))))

; Constraint 9: Ensure total number of fields is exactly 5 or 6 (SAT/UNSAT mix)
(assert (or (= num_fields 5) (= num_fields 6)))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
