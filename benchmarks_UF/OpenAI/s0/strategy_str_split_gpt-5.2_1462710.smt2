(set-logic ALL)

; Uninterpreted interface for split operations (str_split)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Additional helper uninterpreted functions for HTTP header parsing
(declare-fun header_value (String String) String) ; (headers, key) -> value
(declare-fun is_decimal (String) Bool)
(declare-fun to_int (String) Int)

; =========================
; SAT instance: well-formed HTTP headers with consistent Content-Length
; =========================
(declare-const req_headers String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const ua_value String)
(declare-const body String)
(declare-const content_length Int)

; Header block split into lines by CRLF
(assert (= host_line (split_at req_headers "\r\n" 0)))
(assert (= cl_line   (split_at req_headers "\r\n" 1)))
(assert (= ua_line   (split_at req_headers "\r\n" 2)))
(assert (>= (num_splits req_headers "\r\n") 3))

; Each line is a key-value pair split by ": "
(assert (= "Host" (split_at host_line ": " 0)))
(assert (= host_value (split_at host_line ": " 1)))
(assert (>= (num_splits host_line ": ") 2))

(assert (= "Content-Length" (split_at cl_line ": " 0)))
(assert (= cl_value (split_at cl_line ": " 1)))
(assert (>= (num_splits cl_line ": ") 2))

(assert (= "User-Agent" (split_at ua_line ": " 0)))
(assert (= ua_value (split_at ua_line ": " 1)))
(assert (>= (num_splits ua_line ": ") 2))

; Basic content constraints
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))
(assert (> (str.len host_value) 0))

(assert (not (str.contains ua_value "\r")))
(assert (not (str.contains ua_value "\n")))
(assert (> (str.len ua_value) 0))

; Content-Length must be decimal and match body length
(assert (is_decimal cl_value))
(assert (= content_length (to_int cl_value)))
(assert (>= content_length 0))
(assert (= content_length (str.len body)))

; Also relate via abstract header_value interface (consistency)
(assert (= host_value (header_value req_headers "Host")))
(assert (= cl_value   (header_value req_headers "Content-Length")))
(assert (= ua_value   (header_value req_headers "User-Agent")))

; A concrete satisfiable shape for the header block
(assert (= req_headers (str.++ "Host: " host_value "\r\n" "Content-Length: " cl_value "\r\n" "User-Agent: " ua_value "\r\n")))

; =========================
; UNSAT instance: contradictory Content-Length vs body length
; =========================
(declare-const bad_headers String)
(declare-const bad_body String)
(declare-const bad_cl_value String)
(declare-const bad_len Int)

; Force some structure similar to HTTP headers
(assert (>= (num_splits bad_headers "\r\n") 2))
(assert (= "Content-Length" (split_at (split_at bad_headers "\r\n" 0) ": " 0)))
(assert (= bad_cl_value (split_at (split_at bad_headers "\r\n" 0) ": " 1)))
(assert (is_decimal bad_cl_value))
(assert (= bad_len (to_int bad_cl_value)))
(assert (>= bad_len 0))

; Contradiction: require bad_len equals and not equals body length
(assert (= bad_len (str.len bad_body)))
(assert (not (= bad_len (str.len bad_body))))

(check-sat)


; [GENERATION STATUS: SUCCESS]