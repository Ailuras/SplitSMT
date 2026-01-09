(set-logic ALL)

; Uninterpreted interface for str_split
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

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

; Additional uninterpreted helpers for header processing
(declare-fun trim (String) String)
(declare-fun to_lower (String) String)
(declare-fun str_to_int (String) Int)
(declare-fun is_digits (String) Bool)
(declare-fun header_value (String String) String)

; Core HTTP request/header strings
(declare-const req String)
(declare-const header_block String)
(declare-const body String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const http_version String)

; Derived header lines
(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)

; Parsed key/value for specific headers
(declare-const host_line String)
(declare-const host_key String)
(declare-const host_val String)

(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_val_raw String)
(declare-const cl_val String)
(declare-const content_length Int)

; Another header to add diversity
(declare-const ua_line String)
(declare-const ua_key String)
(declare-const ua_val String)

; General sanity constraints
(assert (>= (str.len req) 0))
(assert (>= (str.len header_block) 0))
(assert (>= (str.len body) 0))

; Model a request as: request_line \r\n header_block \r\n\r\n body
(assert (= req (str.++ request_line "\r\n" header_block "\r\n\r\n" body)))

; Parse request line by spaces: METHOD SP PATH SP HTTP/VERSION
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= http_version (split_at request_line " " 2)))

; HTTP version basic shape constraint
(assert (str.contains http_version "HTTP/"))

; Header block split by CRLF into lines
(assert (>= (num_splits header_block "\r\n") 4))
(assert (= line0 (split_at header_block "\r\n" 0)))
(assert (= line1 (split_at header_block "\r\n" 1)))
(assert (= line2 (split_at header_block "\r\n" 2)))
(assert (= line3 (split_at header_block "\r\n" 3)))

; Require each header line to contain a colon separating key/value
(assert (str.contains line0 ":"))
(assert (str.contains line1 ":"))
(assert (str.contains line2 ":"))
(assert (str.contains line3 ":"))

; Choose particular lines to be Host, Content-Length, and User-Agent
(assert (= host_line line0))
(assert (= cl_line line1))
(assert (= ua_line line2))

; Parse Host line: key:value
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (trim (split_rest host_line ":" 1))))
(assert (= (to_lower (trim host_key)) "host"))
(assert (> (str.len host_val) 0))

; Parse Content-Length line: key:value
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_val_raw (split_rest cl_line ":" 1)))
(assert (= cl_val (trim cl_val_raw)))
(assert (= (to_lower (trim cl_key)) "content-length"))

; Validate Content-Length: digits-only, non-negative, matches body length
(assert (is_digits cl_val))
(assert (= content_length (str_to_int cl_val)))
(assert (>= content_length 0))
(assert (= content_length (str.len body)))

; Parse User-Agent line for additional variety
(assert (>= (num_splits ua_line ":") 2))
(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_val (trim (split_rest ua_line ":" 1))))
(assert (= (to_lower (trim ua_key)) "user-agent"))
(assert (> (str.len ua_val) 0))

; Provide a concrete SAT instance
(assert (= method "POST"))
(assert (= path "/upload"))
(assert (= http_version "HTTP/1.1"))

; Concrete headers/body; rely on split/trim/to_lower/is_digits/str_to_int consistency via constraints above
(assert (= host_line "Host: example.com"))
(assert (= ua_line "User-Agent: TestClient/1.0"))
(assert (= body "abcd"))
(assert (= cl_line "Content-Length: 4"))

; Ensure the unused line3 is some other well-formed header
(assert (= line3 "X-Trace: 9f3a"))

(check-sat)

; --- UNSAT instance: same structure but contradictory content-length ---

; Re-fix the request structure but force a conflicting Content-Length vs body
(assert (= method "POST"))
(assert (= path "/upload"))
(assert (= http_version "HTTP/1.1"))

(assert (= host_line "Host: example.com"))
(assert (= ua_line "User-Agent: TestClient/1.0"))
(assert (= body "abcd"))

; Contradiction: header says 5 but body length is 4
(assert (= cl_line "Content-Length: 5"))

(check-sat)
(exit)
