(set-logic ALL)

; Uninterpreted interface for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; Scenario: HTTP Header Parsing
; -----------------------------

; Common delimiter constants
(declare-const CRLF String)
(declare-const COLON String)
(assert (= CRLF "\r\n"))
(assert (= COLON ":"))

; ===== SAT instance: well-formed header list with Content-Length =====
(declare-const req_sat String)
(declare-const first_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const accept_line_sat String)
(declare-const empty_line_sat String)

(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_val_trim_sat String)
(declare-const cl_len_int_sat Int)

(declare-const host_key_sat String)
(declare-const host_val_sat String)

; Ensure request splits into at least 5 lines: request-line + 3 headers + blank line
(assert (>= (num_splits req_sat CRLF) 5))
(assert (= first_line_sat (split_at req_sat CRLF 0)))
(assert (= host_line_sat (split_at req_sat CRLF 1)))
(assert (= cl_line_sat (split_at req_sat CRLF 2)))
(assert (= accept_line_sat (split_at req_sat CRLF 3)))
(assert (= empty_line_sat (split_at req_sat CRLF 4)))
(assert (= empty_line_sat ""))

; Basic structure: request line starts with method and space
(assert (str.prefixof "GET " first_line_sat))
(assert (str.contains first_line_sat " HTTP/1.1"))

; Host header parse: "Host: <value>" (allow optional leading space after colon)
(assert (>= (num_splits host_line_sat COLON) 2))
(assert (= host_key_sat (split_at host_line_sat COLON 0)))
(assert (= host_val_sat (split_rest host_line_sat COLON 1)))
(assert (= host_key_sat "Host"))
(assert (or (str.prefixof " " host_val_sat) (not (str.prefixof " " host_val_sat))))
(assert (> (str.len host_val_sat) 0))

; Content-Length parse: "Content-Length: <digits>" possibly with a single leading space
(assert (>= (num_splits cl_line_sat COLON) 2))
(assert (= cl_key_sat (split_at cl_line_sat COLON 0)))
(assert (= cl_val_sat (split_rest cl_line_sat COLON 1)))
(assert (= cl_key_sat "Content-Length"))

; Trim exactly one optional leading space
(assert (or (= cl_val_trim_sat cl_val_sat)
            (and (str.prefixof " " cl_val_sat)
                 (= cl_val_trim_sat (str.substr cl_val_sat 1 (- (str.len cl_val_sat) 1))))))

; Content-Length must be non-empty and all digits
(assert (> (str.len cl_val_trim_sat) 0))
(assert (str.in_re cl_val_trim_sat (re.+ (re.range "0" "9"))))

; Validate numeric content-length against the declared digits (using str.to_int)
(assert (= cl_len_int_sat (str.to_int cl_val_trim_sat)))
(assert (>= cl_len_int_sat 0))
(assert (<= cl_len_int_sat 1048576))

; Ensure Accept line looks like a header key-value pair too
(declare-const accept_key_sat String)
(declare-const accept_val_sat String)
(assert (>= (num_splits accept_line_sat COLON) 2))
(assert (= accept_key_sat (split_at accept_line_sat COLON 0)))
(assert (= accept_val_sat (split_rest accept_line_sat COLON 1)))
(assert (= accept_key_sat "Accept"))
(assert (> (str.len accept_val_sat) 0))

; Constrain req_sat to be consistent with extracted lines (not fully defining split semantics,
; but adding a plausible reconstruction constraint)
(assert (str.contains req_sat (str.++ first_line_sat CRLF)))
(assert (str.contains req_sat (str.++ host_line_sat CRLF)))
(assert (str.contains req_sat (str.++ cl_line_sat CRLF)))
(assert (str.contains req_sat (str.++ accept_line_sat CRLF CRLF)))

; Provide one concrete satisfying shape to avoid underconstrained triviality
(assert (= first_line_sat "GET /index.html HTTP/1.1"))
(assert (= host_line_sat "Host: example.com"))
(assert (= cl_line_sat "Content-Length: 12"))
(assert (= accept_line_sat "Accept: */*"))
(assert (= req_sat (str.++ first_line_sat CRLF host_line_sat CRLF cl_line_sat CRLF accept_line_sat CRLF CRLF)))

; ===== UNSAT instance: conflicting Content-Length requirements =====
(declare-const req_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_val_trim_unsat String)
(declare-const cl_len_int_unsat Int)

; Assume the request has at least request line + one header + blank line
(assert (>= (num_splits req_unsat CRLF) 3))
(assert (= cl_line_unsat (split_at req_unsat CRLF 1)))

(assert (>= (num_splits cl_line_unsat COLON) 2))
(assert (= cl_key_unsat (split_at cl_line_unsat COLON 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat COLON 1)))
(assert (= cl_key_unsat "Content-Length"))

(assert (or (= cl_val_trim_unsat cl_val_unsat)
            (and (str.prefixof " " cl_val_unsat)
                 (= cl_val_trim_unsat (str.substr cl_val_unsat 1 (- (str.len cl_val_unsat) 1))))))

; Must be digits
(assert (> (str.len cl_val_trim_unsat) 0))
(assert (str.in_re cl_val_trim_unsat (re.+ (re.range "0" "9"))))
(assert (= cl_len_int_unsat (str.to_int cl_val_trim_unsat)))
(assert (>= cl_len_int_unsat 0))

; Force a specific digit string but contradict its numeric value => UNSAT
(assert (= cl_val_trim_unsat "10"))
(assert (= cl_len_int_unsat 9))

(check-sat)


; [GENERATION STATUS: SUCCESS]