(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-derived booleans (kept core structure: T_1, T_2, input string, and contradiction)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-const var_0xINPUT_10301 String)

; HTTP header parsing variables
(declare-const request String)
(declare-const headers String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const body String)
(declare-const cl_num Int)

; Relate request to the seed input
(assert (= request var_0xINPUT_10301))

; Basic split structure: request_line + headers/body via CRLF
(assert (= request_line (split_at request "\r\n" 0)))
(assert (= headers (split_rest request "\r\n" 1)))

; Minimum structure: at least request line and one more segment
(assert (>= (num_splits request "\r\n") 2))

; Extract two header lines after request line
(assert (= host_line (split_at request "\r\n" 1)))
(assert (= cl_line (split_at request "\r\n" 2)))

; Ensure header lines contain ':' and have key/value parts
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))

(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (split_rest host_line ":" 1)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_val (split_rest cl_line ":" 1)))

; Expected keys and basic formatting
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (str.prefixof " " host_val))
(assert (str.prefixof " " cl_val))

; Body is everything after the blank line CRLFCRLF
(assert (= body (split_rest request "\r\n\r\n" 1)))
(assert (>= (num_splits request "\r\n\r\n") 2))

; Content-length sanity constraints (abstract integer, but tied to length)
(assert (>= cl_num 0))
(assert (= cl_num (str.len body)))

; Seed core structure preserved: T_1 indicates non-empty input
(assert (= T_1 (not (= "" var_0xINPUT_10301))))

; Additional semantic requirement: request should look like HTTP request line
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET "))

; Force a contradiction like the seed (UNSAT instance)
(assert (= T_2 (not T_1)))
(assert T_2)
(assert T_1)

(check-sat)


; [GENERATION STATUS: SUCCESS]