; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic: ALL includes strings and integers
(set-logic ALL)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const host_val String)
(declare-const user_agent_str String)
(declare-const user_agent_val String)

; Declare uninterpreted functions for str_split interface

; Assert that the header contains at least three lines separated by newlines
(assert (>= (str.num_splits header "\n") 3))

; Extract the first line (Content-Length) by splitting on newline and taking segment 0
(assert (= content_length_str (str.split_at header "\n" 0)))
; Ensure the Content-Length line contains a colon
(assert (>= (str.num_splits content_length_str ":") 2))
; Extract the value part after the colon (segment 1) and convert to integer
(assert (= content_length_val (str.to_int (str.split_at content_length_str ":" 1))))
; Validate content-length is a positive integer
(assert (> content_length_val 0))

; Extract the second line (Host) by splitting on newline and taking segment 1
(assert (= host_str (str.split_at header "\n" 1)))
; Ensure the Host line contains a colon
(assert (>= (str.num_splits host_str ":") 2))
; Extract the value part after the colon (segment 1)
(assert (= host_val (str.split_at host_str ":" 1)))
; Validate host value is non-empty
(assert (> (str.len host_val) 0))

; Extract the third line (User-Agent) by splitting on newline and taking segment 2
(assert (= user_agent_str (str.split_at header "\n" 2)))
; Ensure the User-Agent line contains a colon
(assert (>= (str.num_splits user_agent_str ":") 2))
; Extract the value part after the colon (segment 1)
(assert (= user_agent_val (str.split_at user_agent_str ":" 1)))
; Validate user-agent value is non-empty
(assert (> (str.len user_agent_val) 0))

; Additional constraint: Ensure the header ends properly (no trailing newline issues)
(assert (not (str.contains (str.split_rest header "\n" 3) "\n")))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
