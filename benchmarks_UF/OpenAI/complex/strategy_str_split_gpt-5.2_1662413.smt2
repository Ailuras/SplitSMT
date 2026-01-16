(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted split interface

; HTTP header parsing scenario
(declare-const req String)
(declare-const request_line String)
(declare-const headers_blob String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const content_length_key String)
(declare-const content_length_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const body String)
(declare-const cl_num_str String)
(declare-const cl_num Int)

; Preserve core seed structure: regex over an ID-like token (now a header value)
(declare-const X String)
(assert (str.in_re X
  (re.union
    (re.++ (str.to_re "050-") ((_ re.loop 7 7) (re.range "0" "9")))
    (re.++ (str.to_re "052-") ((_ re.loop 7 7) (re.range "0" "9")))
    (re.++ (str.to_re "054-") ((_ re.loop 7 7) (re.range "0" "9")))
    (re.++ (str.to_re "057-") ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "\u{a}")))))

; Basic request structure: request-line \n headers \n\n body
(assert (= request_line (split_at req "\u{a}" 0)))
(assert (= headers_blob (split_at req "\u{a}\u{a}" 0)))
(assert (= body (split_rest req "\u{a}\u{a}" 1)))
(assert (>= (num_splits req "\u{a}\u{a}") 2))

; Request line sanity
(assert (str.prefixof "GET " request_line))
(assert (str.contains request_line " HTTP/1.1"))
(assert (str.contains request_line " /"))

; At least a few header lines exist
(assert (>= (num_splits headers_blob "\u{a}") 3))

; Parse two specific headers from the headers blob
(assert (= host_line (split_at headers_blob "\u{a}" 1)))
(assert (= content_length_line (split_at headers_blob "\u{a}" 2)))

; Header lines must contain ':' delimiter
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits content_length_line ":") 2))

; Split key/value around ':'
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= content_length_key (split_at content_length_line ":" 0)))
(assert (= content_length_value (split_rest content_length_line ":" 1)))

; Key checks
(assert (= host_key "Host"))
(assert (= content_length_key "Content-Length"))

; Host must look like a domain with a dot and no spaces
(assert (str.contains host_value "."))
(assert (not (str.contains host_value " ")))

; Content-Length value: require a leading space then digits (no other chars)
(assert (str.prefixof " " content_length_value))
(assert (= cl_num_str (str.substr content_length_value 1 (- (str.len content_length_value) 1))))
(assert (>= (str.len cl_num_str) 1))
(assert (str.in_re cl_num_str (re.+ (re.range "0" "9"))))

; Numeric interpretation and validation against body length
(assert (= cl_num (str.to_int cl_num_str)))
(assert (>= cl_num 0))
(assert (= cl_num (str.len body)))

; Relate X into headers: embed X as part of Host value to force interaction
(assert (str.contains host_value X))

; Additional constraints to create both SAT/UNSAT branches:
; If X matches the 057-...\n variant, it contains a newline, which is disallowed in a header value.
; This makes some regex branches impossible while keeping others satisfiable.
(assert (not (str.contains host_value "\u{a}")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
