(set-logic ALL)

; Uninterpreted interface for string split

; --- Scenario: HTTP Header Parsing ---
; We model an HTTP request header block and extract key/value pairs separated by ": " and "\r\n".

(declare-const request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const method String)
(declare-const uri String)
(declare-const http_version String)

(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)

(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const cl_len Int)

(declare-const ua_line String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const body String)
(declare-const body_len Int)

; SAT/UNSAT switch
(declare-const make_unsat Bool)

; Basic decomposition: header block vs body separated by CRLFCRLF
(assert (= header_block (str.split_at request "\r\n\r\n" 0)))
(assert (= body (str.split_rest request "\r\n\r\n" 1)))
(assert (>= (str.num_splits request "\r\n\r\n") 2))

; Header lines split by CRLF: request line is first line
(assert (= request_line (str.split_at header_block "\r\n" 0)))
(assert (>= (str.num_splits header_block "\r\n") 4))

; Parse request line: "METHOD SP URI SP HTTP/VERSION"
(assert (= method (str.split_at request_line " " 0)))
(assert (= uri (str.split_at request_line " " 1)))
(assert (= http_version (str.split_at request_line " " 2)))
(assert (>= (str.num_splits request_line " ") 3))
(assert (or (= method "GET") (= method "POST")))
(assert (or (= http_version "HTTP/1.1") (= http_version "HTTP/1.0")))
(assert (not (= uri "")))

; Select specific header lines by fixed indices for simplicity
(assert (= host_line (str.split_at header_block "\r\n" 1)))
(assert (= cl_line   (str.split_at header_block "\r\n" 2)))
(assert (= ua_line   (str.split_at header_block "\r\n" 3)))

; Each header line should contain a colon-space delimiter
(assert (>= (str.num_splits host_line ": ") 2))
(assert (>= (str.num_splits cl_line ": ") 2))
(assert (>= (str.num_splits ua_line ": ") 2))

; Extract key and value for each header
(assert (= host_key   (str.split_at host_line ": " 0)))
(assert (= host_value (str.split_rest host_line ": " 1)))

(assert (= cl_key     (str.split_at cl_line ": " 0)))
(assert (= cl_value   (str.split_rest cl_line ": " 1)))

(assert (= ua_key     (str.split_at ua_line ": " 0)))
(assert (= ua_value   (str.split_rest ua_line ": " 1)))

; Validate expected keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Basic sanity on values
(assert (not (= host_value "")))
(assert (not (= ua_value "")))

; Constrain Host format loosely (must contain at least one dot)
(assert (str.contains host_value "."))
(assert (not (str.contains host_value " ")))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; Content-Length must be a non-empty decimal numeral
(assert (not (= cl_value "")))
(assert (= cl_len (str.to_int cl_value)))
(assert (>= cl_len 0))

; Body length check against Content-Length
(assert (= body_len (str.len body)))

; Some structure expectations: body does not contain CRLFCRLF prefix remnants
(assert (not (str.contains body "\r\n\r\n")))

; Build a SAT instance: typical POST with matching length
(assert (= method "POST"))
(assert (= uri "/submit"))
(assert (= host_value "example.com"))
(assert (= ua_value "curl/8.0"))
(assert (= body "abcde"))
(assert (= cl_value "5"))
(assert (= cl_len 5))
(assert (= body_len 5))

; Also create an UNSAT branch: require conflicting Content-Length
; If make_unsat then force mismatch (cl_len = body_len + 1) while also keeping equality.
(assert (=> make_unsat (= cl_len (+ body_len 1))))
(assert (=> make_unsat (= cl_len body_len)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
