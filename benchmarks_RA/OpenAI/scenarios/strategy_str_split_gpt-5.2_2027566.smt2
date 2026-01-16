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

; Uninterpreted interface functions for str_split

; ===== SAT instance: well-formed HTTP header parsing =====
(declare-const req_sat String)
(declare-const header_blob_sat String)
(declare-const first_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; Split request into header block and body by CRLFCRLF
(assert (= header_blob_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at req_sat "\r\n\r\n" 1)))
(assert (= 2 (num_splits req_sat "\r\n\r\n")))

; Split header block into lines by CRLF
(assert (= first_line_sat (split_at header_blob_sat "\r\n" 0)))
(assert (= host_line_sat (split_at header_blob_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at header_blob_sat "\r\n" 2)))
(assert (>= (num_splits header_blob_sat "\r\n") 3))

; Basic request line sanity: must contain method and HTTP version
(assert (str.contains first_line_sat "HTTP/1.1"))
(assert (str.contains first_line_sat " "))

; Parse Host: line by ':'
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat "Host"))
; Host value should be non-empty after trimming leading space (approx via contains)
(assert (or (str.contains host_val_sat "example.com") (>= (str.len host_val_sat) 2)))

; Parse Content-Length: line by ':'
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat "Content-Length"))

; Model content-length as an integer consistent with the body length
(assert (>= content_length_sat 0))
(assert (= content_length_sat (str.len body_sat)))

; Constrain the concrete shape of the request to ensure satisfiable parsing
(assert (= req_sat (str.++
  "POST /submit HTTP/1.1\r\n"
  "Host: example.com\r\n"
  "Content-Length: 5\r\n"
  "\r\n"
  "HELLO")))

; ===== UNSAT instance: contradictory content-length validation =====
(declare-const req_unsat String)
(declare-const header_blob_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_length_unsat Int)

(assert (= header_blob_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at req_unsat "\r\n\r\n" 1)))
(assert (= 2 (num_splits req_unsat "\r\n\r\n")))

; Locate the second header line as Content-Length and parse it
(assert (= cl_line_unsat (split_at header_blob_unsat "\r\n" 1)))
(assert (>= (num_splits header_blob_unsat "\r\n") 2))

(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat "Content-Length"))

; Constrain the request to a fixed body, then require inconsistent length
(assert (= req_unsat (str.++
  "GET / HTTP/1.1\r\n"
  "Content-Length: 3\r\n"
  "\r\n"
  "AB")))

(assert (>= content_length_unsat 0))
(assert (= content_length_unsat (str.len body_unsat)))
; Contradiction: body is "AB" (len 2) but enforce it to be 3
(assert (= content_length_unsat 3))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
