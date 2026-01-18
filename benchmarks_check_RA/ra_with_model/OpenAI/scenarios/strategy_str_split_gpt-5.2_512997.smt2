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

; Uninterpreted interface operations for string splitting

; =========================
; SAT instance: header parsing and content-length validation
; =========================
(declare-const request String)
(declare-const header_delim String)
(declare-const line_delim String)
(declare-const colon_delim String)
(declare-const request_line String)
(declare-const header_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const content_length Int)

(assert (= line_delim "\r\n"))
(assert (= colon_delim ":"))
(assert (= header_delim "\r\n\r\n"))

; Request is split into headers and body by CRLFCRLF
(assert (>= (num_splits request header_delim) 2))
(assert (= header_block (split_at request header_delim 0)))
(assert (= body (split_rest request header_delim 1)))

; Header block lines (0: request line, 1..: header fields)
(assert (>= (num_splits header_block line_delim) 3))
(assert (= request_line (split_at header_block line_delim 0)))
(assert (= host_line (split_at header_block line_delim 1)))
(assert (= cl_line (split_at header_block line_delim 2)))

; Basic request-line sanity: must contain method and path separator spaces
(assert (str.contains request_line " "))
(assert (str.contains request_line "HTTP/1.1"))

; Host header parsing: "Host: <value>"
(assert (>= (num_splits host_line colon_delim) 2))
(assert (= host_key (split_at host_line colon_delim 0)))
(assert (= host_value (split_rest host_line colon_delim 1)))
(assert (= host_key "Host"))
; allow optional leading space in value; enforce non-empty host after trimming one space optionally
(assert (or (= host_value " example.com") (= host_value "example.com")))

; Content-Length header parsing: "Content-Length: <digits>"
(assert (>= (num_splits cl_line colon_delim) 2))
(assert (= cl_key (split_at cl_line colon_delim 0)))
(assert (= cl_value (split_rest cl_line colon_delim 1)))
(assert (= cl_key "Content-Length"))

; cl_value is either " 5" or "5" and must be digits (optionally preceded by a single space)
(assert (str.in_re cl_value (re.union (str.to_re "5") (str.to_re " 5"))))
(assert (= content_length 5))

; Validate body size matches content_length (use string length)
(assert (= (str.len body) content_length))

; Constrain request to a coherent concrete shape to avoid underconstrained UF behavior
(assert (= request
  (str.++
    "GET /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "abcde")))

; =========================
; UNSAT instance: contradictory content-length vs body length
; =========================
(declare-const request_bad String)
(declare-const header_block_bad String)
(declare-const body_bad String)
(declare-const cl_line_bad String)
(declare-const cl_value_bad String)
(declare-const content_length_bad Int)

(assert (>= (num_splits request_bad header_delim) 2))
(assert (= header_block_bad (split_at request_bad header_delim 0)))
(assert (= body_bad (split_rest request_bad header_delim 1)))

(assert (>= (num_splits header_block_bad line_delim) 3))
(assert (= cl_line_bad (split_at header_block_bad line_delim 2)))

(assert (>= (num_splits cl_line_bad colon_delim) 2))
(assert (= cl_value_bad (split_rest cl_line_bad colon_delim 1)))

; Force a concrete bad request with Content-Length 4 but body length 5
(assert (= request_bad
  (str.++
    "POST /data HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 4\r\n"
    "\r\n"
    "abcde")))

(assert (str.in_re cl_value_bad (re.union (str.to_re "4") (str.to_re " 4"))))
(assert (= content_length_bad 4))
(assert (= (str.len body_bad) content_length_bad))



; [GENERATION STATUS: SUCCESS]
(assert (= request_bad "POST /data HTTP/1.1\r\nHost: example.com\r\nContent-Length: 4\r\n\r\nabcde"))
(assert (= header_delim "\r\n\r\n"))
(assert (= cl_value_bad "4"))
(assert (= content_length_bad 4))
(assert (= request "GET /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 5\r\n\r\nabcde"))
(assert (= colon_delim ":"))
(assert (= cl_line "T"))
(assert (= cl_key "Content-Length"))
(assert (= cl_value "5"))
(assert (= host_value "example.com"))
(assert (= body "MNABD"))
(assert (= body_bad "FIJK"))
(assert (= cl_line_bad "/"))
(assert (= host_line "E"))
(assert (= header_block_bad " "))
(assert (= content_length 5))
(assert (= request_line " HTTP/1.1"))
(assert (= header_block "G"))
(assert (= line_delim "\r\n"))
(assert (= host_key "Host"))
(check-sat)
(exit)
