(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface operations for string splitting

; Basic string/integer helpers that are not primitive conversions in all solvers
(declare-fun to_int (String) Int)

; =====================
; SAT instance: well-formed HTTP header parsing
; =====================
(declare-const request_sat String)
(declare-const header_section_sat String)
(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; The request is headers + blank line + body
(assert (= header_section_sat (split_at request_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at request_sat "\r\n\r\n" 1)))
(assert (>= (num_splits request_sat "\r\n\r\n") 2))

; Split header section into lines
(assert (= header_line0_sat (split_at header_section_sat "\r\n" 0)))
(assert (= header_line1_sat (split_at header_section_sat "\r\n" 1)))
(assert (= header_line2_sat (split_at header_section_sat "\r\n" 2)))
(assert (>= (num_splits header_section_sat "\r\n") 3))

; Parse Host: header (key:value)
(assert (= host_key_sat (split_at header_line1_sat ":" 0)))
(assert (= host_val_sat (split_rest header_line1_sat ":" 1)))
(assert (>= (num_splits header_line1_sat ":") 2))
(assert (= host_key_sat "Host"))
; Common formatting: allow an optional leading space in the value
(assert (or (= host_val_sat "example.com") (= host_val_sat " example.com")))

; Parse Content-Length: header (key:value)
(assert (= cl_key_sat (split_at header_line2_sat ":" 0)))
(assert (= cl_val_sat (split_rest header_line2_sat ":" 1)))
(assert (>= (num_splits header_line2_sat ":") 2))
(assert (= cl_key_sat "Content-Length"))
(assert (or (= cl_val_sat "5") (= cl_val_sat " 5")))

; Request line sanity: "GET / HTTP/1.1"
(assert (= header_line0_sat "GET / HTTP/1.1"))

; Validate content-length against body length
(assert (= content_length_sat 5))
(assert (= (str.len body_sat) content_length_sat))

; Constrain the request concretely to ensure satisfiable witness exists
(assert (= request_sat "GET / HTTP/1.1\r\nHost: example.com\r\nContent-Length: 5\r\n\r\nabcde"))

; =====================
; UNSAT instance: contradictory content-length
; =====================
(declare-const request_unsat String)
(declare-const header_section_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

(assert (= header_section_unsat (split_at request_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at request_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits request_unsat "\r\n\r\n") 2))

; Assume Content-Length is on line 1 (after request line)
(assert (= cl_line_unsat (split_at header_section_unsat "\r\n" 1)))
(assert (>= (num_splits header_section_unsat "\r\n") 2))

(assert (= (split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))

; The value says 4, but the body is length 5 -> unsat under equality check
(assert (or (= cl_val_unsat "4") (= cl_val_unsat " 4")))
(assert (= content_length_unsat 4))
(assert (= (str.len body_unsat) content_length_unsat))

; Fix the concrete request so the contradiction is unavoidable
(assert (= request_unsat "POST /submit HTTP/1.1\r\nContent-Length: 4\r\n\r\nabcde"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
