(set-logic ALL)

; Uninterpreted string-splitting interface (by specification)

; ----------- SAT instance: well-formed HTTP header parsing -----------
(declare-const request_sat String)
(declare-const headers_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_len_sat Int)
(declare-const body_sat String)

; Build a concrete request to avoid under-constrained uninterpreted split behavior
(assert (= request_sat (str.++ "POST /upload HTTP/1.1\r\n" "Host: example.com\r\n" "Content-Length: 5\r\n" "\r\n" "abcde")))

; Separate headers and body (split at CRLFCRLF)
(assert (= headers_sat (str.split_at request_sat "\r\n\r\n" 0)))
(assert (= body_sat (str.split_at request_sat "\r\n\r\n" 1)))
(assert (>= (str.num_splits request_sat "\r\n\r\n") 2))

; Split header block into lines by CRLF
(assert (= line0_sat (str.split_at headers_sat "\r\n" 0)))
(assert (= line1_sat (str.split_at headers_sat "\r\n" 1)))
(assert (= line2_sat (str.split_at headers_sat "\r\n" 2)))
(assert (>= (str.num_splits headers_sat "\r\n") 3))

; Request line constraint
(assert (= line0_sat "POST /upload HTTP/1.1"))

; Parse Host line as key/value by ": "
(assert (= host_key_sat (str.split_at line1_sat ": " 0)))
(assert (= host_val_sat (str.split_at line1_sat ": " 1)))
(assert (>= (str.num_splits line1_sat ": ") 2))
(assert (= line1_sat "Host: example.com"))
(assert (= host_key_sat "Host"))
(assert (= host_val_sat "example.com"))

; Parse Content-Length line as key/value by ": "
(assert (= cl_key_sat (str.split_at line2_sat ": " 0)))
(assert (= cl_val_sat (str.split_at line2_sat ": " 1)))
(assert (>= (str.num_splits line2_sat ": ") 2))
(assert (= line2_sat "Content-Length: 5"))
(assert (= cl_key_sat "Content-Length"))
(assert (= cl_val_sat "5"))

; Validate Content-Length is numeric and matches body length
(assert (str.in_re cl_val_sat (re.+ (re.range "0" "9"))))
(assert (= cl_len_sat (str.to_int cl_val_sat)))
(assert (>= cl_len_sat 0))
(assert (= cl_len_sat (str.len body_sat)))

; Additional sanity checks on header formatting
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))
(assert (not (str.contains cl_val_sat "\r")))
(assert (not (str.contains cl_val_sat "\n")))
(assert (= (str.len body_sat) 5))

; ----------- UNSAT instance: inconsistent Content-Length -----------
(declare-const request_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_len_unsat Int)

(assert (= request_unsat (str.++ "POST /x HTTP/1.1\r\n" "Content-Length: 4\r\n" "\r\n" "abcde")))
(assert (= headers_unsat (str.split_at request_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (str.split_at request_unsat "\r\n\r\n" 1)))
(assert (>= (str.num_splits request_unsat "\r\n\r\n") 2))

; Extract the Content-Length line (line 1 of headers: line0 is request line)
(assert (= cl_line_unsat (str.split_at headers_unsat "\r\n" 1)))
(assert (>= (str.num_splits headers_unsat "\r\n") 2))

(assert (= cl_val_unsat (str.split_at cl_line_unsat ": " 1)))
(assert (>= (str.num_splits cl_line_unsat ": ") 2))
(assert (= cl_line_unsat "Content-Length: 4"))

(assert (str.in_re cl_val_unsat (re.+ (re.range "0" "9"))))
(assert (= cl_len_unsat (str.to_int cl_val_unsat)))
(assert (>= cl_len_unsat 0))

; Contradiction: declared length 4 but actual body length 5
(assert (= cl_len_unsat (str.len body_unsat)))
(assert (= (str.len body_unsat) 5))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
