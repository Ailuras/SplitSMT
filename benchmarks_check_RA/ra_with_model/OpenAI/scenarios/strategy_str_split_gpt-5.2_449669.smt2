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

; Uninterpreted split interface (str_split)

; HTTP header parsing scenario
(declare-const request String)
(declare-const headers_block String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const cl_int Int)

; --- Basic shape: request-line + CRLF + headers + CRLFCRLF + body
(assert (= request_line (split_at request "\r\n" 0)))
(assert (= headers_block (split_rest request "\r\n" 1)))
(assert (>= (num_splits request "\r\n") 3))

; Ensure there is an empty line separator: some header line is empty (""), i.e., CRLFCRLF occurs.
; Model this by forcing one of the early lines to be empty.
(assert (= (split_at request "\r\n" 3) ""))

; Host and Content-Length lines appear in fixed positions for this scenario
(assert (= host_line (split_at request "\r\n" 1)))
(assert (= content_length_line (split_at request "\r\n" 2)))

; Split header lines by ":" into key/value
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_at host_line ":" 1)))
(assert (>= (num_splits host_line ":") 2))

(assert (= cl_key (split_at content_length_line ":" 0)))
(assert (= cl_value (split_at content_length_line ":" 1)))
(assert (>= (num_splits content_length_line ":") 2))

; Expected header keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value: require it contains a dot and is non-empty (after colon)
(assert (> (str.len host_value) 0))
(assert (str.contains host_value "."))

; Content-Length value: constrain to be decimal digits (allow optional leading spaces)
(assert (str.in_re cl_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Define numeric content length and basic bounds
(assert (>= cl_int 0))
(assert (<= cl_int 4096))

; Link body length to content length (abstracting body extraction)
; Body is everything after the empty line; for this fixed-position template, body starts at line index 4.
(assert (= body (split_rest request "\r\n" 4)))
(assert (= (str.len body) cl_int))

; Additional sanity: request-line looks like "METHOD SP PATH SP HTTP/1.1"
(declare-const method String)
(declare-const path String)
(declare-const version String)
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))
(assert (or (= method "GET") (= method "POST")))
(assert (str.in_re path (re.++ (str.to_re "/") (re.* re.allchar))))
(assert (= version "HTTP/1.1"))

; -----------------------------------------------------------------------------
; SAT instance: consistent header parsing and content-length/body
; -----------------------------------------------------------------------------
(assert (= request_line "POST /submit HTTP/1.1"))
(assert (= host_line "Host:example.com"))
(assert (= content_length_line "Content-Length:5"))
(assert (= body "abcde"))
(assert (= cl_int 5))
(assert (= request "\r\n"))
(assert (= headers_block "abcde"))
(assert (= host_value "."))
(assert (= body "abcde"))
(assert (= content_length_line "Content-Length:5"))
(assert (= method "GET"))
(assert (= path "/"))
(assert (= host_line "Host:example.com"))
(assert (= version "HTTP/1.1"))
(assert (= request_line "POST /submit HTTP/1.1"))
(assert (= cl_key "Content-Length"))
(assert (= cl_value "0"))
(assert (= cl_int 5))
(assert (= host_key "Host"))
(check-sat)
(exit)
