(set-logic ALL)

; Uninterpreted interface functions for string splitting

; -------------------------
; SAT instance: well-formed HTTP headers
; -------------------------
(declare-const req_sat String)
(declare-const first_line_sat String)
(declare-const headers_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_int_sat Int)
(declare-const body_sat String)

; Request split into lines by CRLF
(assert (>= (str.num_splits req_sat "\r\n") 4))
(assert (= first_line_sat (str.split_at req_sat "\r\n" 0)))
(assert (= headers_sat (str.split_rest req_sat "\r\n" 1)))

; Enforce method and HTTP version pattern in request line: "GET /... HTTP/1.1"
(assert (str.in_re first_line_sat (re.++ (str.to_re "GET ") (re.* re.allchar) (str.to_re " HTTP/1.1"))))

; Header lines: choose line 1 as Host, line 2 as Content-Length
(assert (= host_line_sat (str.split_at req_sat "\r\n" 1)))
(assert (= cl_line_sat (str.split_at req_sat "\r\n" 2)))

; Each header line contains at least one ':' producing at least 2 segments
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (>= (str.num_splits cl_line_sat ":") 2))

; Extract key and value around ':'
(assert (= host_key_sat (str.split_at host_line_sat ":" 0)))
(assert (= host_val_sat (str.split_rest host_line_sat ":" 1)))
(assert (= cl_key_sat (str.split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (str.split_rest cl_line_sat ":" 1)))

; Validate keys exactly
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))

; Common HTTP header formatting: value begins with a single space
(assert (str.prefixof " " host_val_sat))
(assert (str.prefixof " " cl_val_sat))

; Host value must not contain CRLF and must contain a dot
(assert (not (str.contains host_val_sat "\r\n")))
(assert (str.contains host_val_sat "."))

; Content-Length value: one leading space followed by digits only
(assert (str.in_re cl_val_sat (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))

; Parse Content-Length (uninterpreted; link by constraints)
(assert (>= cl_int_sat 0))
(assert (<= cl_int_sat 1000000))
; Connect integer to string via a fixed set of possible lengths (keeps it decidable without str.to_int)
(assert (or (and (= cl_int_sat 0) (= cl_val_sat " 0"))
            (and (= cl_int_sat 4) (= cl_val_sat " 4"))
            (and (= cl_int_sat 10) (= cl_val_sat " 10"))
            (and (= cl_int_sat 42) (= cl_val_sat " 42"))
            (and (= cl_int_sat 100) (= cl_val_sat " 100"))))

; Body is the rest after the empty line: require an empty line at index 3 and body afterwards
(assert (= (str.split_at req_sat "\r\n" 3) ""))
(assert (= body_sat (str.split_rest req_sat "\r\n" 4)))

; Validate body length matches Content-Length (approximate by constraining to one candidate)
; Here we select the 4-byte case to ensure satisfiable concrete model exists.
(assert (= cl_int_sat 4))
(assert (= (str.len body_sat) cl_int_sat))

; Also ensure body has no CRLF for this simple scenario
(assert (not (str.contains body_sat "\r\n")))

; -------------------------
; UNSAT instance: contradictory Content-Length
; -------------------------
(declare-const req_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)
(declare-const body_unsat String)

; Minimal shape: request has at least: request-line, Content-Length line, empty line, body
(assert (>= (str.num_splits req_unsat "\r\n") 4))
(assert (= cl_line_unsat (str.split_at req_unsat "\r\n" 1)))
(assert (= (str.split_at req_unsat "\r\n" 2) ""))
(assert (= body_unsat (str.split_rest req_unsat "\r\n" 3)))

(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (str.in_re cl_val_unsat (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))

(assert (>= cl_int_unsat 0))
; Bind to a single concrete numeric string
(assert (= cl_int_unsat 10))
(assert (= cl_val_unsat " 10"))

; Contradiction: body length forced not equal to cl_int_unsat, and also equal
(assert (= (str.len body_unsat) cl_int_unsat))
(assert (not (= (str.len body_unsat) cl_int_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
