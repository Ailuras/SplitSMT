(set-logic ALL)

; Uninterpreted functions for str_split interface

; Seed artifact kept but repurposed as a payload value
(declare-fun literal_9 () String)
(assert (= literal_9 "\u{3c}\u{64}\u{69}\u{76}\u{20}\u{63}\u{6c}\u{61}\u{73}\u{73}\u{3d}\u{22}\u{66}\u{75}\u{6c}\u{6c}\u{6e}\u{61}\u{6d}\u{65}\u{22}\u{3e}\u{75}\u{73}\u{65}\u{72}\u{3c}\u{2f}\u{64}\u{69}\u{76}\u{3e}"))

; Scenario: HTTP Header Parsing
(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const header0 String)
(declare-const header1 String)
(declare-const header2 String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const x_payload_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const xp_key String)
(declare-const xp_value String)
(declare-const body String)
(declare-const content_length Int)

; Split request into head and body on CRLFCRLF
(assert (>= (str.num_splits request "\r\n\r\n") 2))
(assert (= request_line (str.split_at request "\r\n" 0)))
(assert (= headers_block (str.split_rest request "\r\n" 1)))
(assert (= body (str.split_at request "\r\n\r\n" 1)))

; Parse first few header lines by CRLF
(assert (>= (str.num_splits headers_block "\r\n") 3))
(assert (= header0 (str.split_at headers_block "\r\n" 0)))
(assert (= header1 (str.split_at headers_block "\r\n" 1)))
(assert (= header2 (str.split_at headers_block "\r\n" 2)))

; Identify expected headers among the first three lines
(assert (= host_line header0))
(assert (= content_length_line header1))
(assert (= x_payload_line header2))

; Each header line must contain a colon delimiter
(assert (str.contains host_line ":"))
(assert (str.contains content_length_line ":"))
(assert (str.contains x_payload_line ":"))

; Split headers at colon into key/value pieces
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (= cl_key (str.split_at content_length_line ":" 0)))
(assert (= cl_value (str.split_rest content_length_line ":" 1)))
(assert (= xp_key (str.split_at x_payload_line ":" 0)))
(assert (= xp_value (str.split_rest x_payload_line ":" 1)))

; Normalize keys: require exact keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= xp_key "X-Payload"))

; Basic value sanity: value should not contain CR or LF
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))
(assert (not (str.contains cl_value "\r")))
(assert (not (str.contains cl_value "\n")))
(assert (not (str.contains xp_value "\r")))
(assert (not (str.contains xp_value "\n")))

; Ensure the header value formatting includes a leading space after ':'
(assert (str.prefixof " " host_value))
(assert (str.prefixof " " cl_value))
(assert (str.prefixof " " xp_value))

; Content-Length must be all digits after trimming the leading space
(declare-const cl_digits String)
(assert (= cl_digits (str.substr cl_value 1 (- (str.len cl_value) 1))))
(assert (str.in_re cl_digits (re.+ (re.range "0" "9"))))

; Convert content length to an integer via constrained arithmetic on a bounded width (1..5 digits)
(declare-const nDigits Int)
(assert (= nDigits (str.len cl_digits)))
(assert (>= nDigits 1))
(assert (<= nDigits 5))

; Digit characters
(declare-const d0 String)
(declare-const d1 String)
(declare-const d2 String)
(declare-const d3 String)
(declare-const d4 String)
(assert (= d0 (str.at cl_digits 0)))
(assert (= d1 (ite (>= nDigits 2) (str.at cl_digits 1) "0")))
(assert (= d2 (ite (>= nDigits 3) (str.at cl_digits 2) "0")))
(assert (= d3 (ite (>= nDigits 4) (str.at cl_digits 3) "0")))
(assert (= d4 (ite (>= nDigits 5) (str.at cl_digits 4) "0")))

; Map digit chars to numeric values (0..9)
(declare-const v0 Int)
(declare-const v1 Int)
(declare-const v2 Int)
(declare-const v3 Int)
(declare-const v4 Int)
(assert (or (and (= d0 "0") (= v0 0)) (and (= d0 "1") (= v0 1)) (and (= d0 "2") (= v0 2)) (and (= d0 "3") (= v0 3)) (and (= d0 "4") (= v0 4)) (and (= d0 "5") (= v0 5)) (and (= d0 "6") (= v0 6)) (and (= d0 "7") (= v0 7)) (and (= d0 "8") (= v0 8)) (and (= d0 "9") (= v0 9))))
(assert (or (and (= d1 "0") (= v1 0)) (and (= d1 "1") (= v1 1)) (and (= d1 "2") (= v1 2)) (and (= d1 "3") (= v1 3)) (and (= d1 "4") (= v1 4)) (and (= d1 "5") (= v1 5)) (and (= d1 "6") (= v1 6)) (and (= d1 "7") (= v1 7)) (and (= d1 "8") (= v1 8)) (and (= d1 "9") (= v1 9))))
(assert (or (and (= d2 "0") (= v2 0)) (and (= d2 "1") (= v2 1)) (and (= d2 "2") (= v2 2)) (and (= d2 "3") (= v2 3)) (and (= d2 "4") (= v2 4)) (and (= d2 "5") (= v2 5)) (and (= d2 "6") (= v2 6)) (and (= d2 "7") (= v2 7)) (and (= d2 "8") (= v2 8)) (and (= d2 "9") (= v2 9))))
(assert (or (and (= d3 "0") (= v3 0)) (and (= d3 "1") (= v3 1)) (and (= d3 "2") (= v3 2)) (and (= d3 "3") (= v3 3)) (and (= d3 "4") (= v3 4)) (and (= d3 "5") (= v3 5)) (and (= d3 "6") (= v3 6)) (and (= d3 "7") (= v3 7)) (and (= d3 "8") (= v3 8)) (and (= d3 "9") (= v3 9))))
(assert (or (and (= d4 "0") (= v4 0)) (and (= d4 "1") (= v4 1)) (and (= d4 "2") (= v4 2)) (and (= d4 "3") (= v4 3)) (and (= d4 "4") (= v4 4)) (and (= d4 "5") (= v4 5)) (and (= d4 "6") (= v4 6)) (and (= d4 "7") (= v4 7)) (and (= d4 "8") (= v4 8)) (and (= d4 "9") (= v4 9))))

; Compute integer with left-aligned digits depending on nDigits
(assert (= content_length
  (ite (= nDigits 1)
       v0
  (ite (= nDigits 2)
       (+ (* v0 10) v1)
  (ite (= nDigits 3)
       (+ (* v0 100) (* v1 10) v2)
  (ite (= nDigits 4)
       (+ (* v0 1000) (* v1 100) (* v2 10) v3)
       (+ (* v0 10000) (* v1 1000) (* v2 100) (* v3 10) v4)))))))

; Validate Content-Length equals actual body length
(assert (= content_length (str.len body)))
(assert (>= content_length 0))

; X-Payload should include the seed literal as a substring (after leading space)
(declare-const xp_payload String)
(assert (= xp_payload (str.substr xp_value 1 (- (str.len xp_value) 1))))
(assert (str.contains xp_payload literal_9))

; Mutated seed regex: require the payload to contain "<div" (SAT-friendly) and forbid "\\<SCRIPT"
(assert (str.in_re xp_payload (re.++ (re.* re.allchar) (str.to_re "<div") (re.* re.allchar))))
(assert (not (str.in_re xp_payload (re.++ (re.* re.allchar) (str.to_re "\\<SCRIPT") (re.* re.allchar)))))

; Basic request line shape: must start with GET and contain HTTP/1.1
(assert (str.prefixof "GET " request_line))
(assert (str.contains request_line " HTTP/1.1"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
