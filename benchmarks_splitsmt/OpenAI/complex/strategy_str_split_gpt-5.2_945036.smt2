(set-logic ALL)

; Uninterpreted interface for split operations (str_split)

; Core variables for HTTP header parsing
(declare-const req String)
(declare-const request_line String)
(declare-const headers_blob String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const tmp String)
(declare-const content_length Int)
(declare-const body_len Int)

; Preserve core structure from seed: a regex inequality-shaped constraint over a string
(declare-const x String)
(assert
  (let ((_let_0 (re.* re.allchar)))
    (not
      (= (str.in_re x (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" (str.++ "B" "A"))) _let_0 (str.to_re "A") _let_0))
         (str.in_re x (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" "B")) _let_0 (str.to_re (str.++ "A" "A")) _let_0))))))

; HTTP request must have a header/body separator
(assert (str.contains req "\r\n\r\n"))
(assert (= request_line (str.split_at req "\r\n" 0)))
(assert (= headers_blob (str.split_rest req "\r\n" 1)))

; First line should look like "GET ... HTTP/1.1"
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET "))

; Headers portion still contains the blank line separator; body follows it
(assert (= tmp (str.split_rest headers_blob "\r\n\r\n" 1)))
(assert (= body tmp))

; Ensure at least Host and Content-Length headers exist (in some order, as lines)
(assert (>= (str.num_splits req "\r\n") 4))
(assert (str.contains req "Host:"))
(assert (str.contains req "Content-Length:"))

; Parse Host line with split_at around ':'
; We constrain host_line to be a line containing "Host:".
(assert (str.contains host_line "Host:"))
(assert (= host_key (str.split_at host_line ":" 0)))
(assert (= host_value (str.split_rest host_line ":" 1)))
(assert (= host_key "Host"))
; typical formatting: optional leading space in value, but host value must be non-empty
(assert (> (str.len host_value) 0))

; Parse Content-Length line
(assert (str.contains cl_line "Content-Length:"))
(assert (= cl_key (str.split_at cl_line ":" 0)))
(assert (= cl_value (str.split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Content-Length value must be digits (allow leading spaces)
(assert (str.in_re cl_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Link integer content_length to cl_value via numeric-string roundtrip
(assert (= cl_value (str.++ " " (str.from_int content_length))))
(assert (>= content_length 0))

; Body length must match content-length
(assert (= body_len (str.len body)))
(assert (= body_len content_length))

; Additional header well-formedness: every header line must contain ':'
(assert (>= (str.num_splits headers_blob "\r\n") 2))
(assert (str.contains host_line ":"))
(assert (str.contains cl_line ":"))

; Tie the declared header lines to actual segments of the request to avoid free floating lines
(assert (= host_line (str.split_at req "\r\n" 1)))
(assert (= cl_line (str.split_at req "\r\n" 2)))

; Keep request line distinct from headers
(assert (not (= request_line host_line)))
(assert (not (= request_line cl_line)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
