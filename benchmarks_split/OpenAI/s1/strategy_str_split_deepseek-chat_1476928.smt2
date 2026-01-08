(set-logic ALL)

; --- Uninterpreted split interface (str_split) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Seed-like boolean guards preserved/mutated ---
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)

; --- Input and derived header fields ---
(declare-const var_0xINPUT_339801 String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const content_length Int)

; Non-empty input (seed structure)
(assert (= T_1 (not (= "" var_0xINPUT_339801))))
(assert T_1)

; Mutated equality check: forbid the old trivial value
(assert (= T_2 (not (= var_0xINPUT_339801 "array"))))
(assert T_2)

; --- HTTP parsing: split by CRLF into lines ---
(assert (>= (num_splits var_0xINPUT_339801 "\r\n") 3))
(assert (= request_line (split_at var_0xINPUT_339801 "\r\n" 0)))
(assert (= host_line (split_at var_0xINPUT_339801 "\r\n" 1)))
(assert (= cl_line   (split_at var_0xINPUT_339801 "\r\n" 2)))
(assert (= body      (split_rest var_0xINPUT_339801 "\r\n" 3)))
(assert (= headers_block (str.++ host_line "\r\n" cl_line "\r\n")))

; --- Validate request line shape ---
(assert (str.prefixof "POST " request_line))
(assert (str.contains request_line " HTTP/1.1"))

; --- Parse Host header by colon-space ---
(assert (>= (num_splits host_line ": ") 2))
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_value (split_at host_line ": " 1)))
(assert (= host_key "Host"))
(assert (not (= host_value "")))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; --- Parse Content-Length header by colon-space ---
(assert (>= (num_splits cl_line ": ") 2))
(assert (= cl_key (split_at cl_line ": " 0)))
(assert (= cl_value (split_at cl_line ": " 1)))
(assert (= cl_key "Content-Length"))

; --- Content-Length value constraints (digits only, positive) ---
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))
(assert (>= content_length 1))

; Link length to body length
(assert (= (str.len body) content_length))

; Extra structure: enforce header ordering and presence
(assert (str.contains headers_block "Host: "))
(assert (str.contains headers_block "Content-Length: "))

; Seed-like third boolean, derived from parsing sanity
(assert (= T_3 (and (>= (str.len host_value) 1) (>= (str.len cl_value) 1))))
(assert T_3)

; --- UNSAT twist: contradict the length link intentionally ---
(assert (not (= (str.len body) content_length)))

(check-sat)


; [GENERATION STATUS: SUCCESS]