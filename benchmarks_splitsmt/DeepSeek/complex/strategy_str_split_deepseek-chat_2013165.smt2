; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, with content-length validation.
(set-logic ALL)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const user_agent_str String)

; Declare uninterpreted functions for str_split interface

; Assert that the header contains at least two lines separated by newline delimiter "\n"
(assert (>= (str.num_splits header "\n") 2))

; Extract the first line (e.g., "Content-Length: 123") by splitting header by newline and taking the 0-th segment
(assert (= content_length_str (str.split_at header "\n" 0)))

; Assert that the first line contains a colon delimiter ":" to separate key and value
(assert (>= (str.num_splits content_length_str ":") 2))

; Extract the value part after the colon from the first line (assuming format "Content-Length: 123")
(assert (= content_length_val (str.to_int (str.split_at content_length_str ":" 1))))

; Validate content-length: must be a non-negative integer
(assert (>= content_length_val 0))

; Extract the second line (e.g., "Host: example.com") by splitting header by newline and taking the 1-st segment
(assert (= host_str (str.split_at header "\n" 1)))

; Assert that the second line contains a colon delimiter ":"
(assert (>= (str.num_splits host_str ":") 2))

; Extract the value part after the colon from the second line
(assert (str.contains (str.split_at host_str ":" 1) "."))

; Extract the third line (e.g., "User-Agent: Mozilla") by splitting header by newline and taking the 2-nd segment
(assert (= user_agent_str (str.split_at header "\n" 2)))

; Assert that the third line contains a colon delimiter ":"
(assert (>= (str.num_splits user_agent_str ":") 2))

; Ensure the header has exactly three lines for a SAT instance (can be adjusted for UNSAT)
(assert (= (str.num_splits header "\n") 3))

; Additional constraint: content-length value must be less than 1000 for a SAT instance
(assert (< content_length_val 1000))

; Check satisfiability


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
