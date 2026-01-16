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

; Uninterpreted string-split interface

; -------------------------------
; SAT instance: consistent HTTP header parsing
; -------------------------------
(declare-const request_sat String)
(declare-const header_line0_sat String)
(declare-const header_line1_sat String)
(declare-const header_line2_sat String)
(declare-const key0_sat String)
(declare-const val0_sat String)
(declare-const key1_sat String)
(declare-const val1_sat String)
(declare-const key2_sat String)
(declare-const val2_sat String)
(declare-const host_sat String)
(declare-const content_length_str_sat String)
(declare-const body_sat String)
(declare-const body_len_sat Int)
(declare-const content_length_sat Int)

; Concrete request with three header lines, empty line, then body.
(assert (= request_sat
  (str.++
    "GET /upload HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "X-Trace: abc123\r\n"
    "\r\n"
    "HELLO")))

; Split by CRLF into lines: request line, 3 headers, empty line, then (maybe) rest
(assert (>= (num_splits request_sat "\r\n") 5))
(assert (= header_line0_sat (split_at request_sat "\r\n" 1)))
(assert (= header_line1_sat (split_at request_sat "\r\n" 2)))
(assert (= header_line2_sat (split_at request_sat "\r\n" 3)))
(assert (= "" (split_at request_sat "\r\n" 4)))

; Ensure each header line has at least one ':'
(assert (>= (num_splits header_line0_sat ":") 2))
(assert (>= (num_splits header_line1_sat ":") 2))
(assert (>= (num_splits header_line2_sat ":") 2))

; Extract keys and values using ':' delimiter
(assert (= key0_sat (split_at header_line0_sat ":" 0)))
(assert (= val0_sat (split_rest header_line0_sat ":" 1)))
(assert (= key1_sat (split_at header_line1_sat ":" 0)))
(assert (= val1_sat (split_rest header_line1_sat ":" 1)))
(assert (= key2_sat (split_at header_line2_sat ":" 0)))
(assert (= val2_sat (split_rest header_line2_sat ":" 1)))

; Validate header keys match expected
(assert (= key0_sat "Host"))
(assert (= key1_sat "Content-Length"))
(assert (= key2_sat "X-Trace"))

; Typical HTTP formatting has a space after ':'
(assert (str.prefixof " " val0_sat))
(assert (str.prefixof " " val1_sat))
(assert (str.prefixof " " val2_sat))

; Extract Host value and Content-Length string (including leading space)
(assert (= host_sat (str.substr val0_sat 1 (- (str.len val0_sat) 1))))
(assert (= content_length_str_sat (str.substr val1_sat 1 (- (str.len val1_sat) 1))))

; Host must be non-empty and contain a dot
(assert (> (str.len host_sat) 0))
(assert (str.contains host_sat "."))

; Content-Length must be digits only and parseable
(assert (str.in_re content_length_str_sat (re.+ (re.range "0" "9"))))
(assert (= content_length_sat (str.to_int content_length_str_sat)))
(assert (>= content_length_sat 0))

; Body is after the empty line; using split_rest from index 5 (after 0..4 segments)
(assert (= body_sat (split_rest request_sat "\r\n" 5)))
(assert (= body_len_sat (str.len body_sat)))

; Validate content-length equals body length
(assert (= content_length_sat body_len_sat))

; Additional consistency constraints for the SAT instance
(assert (= body_sat "HELLO"))
(assert (str.contains val2_sat "abc"))

; -------------------------------
; UNSAT instance: inconsistent Content-Length vs body size
; -------------------------------
(declare-const request_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_digits_unsat String)
(declare-const body_unsat String)
(declare-const cl_int_unsat Int)
(declare-const body_len_unsat Int)

(assert (= request_unsat
  (str.++
    "POST /data HTTP/1.1\r\n"
    "Content-Length: 10\r\n"
    "\r\n"
    "HELLO")))

(assert (>= (num_splits request_unsat "\r\n") 3))
(assert (= cl_line_unsat (split_at request_unsat "\r\n" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))
(assert (str.prefixof " " cl_val_unsat))
(assert (= cl_digits_unsat (str.substr cl_val_unsat 1 (- (str.len cl_val_unsat) 1))))
(assert (str.in_re cl_digits_unsat (re.+ (re.range "0" "9"))))
(assert (= cl_int_unsat (str.to_int cl_digits_unsat)))
(assert (>= cl_int_unsat 0))

(assert (= body_unsat (split_rest request_unsat "\r\n" 3)))
(assert (= body_len_unsat (str.len body_unsat)))

; Force mismatch: content-length 10 but body is "HELLO" length 5
(assert (= body_unsat "HELLO"))
(assert (= cl_int_unsat body_len_unsat))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
