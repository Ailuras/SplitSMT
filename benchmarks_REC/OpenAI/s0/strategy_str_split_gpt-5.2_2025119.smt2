(set-logic ALL)

; Uninterpreted interface for string split constraints
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

; Uninterpreted helpers for header parsing
(declare-fun header_value (String String) String) ; header_value(headers, key) -> value string
(declare-fun header_present (String String) Bool)  ; header_present(headers, key)
(declare-fun to_int (String) Int)                  ; parse decimal integer from string
(declare-fun is_digits (String) Bool)              ; whether string is non-empty digits
(declare-fun body_of (String) String)              ; extract message body from full request

; ======== SAT instance: well-formed HTTP header parsing ========
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const cl_val_sat String)
(declare-const host_val_sat String)
(declare-const first_line_sat String)
(declare-const method_sat String)
(declare-const path_sat String)
(declare-const version_sat String)
(declare-const reconstructed_sat String)

; Basic structure: headers and body separated by CRLFCRLF
(assert (= headers_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at req_sat "\r\n\r\n" 1)))
(assert (= body_sat (body_of req_sat)))
(assert (= reconstructed_sat (str.++ headers_sat "\r\n\r\n" body_sat)))
(assert (= req_sat reconstructed_sat))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; Parse request line: METHOD SP PATH SP HTTP/VERSION
(assert (= first_line_sat (split_at headers_sat "\r\n" 0)))
(assert (>= (num_splits headers_sat "\r\n") 2))
(assert (= method_sat (split_at first_line_sat " " 0)))
(assert (= path_sat (split_at first_line_sat " " 1)))
(assert (= version_sat (split_at first_line_sat " " 2)))
(assert (>= (num_splits first_line_sat " ") 3))
(assert (= method_sat "POST"))
(assert (str.in_re version_sat (str.to_re "HTTP/1.1")))
(assert (str.prefixof "/" path_sat))

; Header presence and values (uninterpreted mapping constraints + split-based shaping)
(assert (header_present headers_sat "Host"))
(assert (header_present headers_sat "Content-Length"))
(assert (= host_val_sat (header_value headers_sat "Host")))
(assert (= cl_val_sat (header_value headers_sat "Content-Length")))

; Shape the Host header line as "Host: <value>" somewhere in headers
(declare-const host_line_sat String)
(assert (= host_line_sat (str.++ "Host:" " " host_val_sat)))
(assert (str.contains headers_sat (str.++ host_line_sat "\r\n")))
(assert (>= (str.len host_val_sat) 1))

; Shape the Content-Length header line as "Content-Length: <digits>"
(declare-const cl_line_sat String)
(assert (= cl_line_sat (str.++ "Content-Length:" " " cl_val_sat)))
(assert (str.contains headers_sat (str.++ cl_line_sat "\r\n")))
(assert (is_digits cl_val_sat))
(assert (>= (str.len cl_val_sat) 1))

; Validate Content-Length matches body length
(assert (= (to_int cl_val_sat) (str.len body_sat)))
(assert (>= (to_int cl_val_sat) 0))

; Concrete satisfiable construction with consistency
(assert (= host_val_sat "example.com"))
(assert (= body_sat "ABCDE"))
(assert (= cl_val_sat "5"))
(assert (= headers_sat (str.++ "POST /upload HTTP/1.1\r\n"
                              "Host: example.com\r\n"
                              "Content-Length: 5\r\n"
                              "User-Agent: test\r\n")))
(assert (= req_sat (str.++ headers_sat "\r\n\r\n" body_sat)))

; Additional split constraints using ':' for key-value pairs (structural, relaxed)
(declare-const cl_kv_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_with_space_sat String)
(assert (= cl_kv_sat cl_line_sat))
(assert (= cl_key_sat (split_at cl_kv_sat ":" 0)))
(assert (= cl_value_with_space_sat (split_at cl_kv_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (str.prefixof " " cl_value_with_space_sat))

; Check satisfiable instance
(check-sat)

; ======== UNSAT instance: contradictory Content-Length ========
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_val_unsat String)
(declare-const reconstructed_unsat String)

(assert (= headers_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at req_unsat "\r\n\r\n" 1)))
(assert (= reconstructed_unsat (str.++ headers_unsat "\r\n\r\n" body_unsat)))
(assert (= req_unsat reconstructed_unsat))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

; Must contain Content-Length header, digits, and must match body length
(assert (header_present headers_unsat "Content-Length"))
(assert (= cl_val_unsat (header_value headers_unsat "Content-Length")))
(assert (is_digits cl_val_unsat))
(assert (= (to_int cl_val_unsat) (str.len body_unsat)))

; Concrete conflicting assignments: header says 3 but body length is 5
(assert (= body_unsat "HELLO"))
(assert (= cl_val_unsat "3"))
(assert (str.contains headers_unsat (str.++ "Content-Length: 3\r\n")))
(assert (= headers_unsat (str.++ "POST /x HTTP/1.1\r\n"
                                "Host: a\r\n"
                                "Content-Length: 3\r\n")))
(assert (= req_unsat (str.++ headers_unsat "\r\n\r\n" body_unsat)))

; Check unsatisfiable instance
(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)
