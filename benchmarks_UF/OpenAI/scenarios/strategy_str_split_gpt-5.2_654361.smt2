(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ========== Scenario: HTTP Header Parsing (SAT instance) ==========
(declare-const request_sat String)
(declare-const headers_sat String)
(declare-const host_line_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const cl_line_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; Structure: headers and body separated by CRLFCRLF
(assert (= headers_sat (split_at request_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at request_sat "\r\n\r\n" 1)))
(assert (>= (num_splits request_sat "\r\n\r\n") 2))

; Require at least 3 header lines: request-line + Host + Content-Length
(assert (>= (num_splits headers_sat "\r\n") 3))

; Host header on line 1
(assert (= host_line_sat (split_at headers_sat "\r\n" 1)))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_value_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_value_sat " example.com"))

; Content-Length header on line 2
(assert (= cl_line_sat (split_at headers_sat "\r\n" 2)))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_value_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (>= (num_splits cl_line_sat ":") 2))

; Validate that Content-Length value is a decimal integer and matches body length
(assert (str.in_re cl_value_sat (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))
(assert (= content_length_sat (str.to_int (str.substr cl_value_sat 1 (- (str.len cl_value_sat) 1)))))
(assert (>= content_length_sat 0))
(assert (= content_length_sat (str.len body_sat)))

; Concrete satisfiable request consistent with the parsing constraints
(assert (= request_sat (str.++
  "GET /upload HTTP/1.1\r\n"
  "Host: example.com\r\n"
  "Content-Length: 5\r\n"
  "\r\n"
  "hello")))

; ========== Scenario: HTTP Header Parsing (UNSAT instance) ==========
(declare-const request_unsat String)
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

(assert (= headers_unsat (split_at request_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at request_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits request_unsat "\r\n\r\n") 2))

; Force Content-Length to be present and numeric
(assert (>= (num_splits headers_unsat "\r\n") 2))
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= (split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_value_unsat (split_rest cl_line_unsat ":" 1)))
(assert (str.in_re cl_value_unsat (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))
(assert (= content_length_unsat (str.to_int (str.substr cl_value_unsat 1 (- (str.len cl_value_unsat) 1)))))
(assert (>= content_length_unsat 0))

; Content-Length must equal body length (but we will contradict it with a concrete request)
(assert (= content_length_unsat (str.len body_unsat)))

; Concrete request with mismatching Content-Length (declares 4, body length is 5) => UNSAT
(assert (= request_unsat (str.++
  "POST /data HTTP/1.1\r\n"
  "Content-Length: 4\r\n"
  "\r\n"
  "abcde")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
