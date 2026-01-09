(set-logic ALL)

; Uninterpreted split interface (provided)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; SAT instance: well-formed HTTP header parsing
; -----------------------------
(declare-const req1 String)
(declare-const headers1 String)
(declare-const host_line1 String)
(declare-const cl_line1 String)
(declare-const host_key1 String)
(declare-const host_val1 String)
(declare-const cl_key1 String)
(declare-const cl_val1 String)
(declare-const cl_num1 Int)
(declare-const body1 String)
(declare-const empty_line1 String)

; request structure: headers + "\r\n\r\n" + body
(assert (= headers1 (split_at req1 "\r\n\r\n" 0)))
(assert (= body1 (split_at req1 "\r\n\r\n" 1)))
(assert (>= (num_splits req1 "\r\n\r\n") 2))

; header lines: at least Host and Content-Length
(assert (= host_line1 (split_at headers1 "\r\n" 0)))
(assert (= cl_line1 (split_at headers1 "\r\n" 1)))
(assert (>= (num_splits headers1 "\r\n") 2))

; parse "Key: Value" by colon+space delimiter
(assert (= host_key1 (split_at host_line1 ": " 0)))
(assert (= host_val1 (split_at host_line1 ": " 1)))
(assert (>= (num_splits host_line1 ": ") 2))

(assert (= cl_key1 (split_at cl_line1 ": " 0)))
(assert (= cl_val1 (split_at cl_line1 ": " 1)))
(assert (>= (num_splits cl_line1 ": ") 2))

; validate expected keys
(assert (= host_key1 "Host"))
(assert (= cl_key1 "Content-Length"))

; simple host value sanity
(assert (> (str.len host_val1) 0))
(assert (not (str.contains host_val1 "\r")))
(assert (not (str.contains host_val1 "\n")))

; content-length is numeric and matches body length
(assert (str.in_re cl_val1 (re.+ (re.range "0" "9"))))
(assert (= cl_num1 (str.to_int cl_val1)))
(assert (>= cl_num1 0))
(assert (= (str.len body1) cl_num1))

; ensure there is an empty line separating headers and body (captures the delimiter intent)
(assert (= empty_line1 (split_at req1 "\r\n\r\n" 0)))
(assert (= empty_line1 headers1))

; concrete witness to keep it decidable and clearly SAT
(assert (= host_val1 "example.com"))
(assert (= body1 "hello"))
(assert (= cl_val1 "5"))
(assert (= headers1 (str.++ host_line1 "\r\n" cl_line1)))
(assert (= host_line1 (str.++ "Host" ": " host_val1)))
(assert (= cl_line1 (str.++ "Content-Length" ": " cl_val1)))
(assert (= req1 (str.++ headers1 "\r\n\r\n" body1)))

; -----------------------------
; UNSAT instance: conflicting Content-Length
; -----------------------------
(declare-const req2 String)
(declare-const headers2 String)
(declare-const cl_line2 String)
(declare-const cl_val2 String)
(declare-const cl_num2 Int)
(declare-const body2 String)

(assert (= headers2 (split_at req2 "\r\n\r\n" 0)))
(assert (= body2 (split_at req2 "\r\n\r\n" 1)))
(assert (>= (num_splits req2 "\r\n\r\n") 2))

(assert (= cl_line2 (split_at headers2 "\r\n" 0)))
(assert (>= (num_splits headers2 "\r\n") 1))

(assert (= (split_at cl_line2 ": " 0) "Content-Length"))
(assert (= cl_val2 (split_at cl_line2 ": " 1)))
(assert (>= (num_splits cl_line2 ": ") 2))

(assert (str.in_re cl_val2 (re.+ (re.range "0" "9"))))
(assert (= cl_num2 (str.to_int cl_val2)))
(assert (>= cl_num2 0))

; Force a body and two different length constraints -> UNSAT
(assert (= body2 "abcd"))
(assert (= (str.len body2) 4))
(assert (= cl_val2 "5"))
(assert (= cl_num2 5))
(assert (= (str.len body2) cl_num2))

; Concrete construction for req2
(assert (= cl_line2 (str.++ "Content-Length" ": " cl_val2)))
(assert (= headers2 cl_line2))
(assert (= req2 (str.++ headers2 "\r\n\r\n" body2)))

(check-sat)


; [GENERATION STATUS: SUCCESS]