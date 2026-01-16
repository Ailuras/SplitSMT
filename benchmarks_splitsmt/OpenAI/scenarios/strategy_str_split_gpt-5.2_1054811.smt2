(set-logic ALL)

; Uninterpreted string-split interface

; -------------------------------
; SAT instance: consistent HTTP header parsing
; -------------------------------
(declare-const request_sat String)
(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)
(declare-const key0_sat String)
(declare-const val0_sat String)
(declare-const key1_sat String)
(declare-const val1_sat String)
(declare-const key2_sat String)
(declare-const val2_sat String)
(declare-const host_sat String)
(declare-const content_length_str_sat String)
(declare-const body_sat String)
(declare-const body_len_sat Int)
(declare-const content_length_sat Int)

; Concrete request with three header lines, empty line, then body.
(assert (= request_sat
  (str.++
    "GET /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "X-Trace: abc123\r\n"
    "\r\n"
    "HELLO")))

; Split by CRLF into lines: request line, 3 headers, empty line, then (maybe) rest
(assert (>= (str.num_splits request_sat "\r\n") 5))
(assert (= header_line0_sat (str.split_at request_sat "\r\n" 1)))
(assert (= header_line1_sat (str.split_at request_sat "\r\n" 2)))
(assert (= header_line2_sat (str.split_at request_sat "\r\n" 3)))
(assert (= "" (str.split_at request_sat "\r\n" 4)))

; Ensure each header line has at least one ':'
(assert (>= (str.num_splits header_line0_sat ":") 2))
(assert (>= (str.num_splits header_line1_sat ":") 2))
(assert (>= (str.num_splits header_line2_sat ":") 2))

; Extract keys and values using ':' delimiter
(assert (= key0_sat (str.split_at header_line0_sat ":" 0)))
(assert (= val0_sat (str.split_rest header_line0_sat ":" 1)))
(assert (= key1_sat (str.split_at header_line1_sat ":" 0)))
(assert (= val1_sat (str.split_rest header_line1_sat ":" 1)))
(assert (= key2_sat (str.split_at header_line2_sat ":" 0)))
(assert (= val2_sat (str.split_rest header_line2_sat ":" 1)))

; Validate header keys match expected
(assert (= key0_sat "Host"))
(assert (= key1_sat "Content-Length"))
(assert (= key2_sat "X-Trace"))

; Typical HTTP formatting has a space after ':'
(assert (str.prefixof " " val0_sat))
(assert (str.prefixof " " val1_sat))
(assert (str.prefixof " " val2_sat))

; Extract Host value and Content-Length string (including leading space)
(assert (= host_sat (str.substr val0_sat 1 (- (str.len val0_sat) 1))))
(assert (= content_length_str_sat (str.substr val1_sat 1 (- (str.len val1_sat) 1))))

; Host must be non-empty and contain a dot
(assert (> (str.len host_sat) 0))
(assert (str.contains host_sat "."))

; Content-Length must be digits only and parseable
(assert (str.in_re content_length_str_sat (re.+ (re.range "0" "9"))))
(assert (= content_length_sat (str.to_int content_length_str_sat)))
(assert (>= content_length_sat 0))

; Body is after the empty line; using split_rest from index 5 (after 0..4 segments)
(assert (= body_sat (str.split_rest request_sat "\r\n" 5)))
(assert (= body_len_sat (str.len body_sat)))

; Validate content-length equals body length
(assert (= content_length_sat body_len_sat))

; Additional consistency constraints for the SAT instance
(assert (= body_sat "HELLO"))
(assert (str.contains val2_sat "abc"))

; -------------------------------
; UNSAT instance: inconsistent Content-Length vs body size
; -------------------------------
(declare-const request_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_digits_unsat String)
(declare-const body_unsat String)
(declare-const cl_int_unsat Int)
(declare-const body_len_unsat Int)

(assert (= request_unsat
  (str.++
    "POST /data HTTP/1.1\r\n"
    "Content-Length: 10\r\n"
    "\r\n"
    "HELLO")))

(assert (>= (str.num_splits request_unsat "\r\n") 3))
(assert (= cl_line_unsat (str.split_at request_unsat "\r\n" 1)))
(assert (>= (str.num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (str.split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (str.split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (str.prefixof " " cl_val_unsat))
(assert (= cl_digits_unsat (str.substr cl_val_unsat 1 (- (str.len cl_val_unsat) 1))))
(assert (str.in_re cl_digits_unsat (re.+ (re.range "0" "9"))))
(assert (= cl_int_unsat (str.to_int cl_digits_unsat)))
(assert (>= cl_int_unsat 0))

(assert (= body_unsat (str.split_rest request_unsat "\r\n" 3)))
(assert (= body_len_unsat (str.len body_unsat)))

; Force mismatch: content-length 10 but body is "HELLO" length 5
(assert (= body_unsat "HELLO"))
(assert (= cl_int_unsat body_len_unsat))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
