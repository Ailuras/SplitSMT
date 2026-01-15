(set-logic ALL)

; Uninterpreted interface for string split operations
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

; ========== Scenario: HTTP Header Parsing (SAT instance) ==========
(declare-const request_sat String)
(declare-const headers_sat String)
(declare-const host_line_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const cl_line_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; Structure: headers and body separated by CRLFCRLF
(assert (= headers_sat (split_at request_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at request_sat "\r\n\r\n" 1)))
(assert (>= (num_splits request_sat "\r\n\r\n") 2))

; Require at least 3 header lines: request-line + Host + Content-Length
(assert (>= (num_splits headers_sat "\r\n") 3))

; Host header on line 1
(assert (= host_line_sat (split_at headers_sat "\r\n" 1)))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_value_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_value_sat " example.com"))

; Content-Length header on line 2
(assert (= cl_line_sat (split_at headers_sat "\r\n" 2)))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_value_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (>= (num_splits cl_line_sat ":") 2))

; Validate that Content-Length value is a decimal integer and matches body length
(assert (str.in_re cl_value_sat (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))
(assert (= content_length_sat (str.to_int (str.substr cl_value_sat 1 (- (str.len cl_value_sat) 1)))))
(assert (>= content_length_sat 0))
(assert (= content_length_sat (str.len body_sat)))

; Concrete satisfiable request consistent with the parsing constraints
(assert (= request_sat (str.++
  "GET /upload HTTP/1.1\r\n"
  "Host: example.com\r\n"
  "Content-Length: 5\r\n"
  "\r\n"
  "hello")))

; ========== Scenario: HTTP Header Parsing (UNSAT instance) ==========
(declare-const request_unsat String)
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

(assert (= headers_unsat (split_at request_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at request_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits request_unsat "\r\n\r\n") 2))

; Force Content-Length to be present and numeric
(assert (>= (num_splits headers_unsat "\r\n") 2))
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= (split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_value_unsat (split_rest cl_line_unsat ":" 1)))
(assert (str.in_re cl_value_unsat (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))
(assert (= content_length_unsat (str.to_int (str.substr cl_value_unsat 1 (- (str.len cl_value_unsat) 1)))))
(assert (>= content_length_unsat 0))

; Content-Length must equal body length (but we will contradict it with a concrete request)
(assert (= content_length_unsat (str.len body_unsat)))

; Concrete request with mismatching Content-Length (declares 4, body length is 5) => UNSAT
(assert (= request_unsat (str.++
  "POST /data HTTP/1.1\r\n"
  "Content-Length: 4\r\n"
  "\r\n"
  "abcde")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
