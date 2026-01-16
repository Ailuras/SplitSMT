; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; This scenario validates content-length and key-value pairs, mixing simple and complex patterns
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

; Assert that the header contains at least one newline to ensure multiple lines
(assert (str.contains header "\n"))

; Split the header by newlines to get individual lines
(assert (>= (str.num_splits header "\n") 3))

; Extract the first line (e.g., "Content-Length: 123") and split it by colon
(assert (= content_length_str (str.split_at header "\n" 0)))
(assert (>= (str.num_splits content_length_str ":") 2))
(assert (= content_length_val (str.to_int (str.split_at content_length_str ":" 1))))
(assert (>= content_length_val 0))

; Extract the second line (e.g., "Host: example.com") and split it by colon
(assert (= host_str (str.split_at header "\n" 1)))
(assert (>= (str.num_splits host_str ":") 2))
(assert (= host_val (str.split_at host_str ":" 1)))
(assert (>= (str.len host_val) 1))

; Extract the third line (e.g., "User-Agent: Mozilla") and split it by colon
(assert (= user_agent_str (str.split_at header "\n" 2)))
(assert (>= (str.num_splits user_agent_str ":") 2))
(assert (= user_agent_val (str.split_at user_agent_str ":" 1)))
(assert (>= (str.len user_agent_val) 1))

; Additional constraints for diversity: ensure the header ends with a newline and has no empty lines
(assert (str.suffixof "\n" header))
(assert (not (str.contains header "\n\n")))

; Create a SAT instance by setting specific values for validation
(assert (= content_length_val 123))
(assert (= host_val "example.com"))
(assert (= user_agent_val "Mozilla"))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
