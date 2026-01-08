(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; === HTTP Header Parsing scenario ===
(declare-const request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

(declare-const host_header_line String)
(declare-const cl_header_line String)
(declare-const ua_header_line String)

(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const content_length Int)
(declare-const body String)

; === Basic structure: request-line, header-block, body ===
; Format sketch: "<request-line>\n<header1>\n<header2>\n...\n\n<body>"
(assert (= request_line (split_at request "\n" 0)))
(assert (= header_block (split_rest request "\n" 1)))

; The header_block still contains headers plus the blank-line and body.
; Force at least a few lines to exist.
(assert (>= (num_splits request "\n") 6))

; Request-line parsing: "METHOD SP PATH SP HTTP/1.1"
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))
(assert (or (= method "GET") (= method "POST")))
(assert (str.contains version "HTTP/"))

; Choose specific header lines by index in the original request
(assert (= host_header_line (split_at request "\n" 1)))
(assert (= ua_header_line (split_at request "\n" 2)))
(assert (= cl_header_line (split_at request "\n" 3)))

; The empty line separating headers and body is at index 4
(assert (= (split_at request "\n" 4) ""))
(assert (= body (split_rest request "\n" 5)))

; === Parse key-value pairs via colon delimiter ===
(assert (= host_key (split_at host_header_line ":" 0)))
(assert (= host_value (split_rest host_header_line ":" 1)))
(assert (>= (num_splits host_header_line ":") 2))

(assert (= ua_key (split_at ua_header_line ":" 0)))
(assert (= ua_value (split_rest ua_header_line ":" 1)))
(assert (>= (num_splits ua_header_line ":") 2))

(assert (= cl_key (split_at cl_header_line ":" 0)))
(assert (= cl_value (split_rest cl_header_line ":" 1)))
(assert (>= (num_splits cl_header_line ":") 2))

; Require expected keys (exact match, no canonicalization)
(assert (= host_key "Host"))
(assert (= ua_key "User-Agent"))
(assert (= cl_key "Content-Length"))

; Values should have a leading space in typical HTTP formatting: "Key: value"
(assert (str.prefixof " " host_value))
(assert (str.prefixof " " ua_value))
(assert (str.prefixof " " cl_value))

; Host should contain at least one dot after the leading space (e.g., " example.com")
(assert (str.contains host_value "."))

; === Validate Content-Length as digits and bind to an Int ===
; cl_value is like " 123"; strip the leading space by taking substring from index 1.
(declare-const cl_digits String)
(assert (= cl_digits (str.substr cl_value 1 (- (str.len cl_value) 1))))

; Digit regex: [0-9]+
(declare-const digit_re RegLan)
(assert (= digit_re (re.+ (re.range "0" "9"))))
(assert (str.in_re cl_digits digit_re))

; Convert to Int and relate to body length
(assert (= content_length (str.to_int cl_digits)))
(assert (>= content_length 0))

; Define body as a concrete payload to make the instance SAT and check length relation.
; body may include newlines since it is split_rest from index 5.
(assert (= body "HelloWorld"))
(assert (= content_length (str.len body)))

; Also constrain request to be consistent with the chosen concrete lines.
(assert (= request (str.++ request_line "\n" host_header_line "\n" ua_header_line "\n" cl_header_line "\n\n" body)))

; Provide concrete but nontrivial request-line and headers compatible with parsing constraints.
(assert (= request_line "POST /submit HTTP/1.1"))
(assert (= host_header_line "Host: example.com"))
(assert (= ua_header_line "User-Agent: TestAgent/1.0"))
; Content-Length must match "HelloWorld" length = 10
(assert (= cl_header_line "Content-Length: 10"))

; === Additional SAT-side sanity constraints ===
(assert (>= (str.len path) 1))
(assert (str.prefixof "/" path))
(assert (>= (num_splits host_header_line ":") 2))

; === Separate UNSAT instance constraints (in the same file) ===
; These constraints intentionally contradict the SAT construction above.
; 1) Force a different content-length than the body length.
(assert (= content_length (+ (str.len body) 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]