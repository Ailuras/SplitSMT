(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------
; SAT instance: plausible HTTP header parsing
; -------------------------
(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const body String)

(declare-const header_host_line String)
(declare-const header_cl_line String)
(declare-const header_ua_line String)

(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value_str String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const content_length Int)

; Structure: request-line \n headers \n\n body
(assert (= request_line (split_at req "\n" 0)))
(assert (= headers_block (split_rest req "\n" 1)))

; The headers end at the empty line, so splitting by "\n\n" yields at least 2 parts
(assert (>= (num_splits headers_block "\n\n") 2))
(assert (= body (split_at headers_block "\n\n" 1)))

; At least three header lines before the empty line
(assert (>= (num_splits headers_block "\n") 4))
(assert (= header_host_line (split_at headers_block "\n" 0)))
(assert (= header_cl_line (split_at headers_block "\n" 1)))
(assert (= header_ua_line (split_at headers_block "\n" 2)))

; Each header line is Key:Value with exactly 2 segments when split by ':'
(assert (= (num_splits header_host_line ":") 2))
(assert (= host_key (split_at header_host_line ":" 0)))
(assert (= host_value (split_at header_host_line ":" 1)))

(assert (= (num_splits header_cl_line ":") 2))
(assert (= cl_key (split_at header_cl_line ":" 0)))
(assert (= cl_value_str (split_at header_cl_line ":" 1)))

(assert (= (num_splits header_ua_line ":") 2))
(assert (= ua_key (split_at header_ua_line ":" 0)))
(assert (= ua_value (split_at header_ua_line ":" 1)))

; Request line pattern: "GET / HTTP/1.1" (simple validation)
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET "))

; Normalize expected keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Host value must be non-empty and not contain newline
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\n")))

; Content-Length parsing: allow optional leading space before digits, then digits only
; Regex: (" ")* [0-9]+ and bind integer value via str.to_int
(assert (str.in_re cl_value_str (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))
(assert (= content_length (str.to_int cl_value_str)))
(assert (>= content_length 0))

; Body length must match content-length
(assert (= (str.len body) content_length))

; Optional: User-Agent is present and reasonably bounded
(assert (> (str.len ua_value) 0))
(assert (< (str.len ua_value) 200))

; Make the instance concrete enough to be satisfiable
(assert (= req (str.++ "GET / HTTP/1.1\n" header_host_line "\n" header_cl_line "\n" header_ua_line "\n\n" body)))
(assert (= header_host_line "Host:example.com"))
(assert (= header_ua_line "User-Agent:curl/8.0"))
(assert (= header_cl_line "Content-Length: 5"))
(assert (= body "hello"))

; -------------------------
; UNSAT instance: inconsistent content-length
; -------------------------
(declare-const req_bad String)
(declare-const headers_block_bad String)
(declare-const body_bad String)
(declare-const cl_line_bad String)
(declare-const cl_value_bad String)
(declare-const content_length_bad Int)

(assert (= headers_block_bad (split_rest req_bad "\n" 1)))
(assert (>= (num_splits headers_block_bad "\n\n") 2))
(assert (= body_bad (split_at headers_block_bad "\n\n" 1)))

(assert (>= (num_splits headers_block_bad "\n") 2))
(assert (= cl_line_bad (split_at headers_block_bad "\n" 0)))
(assert (= (num_splits cl_line_bad ":") 2))
(assert (= (split_at cl_line_bad ":" 0) "Content-Length"))
(assert (= cl_value_bad (split_at cl_line_bad ":" 1)))

(assert (str.in_re cl_value_bad (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))
(assert (= content_length_bad (str.to_int cl_value_bad)))
(assert (>= content_length_bad 0))

; Force a mismatch: length(body_bad)=3 but Content-Length=4
(assert (= (str.len body_bad) 3))
(assert (= content_length_bad 4))

; Concrete construction
(assert (= req_bad (str.++ "GET / HTTP/1.1\n" "Content-Length: 4\n\n" body_bad)))
(assert (= body_bad "abc"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
