; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare string variables for HTTP request headers
(declare-const request String)
(declare-const host_header String)
(declare-const content_length_header String)
(declare-const content_length_value String)
(declare-const first_line String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

; Declare integer variables for validation
(declare-const content_length Int)
(declare-const header_count Int)

; Declare str_split interface functions

; Constraint 1: Request must contain at least 3 headers (first line + Host + Content-Length)
(assert (>= (str.num_splits request "\u{a}") 3))

; Constraint 2: Extract first line (method path version)
(assert (= first_line (str.split_at request "\u{a}" 0)))
(assert (>= (str.num_splits first_line " ") 3))
(assert (= method (str.split_at first_line " " 0)))
(assert (= path (str.split_at first_line " " 1)))
(assert (= version (str.split_at first_line " " 2)))

; Constraint 3: Method must be GET or POST
(assert (or (= method "GET") (= method "POST")))

; Constraint 4: Extract Host header (second line)
(assert (= host_header (str.split_at request "\u{a}" 1)))
(assert (str.contains host_header "Host:"))
(assert (>= (str.num_splits host_header ":") 2))
(assert (str.contains (str.split_at host_header ":" 1) "example.com"))

; Constraint 5: Extract Content-Length header (third line)
(assert (= content_length_header (str.split_at request "\u{a}" 2)))
(assert (str.contains content_length_header "Content-Length:"))
(assert (>= (str.num_splits content_length_header ":") 2))
(assert (= content_length_value (str.split_at content_length_header ":" 1)))

; Constraint 6: Content-Length value must be a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (> (str.len content_length_value) 0))
(assert (<= (str.len content_length_value) 5))

; Constraint 7: Convert content_length_value string to integer
(assert (= content_length (str.to_int content_length_value)))
(assert (>= content_length 0))
(assert (<= content_length 10000))

; Constraint 8: If method is POST, Content-Length must be > 0
(assert (=> (= method "POST") (> content_length 0)))

; Constraint 9: If method is GET, Content-Length must be 0
(assert (=> (= method "GET") (= content_length 0)))

; Constraint 10: Validate there are no extra headers after Content-Length (optional)
(assert (= (str.split_rest request "\u{a}" 3) ""))

; Constraint 11: Ensure no malformed headers (no empty lines)
(assert (not (str.contains request "\u{a}\u{a}")))

; Constraint 12: Path must start with /
(assert (str.prefixof "/" path))

; Constraint 13: Version must be HTTP/1.1 or HTTP/2.0
(assert (or (= version "HTTP/1.1") (= version "HTTP/2.0")))

; Constraint 14: Host header value must not contain spaces after colon
(assert (not (str.contains (str.split_at host_header ":" 1) " ")))

; Final check for satisfiability
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
