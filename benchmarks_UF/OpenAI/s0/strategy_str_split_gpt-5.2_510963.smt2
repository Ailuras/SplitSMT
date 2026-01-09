(set-logic ALL)

; Uninterpreted split interface (per provided methodology)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; SAT instance: consistent HTTP header parsing
; =====================
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; shape the request with a blank line separating headers from body
(assert (= request_line_sat (split_at req_sat "\r\n" 0)))
(assert (= headers_block_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_rest req_sat "\r\n\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; request line: "POST /path HTTP/1.1"
(assert (= request_line_sat "POST /submit HTTP/1.1"))

; headers block is request_line + CRLF + header lines
(assert (= headers_block_sat (str.++ request_line_sat "\r\n" host_line_sat "\r\n" cl_line_sat "\r\n" ua_line_sat)))

; parse individual header lines by CRLF split in the headers block
(assert (= host_line_sat (split_at headers_block_sat "\r\n" 1)))
(assert (= cl_line_sat   (split_at headers_block_sat "\r\n" 2)))
(assert (= ua_line_sat   (split_at headers_block_sat "\r\n" 3)))
(assert (>= (num_splits headers_block_sat "\r\n") 4))

; enforce key-value format using ": " delimiter
(assert (= host_key_sat (split_at host_line_sat ": " 0)))
(assert (= host_val_sat (split_at host_line_sat ": " 1)))
(assert (>= (num_splits host_line_sat ": ") 2))

(assert (= cl_key_sat (split_at cl_line_sat ": " 0)))
(assert (= cl_val_sat (split_at cl_line_sat ": " 1)))
(assert (>= (num_splits cl_line_sat ": ") 2))

(assert (= ua_key_sat (split_at ua_line_sat ": " 0)))
(assert (= ua_val_sat (split_at ua_line_sat ": " 1)))
(assert (>= (num_splits ua_line_sat ": ") 2))

; concrete header keys (case-sensitive)
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))

; simple sanity: non-empty values and no CRLF injection inside values
(assert (> (str.len host_val_sat) 0))
(assert (> (str.len cl_val_sat) 0))
(assert (> (str.len ua_val_sat) 0))
(assert (not (str.contains host_val_sat "\r\n")))
(assert (not (str.contains cl_val_sat "\r\n")))
(assert (not (str.contains ua_val_sat "\r\n")))

; concrete values
(assert (= host_val_sat "example.com"))
(assert (= ua_val_sat "curl/8.0"))

; body and content-length consistency
(assert (= body_sat "Hello"))
(assert (= content_length_sat 5))
(assert (= cl_val_sat "5"))
(assert (= (str.len body_sat) content_length_sat))

; also constrain that the overall request begins with the request line
(assert (str.contains req_sat request_line_sat))
(assert (str.contains req_sat "\r\n\r\n"))

(check-sat)

; =====================
; UNSAT instance: contradictory content-length parsing
; =====================
(push 1)
(declare-const req_unsat String)
(declare-const request_line_unsat String)
(declare-const headers_block_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

(assert (= request_line_unsat (split_at req_unsat "\r\n" 0)))
(assert (= headers_block_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_rest req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

(assert (= request_line_unsat "POST /upload HTTP/1.1"))

; make a minimal header block with one header line after the request line
(assert (= headers_block_unsat (str.++ request_line_unsat "\r\n" cl_line_unsat)))
(assert (= cl_line_unsat (split_at headers_block_unsat "\r\n" 1)))
(assert (>= (num_splits headers_block_unsat "\r\n") 2))

(assert (= cl_key_unsat (split_at cl_line_unsat ": " 0)))
(assert (= cl_val_unsat (split_at cl_line_unsat ": " 1)))
(assert (>= (num_splits cl_line_unsat ": ") 2))
(assert (= cl_key_unsat "Content-Length"))

; force body length 4
(assert (= body_unsat "DATA"))
(assert (= (str.len body_unsat) 4))

; but force content-length 5 and also force the header value to "5"
(assert (= content_length_unsat 5))
(assert (= cl_val_unsat "5"))

; core contradiction: body length must equal content-length
(assert (= (str.len body_unsat) content_length_unsat))

(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)