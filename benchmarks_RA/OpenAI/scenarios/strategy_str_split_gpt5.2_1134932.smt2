(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))

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
