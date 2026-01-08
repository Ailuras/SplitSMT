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

; Uninterpreted interface functions for str_split

; Uninterpreted helper functions (non-primitive)
(declare-fun to_int (String) Int)
(declare-fun is_digits (String) Bool)

; ----------------------------
; SAT instance: well-formed HTTP header parsing
; ----------------------------
(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)

(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)

(declare-const ua_line String)
(declare-const ua_key String)
(declare-const ua_value String)

; Split request into lines by newline "\n": request-line then headers
(assert (>= (num_splits req "\n") 4))
(assert (= request_line (split_at req "\n" 0)))
(assert (= headers_block (split_rest req "\n" 1)))

; Parse request line by spaces: METHOD SP PATH SP VERSION
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))

; Simple validation for request line parts
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "/" path))
(assert (or (= version "HTTP/1.1") (= version "HTTP/1.0")))

; Constrain first three header lines to be of form Key:Value
(assert (= host_line (split_at req "\n" 1)))
(assert (= cl_line   (split_at req "\n" 2)))
(assert (= ua_line   (split_at req "\n" 3)))

; Parse Host header
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\n")))

; Parse Content-Length header
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Validate Content-Length numeric content
(assert (is_digits cl_value))
(assert (= content_length (to_int cl_value)))
(assert (>= content_length 0))
(assert (<= content_length 1000000))

; Parse User-Agent header
(assert (>= (num_splits ua_line ":") 2))
(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_value (split_rest ua_line ":" 1)))
(assert (= ua_key "User-Agent"))
(assert (> (str.len ua_value) 0))

; Additional consistency checks: keys are non-empty, no newline embedded in a single header line
(assert (> (str.len host_key) 0))
(assert (> (str.len cl_key) 0))
(assert (> (str.len ua_key) 0))
(assert (not (str.contains host_line "\n")))
(assert (not (str.contains cl_line "\n")))
(assert (not (str.contains ua_line "\n")))

; Ensure the header block actually contains the three lines in order (lightweight containment constraints)
(assert (str.contains headers_block host_line))
(assert (str.contains headers_block cl_line))
(assert (str.contains headers_block ua_line))

; ----------------------------
; UNSAT instance: contradictory Content-Length requirements on same line
; ----------------------------
(declare-const req_bad String)
(declare-const cl_bad_line String)
(declare-const cl_bad_key String)
(declare-const cl_bad_value String)
(declare-const cl_bad_int Int)

(assert (>= (num_splits req_bad "\n") 2))
(assert (= cl_bad_line (split_at req_bad "\n" 1)))
(assert (>= (num_splits cl_bad_line ":") 2))
(assert (= cl_bad_key (split_at cl_bad_line ":" 0)))
(assert (= cl_bad_value (split_rest cl_bad_line ":" 1)))
(assert (= cl_bad_key "Content-Length"))
(assert (is_digits cl_bad_value))
(assert (= cl_bad_int (to_int cl_bad_value)))

; Contradiction: Content-Length must be both 0 and 1
(assert (= cl_bad_int 0))
(assert (= cl_bad_int 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
