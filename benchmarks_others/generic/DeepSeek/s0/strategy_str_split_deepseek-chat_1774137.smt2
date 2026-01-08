; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, with content-length validation.
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
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header into lines using newline as delimiter
(assert (>= (num_splits header "\n") 1))

; Extract the first line (e.g., request line or first header) and ensure it's not empty
(assert (not (= (split_at header "\n" 0) "")))

; Extract the content-length line: assume it's the second line (index 1) for this scenario
(assert (= content_length_str (split_at header "\n" 1)))
(assert (str.contains content_length_str ":"))

; Split the content-length line by colon to get the value part
(assert (>= (num_splits content_length_str ":") 2))
(assert (= content_length_val (str.to_int (split_at content_length_str ":" 1))))

; Validate content-length: must be a non-negative integer
(assert (>= content_length_val 0))
(assert (<= content_length_val 10000)) ; Upper bound for realism

; Extract the host line: assume it's the third line (index 2)
(assert (= host_str (split_at header "\n" 2)))
(assert (str.contains host_str ":"))
(assert (>= (num_splits host_str ":") 2))
(assert (= host_val (split_at host_str ":" 1)))
(assert (not (= host_val ""))) ; Host value should not be empty

; Extract the user-agent line: assume it's the fourth line (index 3)
(assert (= user_agent_str (split_at header "\n" 3)))
(assert (str.contains user_agent_str ":"))
(assert (>= (num_splits user_agent_str ":") 2))
(assert (= user_agent_val (split_at user_agent_str ":" 1)))
(assert (not (= user_agent_val ""))) ; User-agent value should not be empty

; Additional constraints to ensure diversity and realism
; The header must start with a method like "GET" or "POST"
(assert (or (str.prefixof "GET " (split_at header "\n" 0))
            (str.prefixof "POST " (split_at header "\n" 0))))

; The host value should be a valid domain (contains a dot)
(assert (str.contains host_val "."))

; The user-agent value should contain a space (common in user-agent strings)
(assert (str.contains user_agent_val " "))

; Ensure the header has at least 4 lines for the extractions above
(assert (>= (num_splits header "\n") 4))

; Check satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
