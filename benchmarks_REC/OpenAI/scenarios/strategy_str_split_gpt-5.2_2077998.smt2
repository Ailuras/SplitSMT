(set-logic ALL)
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

; Uninterpreted split interface for string splitting

; Additional helper: parse an integer from a string (uninterpreted)
(declare-fun parse_int (String) Int)

; ===== SAT instance: consistent HTTP header parsing =====
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_int_sat Int)
(declare-const request_line_sat String)
(declare-const method_sat String)
(declare-const path_sat String)
(declare-const version_sat String)

; Request is headers + blank line + body
(assert (= req_sat (str.++ headers_sat "\r\n\r\n" body_sat)))

; At least request-line plus two header lines
(assert (>= (num_splits headers_sat "\r\n") 3))

; Split header block into lines
(assert (= request_line_sat (split_at headers_sat "\r\n" 0)))
(assert (= host_line_sat (split_at headers_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at headers_sat "\r\n" 2)))

; Parse request line: "METHOD SP PATH SP VERSION"
(assert (= method_sat (split_at request_line_sat " " 0)))
(assert (= path_sat (split_at request_line_sat " " 1)))
(assert (= version_sat (split_at request_line_sat " " 2)))
(assert (= method_sat "POST"))
(assert (str.prefixof "/" path_sat))
(assert (str.prefixof "HTTP/1.1" version_sat))

; Parse Host header: "Host: value"
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
; Enforce a space after colon (common formatting)
(assert (str.prefixof " " host_val_sat))
; Require non-empty host value after trimming the leading space (approximate)
(assert (>= (str.len host_val_sat) 2))

; Parse Content-Length header: "Content-Length: N"
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (str.prefixof " " cl_val_sat))
(assert (>= (str.len cl_val_sat) 2))

; Validate content-length matches actual body length
(assert (= cl_int_sat (parse_int cl_val_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Provide concrete structure to ensure satisfiable
(assert (= body_sat "hello"))
(assert (= host_val_sat " example.com"))
; cl_val includes a leading space
(assert (= cl_val_sat " 5"))


; ===== UNSAT instance: inconsistent content-length =====
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)
(declare-const host_line_unsat String)
(declare-const request_line_unsat String)
(declare-const method_unsat String)
(declare-const path_unsat String)
(declare-const version_unsat String)

(assert (= req_unsat (str.++ headers_unsat "\r\n\r\n" body_unsat)))
(assert (>= (num_splits headers_unsat "\r\n") 3))
(assert (= request_line_unsat (split_at headers_unsat "\r\n" 0)))
(assert (= host_line_unsat (split_at headers_unsat "\r\n" 1)))
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 2)))

(assert (= method_unsat (split_at request_line_unsat " " 0)))
(assert (= path_unsat (split_at request_line_unsat " " 1)))
(assert (= version_unsat (split_at request_line_unsat " " 2)))
(assert (= method_unsat "POST"))
(assert (str.prefixof "/" path_unsat))
(assert (str.prefixof "HTTP/1.1" version_unsat))

(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (str.prefixof " " cl_val_unsat))
(assert (= cl_int_unsat (parse_int cl_val_unsat)))
(assert (>= cl_int_unsat 0))

; Make body concrete and force mismatch with parsed content-length
(assert (= body_unsat "abc"))
(assert (= cl_val_unsat " 4"))
(assert (= cl_int_unsat (str.len body_unsat)))

; The two previous assertions imply 4 = 3, hence UNSAT



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
