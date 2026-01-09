(set-logic ALL)

; Uninterpreted interface for string split operations

; =========================
; Scenario: HTTP Header Parsing
; Extract values from HTTP request headers using colons and newlines.
; Must handle key-value pairs and validate Content-Length.
; =========================

; Common delimiters
(declare-const CRLF String)
(declare-const COLON String)
(assert (= CRLF "\r\n"))
(assert (= COLON ":"))

; -------------------------
; SAT instance: well-formed request header block
; -------------------------
(declare-const req_sat String)
(declare-const header0_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const empty_line_sat String)
(declare-const method_line_sat String)

(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)

(declare-const body_sat String)
(declare-const body_len_sat Int)
(declare-const cl_int_sat Int)

; Shape of the request: request-line + CRLF + headers + CRLFCRLF + body
(assert (= req_sat (str.++ method_line_sat CRLF header0_sat CRLF CRLF body_sat)))

; Header block split into lines by CRLF
(assert (>= (str.num_splits header0_sat CRLF) 2))
(assert (= host_line_sat (str.split_at header0_sat CRLF 0)))
(assert (= cl_line_sat (str.split_at header0_sat CRLF 1)))

; Each header line is key:value with at least 2 segments
(assert (>= (str.num_splits host_line_sat COLON) 2))
(assert (>= (str.num_splits cl_line_sat COLON) 2))

; Extract key/value around ':'
(assert (= host_key_sat (str.split_at host_line_sat COLON 0)))
(assert (= host_val_sat (str.split_rest host_line_sat COLON 1)))
(assert (= cl_key_sat (str.split_at cl_line_sat COLON 0)))
(assert (= cl_val_sat (str.split_rest cl_line_sat COLON 1)))

; Validate required header keys
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))

; Basic value constraints: non-empty host, content-length digits (simple model: fix a concrete numeric string)
(assert (> (str.len host_val_sat) 0))

; Trim is not provided, so accept optional leading space by allowing two patterns
(declare-const cl_val_sat_nospace String)
(declare-const cl_val_sat_space String)
(assert (= cl_val_sat_nospace cl_val_sat))
(assert (= cl_val_sat_space (str.++ " " cl_val_sat_nospace)))
(assert (or (= cl_val_sat cl_val_sat_nospace) (= cl_val_sat cl_val_sat_space)))

; Choose a concrete content-length string and enforce matching body length
(assert (= cl_val_sat_nospace "5"))
(assert (= body_len_sat (str.len body_sat)))
(assert (= cl_int_sat 5))
(assert (= body_len_sat cl_int_sat))

; Some realism: request line contains spaces and HTTP version
(assert (str.contains method_line_sat "HTTP/1.1"))
(assert (str.contains method_line_sat " "))

; Ensure no CRLF appears inside individual header lines
(assert (not (str.contains host_line_sat CRLF)))
(assert (not (str.contains cl_line_sat CRLF)))

; -------------------------
; UNSAT instance: conflicting Content-Length requirements
; -------------------------
(declare-const req_unsat String)
(declare-const header0_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const cl_val_unsat_nospace String)
(declare-const body_len_unsat Int)

; Same overall shape
(assert (= req_unsat (str.++ "POST /upload HTTP/1.1" CRLF header0_unsat CRLF CRLF body_unsat)))

; Header block must have at least 1 line, with a Content-Length line first
(assert (>= (str.num_splits header0_unsat CRLF) 1))
(assert (= cl_line_unsat (str.split_at header0_unsat CRLF 0)))
(assert (>= (str.num_splits cl_line_unsat COLON) 2))
(assert (= cl_key_unsat (str.split_at cl_line_unsat COLON 0)))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat COLON 1)))
(assert (= cl_key_unsat "Content-Length"))

; Again allow optional leading space
(assert (= cl_val_unsat_nospace "10"))
(assert (or (= cl_val_unsat cl_val_unsat_nospace) (= cl_val_unsat (str.++ " " cl_val_unsat_nospace))))

; Force body length to be 5 while claimed content-length is 10 => UNSAT by construction
(assert (= body_unsat "ABCDE"))
(assert (= body_len_unsat (str.len body_unsat)))
(assert (= body_len_unsat 5))
(assert (= body_len_unsat 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
