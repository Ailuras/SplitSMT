(set-logic ALL)

; Uninterpreted interface for str_split

; Additional helper: parse integer from decimal string (uninterpreted)
(declare-fun str_to_int (String) Int)

; ============================
; SAT instance: well-formed HTTP header parsing with valid Content-Length
; ============================
(declare-const req_sat String)
(declare-const header_block_sat String)
(declare-const request_line_sat String)
(declare-const method_sat String)
(declare-const path_sat String)
(declare-const version_sat String)

(declare-const h0_sat String)
(declare-const h1_sat String)
(declare-const h2_sat String)
(declare-const k0_sat String)
(declare-const v0_sat String)
(declare-const k1_sat String)
(declare-const v1_sat String)
(declare-const k2_sat String)
(declare-const v2_sat String)

(declare-const host_sat String)
(declare-const content_length_str_sat String)
(declare-const content_length_sat Int)
(declare-const user_agent_sat String)
(declare-const body_sat String)
(declare-const body_len_sat Int)

; Shape: request-line \r\n headers \r\n\r\n body
(assert (= request_line_sat (str.split_at req_sat "\r\n" 0)))
(assert (= header_block_sat (str.split_rest req_sat "\r\n" 1)))
(assert (>= (str.num_splits req_sat "\r\n") 4))

; Ensure blank line exists: some line in header_block_sat equals "" before body.
; We approximate by requiring that splitting header_block_sat by "\r\n\r\n" yields at least 2 segments.
(assert (>= (str.num_splits header_block_sat "\r\n\r\n") 2))
(assert (= body_sat (str.split_at header_block_sat "\r\n\r\n" 1)))

; Parse request line: "METHOD SP PATH SP HTTP/VERSION"
(assert (>= (str.num_splits request_line_sat " ") 3))
(assert (= method_sat (str.split_at request_line_sat " " 0)))
(assert (= path_sat (str.split_at request_line_sat " " 1)))
(assert (= version_sat (str.split_at request_line_sat " " 2)))

; Constrain to typical values
(assert (or (= method_sat "GET") (= method_sat "POST")))
(assert (str.prefixof "/" path_sat))
(assert (str.prefixof "HTTP/" version_sat))

; Extract first 3 header lines (after request line) from req_sat
(assert (= h0_sat (str.split_at req_sat "\r\n" 1)))
(assert (= h1_sat (str.split_at req_sat "\r\n" 2)))
(assert (= h2_sat (str.split_at req_sat "\r\n" 3)))

; Each header line should contain ':' and be of the form key ":" value
(assert (str.contains h0_sat ":"))
(assert (str.contains h1_sat ":"))
(assert (str.contains h2_sat ":"))

(assert (>= (str.num_splits h0_sat ":") 2))
(assert (>= (str.num_splits h1_sat ":") 2))
(assert (>= (str.num_splits h2_sat ":") 2))

(assert (= k0_sat (str.split_at h0_sat ":" 0)))
(assert (= v0_sat (str.split_rest h0_sat ":" 1)))
(assert (= k1_sat (str.split_at h1_sat ":" 0)))
(assert (= v1_sat (str.split_rest h1_sat ":" 1)))
(assert (= k2_sat (str.split_at h2_sat ":" 0)))
(assert (= v2_sat (str.split_rest h2_sat ":" 1)))

; Header keys are non-empty and without spaces
(assert (> (str.len k0_sat) 0))
(assert (> (str.len k1_sat) 0))
(assert (> (str.len k2_sat) 0))
(assert (not (str.contains k0_sat " ")))
(assert (not (str.contains k1_sat " ")))
(assert (not (str.contains k2_sat " ")))

; Match specific headers among the three (order-agnostic via disjunctions)
(assert (or (= k0_sat "Host") (= k1_sat "Host") (= k2_sat "Host")))
(assert (or (= k0_sat "Content-Length") (= k1_sat "Content-Length") (= k2_sat "Content-Length")))
(assert (or (= k0_sat "User-Agent") (= k1_sat "User-Agent") (= k2_sat "User-Agent")))

; Bind corresponding values
(assert (=
  host_sat
  (ite (= k0_sat "Host") v0_sat (ite (= k1_sat "Host") v1_sat v2_sat))))
(assert (=
  content_length_str_sat
  (ite (= k0_sat "Content-Length") v0_sat (ite (= k1_sat "Content-Length") v1_sat v2_sat))))
(assert (=
  user_agent_sat
  (ite (= k0_sat "User-Agent") v0_sat (ite (= k1_sat "User-Agent") v1_sat v2_sat))))

; Value-side constraints: allow optional leading space, but forbid CR/LF
(assert (not (str.contains host_sat "\r")))
(assert (not (str.contains host_sat "\n")))
(assert (not (str.contains content_length_str_sat "\r")))
(assert (not (str.contains content_length_str_sat "\n")))
(assert (not (str.contains user_agent_sat "\r")))
(assert (not (str.contains user_agent_sat "\n")))

; Host should contain a dot and be non-empty
(assert (> (str.len host_sat) 0))
(assert (str.contains host_sat "."))

; Content-Length parsing and validation
(assert (= content_length_sat (str_to_int content_length_str_sat)))
(assert (>= content_length_sat 0))
(assert (= body_len_sat (str.len body_sat)))
(assert (= body_len_sat content_length_sat))

; For SAT instance, fix a concrete coherent request
(assert (= req_sat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "User-Agent: UA\r\n"
    "\r\n"
    "abcde")))

; Make str_to_int consistent for the used decimal string
(assert (= (str_to_int " 5") 5))
(assert (= (str_to_int "5") 5))
(assert (= (str_to_int content_length_str_sat) 5))

; ============================
; UNSAT instance: contradictory Content-Length vs body length
; ============================
(declare-const req_unsat String)
(declare-const header_block_unsat String)
(declare-const request_line_unsat String)
(declare-const h0_unsat String)
(declare-const h1_unsat String)
(declare-const h2_unsat String)
(declare-const k0_unsat String)
(declare-const v0_unsat String)
(declare-const k1_unsat String)
(declare-const v1_unsat String)
(declare-const k2_unsat String)
(declare-const v2_unsat String)
(declare-const content_length_str_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_unsat String)
(declare-const body_len_unsat Int)

(assert (= request_line_unsat (str.split_at req_unsat "\r\n" 0)))
(assert (= header_block_unsat (str.split_rest req_unsat "\r\n" 1)))
(assert (>= (str.num_splits req_unsat "\r\n") 4))
(assert (>= (str.num_splits header_block_unsat "\r\n\r\n") 2))
(assert (= body_unsat (str.split_at header_block_unsat "\r\n\r\n" 1)))

(assert (= h0_unsat (str.split_at req_unsat "\r\n" 1)))
(assert (= h1_unsat (str.split_at req_unsat "\r\n" 2)))
(assert (= h2_unsat (str.split_at req_unsat "\r\n" 3)))

(assert (>= (str.num_splits h0_unsat ":") 2))
(assert (>= (str.num_splits h1_unsat ":") 2))
(assert (>= (str.num_splits h2_unsat ":") 2))

(assert (= k0_unsat (str.split_at h0_unsat ":" 0)))
(assert (= v0_unsat (str.split_rest h0_unsat ":" 1)))
(assert (= k1_unsat (str.split_at h1_unsat ":" 0)))
(assert (= v1_unsat (str.split_rest h1_unsat ":" 1)))
(assert (= k2_unsat (str.split_at h2_unsat ":" 0)))
(assert (= v2_unsat (str.split_rest h2_unsat ":" 1)))

(assert (or (= k0_unsat "Content-Length") (= k1_unsat "Content-Length") (= k2_unsat "Content-Length")))
(assert (= content_length_str_unsat (ite (= k0_unsat "Content-Length") v0_unsat (ite (= k1_unsat "Content-Length") v1_unsat v2_unsat))))
(assert (= content_length_unsat (str_to_int content_length_str_unsat)))
(assert (= body_len_unsat (str.len body_unsat)))

; Fix a concrete request with body length 3 but claim Content-Length 4
(assert (= req_unsat
  (str.++
    "POST /x HTTP/1.1\r\n"
    "Host: a.b\r\n"
    "Content-Length: 4\r\n"
    "User-Agent: Z\r\n"
    "\r\n"
    "xyz")))

(assert (= (str_to_int "4") 4))
(assert (= (str_to_int " 4") 4))
(assert (= content_length_unsat 4))
(assert (= body_len_unsat 3))

; The intended validation that makes this UNSAT
(assert (= body_len_unsat content_length_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
