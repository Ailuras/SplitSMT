(set-logic ALL)

; Uninterpreted string-split interface
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

; =========================
; SAT instance: plausible HTTP header parsing
; =========================
(declare-const hdr_sat String)
(declare-const reqline_sat String)
(declare-const headers_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)
(declare-const content_length_sat Int)

; Shape: request line then headers (separated by \r\n)
(assert (= reqline_sat (split_at hdr_sat "\r\n" 0)))
(assert (= headers_sat (split_rest hdr_sat "\r\n" 1)))
(assert (>= (num_splits hdr_sat "\r\n") 4))

; Require a simple GET request line shape
(assert (str.in_re reqline_sat (re.++ (str.to_re "GET ") (re.* re.allchar))))
(assert (str.contains reqline_sat " HTTP/1.1"))

; First three header lines in headers_sat
(assert (= host_line_sat (split_at headers_sat "\r\n" 0)))
(assert (= ua_line_sat   (split_at headers_sat "\r\n" 1)))
(assert (= cl_line_sat   (split_at headers_sat "\r\n" 2)))

; Each header line contains a colon delimiter and has at least 2 segments when split
(assert (>= (num_splits host_line_sat ":") 2))
(assert (>= (num_splits ua_line_sat ":") 2))
(assert (>= (num_splits cl_line_sat ":") 2))

; Extract keys and values (value is everything after the first colon)
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (= ua_key_sat (split_at ua_line_sat ":" 0)))
(assert (= ua_val_sat (split_rest ua_line_sat ":" 1)))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))

; Validate required keys
(assert (= host_key_sat "Host"))
(assert (= ua_key_sat "User-Agent"))
(assert (= cl_key_sat "Content-Length"))

; Ensure values are non-empty and do not contain CR/LF
(assert (> (str.len host_val_sat) 1))
(assert (> (str.len ua_val_sat) 1))
(assert (> (str.len cl_val_sat) 0))
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))
(assert (not (str.contains ua_val_sat "\r")))
(assert (not (str.contains ua_val_sat "\n")))
(assert (not (str.contains cl_val_sat "\r")))
(assert (not (str.contains cl_val_sat "\n")))

; Content-Length value must be digits only (optionally with a leading space)
(assert (str.in_re cl_val_sat (re.union (re.++ (str.to_re " ") (re.+ (re.range "0" "9"))) (re.+ (re.range "0" "9")))))

; Tie Content-Length to an integer via a fixed, constrained example (keeps arithmetic linear)
(assert (= content_length_sat 42))
(assert (or (= cl_val_sat "42") (= cl_val_sat " 42")))

; Basic sanity constraint: content length non-negative and bounded
(assert (and (>= content_length_sat 0) (<= content_length_sat 1000000)))

; Make hdr_sat concrete enough to be satisfiable
(assert (= hdr_sat (str.++ "GET /index.html HTTP/1.1\r\n" host_line_sat "\r\n" ua_line_sat "\r\n" cl_line_sat "\r\n\r\n")))

(check-sat)

; =========================
; UNSAT instance: contradictory Content-Length parsing/validation
; =========================
(declare-const hdr_unsat String)
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const content_length_unsat Int)

(assert (>= (num_splits hdr_unsat "\r\n") 2))
(assert (= headers_unsat (split_rest hdr_unsat "\r\n" 1)))
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 0)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Force a non-digit value but simultaneously require digits-only
(assert (= cl_val_unsat "abc"))
(assert (str.in_re cl_val_unsat (re.+ (re.range "0" "9"))))

; Additionally constrain integer to be 0 and require it to correspond to nonzero string (extra inconsistency)
(assert (= content_length_unsat 0))
(assert (or (= cl_val_unsat "0") (= cl_val_unsat " 0")))

(check-sat)
(exit)
