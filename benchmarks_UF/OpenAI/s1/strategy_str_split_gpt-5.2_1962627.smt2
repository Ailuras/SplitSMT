(set-logic ALL)

; Uninterpreted interface operations for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-like core variables
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_520976 () String)

; HTTP header parsing variables
(declare-const request_line String)
(declare-const headers_block String)
(declare-const body String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const content_length_value String)
(declare-const host_value String)
(declare-const declared_len Int)
(declare-const actual_body_len Int)

; Core structure preserved: non-empty input
(assert (= T_1 (str.len var_0xINPUT_520976)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; Split request into header section and body using CRLFCRLF
(assert (>= (num_splits var_0xINPUT_520976 "\r\n\r\n") 2))
(assert (= headers_block (split_at var_0xINPUT_520976 "\r\n\r\n" 0)))
(assert (= body (split_rest var_0xINPUT_520976 "\r\n\r\n" 1)))

; First line is request line (split by CRLF)
(assert (>= (num_splits headers_block "\r\n") 1))
(assert (= request_line (split_at headers_block "\r\n" 0)))

; Require a plausible request line: contains spaces and HTTP/1.1
(assert (str.contains request_line " "))
(assert (str.contains request_line "HTTP/1.1"))

; Expect at least 3 header lines total (request line + 2 headers)
(assert (>= (num_splits headers_block "\r\n") 3))

; Extract two specific header lines
(assert (= host_line (split_at headers_block "\r\n" 1)))
(assert (= content_length_line (split_at headers_block "\r\n" 2)))

; Each header line must contain a colon separating key and value
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits content_length_line ":") 2))

; Key validation for Host
(assert (= (split_at host_line ":" 0) "Host"))
(assert (= host_value (split_rest host_line ":" 1)))

; Key validation for Content-Length
(assert (= (split_at content_length_line ":" 0) "Content-Length"))
(assert (= content_length_value (split_rest content_length_line ":" 1)))

; Basic sanity: Host value non-empty and does not contain CR or LF
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; Content-Length value should be digits only (allow optional leading spaces trimmed by contains check)
(assert (> (str.len content_length_value) 0))
(assert (str.in_re content_length_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Length consistency constraints
(assert (= actual_body_len (str.len body)))
(assert (>= declared_len 0))
(assert (<= declared_len 1000000))

; SAT branch: allow either consistency holds, or a well-formed but mismatched length (for negative testing)
(declare-const ok_length Bool)
(assert (= ok_length (= declared_len actual_body_len)))
(assert (or ok_length (not ok_length)))

; UNSAT sub-instance: contradictory requirements on Content-Length value shape
; It must both be only digits (above) and also contain a non-digit character.
(assert (str.contains content_length_value "a"))

(check-sat)


; [GENERATION STATUS: SUCCESS]