(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface functions for str_split

; ===== SAT instance: well-formed HTTP header parsing =====
(declare-const req_sat String)
(declare-const header_blob_sat String)
(declare-const first_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; Split request into header block and body by CRLFCRLF
(assert (= header_blob_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at req_sat "\r\n\r\n" 1)))
(assert (= 2 (num_splits req_sat "\r\n\r\n")))

; Split header block into lines by CRLF
(assert (= first_line_sat (split_at header_blob_sat "\r\n" 0)))
(assert (= host_line_sat (split_at header_blob_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at header_blob_sat "\r\n" 2)))
(assert (>= (num_splits header_blob_sat "\r\n") 3))

; Basic request line sanity: must contain method and HTTP version
(assert (str.contains first_line_sat "HTTP/1.1"))
(assert (str.contains first_line_sat " "))

; Parse Host: line by ':'
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat "Host"))
; Host value should be non-empty after trimming leading space (approx via contains)
(assert (or (str.contains host_val_sat "example.com") (>= (str.len host_val_sat) 2)))

; Parse Content-Length: line by ':'
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat "Content-Length"))

; Model content-length as an integer consistent with the body length
(assert (>= content_length_sat 0))
(assert (= content_length_sat (str.len body_sat)))

; Constrain the concrete shape of the request to ensure satisfiable parsing
(assert (= req_sat (str.++
  "POST /submit HTTP/1.1\r\n"
  "Host: example.com\r\n"
  "Content-Length: 5\r\n"
  "\r\n"
  "HELLO")))

; ===== UNSAT instance: contradictory content-length validation =====
(declare-const req_unsat String)
(declare-const header_blob_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_length_unsat Int)

(assert (= header_blob_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at req_unsat "\r\n\r\n" 1)))
(assert (= 2 (num_splits req_unsat "\r\n\r\n")))

; Locate the second header line as Content-Length and parse it
(assert (= cl_line_unsat (split_at header_blob_unsat "\r\n" 1)))
(assert (>= (num_splits header_blob_unsat "\r\n") 2))

(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat "Content-Length"))

; Constrain the request to a fixed body, then require inconsistent length
(assert (= req_unsat (str.++
  "GET / HTTP/1.1\r\n"
  "Content-Length: 3\r\n"
  "\r\n"
  "AB")))

(assert (>= content_length_unsat 0))
(assert (= content_length_unsat (str.len body_unsat)))
; Contradiction: body is "AB" (len 2) but enforce it to be 3
(assert (= content_length_unsat 3))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
