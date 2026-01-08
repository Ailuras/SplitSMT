; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; This includes handling key-value pairs and validating content-length
(set-logic ALL)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const host_val String)
(declare-const user_agent_str String)
(declare-const user_agent_val String)

; Declare uninterpreted functions for string split operations as per the interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header into lines using newline as delimiter
(assert (>= (num_splits header "\n") 1))

; Extract the first line (e.g., request line or first header) and ensure it's not empty
(declare-const first_line String)
(assert (= first_line (split_at header "\n" 0)))
(assert (> (str.len first_line) 0))

; Define a helper function to extract value from a key-value pair line (e.g., "Content-Length: 123")
; This uses colon as delimiter within each line
(assert (str.contains header ":"))

; Extract Content-Length line: assume it exists and is in the format "Content-Length: <value>"
(assert (str.contains header "Content-Length:"))
(declare-const content_length_line String)
; Find the line containing "Content-Length:" by iterating or using a constraint; simplified here
(assert (= content_length_line (split_at header "\n" 1))) ; Assuming it's the second line for example
(assert (str.contains content_length_line "Content-Length:"))

; Split the Content-Length line by colon to get the value part
(assert (>= (num_splits content_length_line ":") 2))
(assert (= content_length_str (split_at content_length_line ":" 1)))
(assert (> (str.len content_length_str) 0))

; Convert the content length string to an integer and validate it's positive
(assert (= content_length_val (str.to_int content_length_str)))
(assert (> content_length_val 0))
(assert (<= content_length_val 10000)) ; Arbitrary upper bound for realism

; Extract Host line similarly
(assert (str.contains header "Host:"))
(declare-const host_line String)
(assert (= host_line (split_at header "\n" 2))) ; Assuming it's the third line
(assert (str.contains host_line "Host:"))
(assert (>= (num_splits host_line ":") 2))
(assert (= host_str (split_at host_line ":" 1)))
(assert (= host_val (str.trim host_str))) ; Trim whitespace for the host value
(assert (> (str.len host_val) 0))

; Extract User-Agent line
(assert (str.contains header "User-Agent:"))
(declare-const user_agent_line String)
(assert (= user_agent_line (split_at header "\n" 3))) ; Assuming it's the fourth line
(assert (str.contains user_agent_line "User-Agent:"))
(assert (>= (num_splits user_agent_line ":") 2))
(assert (= user_agent_str (split_at user_agent_line ":" 1)))
(assert (= user_agent_val (str.trim user_agent_str)))
(assert (> (str.len user_agent_val) 0))

; Additional constraints to ensure diversity and realism
; Ensure the header has at least 4 lines for the extracted components
(assert (>= (num_splits header "\n") 4))
; Ensure no line is empty after trimming
(assert (not (str.contains header "\n\n"))) ; No consecutive newlines
; Validate that content length value matches the length of some body string (simulated)
(declare-const body String)
(assert (= (str.len body) content_length_val))
(assert (str.contains body "data")) ; Arbitrary content check

; Final check for satisfiability
(check-sat)
(get-model)


; [GENERATION STATUS: SUCCESS]
