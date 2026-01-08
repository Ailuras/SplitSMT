; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
(set-logic ALL)

; Declare variables for the HTTP request header string and its components
(declare-const header String)
(declare-const first_line String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)

; Declare uninterpreted functions for string split operations as per the interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Assert that the header contains at least two lines separated by newline (\n)
(assert (>= (num_splits header "\n") 2))

; Extract the first line (e.g., "GET /index.html HTTP/1.1") by splitting on newline
(assert (= first_line (split_at header "\n" 0)))

; Assert that the first line contains a space to separate method, path, and version
(assert (>= (num_splits first_line " ") 3))

; Extract content-length header value by splitting the entire header on newline and then on colon
; Assume content-length is in the second line for simplicity, but handle general case with split_rest
(assert (= content_length_str (split_at (split_rest header "\n" 1) ":" 1)))

; Validate that content-length value is a non-negative integer
(assert (str.is_digit content_length_str))
(assert (>= (str.to_int content_length_str) 0))
(assert (= content_length_val (str.to_int content_length_str)))

; Additional constraints to ensure diversity: mix simple and complex patterns
; Example: Extract a key-value pair from a specific line (e.g., third line)
(assert (>= (num_splits header "\n") 3))
(assert (= key1 (split_at (split_at header "\n" 2) ":" 0)))
(assert (= value1 (split_at (split_at header "\n" 2) ":" 1)))

; Another example: Use split_rest to handle multiple colons in a line (e.g., "Date: Mon, 01 Jan 2024 12:00:00 GMT")
(declare-const date_line String)
(assert (= date_line (split_at header "\n" 3)))
(assert (>= (num_splits date_line ":") 2))
(assert (= key2 (split_at date_line ":" 0)))
(assert (= value2 (split_rest date_line ":" 1)))

; Add a constraint to make the instance SAT: ensure header is non-empty and has valid structure
(assert (not (= header "")))
(assert (str.contains header ":"))
(assert (str.contains header "\n"))

; Check satisfiability
(check-sat)
(get-value (header first_line content_length_val key1 value1 key2 value2))

; [GENERATION STATUS: SUCCESS]
