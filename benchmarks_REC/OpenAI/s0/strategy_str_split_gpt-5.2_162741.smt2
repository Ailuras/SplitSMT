(set-logic ALL)

; Uninterpreted split interface (str_split)
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

; Scenario: HTTP Header Parsing
; We model an HTTP request header block with CRLF separators and colon key/value format.

; Shared primitives
(declare-const CRLF String)
(declare-const COLON String)
(assert (= CRLF "\r\n"))
(assert (= COLON ":"))

; =====================
; SAT instance: well-formed request with consistent Content-Length
; =====================
(declare-const req_sat String)
(declare-const request_line_sat String)
(declare-const headers_block_sat String)
(declare-const line_host_sat String)
(declare-const line_cl_sat String)
(declare-const line_conn_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_val_trim_sat String)
(declare-const conn_key_sat String)
(declare-const conn_val_sat String)
(declare-const body_sat String)
(declare-const content_length_sat Int)

; Split request into lines by CRLF
(assert (= request_line_sat (split_at req_sat CRLF 0)))
(assert (= headers_block_sat (split_rest req_sat CRLF 1)))
(assert (>= (num_splits req_sat CRLF) 5))

; Header lines (assume exactly: Host, Content-Length, Connection, blank, then body)
(assert (= line_host_sat (split_at req_sat CRLF 1)))
(assert (= line_cl_sat (split_at req_sat CRLF 2)))
(assert (= line_conn_sat (split_at req_sat CRLF 3)))
(assert (= (split_at req_sat CRLF 4) ""))
(assert (= body_sat (split_rest req_sat CRLF 5)))

; Each header line contains a colon separating key and value
(assert (>= (num_splits line_host_sat COLON) 2))
(assert (>= (num_splits line_cl_sat COLON) 2))
(assert (>= (num_splits line_conn_sat COLON) 2))

; Extract keys and values around the first colon
(assert (= host_key_sat (split_at line_host_sat COLON 0)))
(assert (= host_val_sat (split_rest line_host_sat COLON 1)))
(assert (= cl_key_sat (split_at line_cl_sat COLON 0)))
(assert (= cl_val_sat (split_rest line_cl_sat COLON 1)))
(assert (= conn_key_sat (split_at line_conn_sat COLON 0)))
(assert (= conn_val_sat (split_rest line_conn_sat COLON 1)))

; Enforce expected header names (case-sensitive for this model)
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= conn_key_sat "Connection"))

; Values are commonly preceded by a single space; model trimmed value by dropping first char
(assert (>= (str.len cl_val_sat) 2))
(assert (= (str.at cl_val_sat 0) " "))
(assert (= cl_val_trim_sat (str.substr cl_val_sat 1 (- (str.len cl_val_sat) 1))))

; Content-Length value is digits only and non-empty
(assert (>= (str.len cl_val_trim_sat) 1))
(assert (str.in_re cl_val_trim_sat (re.+ (re.range "0" "9"))))

; Link Content-Length int to body length in a consistent way
(assert (= content_length_sat (str.to_int cl_val_trim_sat)))
(assert (>= content_length_sat 0))
(assert (= content_length_sat (str.len body_sat)))

; Some additional realism constraints
(assert (str.in_re request_line_sat (re.++ (str.to_re "GET ") (re.+ (re.range "!" "~")) (str.to_re " HTTP/1.1"))))
(assert (str.contains host_val_sat "example"))
(assert (or (= conn_val_sat " close") (= conn_val_sat " keep-alive")))

; Concretize a satisfying shape (still leaves some freedom)
(assert (str.contains req_sat "Content-Length"))
(assert (str.contains req_sat "\r\n\r\n"))

; =====================
; UNSAT instance: inconsistent Content-Length vs body length
; =====================
(declare-const req_unsat String)
(declare-const line_cl_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_val_trim_unsat String)
(declare-const body_unsat String)
(declare-const content_length_unsat Int)

(assert (>= (num_splits req_unsat CRLF) 4))
(assert (= line_cl_unsat (split_at req_unsat CRLF 1)))
(assert (= (split_at req_unsat CRLF 2) ""))
(assert (= body_unsat (split_rest req_unsat CRLF 3)))

(assert (>= (num_splits line_cl_unsat COLON) 2))
(assert (= (split_at line_cl_unsat COLON 0) "Content-Length"))
(assert (= cl_val_unsat (split_rest line_cl_unsat COLON 1)))

(assert (>= (str.len cl_val_unsat) 2))
(assert (= (str.at cl_val_unsat 0) " "))
(assert (= cl_val_trim_unsat (str.substr cl_val_unsat 1 (- (str.len cl_val_unsat) 1))))
(assert (str.in_re cl_val_trim_unsat (re.+ (re.range "0" "9"))))
(assert (= content_length_unsat (str.to_int cl_val_trim_unsat)))
(assert (>= content_length_unsat 0))

; Force a specific mismatch: Content-Length claims 3 but body has length 5.
(assert (= cl_val_trim_unsat "3"))
(assert (= (str.len body_unsat) 5))
(assert (= content_length_unsat (str.len body_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
