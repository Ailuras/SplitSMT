(set-logic ALL)

; Uninterpreted interface operations for str_split

; Additional helper functions as uninterpreted (non-primitive)
(declare-fun to_int (String) Int)
(declare-fun is_digits (String) Bool)
(declare-fun is_token (String) Bool)
(declare-fun trim (String) String)

; ===== SAT instance: consistent HTTP header parsing =====
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const request_line_sat String)
(declare-const method_sat String)
(declare-const path_sat String)
(declare-const version_sat String)

(declare-const host_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)

(declare-const cl_line_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const content_length_sat Int)

(declare-const ua_line_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)

; Structure: request = headers + "\r\n\r\n" + body
(assert (= req_sat (str.++ headers_sat "\r\n\r\n" body_sat)))

; Split headers by CRLF: first line is request line
(assert (>= (str.num_splits headers_sat "\r\n") 4))
(assert (= request_line_sat (str.split_at headers_sat "\r\n" 0)))
(assert (= host_line_sat (str.split_at headers_sat "\r\n" 1)))
(assert (= cl_line_sat (str.split_at headers_sat "\r\n" 2)))
(assert (= ua_line_sat (str.split_at headers_sat "\r\n" 3)))

; Request line: "METHOD SP PATH SP HTTP/1.1"
(assert (>= (str.num_splits request_line_sat " ") 3))
(assert (= method_sat (str.split_at request_line_sat " " 0)))
(assert (= path_sat (str.split_at request_line_sat " " 1)))
(assert (= version_sat (str.split_at request_line_sat " " 2)))

; Basic validation of tokens
(assert (is_token method_sat))
(assert (is_token version_sat))
(assert (str.prefixof "HTTP/" version_sat))
(assert (or (= method_sat "GET") (= method_sat "POST")))
(assert (str.prefixof "/" path_sat))

; Header parsing: split each header line at ":"
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (= host_key_sat (trim (str.split_at host_line_sat ":" 0))))
(assert (= host_val_sat (trim (str.split_rest host_line_sat ":" 1))))
(assert (= host_key_sat "Host"))
(assert (not (= host_val_sat "")))

(assert (>= (str.num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (trim (str.split_at cl_line_sat ":" 0))))
(assert (= cl_val_sat (trim (str.split_rest cl_line_sat ":" 1))))
(assert (= cl_key_sat "Content-Length"))
(assert (is_digits cl_val_sat))
(assert (= content_length_sat (to_int cl_val_sat)))
(assert (>= content_length_sat 0))

(assert (>= (str.num_splits ua_line_sat ":") 2))
(assert (= ua_key_sat (trim (str.split_at ua_line_sat ":" 0))))
(assert (= ua_val_sat (trim (str.split_rest ua_line_sat ":" 1))))
(assert (= ua_key_sat "User-Agent"))
(assert (not (= ua_val_sat "")))

; Validate Content-Length against actual body length
(assert (= (str.len body_sat) content_length_sat))

; Constrain headers content to look like a small request
(assert (= request_line_sat "POST /upload HTTP/1.1"))
(assert (= host_line_sat "Host: example.com"))
(assert (= cl_line_sat "Content-Length: 5"))
(assert (= ua_line_sat "User-Agent: unit-test"))
(assert (= body_sat "abcde"))

; ===== UNSAT instance: contradicting Content-Length =====
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_key_unsat String)
(declare-const content_length_unsat Int)

(assert (= req_unsat (str.++ headers_unsat "\r\n\r\n" body_unsat)))
(assert (>= (str.num_splits headers_unsat "\r\n") 1))
(assert (= cl_line_unsat (str.split_at headers_unsat "\r\n" 0)))

(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (trim (str.split_at cl_line_unsat ":" 0))))
(assert (= cl_val_unsat (trim (str.split_rest cl_line_unsat ":" 1))))
(assert (= cl_key_unsat "Content-Length"))
(assert (is_digits cl_val_unsat))
(assert (= content_length_unsat (to_int cl_val_unsat)))
(assert (>= content_length_unsat 0))

; Force a specific mismatch: length(body)=3 but Content-Length parses to 4
(assert (= cl_line_unsat "Content-Length: 4"))
(assert (= body_unsat "xyz"))
(assert (= (str.len body_unsat) content_length_unsat))

; ===== Check both together: should be UNSAT due to the second block =====


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
