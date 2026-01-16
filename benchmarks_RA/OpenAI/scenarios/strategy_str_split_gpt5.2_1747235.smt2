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

; Uninterpreted interface operations for string splitting

; Core HTTP request/header variables
(declare-const req String)
(declare-const headers String)
(declare-const body String)
(declare-const header_block String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)
(declare-const accept_line String)

(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)

(declare-const cl_int Int)

; Additional constraints / instances
(declare-const req_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const cl_line_sat String)
(declare-const cl_val_sat String)
(declare-const cl_int_sat Int)

(declare-const req_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)

; --- Structural assumptions for an HTTP request ---
; req = header_block + "\r\n\r\n" + body
(assert (= req (str.++ header_block "\r\n\r\n" body)))

; header_block = request_line + CRLF + headers
(assert (= header_block (str.++ (split_at header_block "\r\n" 0) "\r\n" headers)))

; There is at least one header line (in addition to request-line)
(assert (>= (num_splits header_block "\r\n") 2))

; headers is the rest after the request line
(assert (= headers (split_rest header_block "\r\n" 1)))

; At least 3 header lines present in headers: Host, Content-Length, User-Agent (order constrained below)
(assert (>= (num_splits headers "\r\n") 3))

; Extract specific lines by position (simple model of parsing)
(assert (= host_line (split_at headers "\r\n" 0)))
(assert (= cl_line   (split_at headers "\r\n" 1)))
(assert (= ua_line   (split_at headers "\r\n" 2)))

; Optional: accept line may exist, if present it is line 3
(assert (or (< (num_splits headers "\r\n") 4)
            (= accept_line (split_at headers "\r\n" 3))))

; --- Key/value parsing with colon delimiter ---
; Host: <value>
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (split_rest host_line ":" 1)))

; Content-Length: <value>
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_val (split_rest cl_line ":" 1)))

; User-Agent: <value>
(assert (>= (num_splits ua_line ":") 2))
(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_val (split_rest ua_line ":" 1)))

; Validate expected keys (case-sensitive for simplicity)
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Whitespace policy: value begins with a single space
(assert (str.prefixof " " host_val))
(assert (str.prefixof " " cl_val))
(assert (str.prefixof " " ua_val))

; Basic host content sanity: not empty after leading space
(assert (> (str.len host_val) 1))

; Content-Length value format: " <digits>" (at least one digit)
(assert (str.in_re cl_val (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))

; Numeric relation (abstracted): cl_int equals length(body)
(assert (>= cl_int 0))
(assert (= cl_int (str.len body)))

; Tie cl_int to cl_val by restricting to a small numeric domain and matching concrete strings
; This avoids requiring str.to_int while still validating the content-length meaningfully.
(assert (or (and (= cl_int 0)  (= cl_val " 0"))
            (and (= cl_int 1)  (= cl_val " 1"))
            (and (= cl_int 2)  (= cl_val " 2"))
            (and (= cl_int 3)  (= cl_val " 3"))
            (and (= cl_int 4)  (= cl_val " 4"))
            (and (= cl_int 5)  (= cl_val " 5"))
            (and (= cl_int 6)  (= cl_val " 6"))
            (and (= cl_int 7)  (= cl_val " 7"))
            (and (= cl_int 8)  (= cl_val " 8"))
            (and (= cl_int 9)  (= cl_val " 9"))
            (and (= cl_int 10) (= cl_val " 10"))
            (and (= cl_int 11) (= cl_val " 11"))
            (and (= cl_int 12) (= cl_val " 12"))
            (and (= cl_int 13) (= cl_val " 13"))
            (and (= cl_int 14) (= cl_val " 14"))
            (and (= cl_int 15) (= cl_val " 15"))))

; Ensure no CRLF injection inside values: values must not contain "\r\n"
(assert (not (str.contains host_val "\r\n")))
(assert (not (str.contains cl_val "\r\n")))
(assert (not (str.contains ua_val "\r\n")))

; --- SAT instance (consistent fixed request with Content-Length=5) ---
(assert (= req_sat (str.++ "POST /submit HTTP/1.1\r\n"
                           "Host: example.com\r\n"
                           "Content-Length: 5\r\n"
                           "User-Agent: test\r\n"
                           "\r\n"
                           "HELLO")))
(assert (= req_sat (str.++ (split_at req_sat "\r\n\r\n" 0) "\r\n\r\n" body_sat)))
(assert (= headers_sat (split_rest (split_at req_sat "\r\n\r\n" 0) "\r\n" 1)))
(assert (= cl_line_sat (split_at headers_sat "\r\n" 1)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))
(assert (= cl_int_sat (str.len body_sat)))
(assert (= cl_val_sat " 5"))
(assert (= cl_int_sat 5))

; --- UNSAT instance (contradicting Content-Length vs body length) ---
(assert (= req_unsat (str.++ "POST /x HTTP/1.1\r\n"
                             "Host: a\r\n"
                             "Content-Length: 4\r\n"
                             "User-Agent: u\r\n"
                             "\r\n"
                             "ABCDE")))
(assert (= req_unsat (str.++ (split_at req_unsat "\r\n\r\n" 0) "\r\n\r\n" body_unsat)))
(assert (= headers_unsat (split_rest (split_at req_unsat "\r\n\r\n" 0) "\r\n" 1)))
(assert (= cl_line_unsat (split_at headers_unsat "\r\n" 1)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_int_unsat (str.len body_unsat)))
(assert (= cl_val_unsat " 4"))
(assert (= cl_int_unsat 5))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
