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

; Uninterpreted interface functions for string splitting

; Auxiliary uninterpreted functions for header lookup / numeric parsing
(declare-fun header_value (String String) String) ; header_value(headers_blob, key) = value (no surrounding spaces), or "" if absent
(declare-fun parse_int (String) Int)               ; parse_int(s) interprets s as a decimal integer (implementation abstracted)
(declare-fun is_digits (String) Bool)             ; true iff s consists only of digits (no sign)

; ========= SAT instance: consistent HTTP header parsing =========
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)

(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const host_val_sat String)
(declare-const useragent_val_sat String)
(declare-const cl_int_sat Int)

; Split request into request-line, headers-block, body using \n\n boundary
(assert (= request_line_sat (split_at req_sat "\n\n" 0)))
(assert (= headers_sat (split_at req_sat "\n\n" 1)))
(assert (= body_sat (split_at req_sat "\n\n" 2)))
(assert (>= (num_splits req_sat "\n\n") 3))

; Basic HTTP request line sanity
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (str.contains request_line_sat "GET "))

; Header key/value extraction via ':' and newline-separated fields
(assert (= cl_key_sat "Content-Length"))
(assert (= cl_val_sat (header_value headers_sat cl_key_sat)))
(assert (= host_val_sat (header_value headers_sat "Host")))
(assert (= useragent_val_sat (header_value headers_sat "User-Agent")))

; Require key headers present and non-empty
(assert (not (= cl_val_sat "")))
(assert (not (= host_val_sat "")))
(assert (not (= useragent_val_sat "")))

; Validate Content-Length is digits and matches body length
(assert (is_digits cl_val_sat))
(assert (= cl_int_sat (parse_int cl_val_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Ensure there is at least one ':' in headers to reflect key-value pairs
(assert (str.contains headers_sat ":"))

; ========= UNSAT instance: contradictory Content-Length constraints =========
(declare-const req_unsat String)
(declare-const request_line_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)

(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)

(assert (= request_line_unsat (split_at req_unsat "\n\n" 0)))
(assert (= headers_unsat (split_at req_unsat "\n\n" 1)))
(assert (= body_unsat (split_at req_unsat "\n\n" 2)))
(assert (>= (num_splits req_unsat "\n\n") 3))

(assert (str.contains request_line_unsat "HTTP/1.1"))
(assert (str.contains request_line_unsat "POST "))

(assert (= cl_val_unsat (header_value headers_unsat "Content-Length")))
(assert (not (= cl_val_unsat "")))
(assert (is_digits cl_val_unsat))
(assert (= cl_int_unsat (parse_int cl_val_unsat)))
(assert (>= cl_int_unsat 0))

; Contradiction: Content-Length must equal body length and also be body length + 1
(assert (= cl_int_unsat (str.len body_unsat)))
(assert (= cl_int_unsat (+ (str.len body_unsat) 1)))

; ========= Additional mixed constraints to increase diversity =========
; Require that headers are newline-separated and contain Host and Content-Length tokens somewhere
(assert (str.contains headers_sat "\n"))
(assert (str.contains headers_sat "Host"))
(assert (str.contains headers_sat "Content-Length"))

; A weak structural constraint: first header line has a ':' (using split_at with newline)
(declare-const first_header_line_sat String)
(assert (= first_header_line_sat (split_at headers_sat "\n" 0)))
(assert (str.contains first_header_line_sat ":"))

; Index bounds-style constraints for split_at usage
(declare-const k0 Int)
(declare-const k1 Int)
(assert (= k0 0))
(assert (= k1 1))
(assert (>= k0 0))
(assert (>= k1 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
