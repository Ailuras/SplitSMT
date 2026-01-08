(set-logic ALL)

; Uninterpreted interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; SAT instance: plausible HTTP header parsing
; -----------------------------
(declare-const req String)
(declare-const headers String)
(declare-const body String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const user_agent_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)
(declare-const method String)
(declare-const path String)
(declare-const version String)
(declare-const content_length Int)

; Request structure: request-line + CRLF + headers + CRLF CRLF + body
(assert (= request_line (split_at req "\r\n" 0)))
(assert (= headers (split_at req "\r\n\r\n" 0)))
(assert (= body (split_at req "\r\n\r\n" 1)))
(assert (>= (num_splits req "\r\n\r\n") 2))

; Parse request line: "METHOD SP PATH SP HTTP/V"
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (= version "HTTP/1.1"))
(assert (or (= method "GET") (= method "POST")))
(assert (>= (str.len path) 1))
(assert (= (str.at path 0) "/"))

; Headers must contain at least 3 lines: request-line + 2 header lines
(assert (>= (num_splits headers "\r\n") 3))

; Choose concrete positions for key headers
(assert (= host_line (split_at headers "\r\n" 1)))
(assert (= cl_line (split_at headers "\r\n" 2)))
(assert (= user_agent_line (split_at headers "\r\n" 3)))

; Host header parsing: "Host: <value>"
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (>= (num_splits host_line ":") 2))
(assert (>= (str.len host_value) 1))

; Content-Length header parsing: "Content-Length: <digits>"
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))
(assert (>= (num_splits cl_line ":") 2))

; UA header parsing: "User-Agent: <value>"
(assert (= ua_key (split_at user_agent_line ":" 0)))
(assert (= ua_value (split_rest user_agent_line ":" 1)))
(assert (= ua_key "User-Agent"))
(assert (>= (num_splits user_agent_line ":") 2))

; Content-Length validation: model cl_value as a fixed digit string, and align with body length
; (Since no string-to-int conversion is provided in SLIA here, we encode a consistent scenario.)
(assert (= cl_value " 5"))
(assert (= content_length 5))
(assert (= (str.len body) content_length))

; Ensure headers/body do not accidentally include header terminator inside body prefix
(assert (not (str.contains body "\r\n\r\n")))

; -----------------------------
; UNSAT instance: contradictory Content-Length constraints
; -----------------------------
(declare-const req_bad String)
(declare-const headers_bad String)
(declare-const body_bad String)
(declare-const cl_line_bad String)
(declare-const cl_key_bad String)
(declare-const cl_value_bad String)
(declare-const content_length_bad Int)

(assert (= headers_bad (split_at req_bad "\r\n\r\n" 0)))
(assert (= body_bad (split_at req_bad "\r\n\r\n" 1)))
(assert (>= (num_splits req_bad "\r\n\r\n") 2))

; Put Content-Length on line 1 after request line
(assert (>= (num_splits headers_bad "\r\n") 2))
(assert (= cl_line_bad (split_at headers_bad "\r\n" 1)))
(assert (= cl_key_bad (split_at cl_line_bad ":" 0)))
(assert (= cl_value_bad (split_rest cl_line_bad ":" 1)))
(assert (= cl_key_bad "Content-Length"))
(assert (>= (num_splits cl_line_bad ":") 2))

; Contradiction: cl_value_bad fixed to " 0" but length constraint forces nonzero
(assert (= cl_value_bad " 0"))
(assert (= content_length_bad 0))
(assert (= (str.len body_bad) content_length_bad))
(assert (> (str.len body_bad) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]