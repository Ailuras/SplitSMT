(set-logic ALL)

; Uninterpreted split interface (per provided methodology)

; Primitive helpers
(declare-fun str.to_int (String) Int)

; -----------------------------
; SAT instance: consistent HTTP header parsing
; -----------------------------
(declare-const req_sat String)
(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)
(declare-const header_line3_sat String)
(declare-const blank_after_headers_sat String)

(declare-const key_host_sat String)
(declare-const val_host_sat String)
(declare-const key_cl_sat String)
(declare-const val_cl_sat String)
(declare-const key_ua_sat String)
(declare-const val_ua_sat String)

(declare-const content_length_sat Int)

; Shape: request headers are lines separated by \r\n, then an empty line
(assert (= header_line0_sat (str.split_at req_sat "\r\n" 0)))
(assert (= header_line1_sat (str.split_at req_sat "\r\n" 1)))
(assert (= header_line2_sat (str.split_at req_sat "\r\n" 2)))
(assert (= header_line3_sat (str.split_at req_sat "\r\n" 3)))
(assert (= blank_after_headers_sat (str.split_at req_sat "\r\n" 4)))
(assert (= blank_after_headers_sat ""))
(assert (>= (str.num_splits req_sat "\r\n") 5))

; Ensure these are header-like lines (contain a colon)
(assert (str.contains header_line1_sat ":"))
(assert (str.contains header_line2_sat ":"))
(assert (str.contains header_line3_sat ":"))

; Parse Host: key:value by splitting at ':' and expecting optional leading space in value
(assert (= key_host_sat (str.split_at header_line1_sat ":" 0)))
(assert (= val_host_sat (str.split_rest header_line1_sat ":" 1)))
(assert (= key_host_sat "Host"))
(assert (str.contains val_host_sat "example.com"))

; Parse Content-Length
(assert (= key_cl_sat (str.split_at header_line2_sat ":" 0)))
(assert (= val_cl_sat (str.split_rest header_line2_sat ":" 1)))
(assert (= key_cl_sat "Content-Length"))

; Trim model: require value to be either " 0" or " 5" etc. We enforce a concrete, valid numeric.
(assert (= val_cl_sat " 5"))
(assert (= content_length_sat (str.to_int (str.substr val_cl_sat 1 (- (str.len val_cl_sat) 1)))))
(assert (= content_length_sat 5))
(assert (>= content_length_sat 0))

; Parse User-Agent
(assert (= key_ua_sat (str.split_at header_line3_sat ":" 0)))
(assert (= val_ua_sat (str.split_rest header_line3_sat ":" 1)))
(assert (= key_ua_sat "User-Agent"))
(assert (>= (str.len val_ua_sat) 2))

; Tie the request line to a reasonable HTTP request start
(assert (= header_line0_sat "GET /index.html HTTP/1.1"))

; Compose a concrete satisfying request
(assert (= req_sat
  (str.++
    header_line0_sat "\r\n"
    "Host: example.com" "\r\n"
    "Content-Length: 5" "\r\n"
    "User-Agent: Test" "\r\n"
    "" "\r\n")))

; -----------------------------
; UNSAT instance: contradictory content-length validations
; -----------------------------
(declare-const req_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_num_unsat Int)

; Extract the second header line as Content-Length
(assert (>= (str.num_splits req_unsat "\r\n") 3))
(assert (= cl_line_unsat (str.split_at req_unsat "\r\n" 1)))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Force a numeric value but also contradict it
(assert (= cl_val_unsat " 10"))
(assert (= cl_num_unsat (str.to_int (str.substr cl_val_unsat 1 (- (str.len cl_val_unsat) 1)))))
(assert (= cl_num_unsat 10))
(assert (< cl_num_unsat 0))

; Provide a concrete request consistent with the extracted line, but the numeric constraint makes it UNSAT
(assert (= req_unsat
  (str.++
    "POST /submit HTTP/1.1" "\r\n"
    "Content-Length: 10" "\r\n"
    "Host: example.com" "\r\n")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
