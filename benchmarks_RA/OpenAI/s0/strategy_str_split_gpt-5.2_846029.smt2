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

; Additional uninterpreted helpers for header lookup and numeric parsing
(declare-fun header_value (String String) String) ; (headers, key) -> value string (trimmed)
(declare-fun to_int (String) Int) ; parse decimal integer

; ----------------------------
; SAT instance: well-formed HTTP header block with Content-Length validation
; ----------------------------
(declare-const headers_sat String)
(declare-const request_line_sat String)
(declare-const header_lines_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_val_sat String)
(declare-const cl_val_sat String)
(declare-const body_sat String)
(declare-const content_len_sat Int)

; Structure: request-line + CRLF + header-lines + CRLFCRLF + body
(assert (str.contains headers_sat "\r\n"))
(assert (= request_line_sat (split_at headers_sat "\r\n" 0)))
(assert (>= (num_splits headers_sat "\r\n") 4))
(assert (= header_lines_sat (split_rest headers_sat "\r\n" 1)))

; Request line shape: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re request_line_sat (re.++ (str.to_re "GET") (str.to_re " ") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "/") (str.to_re "-") (str.to_re "_") (str.to_re "."))) (str.to_re " ") (str.to_re "HTTP/1.1"))))

; Require Host and Content-Length lines to exist in header section
(assert (>= (num_splits header_lines_sat "\r\n") 2))
(assert (= host_line_sat (split_at header_lines_sat "\r\n" 0)))
(assert (= cl_line_sat (split_at header_lines_sat "\r\n" 1)))

; Key-value parsing using ':' delimiter
(assert (= (split_at host_line_sat ":" 0) "Host"))
(assert (= (split_at cl_line_sat ":" 0) "Content-Length"))
(assert (>= (num_splits host_line_sat ":") 2))
(assert (>= (num_splits cl_line_sat ":") 2))

; Values come from a logical lookup function (trimmed), must match split_rest after ':'
(assert (= host_val_sat (header_value headers_sat "Host")))
(assert (= cl_val_sat (header_value headers_sat "Content-Length")))
(assert (str.contains host_val_sat "."))
(assert (> (str.len host_val_sat) 3))

; Content-Length must be digits only, parseable, non-negative, and equals body length
(assert (str.in_re cl_val_sat (re.+ (re.range "0" "9"))))
(assert (= content_len_sat (to_int cl_val_sat)))
(assert (>= content_len_sat 0))

; Body extraction: after CRLFCRLF (blank line)
(assert (str.contains headers_sat "\r\n\r\n"))
(assert (= body_sat (split_rest headers_sat "\r\n\r\n" 1)))
(assert (= content_len_sat (str.len body_sat)))

; Constrain a concrete-like header prefix while leaving rest flexible
(assert (str.prefixof "GET /index.html HTTP/1.1\r\n" headers_sat))
(assert (str.contains headers_sat "Host:"))
(assert (str.contains headers_sat "Content-Length:"))

; ----------------------------
; UNSAT instance: contradictory Content-Length constraints
; ----------------------------
(declare-const headers_unsat String)
(declare-const cl_val_unsat String)
(declare-const body_unsat String)
(declare-const content_len_unsat Int)

(assert (str.contains headers_unsat "\r\n\r\n"))
(assert (= body_unsat (split_rest headers_unsat "\r\n\r\n" 1)))

(assert (= cl_val_unsat (header_value headers_unsat "Content-Length")))
(assert (str.in_re cl_val_unsat (re.+ (re.range "0" "9"))))
(assert (= content_len_unsat (to_int cl_val_unsat)))
(assert (>= content_len_unsat 0))

; Force a non-empty body but content-length forced to mismatch -> UNSAT
(assert (> (str.len body_unsat) 0))
(assert (= content_len_unsat (str.len body_unsat)))
(assert (= content_len_unsat (+ (str.len body_unsat) 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
