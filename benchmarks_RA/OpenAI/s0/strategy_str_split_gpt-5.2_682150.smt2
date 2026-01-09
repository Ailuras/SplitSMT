(set-logic ALL)

; Uninterpreted functions for str_split interface
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

; Common string-to-int conversion modeled as uninterpreted (non-primitive)
(declare-fun str_to_int (String) Int)

; =====================
; SAT instance: well-formed HTTP header parsing with valid Content-Length
; =====================
(declare-const request_sat String)
(declare-const header_block_sat String)
(declare-const first_line_sat String)
(declare-const method_sat String)
(declare-const path_sat String)
(declare-const version_sat String)

(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const ua_line_sat String)

(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const ua_key_sat String)
(declare-const ua_val_sat String)

(declare-const body_sat String)
(declare-const content_length_sat Int)

; Structure: header block followed by blank line and body
(assert (= request_sat (str.++ header_block_sat "\r\n\r\n" body_sat)))

; First line and subsequent header lines split by CRLF
(assert (= first_line_sat (split_at header_block_sat "\r\n" 0)))
(assert (= host_line_sat (split_at header_block_sat "\r\n" 1)))
(assert (= cl_line_sat (split_at header_block_sat "\r\n" 2)))
(assert (= ua_line_sat (split_at header_block_sat "\r\n" 3)))
(assert (>= (num_splits header_block_sat "\r\n") 4))

; First line: METHOD SP PATH SP HTTP/VERSION
(assert (= method_sat (split_at first_line_sat " " 0)))
(assert (= path_sat (split_at first_line_sat " " 1)))
(assert (= version_sat (split_at first_line_sat " " 2)))
(assert (>= (num_splits first_line_sat " ") 3))

(assert (= method_sat "GET"))
(assert (= version_sat "HTTP/1.1"))
(assert (str.prefixof "/" path_sat))

; Parse header lines as key:value with optional single leading space in value
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (>= (num_splits host_line_sat ":") 2))

(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (>= (num_splits cl_line_sat ":") 2))

(assert (= ua_key_sat (split_at ua_line_sat ":" 0)))
(assert (= ua_val_sat (split_rest ua_line_sat ":" 1)))
(assert (>= (num_splits ua_line_sat ":") 2))

; Expected keys
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))
(assert (= ua_key_sat "User-Agent"))

; Enforce canonical formatting: key followed by ':' then a single space then value (simplified)
(assert (str.prefixof " " host_val_sat))
(assert (str.prefixof " " cl_val_sat))
(assert (str.prefixof " " ua_val_sat))

; Extract trimmed values by dropping the leading space using substr
(declare-const host_val_trim_sat String)
(declare-const cl_val_trim_sat String)
(declare-const ua_val_trim_sat String)
(assert (= host_val_trim_sat (str.substr host_val_sat 1 (- (str.len host_val_sat) 1))))
(assert (= cl_val_trim_sat (str.substr cl_val_sat 1 (- (str.len cl_val_sat) 1))))
(assert (= ua_val_trim_sat (str.substr ua_val_sat 1 (- (str.len ua_val_sat) 1))))
(assert (>= (str.len host_val_sat) 1))
(assert (>= (str.len cl_val_sat) 1))
(assert (>= (str.len ua_val_sat) 1))

; Some content constraints
(assert (not (str.contains host_val_trim_sat "\r")))
(assert (not (str.contains host_val_trim_sat "\n")))
(assert (not (str.contains ua_val_trim_sat "\r")))
(assert (not (str.contains ua_val_trim_sat "\n")))

; Model Content-Length conversion and validation
(assert (= content_length_sat (str_to_int cl_val_trim_sat)))
(assert (>= content_length_sat 0))
(assert (<= content_length_sat 1024))
(assert (= (str.len body_sat) content_length_sat))

; Provide a concrete consistent example to ensure SAT
(assert (= header_block_sat
  (str.++
    "GET /index.html HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 5\r\n"
    "User-Agent: test-agent")))
(assert (= body_sat "abcde"))
(assert (= (str_to_int "5") 5))

; =====================
; UNSAT instance: contradictory Content-Length vs body length
; =====================
(declare-const request_unsat String)
(declare-const header_block_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_val_trim_unsat String)
(declare-const content_length_unsat Int)

(assert (= request_unsat (str.++ header_block_unsat "\r\n\r\n" body_unsat)))

; Ensure there is a Content-Length line at index 1 (after request line)
(assert (>= (num_splits header_block_unsat "\r\n") 2))
(assert (= cl_line_unsat (split_at header_block_unsat "\r\n" 1)))

(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (>= (num_splits cl_line_unsat ":") 2))
(assert (= cl_key_unsat "Content-Length"))
(assert (str.prefixof " " cl_val_unsat))
(assert (>= (str.len cl_val_unsat) 1))
(assert (= cl_val_trim_unsat (str.substr cl_val_unsat 1 (- (str.len cl_val_unsat) 1))))

(assert (= content_length_unsat (str_to_int cl_val_trim_unsat)))
(assert (= (str.len body_unsat) content_length_unsat))

; Concrete contradictory instance
(assert (= header_block_unsat (str.++ "POST /submit HTTP/1.1\r\n" "Content-Length: 4")))
(assert (= body_unsat "ABCDE"))
(assert (= (str_to_int "4") 4))
(assert (= cl_val_trim_unsat "4"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
