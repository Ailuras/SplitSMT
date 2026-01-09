(set-logic ALL)

; Uninterpreted string-split interface

; Additional helpers (uninterpreted): mapping header-line -> key/value, integer parsing
(declare-fun header_key (String) String)
(declare-fun header_value (String) String)
(declare-fun to_int (String) Int)

; =====================
; SAT instance: consistent HTTP header parsing + Content-Length matches body length
; =====================
(declare-const request_sat String)
(declare-const start_line_sat String)
(declare-const headers_block_sat String)
(declare-const body_sat String)

(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)

(declare-const k0_sat String)
(declare-const v0_sat String)
(declare-const k1_sat String)
(declare-const v1_sat String)
(declare-const k2_sat String)
(declare-const v2_sat String)

(declare-const content_length_str_sat String)
(declare-const content_length_int_sat Int)

; Structure: request = start-line + CRLF + headers + CRLF CRLF + body
(assert (= start_line_sat (str.split_at request_sat "\r\n" 0)))
(assert (= headers_block_sat (str.split_at request_sat "\r\n\r\n" 0)))
(assert (= body_sat (str.split_at request_sat "\r\n\r\n" 1)))
(assert (= request_sat (str.++ headers_block_sat "\r\n\r\n" body_sat)))
(assert (str.contains headers_block_sat "\r\n"))
(assert (>= (str.num_splits request_sat "\r\n\r\n") 2))

; Parse three header lines after the start line
(assert (= header_line0_sat (str.split_at headers_block_sat "\r\n" 1)))
(assert (= header_line1_sat (str.split_at headers_block_sat "\r\n" 2)))
(assert (= header_line2_sat (str.split_at headers_block_sat "\r\n" 3)))
(assert (>= (str.num_splits headers_block_sat "\r\n") 4))

; Each header line contains ':' and key/value extraction
(assert (str.contains header_line0_sat ":"))
(assert (str.contains header_line1_sat ":"))
(assert (str.contains header_line2_sat ":"))
(assert (= k0_sat (header_key header_line0_sat)))
(assert (= v0_sat (header_value header_line0_sat)))
(assert (= k1_sat (header_key header_line1_sat)))
(assert (= v1_sat (header_value header_line1_sat)))
(assert (= k2_sat (header_key header_line2_sat)))
(assert (= v2_sat (header_value header_line2_sat)))

; Concrete header names/values (typical request)
(assert (= start_line_sat "POST /submit HTTP/1.1"))
(assert (= k0_sat "Host"))
(assert (= v0_sat "example.com"))
(assert (= k1_sat "Content-Length"))
(assert (= content_length_str_sat v1_sat))
(assert (= k2_sat "User-Agent"))
(assert (= v2_sat "curl/8.0"))

; Content-Length validation: parsed integer equals body length
(assert (= content_length_int_sat (to_int content_length_str_sat)))
(assert (>= content_length_int_sat 0))
(assert (= content_length_int_sat (str.len body_sat)))

; Make the SAT instance concretely satisfiable
(assert (= content_length_str_sat "5"))
(assert (= body_sat "HELLO"))
(assert (= header_line0_sat "Host: example.com"))
(assert (= header_line1_sat "Content-Length: 5"))
(assert (= header_line2_sat "User-Agent: curl/8.0"))
(assert (= headers_block_sat (str.++ start_line_sat "\r\n" header_line0_sat "\r\n" header_line1_sat "\r\n" header_line2_sat)))

; =====================
; UNSAT instance: inconsistent Content-Length vs actual body length
; =====================
(declare-const request_unsat String)
(declare-const headers_block_unsat String)
(declare-const body_unsat String)
(declare-const header_line0_unsat String)
(declare-const header_line1_unsat String)
(declare-const k0_unsat String)
(declare-const v0_unsat String)
(declare-const k1_unsat String)
(declare-const v1_unsat String)
(declare-const cl_int_unsat Int)

(assert (= headers_block_unsat (str.split_at request_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_at request_unsat "\r\n\r\n" 1)))
(assert (= request_unsat (str.++ headers_block_unsat "\r\n\r\n" body_unsat)))
(assert (>= (str.num_splits request_unsat "\r\n\r\n") 2))

(assert (= header_line0_unsat (str.split_at headers_block_unsat "\r\n" 1)))
(assert (= header_line1_unsat (str.split_at headers_block_unsat "\r\n" 2)))
(assert (>= (str.num_splits headers_block_unsat "\r\n") 3))

(assert (str.contains header_line0_unsat ":"))
(assert (str.contains header_line1_unsat ":"))
(assert (= k0_unsat (header_key header_line0_unsat)))
(assert (= v0_unsat (header_value header_line0_unsat)))
(assert (= k1_unsat (header_key header_line1_unsat)))
(assert (= v1_unsat (header_value header_line1_unsat)))

(assert (= k0_unsat "Content-Length"))
(assert (= cl_int_unsat (to_int v0_unsat)))
(assert (= k1_unsat "X-Debug"))

; Force a mismatch: cl_int_unsat must equal body length, but also fixed to 10 while body is length 3
(assert (= headers_block_unsat (str.++ "POST /x HTTP/1.1" "\r\n" header_line0_unsat "\r\n" header_line1_unsat)))
(assert (= header_line0_unsat "Content-Length: 10"))
(assert (= v0_unsat "10"))
(assert (= header_line1_unsat "X-Debug: on"))
(assert (= body_unsat "abc"))
(assert (= cl_int_unsat 10))
(assert (= cl_int_unsat (str.len body_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
