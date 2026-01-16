(set-logic ALL)

; --- Uninterpreted interface ops for splitting ---

; --- Seed structure preserved / mutated ---
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_132387 () String)

; --- HTTP Header Parsing scenario variables ---
(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value_raw String)
(declare-const cl_value String)
(declare-const content_length Int)
(declare-const body String)

; Seed constraints (mutated: input now tied to request and further constrained)
(assert (= var_0xINPUT_132387 request))
(assert (= T_1 (= "-" var_0xINPUT_132387)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_132387)))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- Basic HTTP request structure ---
; Ensure at least request-line + headers + empty line + optional body
(assert (>= (str.num_splits request "\r\n") 3))
(assert (= request_line (str.split_at request "\r\n" 0)))
(assert (= headers_block (str.split_rest request "\r\n" 1)))

; request_line: "METHOD SP PATH SP HTTP/VERSION"
(assert (str.contains request_line "HTTP/"))
(assert (or (str.contains request_line "GET ") (str.contains request_line "POST ")))

; header block ends with an empty line; body starts after that
(assert (>= (str.num_splits headers_block "\r\n\r\n") 2))
(assert (= body (str.split_rest headers_block "\r\n\r\n" 1)))

; --- Extract specific headers by line position (simple model) ---
; Line 1 after request line: Host
; Line 2 after request line: Content-Length
(assert (= host_line (str.split_at request "\r\n" 1)))
(assert (= cl_line (str.split_at request "\r\n" 2)))

; Parse "Key: Value" using ':'
(assert (>= (str.num_splits host_line ":") 2))
(assert (>= (str.num_splits cl_line ":") 2))
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value_raw (str.split_rest cl_line ":" 1)))

; Trim model: require a single leading space before values
(assert (= (str.at host_value 0) " "))
(assert (= (str.at cl_value_raw 0) " "))
(assert (= host_value (str.++ " " (str.substr host_value 1 (- (str.len host_value) 1)))))
(assert (= cl_value_raw (str.++ " " (str.substr cl_value_raw 1 (- (str.len cl_value_raw) 1)))))
(assert (= cl_value (str.substr cl_value_raw 1 (- (str.len cl_value_raw) 1))))

; Validate header keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value sanity
(assert (> (str.len (str.substr host_value 1 (- (str.len host_value) 1))) 0))
(assert (str.contains (str.substr host_value 1 (- (str.len host_value) 1)) "."))

; Content-Length digits only (simple numeric validation)
(assert (> (str.len cl_value) 0))
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Bind an integer approximation of content-length via constraints
(assert (>= content_length 0))
(assert (<= content_length 1000000))

; SAT branch: allow either a consistent length or inconsistent; force consistent here
; If cl_value is "0" then body must be empty; otherwise body length must be > 0
(assert (or (and (= cl_value "0") (= (str.len body) 0) (= content_length 0))
            (and (not (= cl_value "0")) (> (str.len body) 0) (> content_length 0))))

; Additional structural constraints: ensure no stray '-' or empty request
(assert (not (str.contains request "\n\n")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
