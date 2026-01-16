(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted split interface

; HTTP header parsing instance
(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const body String)
(declare-const header_line0 String)
(declare-const header_line1 String)
(declare-const header0_name String)
(declare-const header0_value String)
(declare-const header1_name String)
(declare-const header1_value String)
(declare-const content_length_str String)
(declare-const content_length Int)
(declare-const host String)
(declare-const path String)
(declare-const digit3 String)

; Structure: split request into headers and body
(assert (>= (num_splits req "\u{0D}\u{0A}\u{0D}\u{0A}") 2))
(assert (= headers_block (split_at req "\u{0D}\u{0A}\u{0D}\u{0A}" 0)))
(assert (= body (split_rest req "\u{0D}\u{0A}\u{0D}\u{0A}" 1)))

; Split headers into lines: request line + at least two header lines
(assert (>= (num_splits headers_block "\u{0D}\u{0A}") 3))
(assert (= request_line (split_at headers_block "\u{0D}\u{0A}" 0)))
(assert (= header_line0 (split_at headers_block "\u{0D}\u{0A}" 1)))
(assert (= header_line1 (split_at headers_block "\u{0D}\u{0A}" 2)))

; Request line: METHOD SP PATH SP HTTP/1.1
(assert (>= (num_splits request_line " ") 3))
(assert (= path (split_at request_line " " 1)))
(assert (str.in_re request_line (re.++ (re.union (str.to_re "GET") (str.to_re "POST") (str.to_re "HEAD")) (str.to_re " ") (re.+ re.allchar) (str.to_re " HTTP/1.1"))))

; Header lines contain exactly one ':' separating name and value
(assert (>= (num_splits header_line0 ":") 2))
(assert (>= (num_splits header_line1 ":") 2))
(assert (= header0_name (split_at header_line0 ":" 0)))
(assert (= header0_value (split_rest header_line0 ":" 1)))
(assert (= header1_name (split_at header_line1 ":" 0)))
(assert (= header1_value (split_rest header_line1 ":" 1)))

; Constrain specific headers (core scenario)
(assert (= header0_name "Host"))
(assert (str.in_re header0_value (re.++ (str.to_re " ") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "-") )))))
(assert (= host (str.substr header0_value 1 (- (str.len header0_value) 1))))

(assert (= header1_name "Content-Length"))
(assert (str.in_re header1_value (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))
(assert (= content_length_str (str.substr header1_value 1 (- (str.len header1_value) 1))))

; Content-Length numeric parsing (bounded to 3 digits) and body length check
(assert (str.in_re content_length_str ((_ re.loop 3 3) (re.range "0" "9"))))
(assert (= digit3 content_length_str))
(assert (= content_length (- (str.to_code (str.at digit3 2)) 48)))
(assert (= content_length (+ (* 10 (- (str.to_code (str.at digit3 1)) 48)) content_length)))
(assert (= content_length (+ (* 100 (- (str.to_code (str.at digit3 0)) 48)) content_length)))
(assert (>= content_length 0))
(assert (<= content_length 255))
(assert (= (str.len body) content_length))

; Mutated/extended constraints inspired by seed-style regex checks
; Require path to look like a media resource with suffix and a trailing CRLF not present in path
(assert (str.in_re path (re.++ (str.to_re "/") (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re "_") )) (str.to_re ".webm"))))
(assert (not (str.contains path "\u{0D}\u{0A}")))

; UNSAT twist: forbid any CRLFCRLF in the request while it is required above
(assert (not (str.contains req "\u{0D}\u{0A}\u{0D}\u{0A}")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
