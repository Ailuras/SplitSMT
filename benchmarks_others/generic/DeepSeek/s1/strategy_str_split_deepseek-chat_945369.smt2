; HTTP Header Parsing: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
; Mutated and extended from seed to incorporate str_split interface for parsing and validation.
(set-logic ALL)

; Declare string variables for headers and parsed components
(declare-const header String)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)
(declare-const content_length_str String)
(declare-const content_length_val Int)

; Declare uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Assert that header contains at least two lines separated by newline
(assert (>= (num_splits header "\u{a}") 2))

; Extract first line (e.g., "Host: example.com") and split by colon
(assert (= (split_at header "\u{a}" 0) (str.++ key1 ":" value1)))
(assert (>= (num_splits (split_at header "\u{a}" 0) ":") 2))
(assert (= key1 (split_at (split_at header "\u{a}" 0) ":" 0)))
(assert (= value1 (split_at (split_at header "\u{a}" 0) ":" 1)))

; Extract second line (e.g., "Content-Length: 123") and split by colon
(assert (= (split_at header "\u{a}" 1) (str.++ key2 ":" value2)))
(assert (>= (num_splits (split_at header "\u{a}" 1) ":") 2))
(assert (= key2 (split_at (split_at header "\u{a}" 1) ":" 0)))
(assert (= value2 (split_at (split_at header "\u{a}" 1) ":" 1)))

; Validate that key2 is "content-length" (case-insensitive via conversion)
(assert (= (str.to_lower key2) "content-length"))

; Extract numeric part from value2 (e.g., "123") by splitting on spaces if present
(assert (= content_length_str (split_at value2 " " 0)))
(assert (>= (str.to_int content_length_str) 0))
(assert (= content_length_val (str.to_int content_length_str)))

; Additional constraints for value2: no whitespace at start or end, and must contain digits
(assert (not (= (str.at value2 0) " ")))
(assert (not (= (str.at value2 (- (str.len value2) 1)) " ")))
(assert (str.contains value2 "0"))

; Constraint to ensure header ends with newline for proper splitting
(assert (= (str.at header (- (str.len header) 1)) "\u{a}"))

; Check for satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
