(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =========================================
; SAT instance: well-formed HTTP headers
; =========================================
(declare-const req_sat String)
(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)
(declare-const header_line3_sat String)
(declare-const body_sat String)

(declare-const key1_sat String)
(declare-const val1_sat String)
(declare-const key2_sat String)
(declare-const val2_sat String)
(declare-const key3_sat String)
(declare-const val3_sat String)

(declare-const content_length_str_sat String)
(declare-const content_length_int_sat Int)

; Concrete request with CRLF separators and a short body
(assert (= req_sat (str.++
  "POST /submit HTTP/1.1\r\n"
  "Host: example.com\r\n"
  "Content-Length: 5\r\n"
  "X-Token: abc123\r\n"
  "\r\n"
  "HELLO")))

; Split into lines by CRLF
(assert (= header_line0_sat (split_at req_sat "\r\n" 0)))
(assert (= header_line1_sat (split_at req_sat "\r\n" 1)))
(assert (= header_line2_sat (split_at req_sat "\r\n" 2)))
(assert (= header_line3_sat (split_at req_sat "\r\n" 3)))

; Require at least request-line + 3 headers + blank line + body segment
(assert (>= (num_splits req_sat "\r\n") 6))

; Body is whatever remains after the blank line (index 4 is empty for CRLFCRLF)
(assert (= body_sat (split_rest req_sat "\r\n" 5)))
(assert (= (str.len body_sat) 5))
(assert (= body_sat "HELLO"))

; Parse header line1: "Host: example.com"
(assert (= key1_sat (split_at header_line1_sat ":" 0)))
(assert (= val1_sat (split_rest header_line1_sat ":" 1)))
(assert (= key1_sat "Host"))
(assert (= val1_sat " example.com"))

; Parse header line2: "Content-Length: 5"
(assert (= key2_sat (split_at header_line2_sat ":" 0)))
(assert (= val2_sat (split_rest header_line2_sat ":" 1)))
(assert (= key2_sat "Content-Length"))
(assert (= val2_sat " 5"))

; Parse header line3: "X-Token: abc123"
(assert (= key3_sat (split_at header_line3_sat ":" 0)))
(assert (= val3_sat (split_rest header_line3_sat ":" 1)))
(assert (= key3_sat "X-Token"))
(assert (= val3_sat " abc123"))

; Validate presence of ':' in each header line via split count >= 2
(assert (>= (num_splits header_line1_sat ":") 2))
(assert (>= (num_splits header_line2_sat ":") 2))
(assert (>= (num_splits header_line3_sat ":") 2))

; Content-Length validation: value is exactly " 5" and matches body length
(assert (= content_length_str_sat " 5"))
(assert (= content_length_int_sat 5))
(assert (= val2_sat content_length_str_sat))
(assert (= (str.len body_sat) content_length_int_sat))

; Sanity checks: request-line looks like HTTP/1.1
(assert (str.contains header_line0_sat "HTTP/1.1"))

(check-sat)

; =========================================
; UNSAT instance: contradictory Content-Length
; =========================================
(declare-const req_unsat String)
(declare-const header_line0_unsat String)
(declare-const header_line1_unsat String)
(declare-const header_line2_unsat String)
(declare-const body_unsat String)

(declare-const key_cl_unsat String)
(declare-const val_cl_unsat String)
(declare-const content_length_int_unsat Int)

; Concrete request says Content-Length: 3 but body is length 5
(assert (= req_unsat (str.++
  "POST /x HTTP/1.1\r\n"
  "Host: ex\r\n"
  "Content-Length: 3\r\n"
  "\r\n"
  "HELLO")))

(assert (= header_line0_unsat (split_at req_unsat "\r\n" 0)))
(assert (= header_line1_unsat (split_at req_unsat "\r\n" 1)))
(assert (= header_line2_unsat (split_at req_unsat "\r\n" 2)))
(assert (>= (num_splits req_unsat "\r\n") 5))

; Body remainder after blank line
(assert (= body_unsat (split_rest req_unsat "\r\n" 4)))
(assert (= body_unsat "HELLO"))
(assert (= (str.len body_unsat) 5))

; Parse Content-Length header
(assert (= key_cl_unsat (split_at header_line2_unsat ":" 0)))
(assert (= val_cl_unsat (split_rest header_line2_unsat ":" 1)))
(assert (= key_cl_unsat "Content-Length"))
(assert (= val_cl_unsat " 3"))
(assert (>= (num_splits header_line2_unsat ":") 2))

; Contradictory validation: claim Content-Length is 3 but also must match body length 5
(assert (= content_length_int_unsat 3))
(assert (= (str.len body_unsat) content_length_int_unsat))

; Extra shape constraints
(assert (str.contains header_line0_unsat "HTTP/1.1"))
(assert (= (split_at header_line1_unsat ":" 0) "Host"))

(check-sat)


; [GENERATION STATUS: SUCCESS]