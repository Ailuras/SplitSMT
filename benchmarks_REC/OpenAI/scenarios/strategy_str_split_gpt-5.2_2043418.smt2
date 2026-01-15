(set-logic ALL)

; Uninterpreted interface for string splitting
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

; Scenario: HTTP Header Parsing
(declare-const request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const headers_only String)
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
(declare-const host_has_dot Bool)

; Basic structural parsing: request-line, headers, body separated by CRLF CRLF
(assert (>= (num_splits request "\r\n\r\n") 2))
(assert (= header_block (split_at request "\r\n\r\n" 0)))
(assert (= body (split_rest request "\r\n\r\n" 1)))

; First line is request line, remainder are headers
(assert (>= (num_splits header_block "\r\n") 2))
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (= headers_only (split_rest header_block "\r\n" 1)))

; Must look like an HTTP request line: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re request_line (re.++ (str.to_re "GET ") (re.* re.allchar))))
(assert (str.contains request_line " HTTP/1.1"))

; Ensure at least three header lines exist (Host, Content-Length, User-Agent)
(assert (>= (num_splits headers_only "\r\n") 3))
(assert (= host_line (split_at headers_only "\r\n" 0)))
(assert (= cl_line (split_at headers_only "\r\n" 1)))
(assert (= ua_line (split_at headers_only "\r\n" 2)))

; Each header line must be key:value (at least 2 splits on ':')
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))
(assert (>= (num_splits ua_line ":") 2))

; Extract key and value using ':' delimiter
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (split_rest host_line ":" 1)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_val (split_rest cl_line ":" 1)))
(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_val (split_rest ua_line ":" 1)))

; Key validation: required header names
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Value hygiene: values non-empty, and allow optional leading space after ':'
(assert (> (str.len host_val) 0))
(assert (> (str.len cl_val) 0))
(assert (> (str.len ua_val) 0))

; Host should contain a dot somewhere (very rough validation)
(assert (= host_has_dot (str.contains host_val ".")))
(assert host_has_dot)

; Content-Length value must be all digits (allow leading space)
(assert (str.in_re cl_val (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Convert Content-Length string to integer via a constrained witness integer
(assert (>= cl_len 0))
; Link cl_len to cl_val using decimal formatting without leading/trailing junk
(assert (str.in_re (str.from_int cl_len) (re.+ (re.range "0" "9"))))
(assert (str.contains cl_val (str.from_int cl_len)))
; Also require cl_val not to contain extra digits beyond the number (tighten a bit)
(assert (= (str.replace cl_val (str.from_int cl_len) "") ""))

; Content-Length must match body length (SAT core requirement)
(assert (= cl_len (str.len body)))

; --- Additional diversity constraints (still SAT) ---
; Ensure the request contains the required Host header line text somewhere
(assert (str.contains request (str.++ "Host:" host_val "\r\n")))
; Ensure UA contains "Mozilla" or "curl" (union)
(assert (str.in_re ua_val (re.union (re.++ (re.* re.allchar) (str.to_re "Mozilla") (re.* re.allchar))
                                   (re.++ (re.* re.allchar) (str.to_re "curl") (re.* re.allchar)))))

; --- UNSAT branch (guarded) ---
(declare-const make_unsat Bool)
; If make_unsat then enforce contradictory length constraints
(assert (=> make_unsat (and (= cl_len (str.len body))
                            (= cl_len (+ (str.len body) 1)))))
; But also allow SAT by permitting make_unsat = false
(assert (or make_unsat (not make_unsat)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
