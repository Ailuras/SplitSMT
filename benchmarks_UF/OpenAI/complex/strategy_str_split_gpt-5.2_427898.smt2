(set-logic ALL)

; Uninterpreted interface operations for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-style boolean guards
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)

; Input: HTTP header block (request-line + headers)
(declare-fun var_0xINPUT_130232 () String)

; Parsed components
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

; Numeric content-length (modeled via length of the cl_value string)
(declare-const content_length Int)

; --- Preserve core structure: non-empty input, exclude specific bad constants ---
(assert (= T_1 (not (= "" var_0xINPUT_130232))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_130232))))
(assert T_2)

; Mutate T_3 meaning: forbid a specific degenerate header prefix
(assert (= T_3 (str.prefixof "Example:" var_0xINPUT_130232)))
(assert (= T_4 (not T_3)))
(assert T_4)

(assert (= T_5 (not (= var_0xINPUT_130232 "AA1ND6MEXd"))))
(assert T_5)

; --- HTTP header parsing structure using split operations ---
; Require at least request-line + one header line when splitting by newline
(assert (>= (num_splits var_0xINPUT_130232 "\n") 2))
(assert (>= (num_splits var_0xINPUT_130232 "\n") 3))

(assert (= request_line (split_at var_0xINPUT_130232 "\n" 0)))
(assert (= headers_block (split_rest var_0xINPUT_130232 "\n" 1)))

; Parse request-line: "METHOD PATH VERSION"
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= path   (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))

; Basic sanity
(assert (not (= method "")))
(assert (not (= path "")))
(assert (not (= version "")))
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "HTTP/" version))

; Identify two specific header lines from headers_block
(assert (= host_line (split_at headers_block "\n" 0)))
(assert (= cl_line   (split_at headers_block "\n" 1)))

; Key-value parsing using ':' delimiter
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))

(assert (= host_key   (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= cl_key     (split_at cl_line ":" 0)))
(assert (= cl_value   (split_rest cl_line ":" 1)))

; Normalize expected keys (case-sensitive for simplicity)
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Values must be non-empty and not contain newlines
(assert (not (= host_value "")))
(assert (not (str.contains host_value "\n")))
(assert (not (= cl_value "")))
(assert (not (str.contains cl_value "\n")))

; Content-Length validation (relaxed): value should be digits-only, modeled by forbidding obvious non-digits
(assert (= T_6 (not (str.contains cl_value "-"))))
(assert T_6)
(assert (= T_7 (not (str.contains cl_value "."))))
(assert T_7)

; Content-length numeric proxy: require length between 1 and 10
(assert (= content_length (str.len cl_value)))
(assert (>= content_length 1))
(assert (<= content_length 10))

; Additional constraints to keep instance satisfiable and realistic
(assert (str.prefixof "/" path))
(assert (str.contains host_value "."))
(assert (not (str.contains host_value " ")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
