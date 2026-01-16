(set-logic ALL)

; Uninterpreted interface for string split operations

; -----------------------------
; SAT instance: well-formed HTTP header parsing
; -----------------------------
(declare-const req_sat String)
(declare-const header_blob_sat String)
(declare-const request_line_sat String)
(declare-const method_sat String)
(declare-const uri_sat String)
(declare-const version_sat String)
(declare-const cl_line_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_sat String)
(declare-const host_line_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; Concrete request with CRLF as newline
(assert (= req_sat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "abcde")))

; Split request into header blob and body by empty line delimiter
(assert (= header_blob_sat (str.split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (str.split_at req_sat "\r\n\r\n" 1)))
(assert (>= (str.num_splits req_sat "\r\n\r\n") 2))

; Parse first header line (request line)
(assert (= request_line_sat (str.split_at header_blob_sat "\r\n" 0)))
(assert (= method_sat (str.split_at request_line_sat " " 0)))
(assert (= uri_sat (str.split_at request_line_sat " " 1)))
(assert (= version_sat (str.split_at request_line_sat " " 2)))
(assert (= method_sat "POST"))
(assert (= uri_sat "/submit"))
(assert (= version_sat "HTTP/1.1"))
(assert (>= (str.num_splits request_line_sat " ") 3))

; Parse Host header line: second line in header blob
(assert (= host_line_sat (str.split_at header_blob_sat "\r\n" 1)))
(assert (= host_key_sat (str.split_at host_line_sat ": " 0)))
(assert (= host_value_sat (str.split_at host_line_sat ": " 1)))
(assert (= host_key_sat "Host"))
(assert (= host_value_sat "example.com"))
(assert (>= (str.num_splits host_line_sat ": ") 2))

; Parse Content-Length header line: third line in header blob
(assert (= cl_line_sat (str.split_at header_blob_sat "\r\n" 2)))
(assert (= cl_key_sat (str.split_at cl_line_sat ": " 0)))
(assert (= cl_value_sat (str.split_at cl_line_sat ": " 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (= cl_value_sat "5"))
(assert (>= (str.num_splits cl_line_sat ": ") 2))

; Validate body length matches numeric content-length
(assert (= content_length_sat 5))
(assert (= (str.len body_sat) content_length_sat))

; Basic sanity: header blob should have at least 3 lines (request + 2 headers)
(assert (>= (str.num_splits header_blob_sat "\r\n") 3))

; -----------------------------
; UNSAT instance: contradictory Content-Length vs body length
; -----------------------------
(declare-const req_unsat String)
(declare-const header_blob_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_value_unsat String)
(declare-const content_length_unsat Int)

(assert (= req_unsat
  (str.++
    "POST /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 4\r\n"
    "\r\n"
    "abcde")))

(assert (= header_blob_unsat (str.split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_at req_unsat "\r\n\r\n" 1)))
(assert (>= (str.num_splits req_unsat "\r\n\r\n") 2))

(assert (= cl_line_unsat (str.split_at header_blob_unsat "\r\n" 2)))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ": " 0)))
(assert (= cl_value_unsat (str.split_at cl_line_unsat ": " 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (= cl_value_unsat "4"))
(assert (>= (str.num_splits cl_line_unsat ": ") 2))

(assert (= content_length_unsat 4))
; Contradiction: body is "abcde" (length 5) but content-length is 4
(assert (= (str.len body_unsat) content_length_unsat))

; -----------------------------
; Combined check
; The file contains both SAT and UNSAT constraints together; overall result is UNSAT.
; -----------------------------


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
