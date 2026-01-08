(set-logic ALL)

; Uninterpreted interface for string split operations

; HTTP Header Parsing scenario
(declare-const X String)
(declare-const header_line0 String)
(declare-const header_name0 String)
(declare-const header_value0 String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const content_length_value String)
(declare-const ua_line String)
(declare-const parsed_len Int)

; Core structure preserved: keep some seed regex constraints, but make them consistent with an HTTP-like header block
; Require at least 3 lines separated by LF
(assert (>= (str.num_splits X "\u{a}") 3))
(assert (= header_line0 (str.split_at X "\u{a}" 0)))
(assert (= host_line (str.split_at X "\u{a}" 0)))
(assert (= content_length_line (str.split_at X "\u{a}" 1)))
(assert (= ua_line (str.split_at X "\u{a}" 2)))

; Each header line is key:value form (split at colon)
(assert (>= (str.num_splits host_line ":") 2))
(assert (>= (str.num_splits content_length_line ":") 2))
(assert (>= (str.num_splits ua_line ":") 2))

(assert (= header_name0 (str.split_at host_line ":" 0)))
(assert (= header_value0 (str.split_rest host_line ":" 1)))

; Host header name fixed
(assert (= header_name0 "Host"))

; Host value: simple host token (no spaces), plus specific suffix to preserve seed flavor
(assert (str.in_re header_value0 (re.++ (re.* (str.to_re " ")) (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "-") )) (re.* (str.to_re " ")))))
(assert (str.contains header_value0 "A-311"))

; User-Agent line close to seed but made consistent with line splitting
(assert (= ua_line "User-Agent:etbuviaebe/eqv.bvv"))

; Content-Length parsing
(assert (= (str.split_at content_length_line ":" 0) "Content-Length"))
(assert (= content_length_value (str.split_rest content_length_line ":" 1)))

; Trim-like allowance: optional spaces then digits only
(assert (str.in_re content_length_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")) (re.* (str.to_re " ")))))

; Parse length as an Int via constraint coupling (modeling: content_length_value must be the decimal form of parsed_len)
(assert (>= parsed_len 0))
(assert (<= parsed_len 99999))
(assert (str.in_re (str.from_int parsed_len) (re.+ (re.range "0" "9"))))
; enforce that after stripping spaces, the content_length_value equals the decimal form
(assert (= (str.replace (str.replace content_length_value " " "") " " "") (str.from_int parsed_len)))

; Ensure X has CRLF or LF structure and ends with a blank line after headers (typical HTTP)
; We model it by requiring that the rest after line2 begins with an empty line (i.e., line3 is empty)
(assert (>= (str.num_splits X "\u{a}") 4))
(assert (= (str.split_at X "\u{a}" 3) ""))

; Compose additional constraints using regex to ensure header formatting
(assert (str.in_re host_line (re.++ (str.to_re "Host") (str.to_re ":") (re.* (str.to_re " ")) (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "-") )))))
(assert (str.in_re content_length_line (re.++ (str.to_re "Content-Length") (str.to_re ":") (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; SAT instance constraints (consistent)
(assert (= parsed_len 42))

(check-sat)


; [GENERATION STATUS: SUCCESS]
