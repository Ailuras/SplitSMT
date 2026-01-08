; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string and integer arithmetic for validation
(set-logic ALL)

; Declare variables for the HTTP request header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const host_val String)
(declare-const user_agent_str String)
(declare-const user_agent_val String)

; Declare uninterpreted functions for str_split interface operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header by newlines to get individual lines
(assert (>= (num_splits header "\n") 1))

; Extract the first line (e.g., "Content-Length: 123") and split it by colon to get key and value
(assert (= content_length_str (split_at header "\n" 0)))
(assert (>= (num_splits content_length_str ":") 2))
(assert (= content_length_val (str.to_int (split_at content_length_str ":" 1))))

; Validate content-length: must be a non-negative integer
(assert (>= content_length_val 0))

; Extract the second line (e.g., "Host: example.com") if it exists
(assert (>= (num_splits header "\n") 2))
(assert (= host_str (split_at header "\n" 1)))
(assert (>= (num_splits host_str ":") 2))
(assert (= host_val (split_at host_str ":" 1)))

; Ensure host value is non-empty
(assert (> (str.len host_val) 0))

; Extract the third line (e.g., "User-Agent: Mozilla") if it exists
(assert (>= (num_splits header "\n") 3))
(assert (= user_agent_str (split_at header "\n" 2)))
(assert (>= (num_splits user_agent_str ":") 2))
(assert (= user_agent_val (split_at user_agent_str ":" 1)))

; Ensure user-agent value is non-empty
(assert (> (str.len user_agent_val) 0))

; Additional constraint: content-length must be less than 1000 to create a SAT instance
(assert (< content_length_val 1000))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
