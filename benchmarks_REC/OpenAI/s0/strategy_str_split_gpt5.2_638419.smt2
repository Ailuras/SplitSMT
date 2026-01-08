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

; Uninterpreted interface for str_split

; ---------------------------
; SAT instance: plausible HTTP header parsing
; ---------------------------
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_sat String)
(declare-const header1_sat String)
(declare-const header2_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const host_sat String)
(declare-const content_length_sat String)
(declare-const cl_len_sat Int)
(declare-const body_sat String)
(declare-const body_len_sat Int)

; Shape the request
(assert (= req_sat (str.++ request_line_sat "\n" headers_sat "\n\n" body_sat)))
(assert (= request_line_sat "POST /submit HTTP/1.1"))

; Split headers by newline into at least 2 lines
(assert (>= (num_splits headers_sat "\n") 2))
(assert (= header1_sat (split_at headers_sat "\n" 0)))
(assert (= header2_sat (split_at headers_sat "\n" 1)))

; Identify Host and Content-Length lines (order fixed for this instance)
(assert (= host_line_sat header1_sat))
(assert (= cl_line_sat header2_sat))

; Parse "Host: <value>" using ':' delimiter
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_at host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
; enforce a single leading space before host value
(assert (= host_val_sat (str.++ " " host_sat)))
(assert (not (str.contains host_sat "\n")))
(assert (not (str.contains host_sat ":")))
(assert (> (str.len host_sat) 0))

; Parse "Content-Length: <digits>" using ':' delimiter
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_at cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))
(assert (= cl_val_sat (str.++ " " content_length_sat)))

; Validate that content-length is all digits and consistent with body length
(assert (str.in_re content_length_sat (re.+ (re.range "0" "9"))))
(assert (= cl_len_sat (str.to_int content_length_sat)))
(assert (= body_len_sat (str.len body_sat)))
(assert (>= cl_len_sat 0))
(assert (= cl_len_sat body_len_sat))

; Additional sanity: no CRLF, and avoid embedded header terminator in headers
(assert (not (str.contains req_sat "\r")))
(assert (not (str.contains headers_sat "\n\n")))

; ---------------------------
; UNSAT instance: contradictory Content-Length
; ---------------------------
(declare-const req_unsat String)
(declare-const request_line_unsat String)
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_length_unsat String)
(declare-const cl_len_unsat Int)
(declare-const body_unsat String)
(declare-const body_len_unsat Int)

(assert (= req_unsat (str.++ request_line_unsat "\n" headers_unsat "\n\n" body_unsat)))
(assert (= request_line_unsat "POST /x HTTP/1.1"))

; One header line: Content-Length only
(assert (>= (num_splits headers_unsat "\n") 1))
(assert (= cl_line_unsat (split_at headers_unsat "\n" 0)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_at cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (= cl_val_unsat (str.++ " " content_length_unsat)))

(assert (str.in_re content_length_unsat (re.+ (re.range "0" "9"))))
(assert (= cl_len_unsat (str.to_int content_length_unsat)))
(assert (= body_len_unsat (str.len body_unsat)))

; Force a contradiction: header says length 5 but body must have length 3
(assert (= cl_len_unsat 5))
(assert (= body_len_unsat 3))
(assert (= cl_len_unsat body_len_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
