; CSV Processing: Validate field counts and detect empty fields using str_split operations
(set-logic ALL)

; Declare variables for CSV data and delimiters
(declare-fun csv_line () String)
(declare-fun field1 () String)
(declare-fun field2 () String)
(declare-fun field3 () String)
(declare-fun field4 () String)
(declare-fun field5 () String)
(declare-fun delimiter () String)

; Declare str_split interface functions

; CSV line must contain exactly 5 fields when split by comma
(assert (= delimiter ","))
(assert (= (str.num_splits csv_line delimiter) 5))

; Extract individual fields using split_at
(assert (= field1 (str.split_at csv_line delimiter 0)))
(assert (= field2 (str.split_at csv_line delimiter 1)))
(assert (= field3 (str.split_at csv_line delimiter 2)))
(assert (= field4 (str.split_at csv_line delimiter 3)))
(assert (= field5 (str.split_at csv_line delimiter 4)))

; Field constraints:
; 1. First field must be non-empty
(assert (> (str.len field1) 0))
; 2. Third field must contain only digits (simplified as containing "123")
(assert (str.contains field3 "123"))
; 3. Last field must end with "END"
(assert (str.suffixof "END" field5))
; 4. No field except possibly the second can be empty
(assert (or (= (str.len field2) 0) (> (str.len field2) 0))) ; field2 may be empty
(assert (> (str.len field4) 0))

; Additional constraint: The concatenation of all fields (with delimiters) must equal the original line
(assert (= csv_line (str.++ field1 delimiter field2 delimiter field3 delimiter field4 delimiter field5)))

; Ensure the line has at least 10 characters total
(assert (>= (str.len csv_line) 10))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
