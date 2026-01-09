(set-logic ALL)

; Uninterpreted interface for str_split

; -----------------------------
; SAT instance: well-formed HTTP header parsing with Content-Length validation
; -----------------------------
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_sat String)
(declare-const host_line_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const cl_line_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)
(declare-const body_len_sat Int)

; Basic structure: request-line + headers + blank-line + body
(assert (= request_line_sat (str.split_at req_sat "\r\n" 0)))
(assert (= headers_sat (str.split_rest req_sat "\r\n" 1)))
(assert (>= (str.num_splits req_sat "\r\n") 4))

; Pin a concrete satisfiable request skeleton
(assert (= request_line_sat "POST /submit HTTP/1.1"))
(assert (= host_line_sat (str.split_at req_sat "\r\n" 1)))
(assert (= cl_line_sat (str.split_at req_sat "\r\n" 2)))
(assert (= (str.split_at req_sat "\r\n" 3) ""))
(assert (= body_sat (str.split_rest req_sat "\r\n" 4)))

; Host header: "Host: example.com"
(assert (= host_key_sat (str.split_at host_line_sat ":" 0)))
(assert (= host_value_sat (str.split_at host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
(assert (= host_value_sat " example.com"))
(assert (= (str.num_splits host_line_sat ":") 2))

; Content-Length header: "Content-Length: 5"
(assert (= cl_key_sat (str.split_at cl_line_sat ":" 0)))
(assert (= cl_value_sat (str.split_at cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (= cl_value_sat " 5"))
(assert (= (str.num_splits cl_line_sat ":") 2))

; Body fixed to length 5
(assert (= body_sat "hello"))
(assert (= body_len_sat (str.len body_sat)))
(assert (= content_length_sat 5))
(assert (= body_len_sat content_length_sat))

; Additional sanity constraints: keys are non-empty, no newline inside header lines
(assert (> (str.len host_key_sat) 0))
(assert (> (str.len cl_key_sat) 0))
(assert (not (str.contains host_line_sat "\r\n")))
(assert (not (str.contains cl_line_sat "\r\n")))

; -----------------------------
; UNSAT instance: conflicting Content-Length vs actual body length
; -----------------------------
(declare-const req_unsat String)
(declare-const request_line_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_len_unsat Int)

(assert (= request_line_unsat (str.split_at req_unsat "\r\n" 0)))
(assert (= cl_line_unsat (str.split_at req_unsat "\r\n" 1)))
(assert (= (str.split_at req_unsat "\r\n" 2) ""))
(assert (= body_unsat (str.split_rest req_unsat "\r\n" 3)))
(assert (>= (str.num_splits req_unsat "\r\n") 3))

; Concrete request with body length 4 but claims Content-Length 3 (inconsistent)
(assert (= request_line_unsat "POST /x HTTP/1.1"))
(assert (= cl_line_unsat "Content-Length: 3"))
(assert (= cl_value_unsat (str.split_at cl_line_unsat ":" 1)))
(assert (= cl_value_unsat " 3"))
(assert (= body_unsat "DATA"))
(assert (= body_len_unsat (str.len body_unsat)))
(assert (= content_length_unsat 3))
(assert (= body_len_unsat content_length_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
