(set-logic ALL)

; --- Uninterpreted interface for string split ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Seed-preserved core structure (mutated/extended) ---
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-const var_0xINPUT_27511 String)

; HTTP header parsing scenario variables
(declare-const request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const http_version String)

(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)

(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)
(declare-const body String)

; Connect seed input to the request
(assert (= request var_0xINPUT_27511))

; Keep the original boolean skeleton but repurpose T_1 meaningfully
(assert (= T_1 (not (= "" request))))

; Parse request into header block and body using CRLFCRLF
(assert (>= (num_splits request "\r\n\r\n") 2))
(assert (= header_block (split_at request "\r\n\r\n" 0)))
(assert (= body (split_rest request "\r\n\r\n" 1)))

; Parse first line: METHOD SP PATH SP HTTP/1.1
(assert (>= (num_splits header_block "\r\n") 1))
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= http_version (split_at request_line " " 2)))
(assert (= http_version "HTTP/1.1"))
(assert (or (= method "GET") (= method "POST")))
(assert (not (= path "")))

; Require at least three header lines (request line + Host + Content-Length)
(assert (>= (num_splits header_block "\r\n") 3))
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= cl_line (split_at header_block "\r\n" 2)))

; Parse Host header: "Host: <value>"
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
; basic sanity: must contain a dot and not contain spaces
(assert (str.contains host_value "."))
(assert (not (str.contains host_value " ")))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Trim not modeled: force no leading space in cl_value to keep constraints simple
(assert (not (str.contains cl_value " ")))
(assert (not (= cl_value "")))

; Length validation
(assert (= content_length (str.to_int cl_value)))
(assert (>= content_length 0))
(assert (>= (str.len body) 0))

; Intentional inconsistency to create an UNSAT instance:
; If request is non-empty (T_1), require body length to equal content_length,
; but also require body length to differ from content_length.
(assert (= T_2 (and T_1 (= (str.len body) content_length))))
(assert T_2)
(assert (not (= (str.len body) content_length)))

(check-sat)


; [GENERATION STATUS: SUCCESS]