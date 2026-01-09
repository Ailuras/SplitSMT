(set-logic ALL)

; Uninterpreted split interface (str_split)

; Scenario: HTTP Header Parsing
; We model an HTTP request header block with CRLF separators and colon key/value format.

; Shared primitives
(declare-const CRLF String)
(declare-const COLON String)
(assert (= CRLF "\r\n"))
(assert (= COLON ":"))

; =====================
; SAT instance: well-formed request with consistent Content-Length
; =====================
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const line_host_sat String)
(declare-const line_cl_sat String)
(declare-const line_conn_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_val_trim_sat String)
(declare-const conn_key_sat String)
(declare-const conn_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; Split request into lines by CRLF
(assert (= request_line_sat (str.split_at req_sat CRLF 0)))
(assert (= headers_block_sat (str.split_rest req_sat CRLF 1)))
(assert (>= (str.num_splits req_sat CRLF) 5))

; Header lines (assume exactly: Host, Content-Length, Connection, blank, then body)
(assert (= line_host_sat (str.split_at req_sat CRLF 1)))
(assert (= line_cl_sat (str.split_at req_sat CRLF 2)))
(assert (= line_conn_sat (str.split_at req_sat CRLF 3)))
(assert (= (str.split_at req_sat CRLF 4) ""))
(assert (= body_sat (str.split_rest req_sat CRLF 5)))

; Each header line contains a colon separating key and value
(assert (>= (str.num_splits line_host_sat COLON) 2))
(assert (>= (str.num_splits line_cl_sat COLON) 2))
(assert (>= (str.num_splits line_conn_sat COLON) 2))

; Extract keys and values around the first colon
(assert (= host_key_sat (str.split_at line_host_sat COLON 0)))
(assert (= host_val_sat (str.split_rest line_host_sat COLON 1)))
(assert (= cl_key_sat (str.split_at line_cl_sat COLON 0)))
(assert (= cl_val_sat (str.split_rest line_cl_sat COLON 1)))
(assert (= conn_key_sat (str.split_at line_conn_sat COLON 0)))
(assert (= conn_val_sat (str.split_rest line_conn_sat COLON 1)))

; Enforce expected header names (case-sensitive for this model)
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= conn_key_sat "Connection"))

; Values are commonly preceded by a single space; model trimmed value by dropping first char
(assert (>= (str.len cl_val_sat) 2))
(assert (= (str.at cl_val_sat 0) " "))
(assert (= cl_val_trim_sat (str.substr cl_val_sat 1 (- (str.len cl_val_sat) 1))))

; Content-Length value is digits only and non-empty
(assert (>= (str.len cl_val_trim_sat) 1))
(assert (str.in_re cl_val_trim_sat (re.+ (re.range "0" "9"))))

; Link Content-Length int to body length in a consistent way
(assert (= content_length_sat (str.to_int cl_val_trim_sat)))
(assert (>= content_length_sat 0))
(assert (= content_length_sat (str.len body_sat)))

; Some additional realism constraints
(assert (str.in_re request_line_sat (re.++ (str.to_re "GET ") (re.+ (re.range "!" "~")) (str.to_re " HTTP/1.1"))))
(assert (str.contains host_val_sat "example"))
(assert (or (= conn_val_sat " close") (= conn_val_sat " keep-alive")))

; Concretize a satisfying shape (still leaves some freedom)
(assert (str.contains req_sat "Content-Length"))
(assert (str.contains req_sat "\r\n\r\n"))

; =====================
; UNSAT instance: inconsistent Content-Length vs body length
; =====================
(declare-const req_unsat String)
(declare-const line_cl_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_val_trim_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

(assert (>= (str.num_splits req_unsat CRLF) 4))
(assert (= line_cl_unsat (str.split_at req_unsat CRLF 1)))
(assert (= (str.split_at req_unsat CRLF 2) ""))
(assert (= body_unsat (str.split_rest req_unsat CRLF 3)))

(assert (>= (str.num_splits line_cl_unsat COLON) 2))
(assert (= (str.split_at line_cl_unsat COLON 0) "Content-Length"))
(assert (= cl_val_unsat (str.split_rest line_cl_unsat COLON 1)))

(assert (>= (str.len cl_val_unsat) 2))
(assert (= (str.at cl_val_unsat 0) " "))
(assert (= cl_val_trim_unsat (str.substr cl_val_unsat 1 (- (str.len cl_val_unsat) 1))))
(assert (str.in_re cl_val_trim_unsat (re.+ (re.range "0" "9"))))
(assert (= content_length_unsat (str.to_int cl_val_trim_unsat)))
(assert (>= content_length_unsat 0))

; Force a specific mismatch: Content-Length claims 3 but body has length 5.
(assert (= cl_val_trim_unsat "3"))
(assert (= (str.len body_unsat) 5))
(assert (= content_length_unsat (str.len body_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
