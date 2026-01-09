(set-logic ALL)

; Uninterpreted interface for str_split
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

; ========= SAT instance: plausible HTTP header parsing =========
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const content_length_line_sat String)
(declare-const content_length_value_sat String)
(declare-const host_line_sat String)
(declare-const host_value_sat String)
(declare-const user_agent_line_sat String)
(declare-const user_agent_value_sat String)
(declare-const body_sat String)
(declare-const clen_sat Int)

; Request splits into headers and body by double newline
(assert (>= (num_splits req_sat "\r\n\r\n") 2))
(assert (= headers_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_rest req_sat "\r\n\r\n" 1)))

; Headers have at least request-line + 3 header lines
(assert (>= (num_splits headers_sat "\r\n") 4))

; Select specific header lines by index
(assert (= content_length_line_sat (split_at headers_sat "\r\n" 1)))
(assert (= host_line_sat (split_at headers_sat "\r\n" 2)))
(assert (= user_agent_line_sat (split_at headers_sat "\r\n" 3)))

; Each chosen header line must contain a colon
(assert (>= (num_splits content_length_line_sat ":") 2))
(assert (>= (num_splits host_line_sat ":") 2))
(assert (>= (num_splits user_agent_line_sat ":") 2))

; Enforce header keys exactly (no trimming modeled; space is part of value if present)
(assert (= (split_at content_length_line_sat ":" 0) "Content-Length"))
(assert (= (split_at host_line_sat ":" 0) "Host"))
(assert (= (split_at user_agent_line_sat ":" 0) "User-Agent"))

; Extract values as the remainder after the first colon
(assert (= content_length_value_sat (split_rest content_length_line_sat ":" 1)))
(assert (= host_value_sat (split_rest host_line_sat ":" 1)))
(assert (= user_agent_value_sat (split_rest user_agent_line_sat ":" 1)))

; Concrete values for a satisfiable example
(assert (= host_value_sat " example.com"))
(assert (= user_agent_value_sat " curl/8.0"))
(assert (= content_length_value_sat " 5"))

; Validate content-length: body length matches declared length (treating value as " 5")
(assert (= clen_sat 5))
(assert (= (str.len body_sat) clen_sat))

; Provide a concrete request consistent with the above constraints
(assert (= req_sat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Content-Length: 5\r\n"
    "Host: example.com\r\n"
    "User-Agent: curl/8.0\r\n"
    "\r\n"
    "abcde")))

; ========= UNSAT instance: conflicting content-length =========
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const content_length_line_unsat String)
(declare-const content_length_value_unsat String)
(declare-const clen_unsat Int)

(assert (>= (num_splits req_unsat "\r\n\r\n") 2))
(assert (= headers_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_rest req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits headers_unsat "\r\n") 2))
(assert (= content_length_line_unsat (split_at headers_unsat "\r\n" 1)))
(assert (>= (num_splits content_length_line_unsat ":") 2))
(assert (= (split_at content_length_line_unsat ":" 0) "Content-Length"))
(assert (= content_length_value_unsat (split_rest content_length_line_unsat ":" 1)))

; Fix a request whose body has length 4
(assert (= req_unsat
  (str.++
    "POST /x HTTP/1.1\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "DATA")))

; Force declared content-length as 5 while body is 4 => UNSAT
(assert (= clen_unsat 5))
(assert (= content_length_value_unsat " 5"))
(assert (= (str.len body_unsat) 4))
(assert (= (str.len body_unsat) clen_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
