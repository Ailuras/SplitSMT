(set-logic ALL)

; Uninterpreted interface for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ---------------------------
; SAT instance: plausible HTTP header parsing
; ---------------------------
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_sat String)
(declare-const header1_sat String)
(declare-const header2_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const host_sat String)
(declare-const content_length_sat String)
(declare-const cl_len_sat Int)
(declare-const body_sat String)
(declare-const body_len_sat Int)

; Shape the request
(assert (= req_sat (str.++ request_line_sat "\n" headers_sat "\n\n" body_sat)))
(assert (= request_line_sat "POST /submit HTTP/1.1"))

; Split headers by newline into at least 2 lines
(assert (>= (num_splits headers_sat "\n") 2))
(assert (= header1_sat (split_at headers_sat "\n" 0)))
(assert (= header2_sat (split_at headers_sat "\n" 1)))

; Identify Host and Content-Length lines (order fixed for this instance)
(assert (= host_line_sat header1_sat))
(assert (= cl_line_sat header2_sat))

; Parse "Host: <value>" using ':' delimiter
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_at host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
; enforce a single leading space before host value
(assert (= host_val_sat (str.++ " " host_sat)))
(assert (not (str.contains host_sat "\n")))
(assert (not (str.contains host_sat ":")))
(assert (> (str.len host_sat) 0))

; Parse "Content-Length: <digits>" using ':' delimiter
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_at cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (= cl_val_sat (str.++ " " content_length_sat)))

; Validate that content-length is all digits and consistent with body length
(assert (str.in_re content_length_sat (re.+ (re.range "0" "9"))))
(assert (= cl_len_sat (str.to_int content_length_sat)))
(assert (= body_len_sat (str.len body_sat)))
(assert (>= cl_len_sat 0))
(assert (= cl_len_sat body_len_sat))

; Additional sanity: no CRLF, and avoid embedded header terminator in headers
(assert (not (str.contains req_sat "\r")))
(assert (not (str.contains headers_sat "\n\n")))

; ---------------------------
; UNSAT instance: contradictory Content-Length
; ---------------------------
(declare-const req_unsat String)
(declare-const request_line_unsat String)
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_length_unsat String)
(declare-const cl_len_unsat Int)
(declare-const body_unsat String)
(declare-const body_len_unsat Int)

(assert (= req_unsat (str.++ request_line_unsat "\n" headers_unsat "\n\n" body_unsat)))
(assert (= request_line_unsat "POST /x HTTP/1.1"))

; One header line: Content-Length only
(assert (>= (num_splits headers_unsat "\n") 1))
(assert (= cl_line_unsat (split_at headers_unsat "\n" 0)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_at cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (= cl_val_unsat (str.++ " " content_length_unsat)))

(assert (str.in_re content_length_unsat (re.+ (re.range "0" "9"))))
(assert (= cl_len_unsat (str.to_int content_length_unsat)))
(assert (= body_len_unsat (str.len body_unsat)))

; Force a contradiction: header says length 5 but body must have length 3
(assert (= cl_len_unsat 5))
(assert (= body_len_unsat 3))
(assert (= cl_len_unsat body_len_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]