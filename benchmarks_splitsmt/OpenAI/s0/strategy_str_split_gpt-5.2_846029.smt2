(set-logic ALL)

; Uninterpreted string-split interface

; Additional uninterpreted helpers for header lookup and numeric parsing
(declare-fun header_value (String String) String) ; (headers, key) -> value string (trimmed)
(declare-fun to_int (String) Int) ; parse decimal integer

; ----------------------------
; SAT instance: well-formed HTTP header block with Content-Length validation
; ----------------------------
(declare-const headers_sat String)
(declare-const request_line_sat String)
(declare-const header_lines_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_val_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const content_len_sat Int)

; Structure: request-line + CRLF + header-lines + CRLFCRLF + body
(assert (str.contains headers_sat "\r\n"))
(assert (= request_line_sat (str.split_at headers_sat "\r\n" 0)))
(assert (>= (str.num_splits headers_sat "\r\n") 4))
(assert (= header_lines_sat (str.split_rest headers_sat "\r\n" 1)))

; Request line shape: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re request_line_sat (re.++ (str.to_re "GET") (str.to_re " ") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "/") (str.to_re "-") (str.to_re "_") (str.to_re "."))) (str.to_re " ") (str.to_re "HTTP/1.1"))))

; Require Host and Content-Length lines to exist in header section
(assert (>= (str.num_splits header_lines_sat "\r\n") 2))
(assert (= host_line_sat (str.split_at header_lines_sat "\r\n" 0)))
(assert (= cl_line_sat (str.split_at header_lines_sat "\r\n" 1)))

; Key-value parsing using ':' delimiter
(assert (= (str.split_at host_line_sat ":" 0) "Host"))
(assert (= (str.split_at cl_line_sat ":" 0) "Content-Length"))
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (>= (str.num_splits cl_line_sat ":") 2))

; Values come from a logical lookup function (trimmed), must match split_rest after ':'
(assert (= host_val_sat (header_value headers_sat "Host")))
(assert (= cl_val_sat (header_value headers_sat "Content-Length")))
(assert (str.contains host_val_sat "."))
(assert (> (str.len host_val_sat) 3))

; Content-Length must be digits only, parseable, non-negative, and equals body length
(assert (str.in_re cl_val_sat (re.+ (re.range "0" "9"))))
(assert (= content_len_sat (to_int cl_val_sat)))
(assert (>= content_len_sat 0))

; Body extraction: after CRLFCRLF (blank line)
(assert (str.contains headers_sat "\r\n\r\n"))
(assert (= body_sat (str.split_rest headers_sat "\r\n\r\n" 1)))
(assert (= content_len_sat (str.len body_sat)))

; Constrain a concrete-like header prefix while leaving rest flexible
(assert (str.prefixof "GET /index.html HTTP/1.1\r\n" headers_sat))
(assert (str.contains headers_sat "Host:"))
(assert (str.contains headers_sat "Content-Length:"))

; ----------------------------
; UNSAT instance: contradictory Content-Length constraints
; ----------------------------
(declare-const headers_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_len_unsat Int)

(assert (str.contains headers_unsat "\r\n\r\n"))
(assert (= body_unsat (str.split_rest headers_unsat "\r\n\r\n" 1)))

(assert (= cl_val_unsat (header_value headers_unsat "Content-Length")))
(assert (str.in_re cl_val_unsat (re.+ (re.range "0" "9"))))
(assert (= content_len_unsat (to_int cl_val_unsat)))
(assert (>= content_len_unsat 0))

; Force a non-empty body but content-length forced to mismatch -> UNSAT
(assert (> (str.len body_unsat) 0))
(assert (= content_len_unsat (str.len body_unsat)))
(assert (= content_len_unsat (+ (str.len body_unsat) 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
