; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare string variables for HTTP request headers
(declare-const request String)
(declare-const header_line String)
(declare-const key String)
(declare-const value String)
(declare-const content_length_str String)

; Declare integer variables for validation
(declare-const content_length Int)
(declare-const num_headers Int)

; Declare uninterpreted functions for str_split interface

; Constraint 1: Request contains multiple header lines separated by newlines
(assert (>= (str.num_splits request "\n") 2))

; Constraint 2: Extract first header line
(assert (= header_line (str.split_at request "\n" 0)))

; Constraint 3: First header line must have a colon separator
(assert (>= (str.num_splits header_line ":") 2))

; Constraint 4: Extract key from first header line (before colon)
(assert (= key (str.split_at header_line ":" 0)))

; Constraint 5: Extract value from first header line (after colon)
(assert (= value (str.split_at header_line ":" 1)))

; Constraint 6: Key must be non-empty
(assert (> (str.len key) 0))

; Constraint 7: Value must be non-empty
(assert (> (str.len value) 0))

; Constraint 8: Look for Content-Length header in the request
(assert (str.contains request "Content-Length"))

; Constraint 9: Extract the line containing Content-Length
(assert (str.contains (str.split_at request "\n" 1) "Content-Length"))

; Constraint 10: Get the Content-Length value string
(assert (= content_length_str (str.split_at (str.split_at request "\n" 1) ":" 1)))

; Constraint 11: Convert Content-Length string to integer
(assert (= content_length (str.to_int content_length_str)))

; Constraint 12: Content-Length must be a positive integer
(assert (> content_length 0))

; Constraint 13: Content-Length must be less than 10000
(assert (< content_length 10000))

; Constraint 14: Total number of headers (lines) must be at least 3
(assert (= num_headers (str.num_splits request "\n")))
(assert (>= num_headers 3))

; Constraint 15: All header lines must contain a colon
(assert (forall ((i Int))
    (=> (and (>= i 0) (< i num_headers))
        (>= (str.num_splits (str.split_at request "\n" i) ":") 2))))

; Constraint 16: No empty header lines
(assert (forall ((i Int))
    (=> (and (>= i 0) (< i num_headers))
        (> (str.len (str.split_at request "\n" i)) 0))))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
