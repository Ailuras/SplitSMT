(set-logic ALL)

; Uninterpreted split interface (string split via relaxation)

; Additional uninterpreted helper operations (non-primitive)
(declare-fun trim (String) String)
(declare-fun to_int (String) Int)
(declare-fun lower (String) String)
(declare-fun find_header_value (String String) String)

; ============================
; SAT instance: well-formed header parsing with consistent Content-Length
; ============================
(declare-const request1 String)
(declare-const headers1 String)
(declare-const body1 String)
(declare-const cl_line1 String)
(declare-const cl_key1 String)
(declare-const cl_val_raw1 String)
(declare-const cl_val1 String)
(declare-const content_length1 Int)
(declare-const host_line1 String)
(declare-const host_key1 String)
(declare-const host_val_raw1 String)
(declare-const host_val1 String)
(declare-const host1 String)

; request = headers + "\r\n\r\n" + body
(assert (= headers1 (str.split_at request1 "\r\n\r\n" 0)))
(assert (= body1 (str.split_rest request1 "\r\n\r\n" 1)))
(assert (>= (str.num_splits request1 "\r\n\r\n") 2))

; Headers are CRLF-separated lines, include Host and Content-Length lines
(assert (>= (str.num_splits headers1 "\r\n") 2))

; Content-Length line parsing: key ":" value
(assert (= cl_line1 (find_header_value headers1 "Content-Length")))
(assert (= cl_key1 (str.split_at cl_line1 ":" 0)))
(assert (= cl_val_raw1 (str.split_rest cl_line1 ":" 1)))
(assert (= cl_val1 (trim cl_val_raw1)))
(assert (= (lower (trim cl_key1)) (lower "Content-Length")))

; Host line parsing
(assert (= host_line1 (find_header_value headers1 "Host")))
(assert (= host_key1 (str.split_at host_line1 ":" 0)))
(assert (= host_val_raw1 (str.split_rest host_line1 ":" 1)))
(assert (= host_val1 (trim host_val_raw1)))
(assert (= (lower (trim host_key1)) (lower "Host")))
(assert (= host1 host_val1))

; Basic sanity constraints on extracted values
(assert (>= (str.len host1) 1))
(assert (not (str.contains host1 "\r")))
(assert (not (str.contains host1 "\n")))
(assert (not (str.contains host1 ":")))

; Content-Length is a non-negative integer and must equal body length
(assert (= content_length1 (to_int cl_val1)))
(assert (>= content_length1 0))
(assert (= content_length1 (str.len body1)))

; Ensure the body does not contain CRLFCRLF (to avoid ambiguity in this simplified model)
(assert (not (str.contains body1 "\r\n\r\n")))

; Concretize request1 with a plausible HTTP request
(assert (= request1
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "abcde")))

; ============================
; UNSAT instance: inconsistent Content-Length vs body length
; ============================
(declare-const request2 String)
(declare-const headers2 String)
(declare-const body2 String)
(declare-const cl_line2 String)
(declare-const cl_key2 String)
(declare-const cl_val_raw2 String)
(declare-const cl_val2 String)
(declare-const content_length2 Int)

(assert (= headers2 (str.split_at request2 "\r\n\r\n" 0)))
(assert (= body2 (str.split_rest request2 "\r\n\r\n" 1)))
(assert (>= (str.num_splits request2 "\r\n\r\n") 2))

(assert (= cl_line2 (find_header_value headers2 "Content-Length")))
(assert (= cl_key2 (str.split_at cl_line2 ":" 0)))
(assert (= cl_val_raw2 (str.split_rest cl_line2 ":" 1)))
(assert (= cl_val2 (trim cl_val_raw2)))
(assert (= (lower (trim cl_key2)) (lower "Content-Length")))

(assert (= content_length2 (to_int cl_val2)))
(assert (>= content_length2 0))
(assert (= content_length2 (str.len body2)))

; Concrete request2 where declared Content-Length is 3 but body has length 4 => UNSAT (given the length constraint)
(assert (= request2
  (str.++
    "POST /x HTTP/1.1\r\n"
    "Content-Length: 3\r\n"
    "\r\n"
    "WXYZ")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
