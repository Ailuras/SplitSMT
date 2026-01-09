(set-logic ALL)

; --- Uninterpreted interface for str_split ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Seed-style string building blocks (kept core structure) ---
(declare-fun sigmaStar_5 () String)
(declare-fun sigmaStar_6 () String)
(declare-fun sigmaStar_7 () String)
(declare-fun literal_8 () String)
(declare-fun x_11 () String)
(declare-fun literal_9 () String)
(declare-fun x_12 () String)
(declare-fun literal_10 () String)
(declare-fun x_13 () String)
(declare-fun x_16 () String)
(declare-fun literal_1 () String)

; --- HTTP header parsing scenario variables ---
(declare-const request String)
(declare-const header_block String)
(declare-const body String)
(declare-const line0 String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const content_length Int)

; --- Seed literals adapted to HTTP-ish resources ---
(assert (= literal_8 "/default.html"))
(assert (= x_11 (str.++ sigmaStar_5 literal_8)))
(assert (= literal_9 "/index.html"))
(assert (= x_12 (str.++ sigmaStar_6 literal_9)))
(assert (= literal_10 "/index.htm"))
(assert (= x_13 (str.++ sigmaStar_7 literal_10)))
(assert (= literal_1 "file.php"))

; Path selection (core structure preserved)
(assert (or (= x_16 x_11) (= x_16 literal_1) (= x_16 x_13) (= x_16 x_12)))

; Still require a suspicious substring (mutated from "/evil" to header injection marker "\r\nX-Evil")
(assert (str.in_re x_16 (re.++ (re.* re.allchar) (re.++ (str.to_re "\r\nX-Evil") (re.* re.allchar)))))

; --- Request/header parsing constraints using split_at/num_splits/split_rest ---
; Split request into header block and body by CRLFCRLF
(assert (>= (num_splits request "\r\n\r\n") 2))
(assert (= header_block (split_at request "\r\n\r\n" 0)))
(assert (= body (split_rest request "\r\n\r\n" 1)))

; First line is request-line; subsequent lines include headers
(assert (>= (num_splits header_block "\r\n") 3))
(assert (= line0 (split_at header_block "\r\n" 0)))
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= cl_line (split_at header_block "\r\n" 2)))

; Request line should contain the chosen path x_16
(assert (str.contains line0 x_16))
(assert (str.prefixof "GET " line0))
(assert (str.contains line0 " HTTP/1.1"))

; Parse Host header as key:value
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (split_rest host_line ":" 1)))
(assert (= host_key "Host"))

; Parse Content-Length header as key:value
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_val (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Content-Length validation: body length must match integer content_length
(assert (>= content_length 0))
(assert (= (str.len body) content_length))

; UNSAT twist: content_length is forced to an impossible negative and inconsistent with len(body)
(assert (< content_length 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]