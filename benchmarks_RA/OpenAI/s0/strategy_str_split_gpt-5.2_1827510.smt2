(set-logic ALL)

; Uninterpreted interface for str_split
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
; SAT instance: parse request headers and validate Content-Length
; =========================
(declare-const request String)
(declare-const header_block String)
(declare-const headers_sep String)
(declare-const request_line String)
(declare-const body String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)

(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)

(declare-const cl_len Int)

(assert (= headers_sep "\r\n\r\n"))
(assert (= request (str.++ header_block headers_sep body)))
(assert (>= (num_splits request headers_sep) 2))

; Split header block into request line + subsequent header lines
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (>= (num_splits header_block "\r\n") 4))

; Constrain the request line structure roughly: METHOD SP PATH SP HTTP/VERSION
(assert (str.in_re request_line (re.++ (str.to_re "GET ") (re.* re.allchar) (str.to_re " HTTP/1.1"))))

; Extract specific header lines by index (order chosen for determinism)
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= cl_line   (split_at header_block "\r\n" 2)))
(assert (= ua_line   (split_at header_block "\r\n" 3)))

; Each header line must contain a colon separator producing at least 2 segments
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))
(assert (>= (num_splits ua_line ":") 2))

; Key is before the first colon
(assert (= host_key (split_at host_line ":" 0)))
(assert (= cl_key   (split_at cl_line ":" 0)))
(assert (= ua_key   (split_at ua_line ":" 0)))

; Value is everything after the first colon (may include additional colons)
(assert (= host_val (split_rest host_line ":" 1)))
(assert (= cl_val   (split_rest cl_line ":" 1)))
(assert (= ua_val   (split_rest ua_line ":" 1)))

; Enforce required header keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Basic sanity: values non-empty after trimming at least one char
(assert (>= (str.len host_val) 1))
(assert (>= (str.len cl_val) 1))
(assert (>= (str.len ua_val) 1))

; Content-Length value is digits with optional leading spaces
(assert (str.in_re cl_val (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Connect Content-Length numeric interpretation to body length (simplified constraint)
(assert (>= cl_len 0))
(assert (= cl_len (str.len body)))
(assert (<= cl_len 2048))

; Additional constraints to avoid degenerate headers
(assert (not (str.contains host_val "\r")))
(assert (not (str.contains host_val "\n")))
(assert (not (str.contains ua_val "\r")))
(assert (not (str.contains ua_val "\n")))

; Body must match the length (implicitly by cl_len = len(body)) and may be arbitrary
(assert (str.in_re body (re.* re.allchar)))

(check-sat)

; =========================
; UNSAT instance: force conflicting Content-Length vs body length
; =========================
(declare-const request_u String)
(declare-const header_block_u String)
(declare-const body_u String)
(declare-const request_line_u String)
(declare-const cl_line_u String)
(declare-const cl_key_u String)
(declare-const cl_val_u String)
(declare-const cl_len_u Int)

(assert (= request_u (str.++ header_block_u headers_sep body_u)))
(assert (>= (num_splits request_u headers_sep) 2))
(assert (= request_line_u (split_at header_block_u "\r\n" 0)))
(assert (= cl_line_u (split_at header_block_u "\r\n" 1)))

(assert (str.in_re request_line_u (re.++ (str.to_re "POST ") (re.* re.allchar) (str.to_re " HTTP/1.1"))))

(assert (>= (num_splits cl_line_u ":") 2))
(assert (= cl_key_u (split_at cl_line_u ":" 0)))
(assert (= cl_val_u (split_rest cl_line_u ":" 1)))
(assert (= cl_key_u "Content-Length"))

(assert (str.in_re cl_val_u (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Contradiction: enforce two different body lengths simultaneously
(assert (= cl_len_u (str.len body_u)))
(assert (= cl_len_u 5))
(assert (= (str.len body_u) 7))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
