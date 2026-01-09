(set-logic ALL)

; Uninterpreted split interface
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

; Shared constants
(declare-const CRLF String)
(assert (= CRLF "\r\n"))

; -----------------------------
; SAT instance: well-formed header parsing
; -----------------------------
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const request_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_sat String)
(declare-const content_length_sat Int)
(declare-const body_sat String)
(declare-const total_len_sat Int)

; Request line and header block split by CRLF
(assert (>= (num_splits req_sat CRLF) 5))
(assert (= request_line_sat (split_at req_sat CRLF 0)))
(assert (= host_line_sat (split_at req_sat CRLF 1)))
(assert (= cl_line_sat (split_at req_sat CRLF 2)))
(assert (= ua_line_sat (split_at req_sat CRLF 3)))

; Ensure the 4th segment is the empty line separating headers and body
(assert (= (split_at req_sat CRLF 4) ""))

; Body is the remainder after the blank line
(assert (= body_sat (split_rest req_sat CRLF 5)))

; Request line structure (simple validation)
(assert (str.prefixof "POST " request_line_sat))
(assert (str.contains request_line_sat " HTTP/1.1"))

; Host header: "Host: <value>" and must contain a value
(assert (str.prefixof "Host: " host_line_sat))
(assert (> (str.len host_line_sat) (str.len "Host: ")))

; User-Agent header: "User-Agent: <value>" (optional-like but present here)
(assert (str.prefixof "User-Agent: " ua_line_sat))
(assert (> (str.len ua_line_sat) (str.len "User-Agent: ")))

; Content-Length header parsing using colon delimiter
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_value_sat (split_at cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))

; Value should start with a space and then digits (we constrain with a regex)
(assert (str.prefixof " " cl_value_sat))
(declare-const cl_value_digits_sat String)
(assert (= cl_value_digits_sat (str.substr cl_value_sat 1 (- (str.len cl_value_sat) 1))))
(assert (str.in_re cl_value_digits_sat (re.+ (re.range "0" "9"))))

; Connect parsed digit-string to integer using concrete constraints
; For SAT instance, pick a specific consistent length, e.g., 5
(assert (= content_length_sat 5))
(assert (= cl_value_digits_sat "5"))

; Validate body length equals Content-Length
(assert (= (str.len body_sat) content_length_sat))

; Additional sanity: total request has at least headers and body
(assert (= total_len_sat (str.len req_sat)))
(assert (>= total_len_sat (+ (str.len request_line_sat) (str.len host_line_sat) (str.len cl_line_sat) (str.len ua_line_sat) (str.len body_sat))))

; Provide one concrete construction to ensure satisfiable
(assert (= req_sat (str.++
  request_line_sat CRLF
  host_line_sat CRLF
  cl_line_sat CRLF
  ua_line_sat CRLF
  "" CRLF
  body_sat)))
(assert (= request_line_sat "POST /upload HTTP/1.1"))
(assert (= host_line_sat "Host: example.com"))
(assert (= cl_line_sat "Content-Length: 5"))
(assert (= ua_line_sat "User-Agent: test-agent"))
(assert (= body_sat "abcde"))

; -----------------------------
; UNSAT instance: conflicting Content-Length constraints
; -----------------------------
(declare-const req_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_value_unsat String)
(declare-const cl_value_digits_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

(assert (>= (num_splits req_unsat CRLF) 3))
(assert (= cl_line_unsat (split_at req_unsat CRLF 1)))
(assert (= (split_at req_unsat CRLF 2) ""))
(assert (= body_unsat (split_rest req_unsat CRLF 3)))

; Parse Content-Length line
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_value_unsat (split_at cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (str.prefixof " " cl_value_unsat))
(assert (= cl_value_digits_unsat (str.substr cl_value_unsat 1 (- (str.len cl_value_unsat) 1))))
(assert (str.in_re cl_value_digits_unsat (re.+ (re.range "0" "9"))))

; Force a concrete header value "10" but an integer constraint of 9
(assert (= cl_line_unsat "Content-Length: 10"))
(assert (= cl_value_digits_unsat "10"))
(assert (= content_length_unsat 9))

; Body length must match content_length_unsat but we also force a 10-byte body
(assert (= body_unsat "0123456789"))
(assert (= (str.len body_unsat) content_length_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
