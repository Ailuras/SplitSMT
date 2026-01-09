(set-logic ALL)

; Uninterpreted interface for string splitting

; Scenario: HTTP Header Parsing
; We model a request header block and extract fields using CRLF ("\r\n") and colon+space (": ").

; ===== SAT instance: consistent headers =====
(declare-const req_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const line3_sat String)
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

; Request structure: headers then empty line then body
(assert (= req_sat (str.++ line0_sat "\r\n" line1_sat "\r\n" line2_sat "\r\n" line3_sat "\r\n" "\r\n" body_sat)))

; Parse lines via split on CRLF (k-th segment)
(assert (= line0_sat (str.split_at req_sat "\r\n" 0)))
(assert (= line1_sat (str.split_at req_sat "\r\n" 1)))
(assert (= line2_sat (str.split_at req_sat "\r\n" 2)))
(assert (= line3_sat (str.split_at req_sat "\r\n" 3)))

; Ensure enough splits (at least 5 segments: 4 lines + empty line + body part(s))
(assert (>= (str.num_splits req_sat "\r\n") 6))

; Assign header lines
(assert (= host_line_sat line1_sat))
(assert (= cl_line_sat line2_sat))
(assert (= ua_line_sat line3_sat))

; Each header line must contain delimiter ": "
(assert (str.contains host_line_sat ": "))
(assert (str.contains cl_line_sat ": "))
(assert (str.contains ua_line_sat ": "))

; Split each header line into key/value by ": "
(assert (= host_key_sat (str.split_at host_line_sat ": " 0)))
(assert (= host_val_sat (str.split_at host_line_sat ": " 1)))
(assert (>= (str.num_splits host_line_sat ": ") 2))

(assert (= cl_key_sat (str.split_at cl_line_sat ": " 0)))
(assert (= cl_val_sat (str.split_at cl_line_sat ": " 1)))
(assert (>= (str.num_splits cl_line_sat ": ") 2))

(assert (= ua_key_sat (str.split_at ua_line_sat ": " 0)))
(assert (= ua_val_sat (str.split_at ua_line_sat ": " 1)))
(assert (>= (str.num_splits ua_line_sat ": ") 2))

; Constrain concrete keys
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))

; Basic sanity: non-empty values
(assert (> (str.len host_val_sat) 0))
(assert (> (str.len cl_val_sat) 0))
(assert (> (str.len ua_val_sat) 0))

; A simple request line constraint
(assert (str.contains line0_sat "HTTP/1.1"))

; Content-Length must be numeric (restricted subset) and match body length
; We avoid full decimal parsing by fixing the numeric value and matching the string.
(assert (= content_length_sat 5))
(assert (= cl_val_sat "5"))
(assert (= body_sat "HELLO"))
(assert (= (str.len body_sat) content_length_sat))

; Host should not contain CR or LF
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))

; Make SAT instance fully concrete enough
(assert (= line0_sat "POST /submit HTTP/1.1"))
(assert (= host_val_sat "example.com"))
(assert (= ua_val_sat "TestAgent/1.0"))


; ===== UNSAT instance: contradictory content-length =====
(declare-const req_unsat String)
(declare-const u_line0 String)
(declare-const u_line1 String)
(declare-const u_line2 String)
(declare-const u_host_line String)
(declare-const u_cl_line String)
(declare-const u_host_key String)
(declare-const u_host_val String)
(declare-const u_cl_key String)
(declare-const u_cl_val String)
(declare-const u_body String)
(declare-const u_content_length Int)

(assert (= req_unsat (str.++ u_line0 "\r\n" u_line1 "\r\n" u_line2 "\r\n" "\r\n" u_body)))

(assert (= u_line0 (str.split_at req_unsat "\r\n" 0)))
(assert (= u_line1 (str.split_at req_unsat "\r\n" 1)))
(assert (= u_line2 (str.split_at req_unsat "\r\n" 2)))
(assert (>= (str.num_splits req_unsat "\r\n") 5))

(assert (= u_host_line u_line1))
(assert (= u_cl_line u_line2))

(assert (str.contains u_host_line ": "))
(assert (str.contains u_cl_line ": "))

(assert (= u_host_key (str.split_at u_host_line ": " 0)))
(assert (= u_host_val (str.split_at u_host_line ": " 1)))
(assert (>= (str.num_splits u_host_line ": ") 2))

(assert (= u_cl_key (str.split_at u_cl_line ": " 0)))
(assert (= u_cl_val (str.split_at u_cl_line ": " 1)))
(assert (>= (str.num_splits u_cl_line ": ") 2))

(assert (= u_host_key "Host"))
(assert (= u_cl_key "Content-Length"))

(assert (str.contains u_line0 "HTTP/1.1"))

; Force a numeric mismatch: declared length 4 but actual body length 5
(assert (= u_content_length 4))
(assert (= u_cl_val "4"))
(assert (= u_body "HELLO"))
(assert (= (str.len u_body) 5))
(assert (= (str.len u_body) u_content_length))

; Concretize remaining parts
(assert (= u_line0 "POST /x HTTP/1.1"))
(assert (= u_host_val "bad.example"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
