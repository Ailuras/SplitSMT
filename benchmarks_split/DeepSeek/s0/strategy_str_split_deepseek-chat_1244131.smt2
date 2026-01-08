; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, with content-length validation.
(set-logic ALL)

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const user_agent_str String)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header by newlines to get individual lines; assume first line is request line (e.g., GET / HTTP/1.1)
(assert (>= (num_splits header "\n") 2))

; Extract the second line (index 1) as the first header line after the request line
(assert (= host_str (split_at header "\n" 1)))

; Ensure the host line contains a colon to separate key and value
(assert (str.contains host_str ":"))

; Split the host line by colon to get the value part (index 1)
(assert (= host_str (str.++ "Host: " (split_at host_str ":" 1))))

; Extract the third line (index 2) as another header line, e.g., User-Agent
(assert (= user_agent_str (split_at header "\n" 2)))

; Ensure the user-agent line contains a colon
(assert (str.contains user_agent_str ":"))

; Split the user-agent line by colon to get the value part
(assert (= user_agent_str (str.++ "User-Agent: " (split_at user_agent_str ":" 1))))

; Find the Content-Length line by checking each line; use split_rest to search
(assert (str.contains header "Content-Length"))

; Extract the Content-Length line: assume it's at index 3 for simplicity
(assert (= content_length_str (split_at header "\n" 3)))

; Ensure the Content-Length line contains a colon
(assert (str.contains content_length_str ":"))

; Split the Content-Length line by colon to get the value string
(assert (= content_length_str (str.++ "Content-Length: " (split_at content_length_str ":" 1))))

; Convert the value string to an integer for validation
(assert (str.is_digit (split_at content_length_str ":" 1)))
(assert (= content_length_val (str.to_int (split_at content_length_str ":" 1))))

; Validate content-length: must be non-negative and less than a reasonable limit (e.g., 10000)
(assert (>= content_length_val 0))
(assert (<= content_length_val 10000))

; Additional constraint to make it SAT: ensure the header has at least 4 lines (request line + 3 headers)
(assert (>= (num_splits header "\n") 4))

; Check satisfiability
(check-sat)
(get-value (header content_length_val host_str user_agent_str))


; [GENERATION STATUS: SUCCESS]