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

; Uninterpreted interface for string splitting

; Additional uninterpreted helpers (non-primitive ops)
(declare-fun to_int (String) Int)
(declare-fun is_digits (String) Bool)

; =========
; SAT instance: consistent HTTP header parsing
; =========

(declare-const request String)
(declare-const headers_block String)
(declare-const first_line String)
(declare-const header_line0 String)
(declare-const header_line1 String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const cl_value_trim String)
(declare-const body String)
(declare-const declared_len Int)

; Basic shape: request is split into headers and body by CRLFCRLF
(assert (= headers_block (split_at request "\r\n\r\n" 0)))
(assert (= body (split_rest request "\r\n\r\n" 1)))
(assert (>= (num_splits request "\r\n\r\n") 2))

; Header lines separated by CRLF
(assert (= first_line (split_at headers_block "\r\n" 0)))
(assert (= header_line0 (split_at headers_block "\r\n" 1)))
(assert (= header_line1 (split_at headers_block "\r\n" 2)))
(assert (>= (num_splits headers_block "\r\n") 3))

; Request line plausibility
(assert (str.prefixof "GET " first_line))
(assert (str.contains first_line " HTTP/1.1"))

; Parse Host header: "Host: <value>"
(assert (= host_key (split_at header_line0 ":" 0)))
(assert (= host_value (split_rest header_line0 ":" 1)))
(assert (= host_key "Host"))
(assert (>= (num_splits header_line0 ":") 2))
(assert (str.prefixof " " host_value))
(assert (> (str.len host_value) 1))
(assert (str.contains host_value "."))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (= cl_key (split_at header_line1 ":" 0)))
(assert (= cl_value (split_rest header_line1 ":" 1)))
(assert (= cl_key "Content-Length"))
(assert (>= (num_splits header_line1 ":") 2))

; Allow a single leading space before the numeric value
(assert (str.prefixof " " cl_value))
(assert (= cl_value_trim (str.substr cl_value 1 (- (str.len cl_value) 1))))
(assert (>= (str.len cl_value) 2))

; Digit validation + integer conversion (abstracted)
(assert (is_digits cl_value_trim))
(assert (= declared_len (to_int cl_value_trim)))
(assert (>= declared_len 0))

; Validate that body length matches declared Content-Length
(assert (= (str.len body) declared_len))

; Constrain the body to look like payload data (not required by HTTP, but helps structure)
(assert (or (= body "") (str.contains body "=")))

; =========
; UNSAT instance: contradictory constraints over another request
; =========

(declare-const bad_request String)
(declare-const bad_headers String)
(declare-const bad_body String)
(declare-const bad_cl_line String)
(declare-const bad_cl_val String)
(declare-const bad_cl_val_trim String)
(declare-const bad_declared_len Int)

(assert (= bad_headers (split_at bad_request "\r\n\r\n" 0)))
(assert (= bad_body (split_rest bad_request "\r\n\r\n" 1)))
(assert (>= (num_splits bad_request "\r\n\r\n") 2))

; Pick some header line as Content-Length
(assert (= bad_cl_line (split_at bad_headers "\r\n" 1)))
(assert (>= (num_splits bad_headers "\r\n") 2))
(assert (str.prefixof "Content-Length:" bad_cl_line))

(assert (= bad_cl_val (split_rest bad_cl_line ":" 1)))
(assert (str.prefixof " " bad_cl_val))
(assert (= bad_cl_val_trim (str.substr bad_cl_val 1 (- (str.len bad_cl_val) 1))))
(assert (>= (str.len bad_cl_val) 2))

; Declare it parses to some integer
(assert (is_digits bad_cl_val_trim))
(assert (= bad_declared_len (to_int bad_cl_val_trim)))
(assert (>= bad_declared_len 0))

; Contradiction: body length both equals and differs from declared length
(assert (= (str.len bad_body) bad_declared_len))
(assert (not (= (str.len bad_body) bad_declared_len)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
