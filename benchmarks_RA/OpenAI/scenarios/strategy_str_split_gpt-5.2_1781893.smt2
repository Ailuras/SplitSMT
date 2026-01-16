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

; Uninterpreted functions for str_split interface

; =====================
; SAT instance: consistent HTTP header parsing
; =====================
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const line_host_sat String)
(declare-const line_cl_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const cl_key_sat String)
(declare-const cl_value_sat String)
(declare-const cl_value_sat_int Int)
(declare-const body_sat String)

; Separate headers from body using CRLFCRLF
(assert (= headers_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_rest req_sat "\r\n\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; Extract key lines from headers
(assert (= line_host_sat (split_at headers_sat "\r\n" 1)))
(assert (= line_cl_sat (split_at headers_sat "\r\n" 2)))
(assert (>= (num_splits headers_sat "\r\n") 3))

; Parse Host line: "Host: <value>"
(assert (= host_key_sat (split_at line_host_sat ":" 0)))
(assert (= host_value_sat (split_at line_host_sat ":" 1)))
(assert (>= (num_splits line_host_sat ":") 2))
(assert (= host_key_sat "Host"))
(assert (str.contains host_value_sat "example.com"))
(assert (not (= host_value_sat "")))

; Parse Content-Length line: "Content-Length: <digits>"
(assert (= cl_key_sat (split_at line_cl_sat ":" 0)))
(assert (= cl_value_sat (split_at line_cl_sat ":" 1)))
(assert (>= (num_splits line_cl_sat ":") 2))
(assert (= cl_key_sat "Content-Length"))

; Constrain content-length value to be digits only (optionally with leading space)
(assert (str.in_re cl_value_sat (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Bind to integer and validate against actual body length
(assert (= cl_value_sat_int (str.to_int cl_value_sat)))
(assert (>= cl_value_sat_int 0))
(assert (= (str.len body_sat) cl_value_sat_int))

; Provide a concrete satisfying structure
(assert (= line_host_sat "Host: example.com"))
(assert (= line_cl_sat "Content-Length: 5"))
(assert (= body_sat "Hello"))


; =====================
; UNSAT instance: contradictory content-length
; =====================
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const line_cl_unsat String)
(declare-const cl_value_unsat String)
(declare-const body_unsat String)
(declare-const cl_value_unsat_int Int)

(assert (= headers_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_rest req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

; Assume Content-Length is on line 1 after request line
(assert (= line_cl_unsat (split_at headers_unsat "\r\n" 1)))
(assert (>= (num_splits headers_unsat "\r\n") 2))

(assert (= cl_value_unsat (split_at line_cl_unsat ":" 1)))
(assert (>= (num_splits line_cl_unsat ":") 2))

; Digits-only constraint
(assert (str.in_re cl_value_unsat (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

(assert (= cl_value_unsat_int (str.to_int cl_value_unsat)))
(assert (>= cl_value_unsat_int 0))

; Force a concrete body and a mismatching content length -> UNSAT
(assert (= body_unsat "DATA"))
(assert (= line_cl_unsat "Content-Length: 10"))
(assert (= (str.len body_unsat) cl_value_unsat_int))

(check-sat)
(exit)
