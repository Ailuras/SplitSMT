; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
; Mutated and extended from seed to incorporate str_split operations and diverse constraints.
(set-logic ALL)

; Declare string variables for HTTP headers and components
(declare-const header String)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)
(declare-const content_length_str String)
(declare-const content_length_val Int)

; Declare functions for str_split interface

; Constraint 1: Header must contain specific key-value pairs separated by colons and newlines
(assert (str.contains header "User-Agent:"))
(assert (str.contains header "Host:"))
(assert (str.contains header "Content-Length:"))

; Constraint 2: Split header by newline to extract segments
(assert (>= (str.num_splits header "\u{a}") 3))
(assert (= key1 (str.split_at header "\u{a}" 0)))
(assert (= value1 (str.split_rest header "\u{a}" 1)))

; Constraint 3: Further split first segment by colon to get key and value
(assert (>= (str.num_splits key1 ":") 2))
(assert (= (str.split_at key1 ":" 0) "User-Agent"))
(assert (>= (str.len (str.split_at key1 ":" 1)) 1))

; Constraint 4: Extract Content-Length value and validate it as a positive integer
(assert (str.contains header "Content-Length:"))
(assert (= content_length_str (str.split_at header "Content-Length:" 1)))
(assert (str.in_re content_length_str (re.+ (re.range "0" "9"))))
(assert (>= (str.to_int content_length_str) 0))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (<= content_length_val 10000))

; Constraint 5: Header must match a regex pattern for valid HTTP request structure
(assert (str.in_re header (re.++ (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (str.to_re "-") (str.to_re ":") (str.to_re " ") (str.to_re "\u{a}"))) (str.to_re "\u{a}\u{a}"))))

; Constraint 6: Ensure no malicious patterns (e.g., Trojan) are present
(assert (not (str.in_re header (re.++ (str.to_re "Trojan:") (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "by") (re.+ (re.range "0" "9")) (str.to_re "to") (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "dddlogin.dudu.comSurveillance\u{13}IPOblivion\u{a}")))))

; Constraint 7: Header must not contain invalid port patterns
(assert (not (str.in_re header (re.++ (str.to_re "01") ((_ re.loop 1 1) (re.range "0" "2")) ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "\u{a}")))))

; Constraint 8: Header must not contain specific filename patterns
(assert (not (str.in_re header (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".m4b/i\u{a}")))))

; Constraint 9: Additional validation for key2 and value2 using split operations
(assert (= key2 (str.split_at header "\u{a}" 1)))
(assert (str.contains key2 ":"))
(assert (= value2 (str.split_rest header "\u{a}" 2)))
(assert (>= (str.len value2) 5))

; Check satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
