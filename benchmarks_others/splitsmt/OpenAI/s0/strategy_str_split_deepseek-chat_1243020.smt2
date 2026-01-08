(set-logic ALL)

; Uninterpreted split interface (string split via relaxation)

; -------- Shared symbols --------
(declare-const request String)
(declare-const headers String)
(declare-const body String)
(declare-const header_line0 String)
(declare-const header_line1 String)
(declare-const header_line2 String)
(declare-const header_line3 String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)
(declare-const parsed_len Int)

; Additional strings for constraints and diversity
(declare-const method_line String)
(declare-const http_version String)
(declare-const request_target String)
(declare-const host_name String)
(declare-const host_port String)
(declare-const ua_key String)
(declare-const ua_value String)

; -------- Basic HTTP request structure constraints --------
; request = headers + "\r\n\r\n" + body
(assert (= headers (str.split_at request "\r\n\r\n" 0)))
(assert (= body (str.split_at request "\r\n\r\n" 1)))
(assert (>= (str.num_splits request "\r\n\r\n") 2))

; headers consists of CRLF-separated lines; require at least request-line + 2 header lines
(assert (>= (str.num_splits headers "\r\n") 3))
(assert (= method_line (str.split_at headers "\r\n" 0)))
(assert (= header_line0 (str.split_at headers "\r\n" 1)))
(assert (= header_line1 (str.split_at headers "\r\n" 2)))
(assert (= header_line2 (str.split_at headers "\r\n" 3)))
(assert (= header_line3 (str.split_at headers "\r\n" 4)))

; Request-line: "GET <target> HTTP/1.1" (relaxed via split)
(assert (= "GET" (str.split_at method_line " " 0)))
(assert (= request_target (str.split_at method_line " " 1)))
(assert (= http_version (str.split_at method_line " " 2)))
(assert (= "HTTP/1.1" http_version))
(assert (>= (str.num_splits method_line " ") 3))

; Target is a path starting with '/'
(assert (>= (str.len request_target) 1))
(assert (= "/" (str.substr request_target 0 1)))

; -------- Parse Host header line --------
; Ensure there is a Host header among the first few header lines
; We'll pick header_line0 as Host for the SAT core instance
(assert (= host_key (str.split_at header_line0 ":" 0)))
(assert (= host_value (str.split_at header_line0 ":" 1)))
(assert (>= (str.num_splits header_line0 ":") 2))
(assert (= "Host" host_key))

; Host value has optional leading space and optional ":<port>" suffix
; Constrain it to be " example.com:80" style (leading space)
(assert (>= (str.len host_value) 1))
(assert (= " " (str.substr host_value 0 1)))
(assert (= host_name (str.split_at (str.substr host_value 1 (- (str.len host_value) 1)) ":" 0)))
(assert (= host_port (str.split_at (str.substr host_value 1 (- (str.len host_value) 1)) ":" 1)))
(assert (>= (str.num_splits (str.substr host_value 1 (- (str.len host_value) 1)) ":") 2))

; Hostname is example.com (fixed for satisfiable instance)
(assert (= "example.com" host_name))

; Port must be numeric; approximate by constraining exact "80" here
(assert (= "80" host_port))

; -------- Parse Content-Length header line --------
; Use header_line1 as Content-Length
(assert (= cl_key (str.split_at header_line1 ":" 0)))
(assert (= cl_value (str.split_at header_line1 ":" 1)))
(assert (>= (str.num_splits header_line1 ":") 2))
(assert (= "Content-Length" cl_key))

; cl_value has a leading space then digits; enforce a concrete digit string for SAT instance
(assert (>= (str.len cl_value) 2))
(assert (= " " (str.substr cl_value 0 1)))
(assert (= "5" (str.substr cl_value 1 1)))
(assert (= 5 content_length))
(assert (= 5 parsed_len))

; Validate content length equals body length
(assert (= parsed_len (str.len body)))
(assert (= content_length parsed_len))

; -------- Additional header parsing (User-Agent) for diversity --------
; Use header_line2 as User-Agent
(assert (= ua_key (str.split_at header_line2 ":" 0)))
(assert (= ua_value (str.split_at header_line2 ":" 1)))
(assert (>= (str.num_splits header_line2 ":") 2))
(assert (= "User-Agent" ua_key))

; UA value must contain "curl" somewhere (after optional leading space)
(assert (>= (str.len ua_value) 1))
(assert (= " " (str.substr ua_value 0 1)))
(assert (str.contains (str.substr ua_value 1 (- (str.len ua_value) 1)) "curl"))

; -------- Construct one concrete satisfiable request (ties split results together) --------
(assert (= method_line "GET /index.html HTTP/1.1"))
(assert (= header_line0 "Host: example.com:80"))
(assert (= header_line1 "Content-Length: 5"))
(assert (= header_line2 "User-Agent: curl/8.0"))

; Add an extra header line for realism
(assert (= header_line3 "Accept: */*"))

; Combine headers with CRLF (not all split constraints enforce exact reconstruction; we provide a concrete headers string)
(assert (= headers (str.++ method_line "\r\n" header_line0 "\r\n" header_line1 "\r\n" header_line2 "\r\n" header_line3)))

; Concrete body is length 5
(assert (= body "hello"))
(assert (= request (str.++ headers "\r\n\r\n" body)))

; -------- Create an UNSAT sub-instance to mix SAT and UNSAT in one file --------
; This block is intentionally inconsistent with the established SAT instance.
; It encodes a contradictory requirement: Content-Length must also equal 6.
(assert (not (= content_length 6)))
(assert (= content_length 6))

(check-sat)


; [GENERATION STATUS: SUCCESS]
