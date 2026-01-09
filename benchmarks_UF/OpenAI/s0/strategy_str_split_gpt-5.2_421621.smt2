(set-logic ALL)

; Uninterpreted interface functions for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; SAT instance: parse headers and validate Content-Length
; =====================
(declare-const request_sat String)
(declare-const header_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const content_len_sat Int)

; A simple HTTP request with CRLF and one-line body of length 5
(assert (= request_sat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "HELLO")))

; Split header section from body at the CRLFCRLF separator
(assert (= header_block_sat (split_at request_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at request_sat "\r\n\r\n" 1)))
(assert (>= (num_splits request_sat "\r\n\r\n") 2))

; Header lines: 0=request line, 1=Host line, 2=Content-Length line
(assert (= host_line_sat (split_at header_block_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at header_block_sat "\r\n" 2)))
(assert (>= (num_splits header_block_sat "\r\n") 3))

; Parse Host: key/value by first colon
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_at host_line_sat ":" 1)))
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat "Host"))
; host value includes leading space in raw header; require it starts with " " and contains a dot
(assert (str.prefixof " " host_val_sat))
(assert (str.contains host_val_sat "."))

; Parse Content-Length: key/value
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_at cl_line_sat ":" 1)))
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat "Content-Length"))
(assert (str.prefixof " " cl_val_sat))

; Constrain Content-Length digits and tie to integer
(assert (= cl_val_sat " 5"))
(assert (= content_len_sat 5))
(assert (= (str.len body_sat) content_len_sat))

; Additional sanity: body is uppercase letters and length 5
(assert (= body_sat "HELLO"))

; =====================
; UNSAT instance: conflicting Content-Length vs actual body size
; =====================
(declare-const request_unsat String)
(declare-const header_block_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_len_unsat Int)

(assert (= request_unsat
  (str.++
    "POST /x HTTP/1.1\r\n"
    "Content-Length: 10\r\n"
    "\r\n"
    "HELLO")))

(assert (= header_block_unsat (split_at request_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at request_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits request_unsat "\r\n\r\n") 2))

(assert (= cl_line_unsat (split_at header_block_unsat "\r\n" 1)))
(assert (>= (num_splits header_block_unsat "\r\n") 2))

(assert (= cl_val_unsat (split_at cl_line_unsat ":" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))

(assert (= cl_val_unsat " 10"))
(assert (= content_len_unsat 10))
(assert (= body_unsat "HELLO"))

; This forces a contradiction: len("HELLO") = 5 but required 10
(assert (= (str.len body_unsat) content_len_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]