(set-logic ALL)

; Uninterpreted interface for str_split

; ========= SAT instance: plausible HTTP header parsing =========
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const content_length_line_sat String)
(declare-const content_length_value_sat String)
(declare-const host_line_sat String)
(declare-const host_value_sat String)
(declare-const user_agent_line_sat String)
(declare-const user_agent_value_sat String)
(declare-const body_sat String)
(declare-const clen_sat Int)

; Request splits into headers and body by double newline
(assert (>= (str.num_splits req_sat "\r\n\r\n") 2))
(assert (= headers_sat (str.split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (str.split_rest req_sat "\r\n\r\n" 1)))

; Headers have at least request-line + 3 header lines
(assert (>= (str.num_splits headers_sat "\r\n") 4))

; Select specific header lines by index
(assert (= content_length_line_sat (str.split_at headers_sat "\r\n" 1)))
(assert (= host_line_sat (str.split_at headers_sat "\r\n" 2)))
(assert (= user_agent_line_sat (str.split_at headers_sat "\r\n" 3)))

; Each chosen header line must contain a colon
(assert (>= (str.num_splits content_length_line_sat ":") 2))
(assert (>= (str.num_splits host_line_sat ":") 2))
(assert (>= (str.num_splits user_agent_line_sat ":") 2))

; Enforce header keys exactly (no trimming modeled; space is part of value if present)
(assert (= (str.split_at content_length_line_sat ":" 0) "Content-Length"))
(assert (= (str.split_at host_line_sat ":" 0) "Host"))
(assert (= (str.split_at user_agent_line_sat ":" 0) "User-Agent"))

; Extract values as the remainder after the first colon
(assert (= content_length_value_sat (str.split_rest content_length_line_sat ":" 1)))
(assert (= host_value_sat (str.split_rest host_line_sat ":" 1)))
(assert (= user_agent_value_sat (str.split_rest user_agent_line_sat ":" 1)))

; Concrete values for a satisfiable example
(assert (= host_value_sat " example.com"))
(assert (= user_agent_value_sat " curl/8.0"))
(assert (= content_length_value_sat " 5"))

; Validate content-length: body length matches declared length (treating value as " 5")
(assert (= clen_sat 5))
(assert (= (str.len body_sat) clen_sat))

; Provide a concrete request consistent with the above constraints
(assert (= req_sat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Content-Length: 5\r\n"
    "Host: example.com\r\n"
    "User-Agent: curl/8.0\r\n"
    "\r\n"
    "abcde")))

; ========= UNSAT instance: conflicting content-length =========
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const content_length_line_unsat String)
(declare-const content_length_value_unsat String)
(declare-const clen_unsat Int)

(assert (>= (str.num_splits req_unsat "\r\n\r\n") 2))
(assert (= headers_unsat (str.split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_rest req_unsat "\r\n\r\n" 1)))
(assert (>= (str.num_splits headers_unsat "\r\n") 2))
(assert (= content_length_line_unsat (str.split_at headers_unsat "\r\n" 1)))
(assert (>= (str.num_splits content_length_line_unsat ":") 2))
(assert (= (str.split_at content_length_line_unsat ":" 0) "Content-Length"))
(assert (= content_length_value_unsat (str.split_rest content_length_line_unsat ":" 1)))

; Fix a request whose body has length 4
(assert (= req_unsat
  (str.++
    "POST /x HTTP/1.1\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "DATA")))

; Force declared content-length as 5 while body is 4 => UNSAT
(assert (= clen_unsat 5))
(assert (= content_length_value_unsat " 5"))
(assert (= (str.len body_unsat) 4))
(assert (= (str.len body_unsat) clen_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
