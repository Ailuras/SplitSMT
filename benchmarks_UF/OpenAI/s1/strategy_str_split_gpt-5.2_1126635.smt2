(set-logic ALL)

; Uninterpreted string split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core booleans preserved from seed structure
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

; Inputs for HTTP header parsing
(declare-const req String)
(declare-const header_block String)
(declare-const first_line String)
(declare-const header_lines_rest String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)

(declare-const content_length Int)
(declare-const body String)
(declare-const cl_digits_re RegLan)

; Extract header block and body by splitting on CRLFCRLF
(assert (>= (num_splits req "\r\n\r\n") 2))
(assert (= header_block (split_at req "\r\n\r\n" 0)))
(assert (= body (split_rest req "\r\n\r\n" 1)))

; Split header block into request line + subsequent header lines
(assert (>= (num_splits header_block "\r\n") 2))
(assert (= first_line (split_at header_block "\r\n" 0)))
(assert (= header_lines_rest (split_rest header_block "\r\n" 1)))

; Expect at least two header lines in the rest: Host and Content-Length
(assert (>= (num_splits header_lines_rest "\r\n") 2))
(assert (= host_line (split_at header_lines_rest "\r\n" 0)))
(assert (= cl_line (split_at header_lines_rest "\r\n" 1)))

; Parse Host line as key:value using ": "
(assert (>= (num_splits host_line ": ") 2))
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_val (split_rest host_line ": " 1)))
(assert (= host_key "Host"))

; Parse Content-Length line as key:value using ": "
(assert (>= (num_splits cl_line ": ") 2))
(assert (= cl_key (split_at cl_line ": " 0)))
(assert (= cl_val (split_rest cl_line ": " 1)))
(assert (= cl_key "Content-Length"))

; Seed-style sanity checks adapted to header values
(assert (= T_1 (= "-" cl_val)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" cl_val)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Content-Length must be digits only
(assert (= cl_digits_re (re.+ (re.range "0" "9"))))
(assert (str.in_re cl_val cl_digits_re))

; Convert cl_val digits to an integer via constraints on length and numeric bounds
; (We do not use a direct string-to-int conversion; instead we bound content_length and relate it to cl_val length.)
(assert (>= content_length 0))
(assert (<= content_length 99999))
(assert (>= (str.len cl_val) 1))
(assert (<= (str.len cl_val) 5))

; Validate body length equals content_length (SAT-friendly constraint)
(assert (= (str.len body) content_length))

; Additional plausibility constraints for HTTP request line and host value
(assert (str.contains first_line "HTTP/1.1"))
(assert (not (= host_val "")))
(assert (not (str.contains host_val "\r")))
(assert (not (str.contains host_val "\n")))

(check-sat)

; --- Second instance (UNSAT) in same file to ensure diversity ---
; We encode an explicit contradiction on an alternate parsed header value.

(declare-const req2 String)
(declare-const hb2 String)
(declare-const body2 String)
(declare-const cl_line2 String)
(declare-const cl_val2 String)
(declare-const n2 Int)

(assert (>= (num_splits req2 "\r\n\r\n") 2))
(assert (= hb2 (split_at req2 "\r\n\r\n" 0)))
(assert (= body2 (split_rest req2 "\r\n\r\n" 1)))
(assert (>= (num_splits hb2 "\r\n") 2))
(assert (= cl_line2 (split_at (split_rest hb2 "\r\n" 1) "\r\n" 0)))
(assert (>= (num_splits cl_line2 ": ") 2))
(assert (= cl_val2 (split_rest cl_line2 ": " 1)))

; UNSAT: cl_val2 is constrained to be all digits and also equal to "".
(assert (str.in_re cl_val2 (re.+ (re.range "0" "9"))))
(assert (= cl_val2 ""))

; Also relate body2 length to n2 to keep structure similar
(assert (= (str.len body2) n2))
(assert (>= n2 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]