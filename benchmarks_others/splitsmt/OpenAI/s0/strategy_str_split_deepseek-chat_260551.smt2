(set-logic ALL)

; Uninterpreted interface for str_split

; -----------------------------
; SAT instance: consistent HTTP header parsing
; -----------------------------
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const header1_line_sat String)
(declare-const header2_line_sat String)
(declare-const content_length_value_sat String)
(declare-const host_value_sat String)
(declare-const method_sat String)
(declare-const uri_sat String)
(declare-const http_version_sat String)
(declare-const cl_num_sat Int)

; Request split into request-line and headers using newline
(assert (= request_line_sat (str.split_at req_sat "\n" 0)))
(assert (= headers_block_sat (str.split_rest req_sat "\n" 1)))
(assert (>= (str.num_splits req_sat "\n") 3))

; Parse request-line: "METHOD URI HTTP/1.1"
(assert (= method_sat (str.split_at request_line_sat " " 0)))
(assert (= uri_sat (str.split_at request_line_sat " " 1)))
(assert (= http_version_sat (str.split_at request_line_sat " " 2)))
(assert (>= (str.num_splits request_line_sat " ") 3))
(assert (= method_sat "GET"))
(assert (= http_version_sat "HTTP/1.1"))
(assert (str.prefixof "/" uri_sat))

; Two header lines in the header block (ignore possible extra lines)
(assert (= header1_line_sat (str.split_at headers_block_sat "\n" 0)))
(assert (= header2_line_sat (str.split_at headers_block_sat "\n" 1)))
(assert (>= (str.num_splits headers_block_sat "\n") 2))

; Each header line must contain a ':' separating key and value
(assert (>= (str.num_splits header1_line_sat ":") 2))
(assert (>= (str.num_splits header2_line_sat ":") 2))

; Constrain concrete keys via split_at
(assert (= (str.split_at header1_line_sat ":" 0) "Host"))
(assert (= host_value_sat (str.split_rest header1_line_sat ":" 1)))
(assert (str.contains host_value_sat "example.com"))

(assert (= (str.split_at header2_line_sat ":" 0) "Content-Length"))
(assert (= content_length_value_sat (str.split_rest header2_line_sat ":" 1)))

; Whitespace-tolerant numeric value: allow a leading space before digits
; Accept either " N" or "N" for some positive integer N
(assert (or
  (= content_length_value_sat (str.++ " " (int.to.str cl_num_sat)))
  (= content_length_value_sat (int.to.str cl_num_sat))
))
(assert (> cl_num_sat 0))

; The overall request must contain at least one Content-Length header line
(assert (str.contains req_sat "Content-Length:"))

; -----------------------------
; UNSAT instance: contradictory Content-Length parsing constraints
; -----------------------------
(declare-const req_unsat String)
(declare-const headers_block_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const cl_num_unsat Int)

; Header block begins after request-line
(assert (= headers_block_unsat (str.split_rest req_unsat "\n" 1)))
(assert (>= (str.num_splits req_unsat "\n") 2))

; First header line is Content-Length
(assert (= cl_line_unsat (str.split_at headers_block_unsat "\n" 0)))
(assert (= (str.split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_value_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (>= (str.num_splits cl_line_unsat ":") 2))

; Enforce it is a plain decimal rendering of an integer
(assert (= cl_value_unsat (int.to.str cl_num_unsat)))
(assert (>= cl_num_unsat 0))

; Contradiction: same value must also include a mandatory leading space
(assert (= cl_value_unsat (str.++ " " (int.to.str cl_num_unsat))))

; Additionally, pin a concrete request string that cannot satisfy both
(assert (= req_unsat "POST /submit HTTP/1.1\nContent-Length:5\n\n"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
