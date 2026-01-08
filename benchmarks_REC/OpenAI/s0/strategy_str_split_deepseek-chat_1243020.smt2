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

; Uninterpreted split interface (string split via relaxation)

; -------- Shared symbols --------
(declare-const request String)
(declare-const headers String)
(declare-const body String)
(declare-const header_line0 String)
(declare-const header_line1 String)
(declare-const header_line2 String)
(declare-const header_line3 String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)
(declare-const parsed_len Int)

; Additional strings for constraints and diversity
(declare-const method_line String)
(declare-const http_version String)
(declare-const request_target String)
(declare-const host_name String)
(declare-const host_port String)
(declare-const ua_key String)
(declare-const ua_value String)

; -------- Basic HTTP request structure constraints --------
; request = headers + "\r\n\r\n" + body
(assert (= headers (split_at request "\r\n\r\n" 0)))
(assert (= body (split_at request "\r\n\r\n" 1)))
(assert (>= (num_splits request "\r\n\r\n") 2))

; headers consists of CRLF-separated lines; require at least request-line + 2 header lines
(assert (>= (num_splits headers "\r\n") 3))
(assert (= method_line (split_at headers "\r\n" 0)))
(assert (= header_line0 (split_at headers "\r\n" 1)))
(assert (= header_line1 (split_at headers "\r\n" 2)))
(assert (= header_line2 (split_at headers "\r\n" 3)))
(assert (= header_line3 (split_at headers "\r\n" 4)))

; Request-line: "GET <target> HTTP/1.1" (relaxed via split)
(assert (= "GET" (split_at method_line " " 0)))
(assert (= request_target (split_at method_line " " 1)))
(assert (= http_version (split_at method_line " " 2)))
(assert (= "HTTP/1.1" http_version))
(assert (>= (num_splits method_line " ") 3))

; Target is a path starting with '/'
(assert (>= (str.len request_target) 1))
(assert (= "/" (str.substr request_target 0 1)))

; -------- Parse Host header line --------
; Ensure there is a Host header among the first few header lines
; We'll pick header_line0 as Host for the SAT core instance
(assert (= host_key (split_at header_line0 ":" 0)))
(assert (= host_value (split_at header_line0 ":" 1)))
(assert (>= (num_splits header_line0 ":") 2))
(assert (= "Host" host_key))

; Host value has optional leading space and optional ":<port>" suffix
; Constrain it to be " example.com:80" style (leading space)
(assert (>= (str.len host_value) 1))
(assert (= " " (str.substr host_value 0 1)))
(assert (= host_name (split_at (str.substr host_value 1 (- (str.len host_value) 1)) ":" 0)))
(assert (= host_port (split_at (str.substr host_value 1 (- (str.len host_value) 1)) ":" 1)))
(assert (>= (num_splits (str.substr host_value 1 (- (str.len host_value) 1)) ":") 2))

; Hostname is example.com (fixed for satisfiable instance)
(assert (= "example.com" host_name))

; Port must be numeric; approximate by constraining exact "80" here
(assert (= "80" host_port))

; -------- Parse Content-Length header line --------
; Use header_line1 as Content-Length
(assert (= cl_key (split_at header_line1 ":" 0)))
(assert (= cl_value (split_at header_line1 ":" 1)))
(assert (>= (num_splits header_line1 ":") 2))
(assert (= "Content-Length" cl_key))

; cl_value has a leading space then digits; enforce a concrete digit string for SAT instance
(assert (>= (str.len cl_value) 2))
(assert (= " " (str.substr cl_value 0 1)))
(assert (= "5" (str.substr cl_value 1 1)))
(assert (= 5 content_length))
(assert (= 5 parsed_len))

; Validate content length equals body length
(assert (= parsed_len (str.len body)))
(assert (= content_length parsed_len))

; -------- Additional header parsing (User-Agent) for diversity --------
; Use header_line2 as User-Agent
(assert (= ua_key (split_at header_line2 ":" 0)))
(assert (= ua_value (split_at header_line2 ":" 1)))
(assert (>= (num_splits header_line2 ":") 2))
(assert (= "User-Agent" ua_key))

; UA value must contain "curl" somewhere (after optional leading space)
(assert (>= (str.len ua_value) 1))
(assert (= " " (str.substr ua_value 0 1)))
(assert (str.contains (str.substr ua_value 1 (- (str.len ua_value) 1)) "curl"))

; -------- Construct one concrete satisfiable request (ties split results together) --------
(assert (= method_line "GET /index.html HTTP/1.1"))
(assert (= header_line0 "Host: example.com:80"))
(assert (= header_line1 "Content-Length: 5"))
(assert (= header_line2 "User-Agent: curl/8.0"))

; Add an extra header line for realism
(assert (= header_line3 "Accept: */*"))

; Combine headers with CRLF (not all split constraints enforce exact reconstruction; we provide a concrete headers string)
(assert (= headers (str.++ method_line "\r\n" header_line0 "\r\n" header_line1 "\r\n" header_line2 "\r\n" header_line3)))

; Concrete body is length 5
(assert (= body "hello"))
(assert (= request (str.++ headers "\r\n\r\n" body)))

; -------- Create an UNSAT sub-instance to mix SAT and UNSAT in one file --------
; This block is intentionally inconsistent with the established SAT instance.
; It encodes a contradictory requirement: Content-Length must also equal 6.
(assert (not (= content_length 6)))
(assert (= content_length 6))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
