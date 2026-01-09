(set-logic ALL)

; Uninterpreted split interface

; HTTP header parsing scenario
(declare-const X String)
(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)

; Preserve core seed structure: filename pattern with newline terminator
(assert (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".avi/i\u{a}"))))
(assert (not (str.in_re X (str.to_re "www.makemesearch.comLOGOnevclxatmlhavj/vsy\u{a}"))))
(assert (not (str.in_re X (re.++ (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "\u{a}")))))

; Request/headers shape: request-line then headers then blank line then payload X
(assert (= req (str.++ request_line "\u{a}" headers_block "\u{a}\u{a}" X)))

; Must contain at least Host and Content-Length header lines separated by newlines
(assert (>= (str.num_splits headers_block "\u{a}") 2))
(assert (= host_line (str.split_at headers_block "\u{a}" 0)))
(assert (= cl_line (str.split_at headers_block "\u{a}" 1)))

; Each header line must be key:value with a colon
(assert (>= (str.num_splits host_line ":") 2))
(assert (>= (str.num_splits cl_line ":") 2))

(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_rest cl_line ":" 1)))

; Validate header keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Basic host value sanity: non-empty and no newlines
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\u{a}")))

; cl_value must be decimal digits only
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; content_length must match payload length
(assert (>= content_length 0))
(assert (= content_length (str.len X)))

; Additional HTTP-ish constraints
(assert (str.in_re request_line (re.++ (str.to_re "GET ") (re.+ (re.comp (str.to_re "\u{a}"))) (str.to_re " HTTP/1.1"))))

; UNSAT twist: enforce a different content-length to conflict with (= (str.len X))
(assert (= content_length (+ (str.len X) 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
