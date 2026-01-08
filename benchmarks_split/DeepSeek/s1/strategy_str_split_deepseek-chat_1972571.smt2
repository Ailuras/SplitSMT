; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare variables for HTTP request header string and its components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that header contains at least two lines separated by newline
(assert (>= (num_splits header "\n") 2))

; Extract first key-value pair: split by colon in first line
(assert (= key1 (split_at (split_at header "\n" 0) ":" 0)))
(assert (= value1 (split_rest (split_at header "\n" 0) ":" 1)))

; Extract second key-value pair: split by colon in second line
(assert (= key2 (split_at (split_at header "\n" 1) ":" 0)))
(assert (= value2 (split_rest (split_at header "\n" 1) ":" 1)))

; Validate that one key is "Content-Length" and extract its value
(assert (or (= key1 "Content-Length") (= key2 "Content-Length")))
(assert (=> (= key1 "Content-Length") (= content_length_str value1)))
(assert (=> (= key2 "Content-Length") (= content_length_str value2)))

; Convert content_length_str to integer and ensure it's positive
(assert (str.is_digit content_length_str))
(assert (> (str.to_int content_length_str) 0))
(assert (= content_length_val (str.to_int content_length_str)))

; Additional constraints for diversity: ensure header ends with newline and has no empty lines
(assert (str.suffixof "\n" header))
(assert (not (str.contains header "\n\n")))

; Seed mutation: add regex constraints for header format (e.g., keys are alphabetic, values may include digits)
(assert (str.in_re key1 (re.++ (re.* (re.range "A" "Z")) (re.* (re.range "a" "z")) (re.* (str.to_re "-")))))
(assert (str.in_re key2 (re.++ (re.* (re.range "A" "Z")) (re.* (re.range "a" "z")) (re.* (str.to_re "-")))))
(assert (str.in_re value1 (re.++ (re.* (re.range "0" "9")) (re.* (re.range "a" "z")) (re.* (str.to_re " ")))))
(assert (str.in_re value2 (re.++ (re.* (re.range "0" "9")) (re.* (re.range "a" "z")) (re.* (str.to_re " ")))))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)