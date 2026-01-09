(set-logic ALL)

; Uninterpreted interface functions for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed remnants / core structure preserved
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_18057 () String)
(assert (= T_1 (= "-" var_0xINPUT_18057)))
(assert T_1)

; Scenario: HTTP Header Parsing
(declare-const request String)
(declare-const headers String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const body String)
(declare-const content_length Int)
(declare-const actual_body_len Int)
(declare-const i Int)

; Split request into lines by newline. Line 0 is request line.
(assert (= request_line (split_at request "\n" 0)))
(assert (= headers (split_rest request "\n" 1)))
(assert (>= (num_splits request "\n") 4))

; Ensure request line looks like: "GET / HTTP/1.1"
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET"))

; Parse some header lines (assume they exist at fixed positions for this model)
(assert (= host_line (split_at request "\n" 1)))
(assert (= ua_line   (split_at request "\n" 2)))
(assert (= cl_line   (split_at request "\n" 3)))

; Each header line should contain a colon separator
(assert (str.contains host_line ":"))
(assert (str.contains ua_line ":"))
(assert (str.contains cl_line ":"))

; Split header lines by ":" into key and value segments
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (split_rest host_line ":" 1)))
(assert (= ua_key   (split_at ua_line ":" 0)))
(assert (= ua_val   (split_rest ua_line ":" 1)))
(assert (= cl_key   (split_at cl_line ":" 0)))
(assert (= cl_val   (split_rest cl_line ":" 1)))

; Validate required header keys (case-sensitive in this simplified model)
(assert (= host_key "Host"))
(assert (= ua_key "User-Agent"))
(assert (= cl_key "Content-Length"))

; Trim-like constraints via containment (no real trim function available)
(assert (not (= host_val "")))
(assert (not (= ua_val "")))
(assert (not (= cl_val "")))

; Content-Length value must be all digits (allow a leading space before digits)
; Regex: (" ")? [0-9]+
(assert (str.in_re cl_val (re.++ (re.opt (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Relate content_length to some numeric property; use a simple bounded interpretation
; (since full string-to-int is not part of the provided interface)
(assert (>= content_length 0))
(assert (<= content_length 1024))

; Define body as everything after header lines (from line 4 onwards)
(assert (= body (split_rest request "\n" 4)))
(assert (= actual_body_len (str.len body)))

; SAT instance: accept consistent length
(assert (= actual_body_len content_length))

; Add some additional structure: header section must end with an empty line at line 4
(assert (= (split_at request "\n" 4) ""))

; Ensure host value contains a dot, like a domain
(assert (str.contains host_val "."))

; Index constraints for interface natural indices
(assert (>= i 0))
(assert (< i (num_splits request "\n")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
