; HTTP Header Parsing with str_split operations
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Declare string variables for HTTP request headers
(declare-const request String)
(declare-const header_line String)
(declare-const key String)
(declare-const value String)
(declare-const content_length_str String)
(declare-const content_length_val Int)

; Declare str_split interface functions

; Constraint 1: Request must contain at least one header line separated by newline
(assert (>= (num_splits request "\n") 1))

; Constraint 2: Extract first header line
(assert (= header_line (split_at request "\n" 0)))

; Constraint 3: Header line must contain a colon separator
(assert (>= (num_splits header_line ":") 2))

; Constraint 4: Extract key (before colon) and value (after colon) from first header line
(assert (= key (split_at header_line ":" 0)))
(assert (= value (split_rest header_line ":" 1)))

; Constraint 5: Key must be non-empty
(assert (> (str.len key) 0))

; Constraint 6: If key is "Content-Length", value must be a valid integer string
(assert (=> (= key "Content-Length") (str.is_digit value)))

; Constraint 7: Extract content-length value if present
(assert (= content_length_str (ite (= key "Content-Length") value "0")))

; Constraint 8: Convert content-length string to integer (using uninterpreted function)
(declare-fun str_to_int (String) Int)
(assert (= content_length_val (str_to_int content_length_str)))

; Constraint 9: Content-length must be non-negative if present
(assert (=> (= key "Content-Length") (>= content_length_val 0)))

; Constraint 10: Additional constraint to make it SAT - request must start with valid header
(assert (str.prefixof request "Content-Length:"))

; Constraint 11: Ensure request has proper format (example to avoid trivial SAT)
(assert (str.contains request "\n"))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
