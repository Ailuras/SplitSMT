(set-logic ALL)

; --- Uninterpreted interface for string split ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- HTTP header parsing scenario ---
(declare-const X String)                 ; full HTTP request text
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const email_like String)
(declare-const body String)
(declare-const cl_num Int)

; Seed-derived constraints (mutated/extended): disallow a specific bad host payload
(assert (not (str.in_re X (str.to_re "dll?badurl.grandstreetinteractive.com\u{0A}"))))

; Extract request line and a headers block by newline splitting
(assert (= request_line (split_at X "\u{0A}" 0)))
(assert (= headers_block (split_rest X "\u{0A}" 1)))
(assert (>= (num_splits X "\u{0A}") 4))

; Require a plausible request line: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re request_line
  (re.++
    (re.union (str.to_re "GET") (str.to_re "POST"))
    (str.to_re " ")
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "/") (str.to_re "_") (str.to_re "-") (str.to_re ".")))
    (str.to_re " HTTP/1.1"))))

; First two header lines inside headers_block
(assert (= host_line (split_at headers_block "\u{0A}" 0)))
(assert (= cl_line   (split_at headers_block "\u{0A}" 1)))

; Parse "Host: <value>" using colon+space delimiter
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_val (split_at host_line ": " 1)))
(assert (= host_key "Host"))
(assert (>= (num_splits host_line ": ") 2))

; Host value should look like a domain (no spaces, contains a dot)
(assert (not (str.contains host_val " ")))
(assert (str.contains host_val "."))
(assert (str.in_re host_val
  (re.++
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re "_")))
    (str.to_re ".")
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re "_"))))))

; Parse "Content-Length: <digits>" with colon+space delimiter
(assert (= cl_key (split_at cl_line ": " 0)))
(assert (= cl_val (split_at cl_line ": " 1)))
(assert (= cl_key "Content-Length"))
(assert (>= (num_splits cl_line ": ") 2))
(assert (str.in_re cl_val (re.+ (re.range "0" "9"))))

; Relate body and content-length using string length
(assert (= body (split_rest headers_block "\u{0A}" 2)))
(assert (= (str.len body) cl_num))
(assert (>= cl_num 0))
(assert (<= cl_num 1024))
(assert (>= (str.len cl_val) 1))

; Keep a seed-like email regex constraint but apply it to a derived field.
; Here we require some later header line to contain an email-like token after a newline.
(assert (= email_like (split_at headers_block "\u{0A}" 2)))
(assert (str.in_re email_like
  (re.++
    (str.to_re "From: ")
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-")))
    (str.to_re "@")
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-")))
    (str.to_re ".")
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-"))))))

; --- Additional constraints to create both SAT and UNSAT branches ---
(declare-const force_unsat Bool)

; If force_unsat then require an impossible content-length relation
(assert (=> force_unsat (and (= cl_num 5) (= cl_num (str.len body)) (= (str.len body) 7))))

; Otherwise ensure a coherent structure and non-empty body when content-length > 0
(assert (=> (not force_unsat) (and (>= cl_num 0) (<= cl_num 100) (=> (> cl_num 0) (> (str.len body) 0)))))

; Make sure the request does not accidentally equal the exact forbidden pattern including newline
(assert (not (= X "dll?badurl.grandstreetinteractive.com\u{0A}")))

(check-sat)


; [GENERATION STATUS: SUCCESS]