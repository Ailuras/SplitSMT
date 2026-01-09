(set-logic ALL)

; Uninterpreted string-splitting interface (by specification)
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

; ----------- SAT instance: well-formed HTTP header parsing -----------
(declare-const request_sat String)
(declare-const headers_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_len_sat Int)
(declare-const body_sat String)

; Build a concrete request to avoid under-constrained uninterpreted split behavior
(assert (= request_sat (str.++ "POST /upload HTTP/1.1\r\n" "Host: example.com\r\n" "Content-Length: 5\r\n" "\r\n" "abcde")))

; Separate headers and body (split at CRLFCRLF)
(assert (= headers_sat (split_at request_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_at request_sat "\r\n\r\n" 1)))
(assert (>= (num_splits request_sat "\r\n\r\n") 2))

; Split header block into lines by CRLF
(assert (= line0_sat (split_at headers_sat "\r\n" 0)))
(assert (= line1_sat (split_at headers_sat "\r\n" 1)))
(assert (= line2_sat (split_at headers_sat "\r\n" 2)))
(assert (>= (num_splits headers_sat "\r\n") 3))

; Request line constraint
(assert (= line0_sat "POST /upload HTTP/1.1"))

; Parse Host line as key/value by ": "
(assert (= host_key_sat (split_at line1_sat ": " 0)))
(assert (= host_val_sat (split_at line1_sat ": " 1)))
(assert (>= (num_splits line1_sat ": ") 2))
(assert (= line1_sat "Host: example.com"))
(assert (= host_key_sat "Host"))
(assert (= host_val_sat "example.com"))

; Parse Content-Length line as key/value by ": "
(assert (= cl_key_sat (split_at line2_sat ": " 0)))
(assert (= cl_val_sat (split_at line2_sat ": " 1)))
(assert (>= (num_splits line2_sat ": ") 2))
(assert (= line2_sat "Content-Length: 5"))
(assert (= cl_key_sat "Content-Length"))
(assert (= cl_val_sat "5"))

; Validate Content-Length is numeric and matches body length
(assert (str.in_re cl_val_sat (re.+ (re.range "0" "9"))))
(assert (= cl_len_sat (str.to_int cl_val_sat)))
(assert (>= cl_len_sat 0))
(assert (= cl_len_sat (str.len body_sat)))

; Additional sanity checks on header formatting
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))
(assert (not (str.contains cl_val_sat "\r")))
(assert (not (str.contains cl_val_sat "\n")))
(assert (= (str.len body_sat) 5))

; ----------- UNSAT instance: inconsistent Content-Length -----------
(declare-const request_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_len_unsat Int)

(assert (= request_unsat (str.++ "POST /x HTTP/1.1\r\n" "Content-Length: 4\r\n" "\r\n" "abcde")))
(assert (= headers_unsat (split_at request_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_at request_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits request_unsat "\r\n\r\n") 2))

; Extract the Content-Length line (line 1 of headers: line0 is request line)
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 1)))
(assert (>= (num_splits headers_unsat "\r\n") 2))

(assert (= cl_val_unsat (split_at cl_line_unsat ": " 1)))
(assert (>= (num_splits cl_line_unsat ": ") 2))
(assert (= cl_line_unsat "Content-Length: 4"))

(assert (str.in_re cl_val_unsat (re.+ (re.range "0" "9"))))
(assert (= cl_len_unsat (str.to_int cl_val_unsat)))
(assert (>= cl_len_unsat 0))

; Contradiction: declared length 4 but actual body length 5
(assert (= cl_len_unsat (str.len body_unsat)))
(assert (= (str.len body_unsat) 5))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
