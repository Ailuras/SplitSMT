(set-logic ALL)

; Uninterpreted interface for str_split

; Additional uninterpreted helpers for header processing
(declare-fun trim (String) String)
(declare-fun to_lower (String) String)
(declare-fun str_to_int (String) Int)
(declare-fun is_digits (String) Bool)
(declare-fun header_value (String String) String)

; Core HTTP request/header strings
(declare-const req String)
(declare-const header_block String)
(declare-const body String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const http_version String)

; Derived header lines
(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)

; Parsed key/value for specific headers
(declare-const host_line String)
(declare-const host_key String)
(declare-const host_val String)

(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_val_raw String)
(declare-const cl_val String)
(declare-const content_length Int)

; Another header to add diversity
(declare-const ua_line String)
(declare-const ua_key String)
(declare-const ua_val String)

; General sanity constraints
(assert (>= (str.len req) 0))
(assert (>= (str.len header_block) 0))
(assert (>= (str.len body) 0))

; Model a request as: request_line \r\n header_block \r\n\r\n body
(assert (= req (str.++ request_line "\r\n" header_block "\r\n\r\n" body)))

; Parse request line by spaces: METHOD SP PATH SP HTTP/VERSION
(assert (>= (str.num_splits request_line " ") 3))
(assert (= method (str.split_at request_line " " 0)))
(assert (= path (str.split_at request_line " " 1)))
(assert (= http_version (str.split_at request_line " " 2)))

; HTTP version basic shape constraint
(assert (str.contains http_version "HTTP/"))

; Header block split by CRLF into lines
(assert (>= (str.num_splits header_block "\r\n") 4))
(assert (= line0 (str.split_at header_block "\r\n" 0)))
(assert (= line1 (str.split_at header_block "\r\n" 1)))
(assert (= line2 (str.split_at header_block "\r\n" 2)))
(assert (= line3 (str.split_at header_block "\r\n" 3)))

; Require each header line to contain a colon separating key/value
(assert (str.contains line0 ":"))
(assert (str.contains line1 ":"))
(assert (str.contains line2 ":"))
(assert (str.contains line3 ":"))

; Choose particular lines to be Host, Content-Length, and User-Agent
(assert (= host_line line0))
(assert (= cl_line line1))
(assert (= ua_line line2))

; Parse Host line: key:value
(assert (>= (str.num_splits host_line ":") 2))
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_val (trim (str.split_rest host_line ":" 1))))
(assert (= (to_lower (trim host_key)) "host"))
(assert (> (str.len host_val) 0))

; Parse Content-Length line: key:value
(assert (>= (str.num_splits cl_line ":") 2))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_val_raw (str.split_rest cl_line ":" 1)))
(assert (= cl_val (trim cl_val_raw)))
(assert (= (to_lower (trim cl_key)) "content-length"))

; Validate Content-Length: digits-only, non-negative, matches body length
(assert (is_digits cl_val))
(assert (= content_length (str_to_int cl_val)))
(assert (>= content_length 0))
(assert (= content_length (str.len body)))

; Parse User-Agent line for additional variety
(assert (>= (str.num_splits ua_line ":") 2))
(assert (= ua_key (str.split_at ua_line ":" 0)))
(assert (= ua_val (trim (str.split_rest ua_line ":" 1))))
(assert (= (to_lower (trim ua_key)) "user-agent"))
(assert (> (str.len ua_val) 0))

; Provide a concrete SAT instance
(assert (= method "POST"))
(assert (= path "/upload"))
(assert (= http_version "HTTP/1.1"))

; Concrete headers/body; rely on split/trim/to_lower/is_digits/str_to_int consistency via constraints above
(assert (= host_line "Host: example.com"))
(assert (= ua_line "User-Agent: TestClient/1.0"))
(assert (= body "abcd"))
(assert (= cl_line "Content-Length: 4"))

; Ensure the unused line3 is some other well-formed header
(assert (= line3 "X-Trace: 9f3a"))

(check-sat)

; --- UNSAT instance: same structure but contradictory content-length ---

; Re-fix the request structure but force a conflicting Content-Length vs body
(assert (= method "POST"))
(assert (= path "/upload"))
(assert (= http_version "HTTP/1.1"))

(assert (= host_line "Host: example.com"))
(assert (= ua_line "User-Agent: TestClient/1.0"))
(assert (= body "abcd"))

; Contradiction: header says 5 but body length is 4
(assert (= cl_line "Content-Length: 5"))

(check-sat)
(exit)
