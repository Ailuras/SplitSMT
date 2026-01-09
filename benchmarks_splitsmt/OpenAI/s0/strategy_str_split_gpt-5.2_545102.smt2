(set-logic ALL)

; Uninterpreted string-split interface (per provided methodology)

; ========== SAT instance: well-formed HTTP header parsing ==========
(declare-const hdr_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)
(declare-const content_length_sat Int)
(declare-const body_sat String)

; Basic structure: request-line \n headers... \n\n body
(assert (= request_line_sat (str.split_at hdr_sat "\n" 0)))
(assert (= headers_block_sat (str.split_rest hdr_sat "\n" 1)))
(assert (>= (str.num_splits hdr_sat "\n") 5))

; Constrain concrete header text to make the instance satisfiable
(assert (= hdr_sat
  (str.++
    "POST /submit HTTP/1.1\n"
    "Host: example.com\n"
    "Content-Length: 5\n"
    "User-Agent: AgentX\n"
    "\n"
    "abcde")))

; Identify header lines by line splitting
(assert (= host_line_sat (str.split_at hdr_sat "\n" 1)))
(assert (= cl_line_sat   (str.split_at hdr_sat "\n" 2)))
(assert (= ua_line_sat   (str.split_at hdr_sat "\n" 3)))
(assert (= body_sat      (str.split_at hdr_sat "\n" 5)))

; Parse key/value with colon+space delimiter
(assert (= host_key_sat (str.split_at host_line_sat ": " 0)))
(assert (= host_val_sat (str.split_at host_line_sat ": " 1)))
(assert (= cl_key_sat   (str.split_at cl_line_sat   ": " 0)))
(assert (= cl_val_sat   (str.split_at cl_line_sat   ": " 1)))
(assert (= ua_key_sat   (str.split_at ua_line_sat   ": " 0)))
(assert (= ua_val_sat   (str.split_at ua_line_sat   ": " 1)))

; Interface/bounds-style constraints
(assert (>= (str.num_splits host_line_sat ": ") 2))
(assert (>= (str.num_splits cl_line_sat   ": ") 2))
(assert (>= (str.num_splits ua_line_sat   ": ") 2))

; Header key validation
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))

; Content validation: content-length matches body length
(assert (= cl_val_sat "5"))
(assert (= content_length_sat 5))
(assert (= (str.len body_sat) content_length_sat))

; Extra realism checks
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (> (str.len host_val_sat) 0))
(assert (> (str.len ua_val_sat) 0))
(assert (not (str.contains host_val_sat " ")))

; ========== UNSAT instance: conflicting content-length ==========
(declare-const hdr_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

; Constrain a concrete header where Content-Length disagrees with body length
(assert (= hdr_unsat
  (str.++
    "POST /x HTTP/1.1\n"
    "Host: a.test\n"
    "Content-Length: 4\n"
    "\n"
    "HELLO")))

(assert (= cl_line_unsat (str.split_at hdr_unsat "\n" 2)))
(assert (= cl_val_unsat  (str.split_at cl_line_unsat ": " 1)))
(assert (= body_unsat    (str.split_at hdr_unsat "\n" 4)))

(assert (>= (str.num_splits cl_line_unsat ": ") 2))
(assert (= cl_val_unsat "4"))
(assert (= content_length_unsat 4))

; Contradiction: body is "HELLO" length 5, but content-length forced to 4
(assert (= (str.len body_unsat) content_length_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
