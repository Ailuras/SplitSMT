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

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
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

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))

; Uninterpreted interface for string split operations

; Core HTTP request/header variables
(declare-const raw_request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const method String)
(declare-const uri String)
(declare-const http_version String)

(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)

(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value_str String)
(declare-const cl_value_int Int)

(declare-const body String)
(declare-const computed_body_len Int)

; Auxiliary strings
(declare-const crlf String)
(declare-const colon String)
(declare-const empty String)

(assert (= crlf "\r\n"))
(assert (= colon ":"))
(assert (= empty ""))

; Split request into header block and body using CRLFCRLF
(assert (= header_block (split_at raw_request (str.++ crlf crlf) 0)))
(assert (= body (split_at raw_request (str.++ crlf crlf) 1)))
(assert (>= (num_splits raw_request (str.++ crlf crlf)) 2))

; First line is request-line
(assert (= request_line (split_at header_block crlf 0)))
(assert (>= (num_splits header_block crlf) 2))

; Parse request-line: "METHOD SP URI SP HTTP/VERSION"
(assert (= method (split_at request_line " " 0)))
(assert (= uri (split_at request_line " " 1)))
(assert (= http_version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))

; Basic validation for method and http version
(assert (or (= method "GET") (= method "POST") (= method "PUT") (= method "HEAD")))
(assert (or (= http_version "HTTP/1.0") (= http_version "HTTP/1.1")))

; Extract Host header line as the second line (common case)
(assert (= host_line (split_at header_block crlf 1)))
(assert (= host_key (split_at host_line colon 0)))
(assert (= host_value (split_at host_line colon 1)))
(assert (>= (num_splits host_line colon) 2))

; Host header checks
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; Extract Content-Length header line as third line (common case)
(assert (= cl_line (split_at header_block crlf 2)))
(assert (= cl_key (split_at cl_line colon 0)))
(assert (= cl_value_str (split_at cl_line colon 1)))
(assert (>= (num_splits cl_line colon) 2))

; Content-Length header checks
(assert (= cl_key "Content-Length"))
(assert (> (str.len cl_value_str) 0))
(assert (not (str.contains cl_value_str "\r")))
(assert (not (str.contains cl_value_str "\n")))

; Constrain Content-Length to be a non-negative integer and equal to the body length
(assert (>= cl_value_int 0))
(assert (= computed_body_len (str.len body)))
(assert (= cl_value_int computed_body_len))

; Ensure header ordering and newline presence
(assert (str.contains header_block crlf))
(assert (str.contains raw_request (str.++ crlf crlf)))

; ----- SAT instance: a well-formed request -----
(declare-const sat_request String)
(declare-const sat_body String)
(declare-const sat_header String)
(declare-const sat_host String)

(assert (= sat_body "HELLO"))
(assert (= sat_host " example.com"))
(assert (= sat_header (str.++
  "POST /submit HTTP/1.1" crlf
  "Host:" sat_host crlf
  "Content-Length: 5" crlf
  crlf)))
(assert (= sat_request (str.++ sat_header sat_body)))

; Tie the core variables to the SAT instance
(assert (= raw_request sat_request))

; ----- UNSAT instance: conflicting Content-Length vs actual body length -----
; We create an additional request that must simultaneously satisfy a contradictory length requirement.
(declare-const raw_request_bad String)
(declare-const header_block_bad String)
(declare-const body_bad String)
(declare-const cl_value_int_bad Int)
(declare-const computed_body_len_bad Int)

(assert (= header_block_bad (split_at raw_request_bad (str.++ crlf crlf) 0)))
(assert (= body_bad (split_at raw_request_bad (str.++ crlf crlf) 1)))
(assert (>= (num_splits raw_request_bad (str.++ crlf crlf)) 2))
(assert (= computed_body_len_bad (str.len body_bad)))

; Force a concrete body of length 4 but also force the declared Content-Length int to be 5
(assert (= body_bad "DATA"))
(assert (= cl_value_int_bad 5))
(assert (= computed_body_len_bad 4))

; Additionally require these two to be equal (contradiction)
(assert (= cl_value_int_bad computed_body_len_bad))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
