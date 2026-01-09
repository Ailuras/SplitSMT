(set-logic ALL)

; HTTP Header Parsing scenario: extract key-value pairs split by newlines and colon-space

; Uninterpreted split interface

; Input request headers blob
(declare-const X String)

; Derived lines and fields
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const cl_len Int)
(declare-const body String)
(declare-const header_blob String)

; Core structure preserved/mutated from seed: keep the two negative regex constraints (slightly generalized)
(assert (not (str.in_re X (re.++ (str.to_re "search2.ad.shopnav.com/9899/search/results.php") (re.* re.allchar) (str.to_re "Logger") (re.* re.allchar) (str.to_re "Subject:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Host:Host:\u{a}")))))
(assert (not (str.in_re X (str.to_re "forum=From:comTencentTravelerBackAtTaCkExplorer\u{a}"))))

; Basic HTTP header shape: request line + headers + empty line + body
(assert (>= (str.num_splits X "\u{a}") 5))
(assert (= request_line (str.split_at X "\u{a}" 0)))
(assert (= host_line (str.split_at X "\u{a}" 1)))
(assert (= cl_line (str.split_at X "\u{a}" 2)))
(assert (= body (str.split_rest X "\u{a}" 4)))
(assert (= header_blob (str.split_rest X "\u{a}" 1)))

; Request line should begin with a method token and contain HTTP version marker
(assert (str.contains request_line "HTTP/1."))
(assert (or (str.contains request_line "GET ") (str.contains request_line "POST ") (str.contains request_line "HEAD ")))

; Parse Host header: "Host: " + value
(assert (= (str.split_at host_line ": " 0) "Host"))
(assert (>= (str.num_splits host_line ": ") 2))
(assert (= host_value (str.split_at host_line ": " 1)))
(assert (>= (str.len host_value) 1))
(assert (not (str.contains host_value " ")))
(assert (not (str.contains host_value "\u{a}")))

; Parse Content-Length header: "Content-Length: " + digits
(assert (= (str.split_at cl_line ": " 0) "Content-Length"))
(assert (>= (str.num_splits cl_line ": ") 2))
(assert (= cl_value (str.split_at cl_line ": " 1)))
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Content-length numeric consistency (string length in bytes/characters)
(assert (= cl_len (str.to_int cl_value)))
(assert (>= cl_len 0))
(assert (= cl_len (str.len body)))

; Additional constraints: ensure there is a blank line separating headers from body
(assert (= (str.split_at X "\u{a}" 3) ""))

; SAT branch: at least one extra header after Content-Length (not necessarily parsed)
(assert (>= (str.num_splits header_blob "\u{a}") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
