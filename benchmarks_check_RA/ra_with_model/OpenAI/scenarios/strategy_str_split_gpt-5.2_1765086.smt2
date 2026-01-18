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

; Uninterpreted interface: str_split

; Additional helper uninterpreted functions (non-primitive operations)
(declare-fun is_digits (String) Bool)
(declare-fun to_int (String) Int)

; =====================
; SAT instance: well-formed header parsing
; =====================
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const cl_value_sat String)
(declare-const body_sat String)
(declare-const host_key_sat String)
(declare-const host_value_sat String)
(declare-const cl_key_sat String)

; Structural: request line + headers + blank line + body
(assert (= request_line_sat (split_at req_sat "\r\n" 0)))
(assert (= headers_block_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at req_sat "\r\n\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; Ensure request line looks like an HTTP request line fragment
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (str.contains request_line_sat "GET "))

; Work within the header block: take some header lines
(assert (>= (num_splits headers_block_sat "\r\n") 3))
(assert (= host_line_sat (split_at headers_block_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at headers_block_sat "\r\n" 2)))

; Parse Host header: "Host: <value>"
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_value_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
(assert (str.contains host_value_sat "example.com"))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_value_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))

; Value validation and consistency with body length
(assert (is_digits cl_value_sat))
(assert (>= (to_int cl_value_sat) 0))
(assert (= (to_int cl_value_sat) (str.len body_sat)))

; Make the instance concretely satisfiable
(assert (= req_sat
  (str.++
    "GET /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "abcde")))

; =====================
; UNSAT instance: conflicting content-length vs body length
; =====================
(declare-const req_unsat String)
(declare-const headers_block_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const cl_key_unsat String)

(assert (= headers_block_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

; Find Content-Length line (assume it is the second header line for this test)
(assert (>= (num_splits headers_block_unsat "\r\n") 3))
(assert (= cl_line_unsat (split_at headers_block_unsat "\r\n" 2)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_value_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Validate digits, then impose contradictory length constraint
(assert (is_digits cl_value_unsat))
(assert (= (to_int cl_value_unsat) (str.len body_unsat)))

; Concrete request: body length is 4 but Content-Length says 5 (unsat with above equality)
(assert (= req_unsat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: bad.example\r\n"
    "Content-Length: 5\r\n"
    "\r\n"
    "wxyz")))



; [GENERATION STATUS: SUCCESS]
(assert (= cl_key_unsat "Content-Length"))
(assert (= headers_block_sat "G"))
(assert (= request_line_sat "GET HTTP/1.1"))
(assert (= cl_value_unsat "p"))
(assert (= body_unsat ""))
(assert (= cl_line_unsat "u"))
(assert (= host_key_sat "Host"))
(assert (= cl_value_sat " "))
(assert (= cl_key_sat "Content-Length"))
(assert (= host_value_sat "example.com"))
(assert (= req_unsat "POST /submit HTTP/1.1\r\nHost: bad.example\r\nContent-Length: 5\r\n\r\nwxyz"))
(assert (= body_sat ""))
(assert (= headers_block_unsat "/"))
(assert (= host_line_sat "E"))
(assert (= req_sat "GET /upload HTTP/1.1\r\nHost: example.com\r\nContent-Length: 5\r\n\r\nabcde"))
(assert (= cl_line_sat "T"))
(check-sat)
(exit)
