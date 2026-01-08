(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; HTTP Header Parsing via str_split: request line + header lines + blank line + body

(declare-const req String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

(declare-const headers_and_body String)
(declare-const headers_block String)
(declare-const body String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)

(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const content_length Int)
(declare-const sat_case Bool)

; non-primitive interface ops

; helper to parse int from string (uninterpreted, constrained by regex)
(declare-fun str_to_int (String) Int)

; Structural constraints
(assert (>= (str.len req) 20))
(assert (str.contains req "\r\n"))

; Split request into request-line and the rest
(assert (= (split_at req "\r\n" 0) (str.++ method " " path " " version)))
(assert (= headers_and_body (split_rest req "\r\n" 1)))
(assert (>= (num_splits req "\r\n") 4))

; Request-line basics
(assert (or (= method "GET") (= method "POST")))
(assert (str.in_re path (re.++ (str.to_re "/") (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "/"))))))
(assert (or (= version "HTTP/1.1") (= version "HTTP/1.0")))

; Find header/body boundary using CRLFCRLF
(assert (str.contains headers_and_body "\r\n\r\n"))
(assert (= headers_block (split_at headers_and_body "\r\n\r\n" 0)))
(assert (= body (split_rest headers_and_body "\r\n\r\n" 1)))
(assert (>= (num_splits headers_and_body "\r\n\r\n") 2))

; At least 3 header lines
(assert (>= (num_splits headers_block "\r\n") 3))

; Extract specific header lines by position (order simplified)
(assert (= host_line (split_at headers_block "\r\n" 0)))
(assert (= cl_line   (split_at headers_block "\r\n" 1)))
(assert (= ua_line   (split_at headers_block "\r\n" 2)))

; Each header line must contain a colon
(assert (str.contains host_line ":"))
(assert (str.contains cl_line ":"))
(assert (str.contains ua_line ":"))

; Parse key/value around ':' and an optional leading space in value
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_value (split_rest ua_line ":" 1)))

; Normalize common pattern: ": " (value starts with a space)
(assert (or (= host_value (str.++ " " (split_rest host_line ": " 1))) (= host_value (split_rest host_line ":" 1))))
(assert (or (= cl_value   (str.++ " " (split_rest cl_line   ": " 1))) (= cl_value   (split_rest cl_line   ":" 1))))
(assert (or (= ua_value   (str.++ " " (split_rest ua_line   ": " 1))) (= ua_value   (split_rest ua_line   ":" 1))))

; Header keys expected (case-sensitive simplification)
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Host value must include at least one dot, and be reasonably sized
(assert (>= (str.len host_value) 2))
(assert (<= (str.len host_value) 80))
(assert (str.contains host_value "."))

; Content-Length value is digits possibly prefixed by a single space
(assert (str.in_re cl_value (re.++ (re.opt (str.to_re " ")) (re.+ (re.range "0" "9")))))

; UA non-empty, no CR/LF inside
(assert (> (str.len ua_value) 1))
(assert (not (str.contains ua_value "\r")))
(assert (not (str.contains ua_value "\n")))

; Map cl_value to integer and validate bounds
(assert (= content_length (str_to_int cl_value)))
(assert (>= content_length 0))
(assert (<= content_length 4096))

; SAT/UNSAT fork: enforce exact length when sat_case, contradict when not sat_case
(assert (or sat_case (not sat_case)))
(assert (ite sat_case
            (= (str.len body) content_length)
            (and (= (str.len body) content_length)
                 (not (= (str.len body) content_length)))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
