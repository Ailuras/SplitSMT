(set-logic ALL)
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

; Uninterpreted interface functions for string split constraints

; Additional uninterpreted helpers for parsing/validation not covered by primitives
(declare-fun header_value (String String) String) ; header_value(headers_blob, key) -> value
(declare-fun header_present (String String) Bool) ; header_present(headers_blob, key)
(declare-fun parse_int (String) Int) ; parse decimal integer from string
(declare-fun is_digits (String) Bool) ; all characters are digits, non-empty

; -------------------------
; SAT instance: well-formed HTTP header parsing
; -------------------------
(declare-const headers_sat String)
(declare-const request_line_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)
(declare-const header_terminator_sat String)
(declare-const host_value_sat String)
(declare-const cl_value_sat String)
(declare-const ua_value_sat String)
(declare-const content_length_sat Int)
(declare-const body_sat String)

; Construct a concrete-ish header block using split structure
(assert (= request_line_sat (split_at headers_sat "\n" 0)))
(assert (= host_line_sat (split_at headers_sat "\n" 1)))
(assert (= ua_line_sat (split_at headers_sat "\n" 2)))
(assert (= cl_line_sat (split_at headers_sat "\n" 3)))
(assert (= header_terminator_sat (split_at headers_sat "\n" 4)))

; Require at least 5 lines: request-line, host, ua, content-length, blank line
(assert (>= (num_splits headers_sat "\n") 5))

; Blank line ends headers
(assert (= header_terminator_sat ""))

; Basic formatting: "Key: Value" (split at ":" yields at least 2 segments)
(assert (>= (num_splits host_line_sat ":") 2))
(assert (>= (num_splits ua_line_sat ":") 2))
(assert (>= (num_splits cl_line_sat ":") 2))

; Ensure expected keys appear exactly as the first segment before ':'
(assert (= (split_at host_line_sat ":" 0) "Host"))
(assert (= (split_at ua_line_sat ":" 0) "User-Agent"))
(assert (= (split_at cl_line_sat ":" 0) "Content-Length"))

; Value is everything after the ':' from index 1 onward; allow optional leading space
(assert (= host_value_sat (split_rest host_line_sat ":" 1)))
(assert (= ua_value_sat (split_rest ua_line_sat ":" 1)))
(assert (= cl_value_sat (split_rest cl_line_sat ":" 1)))

; Common HTTP formatting: values start with a single space
(assert (str.prefixof " " host_value_sat))
(assert (str.prefixof " " ua_value_sat))
(assert (str.prefixof " " cl_value_sat))

; Define higher-level extraction API consistency
(assert (header_present headers_sat "Host"))
(assert (header_present headers_sat "User-Agent"))
(assert (header_present headers_sat "Content-Length"))
(assert (= (header_value headers_sat "Host") host_value_sat))
(assert (= (header_value headers_sat "User-Agent") ua_value_sat))
(assert (= (header_value headers_sat "Content-Length") cl_value_sat))

; Validate Content-Length: digits (after trimming leading space by substr(1,...))
; Note: we avoid defining trim; we just require the value is " " ++ digits
(declare-const cl_digits_sat String)
(assert (= cl_value_sat (str.++ " " cl_digits_sat)))
(assert (is_digits cl_digits_sat))
(assert (= content_length_sat (parse_int cl_digits_sat)))
(assert (>= content_length_sat 0))

; Body length must match Content-Length
(assert (= (str.len body_sat) content_length_sat))

; Additional sanity constraints for SAT instance
(assert (str.prefixof "GET " request_line_sat))
(assert (str.contains request_line_sat "HTTP/1.1"))
(assert (>= (str.len host_value_sat) 2))
(assert (>= (str.len ua_value_sat) 2))

; Bound the SAT instance to keep it realistic
(assert (<= (str.len headers_sat) 500))
(assert (<= content_length_sat 1000))

; -------------------------
; UNSAT instance: contradictory Content-Length and body length constraints
; -------------------------
(declare-const headers_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const cl_digits_unsat String)
(declare-const content_length_unsat Int)
(declare-const body_unsat String)

; Locate Content-Length line in a smaller header set
(assert (= cl_line_unsat (split_at headers_unsat "\n" 1)))
(assert (>= (num_splits headers_unsat "\n") 3))
(assert (= (split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_value_unsat (split_rest cl_line_unsat ":" 1)))

; Force a numeric content length
(assert (= cl_value_unsat (str.++ " " cl_digits_unsat)))
(assert (is_digits cl_digits_unsat))
(assert (= content_length_unsat (parse_int cl_digits_unsat)))
(assert (>= content_length_unsat 0))

; Contradiction: require content length equals 0 but body length is 1
(assert (= content_length_unsat 0))
(assert (= (str.len body_unsat) 1))
(assert (= (str.len body_unsat) content_length_unsat))

; -------------------------
; UNSAT instance: header present contradiction
; -------------------------
(declare-const headers_unsat2 String)
(declare-const host_line_unsat2 String)

(assert (= host_line_unsat2 (split_at headers_unsat2 "\n" 0)))
(assert (>= (num_splits headers_unsat2 "\n") 1))

; Say Host header is present, but also enforce it cannot be found via split key
(assert (header_present headers_unsat2 "Host"))
(assert (not (= (split_at host_line_unsat2 ":" 0) "Host")))
(assert (>= (num_splits host_line_unsat2 ":") 2))

; -------------------------
; Global consistency constraints (lightweight, not fully axiomatizing parsing)
; -------------------------
; If a header is present, its value is non-empty
(declare-const key_tmp String)
(declare-const hdr_tmp String)
(assert (forall ((hdr_tmp String) (key_tmp String))
  (=> (header_present hdr_tmp key_tmp)
      (> (str.len (header_value hdr_tmp key_tmp)) 0))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
