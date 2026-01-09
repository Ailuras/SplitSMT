(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Common HTTP request header material
(declare-const req String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const method String)
(declare-const uri String)
(declare-const httpver String)

(declare-const host_line String)
(declare-const content_length_line String)
(declare-const user_agent_line String)
(declare-const xtrace_line String)

(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)
(declare-const xtrace_key String)
(declare-const xtrace_value String)

(declare-const body String)

(declare-const content_length Int)
(declare-const body_len Int)

; Another independent request instance to force an UNSAT branch under a condition
(declare-const req_bad String)
(declare-const header_block_bad String)
(declare-const content_length_line_bad String)
(declare-const cl_key_bad String)
(declare-const cl_value_bad String)
(declare-const content_length_bad Int)
(declare-const body_bad String)
(declare-const body_len_bad Int)

; -----------------------------
; SAT instance: well-formed request, parse headers and validate Content-Length
; -----------------------------

; Request decomposes into header block and body at CRLFCRLF
(assert (= header_block (split_at req "\r\n\r\n" 0)))
(assert (= body (split_at req "\r\n\r\n" 1)))
(assert (>= (num_splits req "\r\n\r\n") 2))

; Header block decomposes into request line and subsequent header lines
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= user_agent_line (split_at header_block "\r\n" 2)))
(assert (= content_length_line (split_at header_block "\r\n" 3)))
(assert (= xtrace_line (split_at header_block "\r\n" 4)))
(assert (>= (num_splits header_block "\r\n") 5))

; Concrete request line for stability
(assert (= request_line "POST /submit HTTP/1.1"))
(assert (= method (split_at request_line " " 0)))
(assert (= uri (split_at request_line " " 1)))
(assert (= httpver (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))
(assert (= method "POST"))
(assert (= uri "/submit"))
(assert (= httpver "HTTP/1.1"))

; Parse Host header key/value by ": "
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_value (split_at host_line ": " 1)))
(assert (>= (num_splits host_line ": ") 2))
(assert (= host_key "Host"))
(assert (= host_value "example.com"))
(assert (= host_line (str.++ host_key ": " host_value)))

; Parse User-Agent header
(assert (= ua_key (split_at user_agent_line ": " 0)))
(assert (= ua_value (split_at user_agent_line ": " 1)))
(assert (>= (num_splits user_agent_line ": ") 2))
(assert (= ua_key "User-Agent"))
(assert (= ua_value "curl/8.0"))
(assert (= user_agent_line (str.++ ua_key ": " ua_value)))

; Parse Content-Length header
(assert (= cl_key (split_at content_length_line ": " 0)))
(assert (= cl_value (split_at content_length_line ": " 1)))
(assert (>= (num_splits content_length_line ": ") 2))
(assert (= cl_key "Content-Length"))
(assert (= cl_value "5"))
(assert (= content_length_line (str.++ cl_key ": " cl_value)))

; Parse X-Trace header and require it contains hyphen
(assert (= xtrace_key (split_at xtrace_line ": " 0)))
(assert (= xtrace_value (split_at xtrace_line ": " 1)))
(assert (>= (num_splits xtrace_line ": ") 2))
(assert (= xtrace_key "X-Trace"))
(assert (str.contains xtrace_value "-"))
(assert (= xtrace_line (str.++ xtrace_key ": " xtrace_value)))

; Content-Length validation: connect numeric length with body length
(assert (= content_length 5))
(assert (= body "hello"))
(assert (= body_len (str.len body)))
(assert (= content_length body_len))
(assert (>= content_length 0))

; Ensure header block is consistent with composed lines
(assert (= header_block
  (str.++ request_line "\r\n" host_line "\r\n" user_agent_line "\r\n" content_length_line "\r\n" xtrace_line)))

; -----------------------------
; UNSAT instance: same parsing idea, but contradictory Content-Length constraints
; Kept independent from SAT instance variables.
; -----------------------------

(assert (= header_block_bad (split_at req_bad "\r\n\r\n" 0)))
(assert (= body_bad (split_at req_bad "\r\n\r\n" 1)))
(assert (>= (num_splits req_bad "\r\n\r\n") 2))

(assert (= content_length_line_bad (split_at header_block_bad "\r\n" 1)))
(assert (>= (num_splits header_block_bad "\r\n") 2))

(assert (= cl_key_bad (split_at content_length_line_bad ": " 0)))
(assert (= cl_value_bad (split_at content_length_line_bad ": " 1)))
(assert (>= (num_splits content_length_line_bad ": ") 2))
(assert (= cl_key_bad "Content-Length"))

; Fix body and force mismatch in two different ways
(assert (= body_bad "abc"))
(assert (= body_len_bad (str.len body_bad)))
(assert (= content_length_bad 4))
(assert (= content_length_bad body_len_bad))

; Additionally force the textual value to claim a different length
(assert (= cl_value_bad "4"))
(assert (= content_length_line_bad (str.++ cl_key_bad ": " cl_value_bad)))

(check-sat)


; [GENERATION STATUS: SUCCESS]