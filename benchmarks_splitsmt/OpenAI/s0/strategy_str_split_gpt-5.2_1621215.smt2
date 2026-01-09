(set-logic ALL)

; Uninterpreted functions for string split interface

; ========= SAT instance: well-formed HTTP header parsing =========
(declare-const req1 String)
(declare-const headers1 String)
(declare-const line_host String)
(declare-const line_cl String)
(declare-const line_ua String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const body1 String)
(declare-const content_length1 Int)

; Construct a concrete request with three header lines and a body
(assert (= line_host "Host: example.com"))
(assert (= line_cl "Content-Length: 5"))
(assert (= line_ua "User-Agent: curl/8.0"))
(assert (= headers1 (str.++ line_host "\r\n" line_cl "\r\n" line_ua "\r\n" "\r\n")))
(assert (= body1 "HELLO"))
(assert (= req1 (str.++ "GET / HTTP/1.1\r\n" headers1 body1)))

; Split header block into lines using CRLF
(assert (>= (str.num_splits headers1 "\r\n") 5))
(assert (= (str.split_at headers1 "\r\n" 0) line_host))
(assert (= (str.split_at headers1 "\r\n" 1) line_cl))
(assert (= (str.split_at headers1 "\r\n" 2) line_ua))

; Parse key/value pairs using ": "
(assert (>= (str.num_splits line_host ": ") 2))
(assert (= host_key (str.split_at line_host ": " 0)))
(assert (= host_val (str.split_at line_host ": " 1)))
(assert (= host_key "Host"))
(assert (= host_val "example.com"))

(assert (>= (str.num_splits line_cl ": ") 2))
(assert (= cl_key (str.split_at line_cl ": " 0)))
(assert (= cl_val (str.split_at line_cl ": " 1)))
(assert (= cl_key "Content-Length"))
(assert (= cl_val "5"))

(assert (>= (str.num_splits line_ua ": ") 2))
(assert (= ua_key (str.split_at line_ua ": " 0)))
(assert (= ua_val (str.split_at line_ua ": " 1)))
(assert (= ua_key "User-Agent"))
(assert (= ua_val "curl/8.0"))

; Validate Content-Length against actual body length
(assert (= content_length1 5))
(assert (= (str.len body1) content_length1))

; Additional sanity: ensure no stray colon in keys (approximate via split count)
(assert (= (str.num_splits host_key ":") 1))
(assert (= (str.num_splits cl_key ":") 1))
(assert (= (str.num_splits ua_key ":") 1))

; ========= UNSAT instance: inconsistent Content-Length =========
(declare-const req2 String)
(declare-const headers2 String)
(declare-const line2_cl String)
(declare-const body2 String)
(declare-const cl2_key String)
(declare-const cl2_val String)
(declare-const content_length2 Int)

; A second request fragment where Content-Length claims 4 but body is length 5
(assert (= line2_cl "Content-Length: 4"))
(assert (= headers2 (str.++ line2_cl "\r\n" "\r\n")))
(assert (= body2 "ABCDE"))
(assert (= req2 (str.++ "POST /submit HTTP/1.1\r\n" headers2 body2)))

(assert (>= (str.num_splits headers2 "\r\n") 3))
(assert (= (str.split_at headers2 "\r\n" 0) line2_cl))
(assert (>= (str.num_splits line2_cl ": ") 2))
(assert (= cl2_key (str.split_at line2_cl ": " 0)))
(assert (= cl2_val (str.split_at line2_cl ": " 1)))
(assert (= cl2_key "Content-Length"))
(assert (= cl2_val "4"))

(assert (= content_length2 4))
(assert (= (str.len body2) content_length2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
