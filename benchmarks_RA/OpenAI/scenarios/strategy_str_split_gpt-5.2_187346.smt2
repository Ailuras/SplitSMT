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

; Uninterpreted string-splitting interface

; Common string helpers as uninterpreted for higher-level parsing
(declare-fun trim (String) String)
(declare-fun to_int (String) Int)

; -----------------------------
; SAT instance: well-formed HTTP headers with consistent Content-Length
; -----------------------------
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const request_line_sat String)
(declare-const body_sat String)

(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const line3_sat String)
(declare-const blankline_sat String)

(declare-const key0_sat String)
(declare-const val0_sat String)
(declare-const key1_sat String)
(declare-const val1_sat String)
(declare-const key2_sat String)
(declare-const val2_sat String)

(declare-const cl_val_str_sat String)
(declare-const cl_val_trim_sat String)
(declare-const cl_int_sat Int)

; Structure: request line + headers + blank line + body
(assert (= request_line_sat (split_at req_sat "\r\n" 0)))
(assert (= headers_sat (split_at req_sat "\r\n\r\n" 0)))
(assert (= body_sat (split_rest req_sat "\r\n\r\n" 1)))
(assert (>= (num_splits req_sat "\r\n\r\n") 2))

; Header lines within headers block (including request line at index 0)
(assert (= line0_sat (split_at headers_sat "\r\n" 0)))
(assert (= line1_sat (split_at headers_sat "\r\n" 1)))
(assert (= line2_sat (split_at headers_sat "\r\n" 2)))
(assert (= line3_sat (split_at headers_sat "\r\n" 3)))
(assert (>= (num_splits headers_sat "\r\n") 4))

; Constrain request line to look like: "POST /... HTTP/1.1"
(assert (str.contains line0_sat "HTTP/1.1"))
(assert (str.contains line0_sat "POST"))
(assert (>= (str.len line0_sat) 14))

; Parse three header lines as key:value pairs using ':'
(assert (>= (num_splits line1_sat ":") 2))
(assert (>= (num_splits line2_sat ":") 2))
(assert (>= (num_splits line3_sat ":") 2))

(assert (= key0_sat (split_at line1_sat ":" 0)))
(assert (= val0_sat (split_rest line1_sat ":" 1)))
(assert (= key1_sat (split_at line2_sat ":" 0)))
(assert (= val1_sat (split_rest line2_sat ":" 1)))
(assert (= key2_sat (split_at line3_sat ":" 0)))
(assert (= val2_sat (split_rest line3_sat ":" 1)))

; Require distinct keys, and canonical Host / Content-Length / User-Agent
(assert (distinct key0_sat key1_sat key2_sat))
(assert (= (trim key0_sat) "Host"))
(assert (= (trim key1_sat) "Content-Length"))
(assert (= (trim key2_sat) "User-Agent"))

; Content-Length validation
(assert (= cl_val_str_sat val1_sat))
(assert (= cl_val_trim_sat (trim cl_val_str_sat)))
(assert (= cl_int_sat (to_int cl_val_trim_sat)))
(assert (>= cl_int_sat 0))
(assert (= cl_int_sat (str.len body_sat)))

; Additional sanity: Host must contain a dot; User-Agent non-empty after trim
(assert (str.contains (trim val0_sat) "."))
(assert (> (str.len (trim val2_sat)) 0))

; Concretize an example request to make SAT witness straightforward
(assert (= req_sat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "User-Agent: test\r\n"
    "\r\n"
    "abcde")))

; -----------------------------
; UNSAT instance: inconsistent Content-Length against actual body length
; -----------------------------
(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const line1_unsat String)
(declare-const key1_unsat String)
(declare-const val1_unsat String)
(declare-const cl_val_trim_unsat String)
(declare-const cl_int_unsat Int)

(assert (= headers_unsat (split_at req_unsat "\r\n\r\n" 0)))
(assert (= body_unsat (split_rest req_unsat "\r\n\r\n" 1)))
(assert (>= (num_splits req_unsat "\r\n\r\n") 2))

; Ensure there is a Content-Length header line at index 2 (0=request line, 1=Host, 2=Content-Length)
(assert (>= (num_splits headers_unsat "\r\n") 3))
(assert (= line1_unsat (split_at headers_unsat "\r\n" 2)))
(assert (>= (num_splits line1_unsat ":") 2))
(assert (= key1_unsat (split_at line1_unsat ":" 0)))
(assert (= val1_unsat (split_rest line1_unsat ":" 1)))
(assert (= (trim key1_unsat) "Content-Length"))

(assert (= cl_val_trim_unsat (trim val1_unsat)))
(assert (= cl_int_unsat (to_int cl_val_trim_unsat)))
(assert (>= cl_int_unsat 0))

; Inconsistent: enforce Content-Length equals 10 but body is length 3
(assert (= req_unsat
  (str.++
    "POST /x HTTP/1.1\r\n"
    "Host: a.b\r\n"
    "Content-Length: 10\r\n"
    "\r\n"
    "xyz")))

; This makes the constraints contradictory
(assert (= cl_int_unsat (str.len body_unsat)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
