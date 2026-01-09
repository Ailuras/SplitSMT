(set-logic ALL)

; Uninterpreted string split interface
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

; Uninterpreted helper for numeric parsing/validation
(declare-fun str_to_int (String) Int)

; =====================
; SAT instance: well-formed HTTP headers with Content-Length
; =====================
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const line0_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const cl_int_sat Int)

; Structure: split request by CRLF into header lines
(assert (>= (num_splits req_sat "\r\n") 4))
(assert (= line0_sat (split_at req_sat "\r\n" 0)))
(assert (= host_line_sat (split_at req_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at req_sat "\r\n" 2)))
(assert (= headers_sat (split_rest req_sat "\r\n" 0)))

; Request line sanity (contains method and HTTP version)
(assert (str.contains line0_sat "HTTP/1.1"))
(assert (or (str.contains line0_sat "GET ") (str.contains line0_sat "POST ")))

; Host header parsing: "Host: <value>"
(assert (>= (num_splits host_line_sat ":") 2))
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (= host_key_sat "Host"))
; Host value must be non-empty and must not contain CR or LF
(assert (> (str.len host_val_sat) 1))
(assert (not (str.contains host_val_sat "\r")))
(assert (not (str.contains host_val_sat "\n")))

; Content-Length header parsing: "Content-Length: <digits>"
(assert (>= (num_splits cl_line_sat ":") 2))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_key_sat "Content-Length"))

; Allow optional leading space before digits in value; enforce digits-only after stripping one space
; We model it by requiring either digits-only or a single leading space then digits-only.
(assert (or
  (str.in_re cl_val_sat (re.+ (re.range "0" "9")))
  (and
    (>= (str.len cl_val_sat) 2)
    (= (str.at cl_val_sat 0) " ")
    (str.in_re (str.substr cl_val_sat 1 (- (str.len cl_val_sat) 1)) (re.+ (re.range "0" "9")))
  )
))

; Link numeric conversion with an uninterpreted converter and validate range
(assert (= cl_int_sat (str_to_int cl_val_sat)))
(assert (>= cl_int_sat 0))
(assert (<= cl_int_sat 1048576))

; Constrain a concrete satisfying example
(assert (= req_sat
  (str.++
    "GET /index.html HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 12\r\n"
    "\r\n"
  )
))

; =====================
; UNSAT instance: contradictory Content-Length constraints
; =====================
(declare-const req_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)

(assert (>= (num_splits req_unsat "\r\n") 3))
(assert (= cl_line_unsat (split_at req_unsat "\r\n" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Force a specific Content-Length string
(assert (= cl_val_unsat "10"))
(assert (= cl_int_unsat (str_to_int cl_val_unsat)))

; Contradiction: same parsed integer must be 10 and 11
(assert (= cl_int_unsat 10))
(assert (= cl_int_unsat 11))

; Provide a concrete request containing the header
(assert (= req_unsat
  (str.++
    "POST /upload HTTP/1.1\r\n"
    "Content-Length:10\r\n"
    "\r\n"
  )
))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
