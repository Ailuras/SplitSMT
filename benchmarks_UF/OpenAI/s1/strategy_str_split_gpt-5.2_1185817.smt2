(set-logic ALL)

; HTTP Header Parsing scenario using str_split interface and regex constraints

(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const X String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const content_length Int)

; Preserve core seed structure: keep a few negative regex membership constraints
(assert (not (str.in_re X
  (re.++
    (re.opt (re.++ (re.opt (str.to_re "(")) (re.opt (str.to_re "+")) (re.* (re.range "0" "9")) (re.opt (str.to_re ")"))))
    (re.* (re.union (re.range "0" "9") (str.to_re "_") (str.to_re "-") (str.to_re " ") (str.to_re "(") (str.to_re ")")))
    (str.to_re "\u{a}")))))

(assert (not (str.in_re X (re.++ (str.to_re "Host:") (re.+ (re.range "0" "9")) (str.to_re "Subject:as.starware.com/dp/search?x=\u{a}")))))
(assert (not (str.in_re X (str.to_re "//bin.exe/U\u{a}"))))

; HTTP request structure: split at first newline to separate request-line and headers
(assert (>= (num_splits X "\u{a}") 2))
(assert (= request_line (split_at X "\u{a}" 0)))
(assert (= headers_block (split_rest X "\u{a}" 1)))

; Request line shape: METHOD SP PATH SP HTTP/VERSION
(assert (str.in_re request_line
  (re.++
    (re.union (str.to_re "GET") (str.to_re "POST") (str.to_re "HEAD"))
    (str.to_re " ")
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "/") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "?") (str.to_re "=") (str.to_re "&")))
    (str.to_re " ")
    (str.to_re "HTTP/1.1"))))

; Ensure Host and Content-Length headers exist somewhere in the header block
(assert (str.contains headers_block "Host:"))
(assert (str.contains headers_block "Content-Length:"))

; Extract first two header lines from the headers block by newline
(assert (>= (num_splits headers_block "\u{a}") 2))
(assert (= host_line (split_at headers_block "\u{a}" 0)))
(assert (= cl_line (split_at headers_block "\u{a}" 1)))

; Parse each header line at the first colon
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))

; Host header should begin with key "Host" and capture remainder as value
(assert (= (split_at host_line ":" 0) "Host"))
(assert (= host_value (split_rest host_line ":" 1)))

; Content-Length header should begin with key "Content-Length" and capture remainder
(assert (= (split_at cl_line ":" 0) "Content-Length"))
(assert (= cl_value (split_rest cl_line ":" 1)))

; Trim policy (approximate): no newline in extracted values
(assert (not (str.contains host_value "\u{a}")))
(assert (not (str.contains cl_value "\u{a}")))

; Validate host value: must not be empty and must look like hostname (no spaces)
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value " ")))
(assert (str.in_re host_value
  (re.++
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") (str.to_re ".")))
    (re.opt (re.++ (str.to_re ":") (re.+ (re.range "0" "9")))))))

; Validate Content-Length value: optional single leading space then digits
(assert (str.in_re cl_value
  (re.++ (re.opt (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Relate integer content_length with string cl_value (simple bounded interpretation)
; Approximation: enforce content_length non-negative and bounded by length of headers_block
(assert (>= content_length 0))
(assert (<= content_length (str.len headers_block)))

; Force a contradiction to create an UNSAT instance: content_length must be both > 10 and <= 5
(assert (> content_length 10))
(assert (<= content_length 5))

(check-sat)


; [GENERATION STATUS: SUCCESS]