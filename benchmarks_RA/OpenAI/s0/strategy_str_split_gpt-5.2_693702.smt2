(set-logic ALL)

; Uninterpreted interface for string split operations
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
; Scenario: HTTP Header Parsing
; Extract values from HTTP request headers using colons and newlines.
; Must handle key-value pairs and validate Content-Length.
; =========================

; Common delimiters
(declare-const CRLF String)
(declare-const COLON String)
(assert (= CRLF "\r\n"))
(assert (= COLON ":"))

; -------------------------
; SAT instance: well-formed request header block
; -------------------------
(declare-const req_sat String)
(declare-const header0_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const empty_line_sat String)
(declare-const method_line_sat String)

(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)

(declare-const body_sat String)
(declare-const body_len_sat Int)
(declare-const cl_int_sat Int)

; Shape of the request: request-line + CRLF + headers + CRLFCRLF + body
(assert (= req_sat (str.++ method_line_sat CRLF header0_sat CRLF CRLF body_sat)))

; Header block split into lines by CRLF
(assert (>= (num_splits header0_sat CRLF) 2))
(assert (= host_line_sat (split_at header0_sat CRLF 0)))
(assert (= cl_line_sat (split_at header0_sat CRLF 1)))

; Each header line is key:value with at least 2 segments
(assert (>= (num_splits host_line_sat COLON) 2))
(assert (>= (num_splits cl_line_sat COLON) 2))

; Extract key/value around ':'
(assert (= host_key_sat (split_at host_line_sat COLON 0)))
(assert (= host_val_sat (split_rest host_line_sat COLON 1)))
(assert (= cl_key_sat (split_at cl_line_sat COLON 0)))
(assert (= cl_val_sat (split_rest cl_line_sat COLON 1)))

; Validate required header keys
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))

; Basic value constraints: non-empty host, content-length digits (simple model: fix a concrete numeric string)
(assert (> (str.len host_val_sat) 0))

; Trim is not provided, so accept optional leading space by allowing two patterns
(declare-const cl_val_sat_nospace String)
(declare-const cl_val_sat_space String)
(assert (= cl_val_sat_nospace cl_val_sat))
(assert (= cl_val_sat_space (str.++ " " cl_val_sat_nospace)))
(assert (or (= cl_val_sat cl_val_sat_nospace) (= cl_val_sat cl_val_sat_space)))

; Choose a concrete content-length string and enforce matching body length
(assert (= cl_val_sat_nospace "5"))
(assert (= body_len_sat (str.len body_sat)))
(assert (= cl_int_sat 5))
(assert (= body_len_sat cl_int_sat))

; Some realism: request line contains spaces and HTTP version
(assert (str.contains method_line_sat "HTTP/1.1"))
(assert (str.contains method_line_sat " "))

; Ensure no CRLF appears inside individual header lines
(assert (not (str.contains host_line_sat CRLF)))
(assert (not (str.contains cl_line_sat CRLF)))

; -------------------------
; UNSAT instance: conflicting Content-Length requirements
; -------------------------
(declare-const req_unsat String)
(declare-const header0_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const cl_val_unsat_nospace String)
(declare-const body_len_unsat Int)

; Same overall shape
(assert (= req_unsat (str.++ "POST /upload HTTP/1.1" CRLF header0_unsat CRLF CRLF body_unsat)))

; Header block must have at least 1 line, with a Content-Length line first
(assert (>= (num_splits header0_unsat CRLF) 1))
(assert (= cl_line_unsat (split_at header0_unsat CRLF 0)))
(assert (>= (num_splits cl_line_unsat COLON) 2))
(assert (= cl_key_unsat (split_at cl_line_unsat COLON 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat COLON 1)))
(assert (= cl_key_unsat "Content-Length"))

; Again allow optional leading space
(assert (= cl_val_unsat_nospace "10"))
(assert (or (= cl_val_unsat cl_val_unsat_nospace) (= cl_val_unsat (str.++ " " cl_val_unsat_nospace))))

; Force body length to be 5 while claimed content-length is 10 => UNSAT by construction
(assert (= body_unsat "ABCDE"))
(assert (= body_len_unsat (str.len body_unsat)))
(assert (= body_len_unsat 5))
(assert (= body_len_unsat 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
