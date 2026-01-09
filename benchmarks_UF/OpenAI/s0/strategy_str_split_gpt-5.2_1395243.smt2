(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; SAT instance: plausible HTTP request header parsing
; =====================
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const content_length_sat Int)

; split request into request-line and the rest by CRLF
(assert (>= (num_splits req_sat "\r\n") 2))
(assert (= request_line_sat (split_at req_sat "\r\n" 0)))
(assert (= headers_sat (split_rest req_sat "\r\n" 1)))

; request line should look like: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re request_line_sat (re.++ (str.to_re "GET") (str.to_re " ") (re.* re.allchar) (str.to_re " HTTP/1.1"))))

; headers contain at least Host and Content-Length lines
(assert (>= (num_splits headers_sat "\r\n") 3))
(assert (= host_line_sat (split_at headers_sat "\r\n" 0)))
(assert (= cl_line_sat (split_at headers_sat "\r\n" 1)))

; each header line has a ':' separator with non-empty key and value
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (> (str.len host_key_sat) 0))
(assert (> (str.len host_val_sat) 0))

(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (> (str.len cl_key_sat) 0))
(assert (> (str.len cl_val_sat) 0))

; fix header names (allow exact match)
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))

; host value must not contain CR/LF and must include at least one dot
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))
(assert (str.contains host_val_sat "."))

; content-length value is a sequence of digits, and agrees with an integer variable
(assert (str.in_re cl_val_sat (re.+ (re.range "0" "9"))))
(assert (= content_length_sat (str.to_int cl_val_sat)))
(assert (>= content_length_sat 0))
(assert (<= content_length_sat 1000000))

; ensure request has header terminator (blank line) somewhere after headers
(assert (str.contains req_sat "\r\n\r\n"))

; make SAT instance more concrete
(assert (= req_sat (str.++ "GET /index.html HTTP/1.1\r\n" "Host:example.com\r\n" "Content-Length:5\r\n" "\r\n" "HELLO")))

; =====================
; UNSAT instance: contradictory Content-Length parsing constraints
; =====================
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_unsat String)

; split by header terminator to get header block and body
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))
(assert (= headers_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_rest req_unsat "\r\n\r\n" 1)))

; pick the second line as Content-Length line (after request line)
(assert (>= (num_splits headers_unsat "\r\n") 2))
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; constrain cl_val to be digits, convert to int
(assert (str.in_re cl_val_unsat (re.+ (re.range "0" "9"))))
(assert (= content_length_unsat (str.to_int cl_val_unsat)))
(assert (>= content_length_unsat 0))

; require body length to equal content-length
(assert (= (str.len body_unsat) content_length_unsat))

; but also force a mismatch -> UNSAT
(assert (not (= (str.len body_unsat) content_length_unsat)))

; make the UNSAT request concrete
(assert (= req_unsat (str.++ "POST /submit HTTP/1.1\r\n" "Content-Length:3\r\n" "\r\n" "AB")))

(check-sat)


; [GENERATION STATUS: SUCCESS]