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

; Constraint 2: Extract first header line using split_at
(assert (= header_line (split_at request "\n" 0)))

; Constraint 3: First header line must contain a colon to separate key-value pair
(assert (>= (num_splits header_line ":") 2))

; Constraint 4: Extract key (before colon) and value (after colon) from first header line
(assert (= key (split_at header_line ":" 0)))
(assert (= value (split_at header_line ":" 1)))

; Constraint 5: Key must be non-empty and contain only valid HTTP header characters
(assert (> (str.len key) 0))
(assert (str.in_re key (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))

; Constraint 6: Value must be non-empty and may contain spaces, letters, digits, and hyphens
(assert (> (str.len value) 0))
(assert (str.in_re value (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re " ") (str.to_re "-")))))

; Constraint 7: Check if there's a Content-Length header in the request
(assert (str.contains request "Content-Length"))

; Constraint 8: Extract the Content-Length value using split operations
; First, find the line containing "Content-Length"
(assert (str.contains (split_at request "\n" 1) "Content-Length"))
(assert (= content_length_str (split_at (split_at request "\n" 1) ":" 1)))

; Constraint 9: Content-Length value must be a positive integer
(assert (str.in_re content_length_str (re.+ (re.range "0" "9"))))

; Constraint 10: Convert content_length_str to integer and ensure it's within reasonable bounds
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
(assert (<= content_length_val 1000000))

; Constraint 11: Ensure the request ends properly (optional trailing newline)
(assert (str.suffixof "\n" request))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
