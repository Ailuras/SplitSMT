; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare variables for HTTP request header and components
(declare-const header String)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)
(declare-const content_length_str String)
(declare-const content_length Int)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Assert that header contains at least two key-value pairs separated by newlines
(assert (>= (num_splits header "\n") 2))

; Extract first key-value pair: split by colon and newline
(assert (= key1 (split_at (split_at header "\n" 0) ":" 0)))
(assert (= value1 (split_rest (split_at header "\n" 0) ":" 1)))

; Extract second key-value pair: similar process
(assert (= key2 (split_at (split_at header "\n" 1) ":" 0)))
(assert (= value2 (split_rest (split_at header "\n" 1) ":" 1)))

; Validate that one key is "Content-Length" and extract its value
(assert (or (= key1 "Content-Length") (= key2 "Content-Length")))
(assert (=> (= key1 "Content-Length") (= content_length_str value1)))
(assert (=> (= key2 "Content-Length") (= content_length_str value2)))

; Ensure content_length_str consists only of digits and convert to integer
(assert (str.in_re content_length_str (re.* (re.range "0" "9"))))
(assert (> (str.len content_length_str) 0))
(assert (= content_length (str.to_int content_length_str)))

; Constraint: content-length must be positive and less than 10000
(assert (> content_length 0))
(assert (< content_length 10000))

; Additional constraint: header must end with a newline for proper formatting
(assert (str.suffixof "\n" header))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
