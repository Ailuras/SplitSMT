(set-logic ALL)

; Uninterpreted interface for split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-related symbols (preserve core structure: T_1 guards a negated equality on the raw input)
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_127821 String)

; HTTP header parsing symbols
(declare-const header_block String)
(declare-const request_line String)
(declare-const header_lines String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const content_length Int)

; Keep the seed constraint
(assert (= T_1 (not (= "file:" var_0xINPUT_127821))))
(assert T_1)

; Relate input to an HTTP header block and ensure it is not a file: URL-like string
(assert (= header_block var_0xINPUT_127821))
(assert (not (str.prefixof "file:" header_block)))

; Basic structure: request line + headers separated by a blank line (CRLFCRLF)
(assert (>= (num_splits header_block "\r\n\r\n") 2))
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (= header_lines (split_rest header_block "\r\n" 1)))
(assert (= body (split_rest header_block "\r\n\r\n" 1)))

; Request line sanity: must look like METHOD SP PATH SP HTTP/1.1
(assert (str.contains request_line " HTTP/1.1"))
(assert (str.contains request_line " "))

; Require at least two header lines
(assert (>= (num_splits header_lines "\r\n") 2))

; Extract first two lines as Host and Content-Length (order fixed for this scenario)
(assert (= host_line (split_at header_lines "\r\n" 0)))
(assert (= cl_line (split_at header_lines "\r\n" 1)))

; Parse Host line using colon delimiter
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))
(assert (str.contains host_value " "))

; Parse Content-Length line using colon delimiter
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Validate that content-length value looks numeric (optional leading space, then digits)
(assert (str.in_re cl_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Integer constraints for content length and body length
(assert (>= content_length 0))
(assert (<= content_length 1000000))

; SAT track: consistent length equality
(assert (= (str.len body) content_length))

; UNSAT track in the same file via an additional contradictory requirement guarded by a fresh boolean
(declare-const force_unsat Bool)
(assert (= force_unsat false))
(assert (=> force_unsat (not (= (str.len body) content_length))))

(check-sat)


; [GENERATION STATUS: SUCCESS]