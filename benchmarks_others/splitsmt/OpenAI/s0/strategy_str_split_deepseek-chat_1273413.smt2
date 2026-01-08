(set-logic ALL)

; Uninterpreted interface functions for string split

; Additional helpers as uninterpreted functions (non-primitive interface operations)
(declare-fun to_int (String) Int)
(declare-fun trim (String) String)
(declare-fun lower (String) String)

; -------------------------------
; SAT instance: well-formed HTTP header parsing constraints
; -------------------------------
(declare-const request_sat String)
(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)
(declare-const header_line3_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const content_length_sat Int)
(declare-const body_sat String)

; Split request into lines by \n
(assert (>= (str.num_splits request_sat "\n") 5))
(assert (= header_line0_sat (str.split_at request_sat "\n" 0)))
(assert (= header_line1_sat (str.split_at request_sat "\n" 1)))
(assert (= header_line2_sat (str.split_at request_sat "\n" 2)))
(assert (= header_line3_sat (str.split_at request_sat "\n" 3)))

; Force a simple request line and required headers
(assert (= header_line0_sat "POST /upload HTTP/1.1"))

; Parse Host header line: "Host: example.com"
(assert (= (lower (trim (str.split_at header_line1_sat ":" 0))) "host"))
(assert (>= (str.num_splits header_line1_sat ":") 2))
(assert (= host_key_sat (trim (str.split_at header_line1_sat ":" 0))))
(assert (= host_val_sat (trim (str.split_rest header_line1_sat ":" 1))))
(assert (= host_val_sat "example.com"))

; Parse Content-Length header line: "Content-Length: <digits>"
(assert (= (lower (trim (str.split_at header_line2_sat ":" 0))) "content-length"))
(assert (>= (str.num_splits header_line2_sat ":") 2))
(assert (= cl_key_sat (trim (str.split_at header_line2_sat ":" 0))))
(assert (= cl_val_sat (trim (str.split_rest header_line2_sat ":" 1))))

; Enforce cl_val_sat is digits via regex, then interpret as int
(assert (str.in_re cl_val_sat (re.+ (re.range "0" "9"))))
(assert (= content_length_sat (to_int cl_val_sat)))
(assert (>= content_length_sat 0))

; Header terminator: require a blank line somewhere after header_line3_sat
; We model that header_line3_sat is empty, and body is remainder after it.
(assert (= header_line3_sat ""))
(assert (= body_sat (str.split_rest request_sat "\n" 4)))

; Validate body length equals Content-Length
(assert (= (str.len body_sat) content_length_sat))

; Construct a concrete satisfiable request
(assert (= request_sat
  (str.++
    "POST /upload HTTP/1.1" "\n"
    "Host: example.com" "\n"
    "Content-Length: 4" "\n"
    "" "\n"
    "DATA")))


; -------------------------------
; UNSAT instance: conflicting Content-Length vs body size
; -------------------------------
(declare-const request_unsat String)
(declare-const u_line0 String)
(declare-const u_line1 String)
(declare-const u_line2 String)
(declare-const u_line3 String)
(declare-const u_cl_val String)
(declare-const u_content_length Int)
(declare-const u_body String)

(assert (>= (str.num_splits request_unsat "\n") 5))
(assert (= u_line0 (str.split_at request_unsat "\n" 0)))
(assert (= u_line1 (str.split_at request_unsat "\n" 1)))
(assert (= u_line2 (str.split_at request_unsat "\n" 2)))
(assert (= u_line3 (str.split_at request_unsat "\n" 3)))

(assert (= u_line0 "POST /submit HTTP/1.1"))

; Content-Length line at u_line2
(assert (= (lower (trim (str.split_at u_line2 ":" 0))) "content-length"))
(assert (>= (str.num_splits u_line2 ":") 2))
(assert (= u_cl_val (trim (str.split_rest u_line2 ":" 1))))
(assert (str.in_re u_cl_val (re.+ (re.range "0" "9"))))
(assert (= u_content_length (to_int u_cl_val)))
(assert (>= u_content_length 0))

; Terminate headers and define body
(assert (= u_line3 ""))
(assert (= u_body (str.split_rest request_unsat "\n" 4)))

; Conflict: set Content-Length to 10 but body is 3 bytes
(assert (= request_unsat
  (str.++
    "POST /submit HTTP/1.1" "\n"
    "Host: example.org" "\n"
    "Content-Length: 10" "\n"
    "" "\n"
    "abc")))

(assert (= (str.len u_body) u_content_length))


(check-sat)


; [GENERATION STATUS: SUCCESS]
