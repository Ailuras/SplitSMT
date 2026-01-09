(set-logic ALL)

; Uninterpreted interface for string split (as provided)

; Additional uninterpreted helpers for header parsing
(declare-fun header_value (String String) String) ; header_value(rawHeaders, key) -> value (without key prefix)
(declare-fun is_digits (String) Bool)
(declare-fun to_int (String) Int)

; =====================
; SAT instance: consistent header block with content-length validation
; =====================
(declare-const headers_sat String)
(declare-const request_line_sat String)
(declare-const header_lines_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const host_value_sat String)
(declare-const cl_value_sat String)
(declare-const ua_value_sat String)
(declare-const body_len_sat Int)
(declare-const cl_int_sat Int)

; Request line and header block split by CRLF
(assert (>= (str.num_splits headers_sat "\r\n") 4))
(assert (= request_line_sat (str.split_at headers_sat "\r\n" 0)))
(assert (= header_lines_sat (str.split_rest headers_sat "\r\n" 1)))

; Require a plausible request line
(assert (or (= request_line_sat "GET / HTTP/1.1")
            (= request_line_sat "POST /submit HTTP/1.1")))

; Pick specific lines (after request line) as headers
(assert (= host_line_sat (str.split_at headers_sat "\r\n" 1)))
(assert (= cl_line_sat (str.split_at headers_sat "\r\n" 2)))
(assert (= ua_line_sat (str.split_at headers_sat "\r\n" 3)))

; Each header line must contain exactly one ": " separator into key and value
(assert (>= (str.num_splits host_line_sat ": ") 2))
(assert (>= (str.num_splits cl_line_sat ": ") 2))
(assert (>= (str.num_splits ua_line_sat ": ") 2))

; Enforce header keys
(assert (= (str.split_at host_line_sat ": " 0) "Host"))
(assert (= (str.split_at cl_line_sat ": " 0) "Content-Length"))
(assert (= (str.split_at ua_line_sat ": " 0) "User-Agent"))

; Extract values via split
(assert (= host_value_sat (str.split_rest host_line_sat ": " 1)))
(assert (= cl_value_sat (str.split_rest cl_line_sat ": " 1)))
(assert (= ua_value_sat (str.split_rest ua_line_sat ": " 1)))

; Additional extraction via uninterpreted header_value (consistency)
(assert (= host_value_sat (header_value headers_sat "Host")))
(assert (= cl_value_sat (header_value headers_sat "Content-Length")))
(assert (= ua_value_sat (header_value headers_sat "User-Agent")))

; Basic value constraints
(assert (> (str.len host_value_sat) 0))
(assert (not (str.contains host_value_sat "\r")))
(assert (not (str.contains host_value_sat "\n")))

(assert (> (str.len ua_value_sat) 0))
(assert (not (str.contains ua_value_sat "\r")))
(assert (not (str.contains ua_value_sat "\n")))

; Content-Length must be digits and consistent with integer conversion
(assert (is_digits cl_value_sat))
(assert (= cl_int_sat (to_int cl_value_sat)))
(assert (>= cl_int_sat 0))

; Validate content-length against an abstract body length
(assert (>= body_len_sat 0))
(assert (= body_len_sat cl_int_sat))

; Ensure the overall header string resembles HTTP headers with trailing blank line
(assert (str.contains headers_sat "\r\n\r\n"))

; =====================
; UNSAT instance: contradictory content-length constraints for another header block
; =====================
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const cl_int_unsat Int)
(declare-const body_len_unsat Int)

(assert (>= (str.num_splits headers_unsat "\r\n") 3))
(assert (= cl_line_unsat (str.split_at headers_unsat "\r\n" 1)))
(assert (= (str.split_at cl_line_unsat ": " 0) "Content-Length"))
(assert (= cl_value_unsat (str.split_rest cl_line_unsat ": " 1)))

(assert (is_digits cl_value_unsat))
(assert (= cl_int_unsat (to_int cl_value_unsat)))
(assert (>= cl_int_unsat 0))
(assert (>= body_len_unsat 0))

; Contradiction: body_len_unsat must equal cl_int_unsat, but also differ
(assert (= body_len_unsat cl_int_unsat))
(assert (not (= body_len_unsat cl_int_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
