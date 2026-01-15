(set-logic ALL)

; Uninterpreted interface for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Additional uninterpreted parsing helpers (non-primitive)
(declare-fun parse_int (String) Int)

; ========== Shared declarations ==========
(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const body String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)

(declare-const host_key String)
(declare-const host_val_raw String)
(declare-const host_val String)

(declare-const cl_key String)
(declare-const cl_val_raw String)
(declare-const cl_val String)
(declare-const cl_int Int)

(declare-const ua_key String)
(declare-const ua_val_raw String)
(declare-const ua_val String)

(declare-const rest_after_reqline String)
(declare-const rest_after_headers String)

(declare-const sat_case Bool)

; ========== Global structure: request line, headers, blank line, body ==========
; Split by CRLF (\r\n): first segment is request line
(assert (= request_line (split_at request "\r\n" 0)))
(assert (= rest_after_reqline (split_rest request "\r\n" 1)))

; Headers end at the first empty line: model as splitting the remainder by double-CRLF
(assert (= headers_block (split_at rest_after_reqline "\r\n\r\n" 0)))
(assert (= rest_after_headers (split_rest rest_after_reqline "\r\n\r\n" 1)))
(assert (= body rest_after_headers))

; Basic sanity: must contain at least one header line and a body boundary
(assert (>= (num_splits rest_after_reqline "\r\n\r\n") 2))
(assert (>= (num_splits headers_block "\r\n") 2))

; ========== Identify specific header lines by position (simplified scenario) ==========
(assert (= host_line (split_at headers_block "\r\n" 0)))
(assert (= cl_line (split_at headers_block "\r\n" 1)))
(assert (= ua_line (split_at headers_block "\r\n" 2)))
(assert (>= (num_splits headers_block "\r\n") 3))

; ========== Parse key/value by colon delimiter ==========
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val_raw (split_rest host_line ":" 1)))

(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_val_raw (split_rest cl_line ":" 1)))

(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_val_raw (split_rest ua_line ":" 1)))

; Require the header lines to actually contain ':' (at least 2 segments)
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))
(assert (>= (num_splits ua_line ":") 2))

; In this simplified model, require a single ':' per header line
(assert (= (num_splits host_line ":") 2))
(assert (= (num_splits cl_line ":") 2))
(assert (= (num_splits ua_line ":") 2))

; ========== Whitespace handling (simplified): require single leading space in values ==========
(assert (= (str.at host_val_raw 0) " "))
(assert (= (str.at cl_val_raw 0) " "))
(assert (= (str.at ua_val_raw 0) " "))

(assert (>= (str.len host_val_raw) 2))
(assert (>= (str.len cl_val_raw) 2))
(assert (>= (str.len ua_val_raw) 2))

; Drop the leading space
(assert (= host_val (str.substr host_val_raw 1 (- (str.len host_val_raw) 1))))
(assert (= cl_val (str.substr cl_val_raw 1 (- (str.len cl_val_raw) 1))))
(assert (= ua_val (str.substr ua_val_raw 1 (- (str.len ua_val_raw) 1))))

; ========== Header key validation (case-sensitive for this scenario) ==========
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Host value must be non-empty and contain a dot (e.g., example.com)
(assert (> (str.len host_val) 0))
(assert (str.contains host_val "."))

; User-Agent must be non-empty
(assert (> (str.len ua_val) 0))

; Content-Length numeric parsing and validation
(assert (= cl_int (parse_int cl_val)))
(assert (>= cl_int 0))

; ========== Request line basic validation ==========
; Require it starts with "POST " and contains " HTTP/1.1"
(assert (str.contains request_line " HTTP/1.1"))
(assert (= (str.substr request_line 0 5) "POST "))

; ========== Content-Length matches body length (SAT branch) ==========
(declare-const request_sat String)
(declare-const request_unsat String)

; Use sat_case to select which instance is active
(assert (= request (ite sat_case request_sat request_unsat)))

; --- SAT instance: consistent content-length ---
(declare-const sat_body String)
(declare-const sat_cl_val String)
(declare-const sat_cl_int Int)

(assert (= sat_body "hello=world"))
(assert (= sat_cl_val "11"))
(assert (= sat_cl_int (parse_int sat_cl_val)))

(assert (= request_sat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    (str.++ "Content-Length: " (str.++ sat_cl_val "\r\n"))
    "User-Agent: TestAgent/1.0\r\n"
    "\r\n"
    sat_body)))

; enforce the intended relation in the SAT instance
(assert (= sat_cl_int (str.len sat_body)))

; --- UNSAT instance: inconsistent content-length ---
(declare-const unsat_body String)
(declare-const unsat_cl_val String)
(declare-const unsat_cl_int Int)

(assert (= unsat_body "ABCDE"))
(assert (= unsat_cl_val "4"))
(assert (= unsat_cl_int (parse_int unsat_cl_val)))

(assert (= request_unsat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    (str.++ "Content-Length: " (str.++ unsat_cl_val "\r\n"))
    "User-Agent: TestAgent/1.0\r\n"
    "\r\n"
    unsat_body)))

; force the inconsistency for the UNSAT instance
(assert (not (= unsat_cl_int (str.len unsat_body))))

; ========== Connect extracted Content-Length to body length depending on chosen case ==========
; When sat_case is true, the parsed content-length must match the extracted body length
; When sat_case is false, we demand the opposite, making the entire instance UNSAT for that branch.
(assert (ite sat_case
  (= cl_int (str.len body))
  (not (= cl_int (str.len body)))))

; Additionally, tie the cl_val to the chosen concrete request content-length value
(assert (= cl_val (ite sat_case sat_cl_val unsat_cl_val)))

; Choose one: set sat_case to true for SAT, false for UNSAT.
; Leaving it unconstrained lets the solver pick SAT via sat_case = true.

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
