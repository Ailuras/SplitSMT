(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string splitting

; ----------------------------
; Scenario: HTTP Header Parsing
; Parse request line + headers separated by \r\n, and header fields split by ":".
; Validate Content-Length when present.
; ----------------------------

; Shared primitives
(declare-const crlf String)
(declare-const colon String)
(assert (= crlf "\r\n"))
(assert (= colon ":"))

; =====================================
; SAT instance: consistent header parsing
; =====================================
(declare-const request_ok String)
(declare-const reqline_ok String)
(declare-const header1_ok String)
(declare-const header2_ok String)
(declare-const header3_ok String)
(declare-const body_ok String)

(declare-const method_ok String)
(declare-const path_ok String)
(declare-const version_ok String)

(declare-const k1_ok String)
(declare-const v1_ok String)
(declare-const k2_ok String)
(declare-const v2_ok String)
(declare-const k3_ok String)
(declare-const v3_ok String)

(declare-const content_length_str_ok String)
(declare-const content_length_ok Int)

; Structure: request line, three headers, empty line, body
(assert (= reqline_ok (split_at request_ok crlf 0)))
(assert (= header1_ok (split_at request_ok crlf 1)))
(assert (= header2_ok (split_at request_ok crlf 2)))
(assert (= header3_ok (split_at request_ok crlf 3)))
(assert (= "" (split_at request_ok crlf 4)))
(assert (= body_ok (split_rest request_ok crlf 5)))
(assert (>= (num_splits request_ok crlf) 6))

; Request line parsing: "METHOD PATH HTTP/1.1"
(assert (= method_ok (split_at reqline_ok " " 0)))
(assert (= path_ok (split_at reqline_ok " " 1)))
(assert (= version_ok (split_at reqline_ok " " 2)))
(assert (= 3 (num_splits reqline_ok " ")))
(assert (str.in_re method_ok (re.union (str.to_re "GET") (str.to_re "POST"))))
(assert (str.prefixof "/" path_ok))
(assert (str.in_re version_ok (str.to_re "HTTP/1.1")))

; Header1: Host: example.com
(assert (= k1_ok (split_at header1_ok colon 0)))
(assert (= v1_ok (split_rest header1_ok colon 1)))
(assert (>= (num_splits header1_ok colon) 2))
(assert (= k1_ok "Host"))
(assert (str.prefixof " " v1_ok))
(assert (str.contains v1_ok "example.com"))

; Header2: Content-Length: 5
(assert (= k2_ok (split_at header2_ok colon 0)))
(assert (= v2_ok (split_rest header2_ok colon 1)))
(assert (>= (num_splits header2_ok colon) 2))
(assert (= k2_ok "Content-Length"))
(assert (str.prefixof " " v2_ok))
(assert (= content_length_str_ok (str.substr v2_ok 1 (- (str.len v2_ok) 1))))
(assert (= content_length_ok (str.to_int content_length_str_ok)))
(assert (>= content_length_ok 0))
; digits only (excluding the leading space already stripped)
(assert (str.in_re content_length_str_ok (re.+ (re.range "0" "9"))))

; Header3: Connection: close
(assert (= k3_ok (split_at header3_ok colon 0)))
(assert (= v3_ok (split_rest header3_ok colon 1)))
(assert (>= (num_splits header3_ok colon) 2))
(assert (= k3_ok "Connection"))
(assert (str.prefixof " " v3_ok))
(assert (str.contains v3_ok "close"))

; Content-Length validation against body length
(assert (= (str.len body_ok) content_length_ok))

; Make the instance concrete enough to be satisfiable
(assert (= request_ok (str.++ "POST /submit HTTP/1.1" crlf
                             "Host: example.com" crlf
                             "Content-Length: 5" crlf
                             "Connection: close" crlf
                             crlf
                             "abcde")))

; =====================================
; UNSAT instance: inconsistent Content-Length
; =====================================
(declare-const request_bad String)
(declare-const reqline_bad String)
(declare-const header_cl_bad String)
(declare-const body_bad String)

(declare-const cl_key_bad String)
(declare-const cl_val_bad String)
(declare-const cl_num_str_bad String)
(declare-const cl_num_bad Int)

(assert (= reqline_bad (split_at request_bad crlf 0)))
(assert (= header_cl_bad (split_at request_bad crlf 1)))
(assert (= "" (split_at request_bad crlf 2)))
(assert (= body_bad (split_rest request_bad crlf 3)))
(assert (>= (num_splits request_bad crlf) 4))

; Content-Length header parse
(assert (= cl_key_bad (split_at header_cl_bad colon 0)))
(assert (= cl_val_bad (split_rest header_cl_bad colon 1)))
(assert (>= (num_splits header_cl_bad colon) 2))
(assert (= cl_key_bad "Content-Length"))
(assert (str.prefixof " " cl_val_bad))
(assert (= cl_num_str_bad (str.substr cl_val_bad 1 (- (str.len cl_val_bad) 1))))
(assert (str.in_re cl_num_str_bad (re.+ (re.range "0" "9"))))
(assert (= cl_num_bad (str.to_int cl_num_str_bad)))
(assert (>= cl_num_bad 0))

; Contradiction: declared Content-Length does not match actual body length
(assert (= (str.len body_bad) cl_num_bad))
(assert (= request_bad (str.++ "GET / HTTP/1.1" crlf
                              "Content-Length: 4" crlf
                              crlf
                              "abc")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
