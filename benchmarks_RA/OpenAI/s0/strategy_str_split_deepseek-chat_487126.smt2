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

; =========================
; Scenario: HTTP Header Parsing
; - Parse request line and headers separated by CRLF
; - Parse header key/value pairs separated by ": "
; - Validate Content-Length as decimal digits and consistent with body length
; - Include both SAT and UNSAT sub-instances
; =========================

; ----- Shared constants -----
(declare-const CRLF String)
(declare-const COLONSP String)
(assert (= CRLF "\r\n"))
(assert (= COLONSP ": "))

; =========================
; SAT instance: well-formed request with valid Content-Length
; =========================
(declare-const req_sat String)
(declare-const body_sat String)
(declare-const request_line_sat String)
(declare-const header1_sat String)
(declare-const header2_sat String)
(declare-const header3_sat String)
(declare-const headers_tail_sat String)
(declare-const blankline_sat String)

(declare-const h1_key_sat String)
(declare-const h1_val_sat String)
(declare-const h2_key_sat String)
(declare-const h2_val_sat String)
(declare-const h3_key_sat String)
(declare-const h3_val_sat String)

(declare-const cl_str_sat String)
(declare-const body_len_sat Int)
(declare-const cl_num_sat Int)

; Structure: request-line, headers..., blank line, body
(assert (>= (num_splits req_sat CRLF) 6))
(assert (= request_line_sat (split_at req_sat CRLF 0)))
(assert (= header1_sat (split_at req_sat CRLF 1)))
(assert (= header2_sat (split_at req_sat CRLF 2)))
(assert (= header3_sat (split_at req_sat CRLF 3)))
(assert (= blankline_sat (split_at req_sat CRLF 4)))
(assert (= headers_tail_sat (split_rest req_sat CRLF 5)))
(assert (= blankline_sat ""))
(assert (= body_sat headers_tail_sat))

; Request line: "POST /submit HTTP/1.1"
(assert (= request_line_sat "POST /submit HTTP/1.1"))

; Header 1: Host
(assert (>= (num_splits header1_sat COLONSP) 2))
(assert (= h1_key_sat (split_at header1_sat COLONSP 0)))
(assert (= h1_val_sat (split_rest header1_sat COLONSP 1)))
(assert (= h1_key_sat "Host"))
(assert (= h1_val_sat "example.com"))

; Header 2: Content-Length
(assert (>= (num_splits header2_sat COLONSP) 2))
(assert (= h2_key_sat (split_at header2_sat COLONSP 0)))
(assert (= h2_val_sat (split_rest header2_sat COLONSP 1)))
(assert (= h2_key_sat "Content-Length"))
(assert (= cl_str_sat h2_val_sat))

; Header 3: Content-Type
(assert (>= (num_splits header3_sat COLONSP) 2))
(assert (= h3_key_sat (split_at header3_sat COLONSP 0)))
(assert (= h3_val_sat (split_rest header3_sat COLONSP 1)))
(assert (= h3_key_sat "Content-Type"))
(assert (= h3_val_sat "application/x-www-form-urlencoded"))

; Content-Length validation (SAT): constrain to a fixed decimal and body length consistent
(assert (= cl_str_sat "11"))
(assert (= body_sat "hello=world"))
(assert (= body_len_sat (str.len body_sat)))
(assert (= body_len_sat 11))

; Numeric parse link (kept simple and consistent)
(assert (= cl_num_sat 11))
(assert (= cl_num_sat body_len_sat))

; Extra sanity: header lines must contain ": "
(assert (str.contains header1_sat COLONSP))
(assert (str.contains header2_sat COLONSP))
(assert (str.contains header3_sat COLONSP))

(check-sat)

; =========================
; UNSAT instance: contradictory Content-Length and body length
; =========================
(declare-const req_unsat String)
(declare-const body_unsat String)
(declare-const request_line_unsat String)
(declare-const headerA_unsat String)
(declare-const headerB_unsat String)
(declare-const blankline_unsat String)
(declare-const tail_unsat String)

(declare-const hA_key_unsat String)
(declare-const hA_val_unsat String)
(declare-const hB_key_unsat String)
(declare-const hB_val_unsat String)

(declare-const cl_str_unsat String)
(declare-const body_len_unsat Int)
(declare-const cl_num_unsat Int)

; Structure with fewer headers: request-line, two headers, blank line, body
(assert (>= (num_splits req_unsat CRLF) 5))
(assert (= request_line_unsat (split_at req_unsat CRLF 0)))
(assert (= headerA_unsat (split_at req_unsat CRLF 1)))
(assert (= headerB_unsat (split_at req_unsat CRLF 2)))
(assert (= blankline_unsat (split_at req_unsat CRLF 3)))
(assert (= blankline_unsat ""))
(assert (= tail_unsat (split_rest req_unsat CRLF 4)))
(assert (= body_unsat tail_unsat))

(assert (= request_line_unsat "POST /upload HTTP/1.1"))

; HeaderA: Content-Length
(assert (>= (num_splits headerA_unsat COLONSP) 2))
(assert (= hA_key_unsat (split_at headerA_unsat COLONSP 0)))
(assert (= hA_val_unsat (split_rest headerA_unsat COLONSP 1)))
(assert (= hA_key_unsat "Content-Length"))
(assert (= cl_str_unsat hA_val_unsat))

; HeaderB: Connection
(assert (>= (num_splits headerB_unsat COLONSP) 2))
(assert (= hB_key_unsat (split_at headerB_unsat COLONSP 0)))
(assert (= hB_val_unsat (split_rest headerB_unsat COLONSP 1)))
(assert (= hB_key_unsat "Connection"))
(assert (= hB_val_unsat "close"))

; Content-Length digits constraint (still allows digits)
(assert (str.in_re cl_str_unsat (re.+ (re.range "0" "9"))))

; Force a concrete mismatch: length says 4 but body is length 3
(assert (= cl_str_unsat "4"))
(assert (= cl_num_unsat 4))
(assert (= body_unsat "abc"))
(assert (= body_len_unsat (str.len body_unsat)))
(assert (= body_len_unsat 3))
(assert (= cl_num_unsat body_len_unsat))

(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)
