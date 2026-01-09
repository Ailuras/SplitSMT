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

; =====================
; SAT instance: well-formed HTTP header parsing
; =====================
(declare-const req String)
(declare-const request_line String)
(declare-const headers_blob String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const content_length Int)
(declare-const body String)
(declare-const cl_digits_re RegLan)

; Concrete request (typical request-line + headers + empty line + body)
(assert (= req
  (str.++
    "GET /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "User-Agent: UA\r\n"
    "\r\n"
    "HELLO")))

; Split request into lines
(assert (>= (num_splits req "\r\n") 5))
(assert (= request_line (split_at req "\r\n" 0)))
(assert (= host_line    (split_at req "\r\n" 1)))
(assert (= cl_line      (split_at req "\r\n" 2)))
(assert (= ua_line      (split_at req "\r\n" 3)))
(assert (= body         (split_rest req "\r\n\r\n" 1)))

; Basic request line validation
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET "))

; Parse header key/value via ':' delimiter
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))
(assert (>= (num_splits ua_line ":") 2))

(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (split_rest host_line ":" 1)))
(assert (= cl_key   (split_at cl_line ":" 0)))
(assert (= cl_val   (split_rest cl_line ":" 1)))
(assert (= ua_key   (split_at ua_line ":" 0)))
(assert (= ua_val   (split_rest ua_line ":" 1)))

; Header name constraints
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Minimal value constraints (allow leading space after ':')
(assert (str.contains host_val "example.com"))
(assert (str.contains ua_val "UA"))

; Content-Length must be digits with optional leading space
(assert (= cl_digits_re (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))
(assert (str.in_re cl_val cl_digits_re))

; Check the content-length matches body length for this concrete request
(assert (= content_length 5))
(assert (= (str.len body) content_length))

; Additional sanity: no empty host
(assert (> (str.len host_val) 1))

(check-sat)

; =====================
; UNSAT instance: contradictory Content-Length
; =====================
(declare-const req_bad String)
(declare-const cl_line_bad String)
(declare-const cl_val_bad String)
(declare-const body_bad String)
(declare-const content_length_bad Int)

(assert (= req_bad
  (str.++
    "POST /data HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 10\r\n"
    "\r\n"
    "HELLO")))

(assert (>= (num_splits req_bad "\r\n") 4))
(assert (= cl_line_bad (split_at req_bad "\r\n" 2)))
(assert (>= (num_splits cl_line_bad ":") 2))
(assert (= cl_val_bad (split_rest cl_line_bad ":" 1)))

; Ensure it looks like a digit value with leading space
(assert (str.in_re cl_val_bad cl_digits_re))

(assert (= body_bad (split_rest req_bad "\r\n\r\n" 1)))

; Contradiction: force parsed content-length to be 10 while body length is 5
(assert (= content_length_bad 10))
(assert (= (str.len body_bad) 5))
(assert (= (str.len body_bad) content_length_bad))

(check-sat)
(exit)
