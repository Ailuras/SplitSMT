(set-logic ALL)

; Uninterpreted interface operations for split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =========================
; SAT instance: plausible HTTP header parsing
; =========================
(declare-const req String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const host_value_len Int)
(declare-const cl_value_len Int)
(declare-const content_length Int)
(declare-const body String)

; Split request into header block and body by CRLFCRLF
(assert (>= (num_splits req "\r\n\r\n") 2))
(assert (= header_block (split_at req "\r\n\r\n" 0)))
(assert (= body (split_rest req "\r\n\r\n" 1)))

; Header block split into lines by CRLF
(assert (>= (num_splits header_block "\r\n") 3))
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= cl_line (split_at header_block "\r\n" 2)))

; Request line basic structure (method SP path SP version)
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET "))

; Host line parsing by colon+space
(assert (>= (num_splits host_line ": ") 2))
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_value (split_rest host_line ": " 1)))
(assert (= host_key "Host"))

; Content-Length line parsing by colon+space
(assert (>= (num_splits cl_line ": ") 2))
(assert (= cl_key (split_at cl_line ": " 0)))
(assert (= cl_value (split_rest cl_line ": " 1)))
(assert (= cl_key "Content-Length"))

; Validate host value: non-empty and no CR/LF
(assert (= host_value_len (str.len host_value)))
(assert (> host_value_len 0))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; Validate Content-Length value: restrict to digits by excluding common non-digit markers
(assert (= cl_value_len (str.len cl_value)))
(assert (> cl_value_len 0))
(assert (not (str.contains cl_value "-")))
(assert (not (str.contains cl_value "+")))
(assert (not (str.contains cl_value " ")))
(assert (not (str.contains cl_value "\t")))
(assert (not (str.contains cl_value ",")))
(assert (not (str.contains cl_value ".")))

; Tie Content-Length integer to a concrete small value (models digit parsing without defining conversion)
(assert (= content_length 5))
(assert (= cl_value "5"))

; Enforce that body length matches Content-Length
(assert (= (str.len body) content_length))

; Ensure the overall request string is consistent with decomposition
(assert (= req (str.++ header_block "\r\n\r\n" body)))

; =========================
; UNSAT instance: contradictory content-length validation
; =========================
(declare-const req_bad String)
(declare-const header_block_bad String)
(declare-const body_bad String)
(declare-const cl_line_bad String)
(declare-const cl_value_bad String)
(declare-const content_length_bad Int)

(assert (>= (num_splits req_bad "\r\n\r\n") 2))
(assert (= header_block_bad (split_at req_bad "\r\n\r\n" 0)))
(assert (= body_bad (split_rest req_bad "\r\n\r\n" 1)))

; Assume Content-Length is the first header line after request line (index 1)
(assert (>= (num_splits header_block_bad "\r\n") 2))
(assert (= cl_line_bad (split_at header_block_bad "\r\n" 1)))
(assert (>= (num_splits cl_line_bad ": ") 2))
(assert (= cl_value_bad (split_rest cl_line_bad ": " 1)))

; Contradiction: declare length says 3 but body is constrained to length 4
(assert (= content_length_bad 3))
(assert (= cl_value_bad "3"))
(assert (= (str.len body_bad) 4))
(assert (= (str.len body_bad) content_length_bad))

(check-sat)


; [GENERATION STATUS: SUCCESS]