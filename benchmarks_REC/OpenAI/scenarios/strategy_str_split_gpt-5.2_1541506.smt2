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

; Uninterpreted interface for string split

; --- Scenario: HTTP Header Parsing ---
; We model an HTTP request header block and extract key/value pairs separated by ": " and "\r\n".

(declare-const request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const method String)
(declare-const uri String)
(declare-const http_version String)

(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)

(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const cl_len Int)

(declare-const ua_line String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const body String)
(declare-const body_len Int)

; SAT/UNSAT switch
(declare-const make_unsat Bool)

; Basic decomposition: header block vs body separated by CRLFCRLF
(assert (= header_block (split_at request "\r\n\r\n" 0)))
(assert (= body (split_rest request "\r\n\r\n" 1)))
(assert (>= (num_splits request "\r\n\r\n") 2))

; Header lines split by CRLF: request line is first line
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (>= (num_splits header_block "\r\n") 4))

; Parse request line: "METHOD SP URI SP HTTP/VERSION"
(assert (= method (split_at request_line " " 0)))
(assert (= uri (split_at request_line " " 1)))
(assert (= http_version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))
(assert (or (= method "GET") (= method "POST")))
(assert (or (= http_version "HTTP/1.1") (= http_version "HTTP/1.0")))
(assert (not (= uri "")))

; Select specific header lines by fixed indices for simplicity
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= cl_line   (split_at header_block "\r\n" 2)))
(assert (= ua_line   (split_at header_block "\r\n" 3)))

; Each header line should contain a colon-space delimiter
(assert (>= (num_splits host_line ": ") 2))
(assert (>= (num_splits cl_line ": ") 2))
(assert (>= (num_splits ua_line ": ") 2))

; Extract key and value for each header
(assert (= host_key   (split_at host_line ": " 0)))
(assert (= host_value (split_rest host_line ": " 1)))

(assert (= cl_key     (split_at cl_line ": " 0)))
(assert (= cl_value   (split_rest cl_line ": " 1)))

(assert (= ua_key     (split_at ua_line ": " 0)))
(assert (= ua_value   (split_rest ua_line ": " 1)))

; Validate expected keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Basic sanity on values
(assert (not (= host_value "")))
(assert (not (= ua_value "")))

; Constrain Host format loosely (must contain at least one dot)
(assert (str.contains host_value "."))
(assert (not (str.contains host_value " ")))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; Content-Length must be a non-empty decimal numeral
(assert (not (= cl_value "")))
(assert (= cl_len (str.to_int cl_value)))
(assert (>= cl_len 0))

; Body length check against Content-Length
(assert (= body_len (str.len body)))

; Some structure expectations: body does not contain CRLFCRLF prefix remnants
(assert (not (str.contains body "\r\n\r\n")))

; Build a SAT instance: typical POST with matching length
(assert (= method "POST"))
(assert (= uri "/submit"))
(assert (= host_value "example.com"))
(assert (= ua_value "curl/8.0"))
(assert (= body "abcde"))
(assert (= cl_value "5"))
(assert (= cl_len 5))
(assert (= body_len 5))

; Also create an UNSAT branch: require conflicting Content-Length
; If make_unsat then force mismatch (cl_len = body_len + 1) while also keeping equality.
(assert (=> make_unsat (= cl_len (+ body_len 1))))
(assert (=> make_unsat (= cl_len body_len)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
