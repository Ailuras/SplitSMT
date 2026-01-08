(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Core HTTP request/header variables
(declare-const raw_request String)
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
(declare-const cl_value_str String)
(declare-const cl_value_int Int)

(declare-const body String)
(declare-const computed_body_len Int)

; Auxiliary strings
(declare-const crlf String)
(declare-const colon String)
(declare-const empty String)

(assert (= crlf "\r\n"))
(assert (= colon ":"))
(assert (= empty ""))

; Split request into header block and body using CRLFCRLF
(assert (= header_block (split_at raw_request (str.++ crlf crlf) 0)))
(assert (= body (split_at raw_request (str.++ crlf crlf) 1)))
(assert (>= (num_splits raw_request (str.++ crlf crlf)) 2))

; First line is request-line
(assert (= request_line (split_at header_block crlf 0)))
(assert (>= (num_splits header_block crlf) 2))

; Parse request-line: "METHOD SP URI SP HTTP/VERSION"
(assert (= method (split_at request_line " " 0)))
(assert (= uri (split_at request_line " " 1)))
(assert (= http_version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))

; Basic validation for method and http version
(assert (or (= method "GET") (= method "POST") (= method "PUT") (= method "HEAD")))
(assert (or (= http_version "HTTP/1.0") (= http_version "HTTP/1.1")))

; Extract Host header line as the second line (common case)
(assert (= host_line (split_at header_block crlf 1)))
(assert (= host_key (split_at host_line colon 0)))
(assert (= host_value (split_at host_line colon 1)))
(assert (>= (num_splits host_line colon) 2))

; Host header checks
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; Extract Content-Length header line as third line (common case)
(assert (= cl_line (split_at header_block crlf 2)))
(assert (= cl_key (split_at cl_line colon 0)))
(assert (= cl_value_str (split_at cl_line colon 1)))
(assert (>= (num_splits cl_line colon) 2))

; Content-Length header checks
(assert (= cl_key "Content-Length"))
(assert (> (str.len cl_value_str) 0))
(assert (not (str.contains cl_value_str "\r")))
(assert (not (str.contains cl_value_str "\n")))

; Constrain Content-Length to be a non-negative integer and equal to the body length
(assert (>= cl_value_int 0))
(assert (= computed_body_len (str.len body)))
(assert (= cl_value_int computed_body_len))

; Ensure header ordering and newline presence
(assert (str.contains header_block crlf))
(assert (str.contains raw_request (str.++ crlf crlf)))

; ----- SAT instance: a well-formed request -----
(declare-const sat_request String)
(declare-const sat_body String)
(declare-const sat_header String)
(declare-const sat_host String)

(assert (= sat_body "HELLO"))
(assert (= sat_host " example.com"))
(assert (= sat_header (str.++
  "POST /submit HTTP/1.1" crlf
  "Host:" sat_host crlf
  "Content-Length: 5" crlf
  crlf)))
(assert (= sat_request (str.++ sat_header sat_body)))

; Tie the core variables to the SAT instance
(assert (= raw_request sat_request))

; ----- UNSAT instance: conflicting Content-Length vs actual body length -----
; We create an additional request that must simultaneously satisfy a contradictory length requirement.
(declare-const raw_request_bad String)
(declare-const header_block_bad String)
(declare-const body_bad String)
(declare-const cl_value_int_bad Int)
(declare-const computed_body_len_bad Int)

(assert (= header_block_bad (split_at raw_request_bad (str.++ crlf crlf) 0)))
(assert (= body_bad (split_at raw_request_bad (str.++ crlf crlf) 1)))
(assert (>= (num_splits raw_request_bad (str.++ crlf crlf)) 2))
(assert (= computed_body_len_bad (str.len body_bad)))

; Force a concrete body of length 4 but also force the declared Content-Length int to be 5
(assert (= body_bad "DATA"))
(assert (= cl_value_int_bad 5))
(assert (= computed_body_len_bad 4))

; Additionally require these two to be equal (contradiction)
(assert (= cl_value_int_bad computed_body_len_bad))

(check-sat)


; [GENERATION STATUS: SUCCESS]
