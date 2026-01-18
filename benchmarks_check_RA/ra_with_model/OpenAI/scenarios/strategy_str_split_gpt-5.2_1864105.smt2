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

; Uninterpreted interface for str_split

; Additional uninterpreted parsing helpers (non-primitive)
(declare-fun parse_int (String) Int)

; ========== Shared declarations ==========
(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const body String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)

(declare-const host_key String)
(declare-const host_val_raw String)
(declare-const host_val String)

(declare-const cl_key String)
(declare-const cl_val_raw String)
(declare-const cl_val String)
(declare-const cl_int Int)

(declare-const ua_key String)
(declare-const ua_val_raw String)
(declare-const ua_val String)

(declare-const rest_after_reqline String)
(declare-const rest_after_headers String)

(declare-const sat_case Bool)

; ========== Global structure: request line, headers, blank line, body ==========
; Split by CRLF (\r\n): first segment is request line
(assert (= request_line (split_at request "\r\n" 0)))
(assert (= rest_after_reqline (split_rest request "\r\n" 1)))

; Headers end at the first empty line: model as splitting the remainder by double-CRLF
(assert (= headers_block (split_at rest_after_reqline "\r\n\r\n" 0)))
(assert (= rest_after_headers (split_rest rest_after_reqline "\r\n\r\n" 1)))
(assert (= body rest_after_headers))

; Basic sanity: must contain at least one header line and a body boundary
(assert (>= (num_splits rest_after_reqline "\r\n\r\n") 2))
(assert (>= (num_splits headers_block "\r\n") 2))

; ========== Identify specific header lines by position (simplified scenario) ==========
(assert (= host_line (split_at headers_block "\r\n" 0)))
(assert (= cl_line (split_at headers_block "\r\n" 1)))
(assert (= ua_line (split_at headers_block "\r\n" 2)))
(assert (>= (num_splits headers_block "\r\n") 3))

; ========== Parse key/value by colon delimiter ==========
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val_raw (split_rest host_line ":" 1)))

(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_val_raw (split_rest cl_line ":" 1)))

(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_val_raw (split_rest ua_line ":" 1)))

; Require the header lines to actually contain ':' (at least 2 segments)
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))
(assert (>= (num_splits ua_line ":") 2))

; In this simplified model, require a single ':' per header line
(assert (= (num_splits host_line ":") 2))
(assert (= (num_splits cl_line ":") 2))
(assert (= (num_splits ua_line ":") 2))

; ========== Whitespace handling (simplified): require single leading space in values ==========
(assert (= (str.at host_val_raw 0) " "))
(assert (= (str.at cl_val_raw 0) " "))
(assert (= (str.at ua_val_raw 0) " "))

(assert (>= (str.len host_val_raw) 2))
(assert (>= (str.len cl_val_raw) 2))
(assert (>= (str.len ua_val_raw) 2))

; Drop the leading space
(assert (= host_val (str.substr host_val_raw 1 (- (str.len host_val_raw) 1))))
(assert (= cl_val (str.substr cl_val_raw 1 (- (str.len cl_val_raw) 1))))
(assert (= ua_val (str.substr ua_val_raw 1 (- (str.len ua_val_raw) 1))))

; ========== Header key validation (case-sensitive for this scenario) ==========
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Host value must be non-empty and contain a dot (e.g., example.com)
(assert (> (str.len host_val) 0))
(assert (str.contains host_val "."))

; User-Agent must be non-empty
(assert (> (str.len ua_val) 0))

; Content-Length numeric parsing and validation
(assert (= cl_int (parse_int cl_val)))
(assert (>= cl_int 0))

; ========== Request line basic validation ==========
; Require it starts with "POST " and contains " HTTP/1.1"
(assert (str.contains request_line " HTTP/1.1"))
(assert (= (str.substr request_line 0 5) "POST "))

; ========== Content-Length matches body length (SAT branch) ==========
(declare-const request_sat String)
(declare-const request_unsat String)

; Use sat_case to select which instance is active
(assert (= request (ite sat_case request_sat request_unsat)))

; --- SAT instance: consistent content-length ---
(declare-const sat_body String)
(declare-const sat_cl_val String)
(declare-const sat_cl_int Int)

(assert (= sat_body "hello=world"))
(assert (= sat_cl_val "11"))
(assert (= sat_cl_int (parse_int sat_cl_val)))

(assert (= request_sat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    (str.++ "Content-Length: " (str.++ sat_cl_val "\r\n"))
    "User-Agent: TestAgent/1.0\r\n"
    "\r\n"
    sat_body)))

; enforce the intended relation in the SAT instance
(assert (= sat_cl_int (str.len sat_body)))

; --- UNSAT instance: inconsistent content-length ---
(declare-const unsat_body String)
(declare-const unsat_cl_val String)
(declare-const unsat_cl_int Int)

(assert (= unsat_body "ABCDE"))
(assert (= unsat_cl_val "4"))
(assert (= unsat_cl_int (parse_int unsat_cl_val)))

(assert (= request_unsat
  (str.++
    "POST /submit HTTP/1.1\r\n"
    "Host: example.com\r\n"
    (str.++ "Content-Length: " (str.++ unsat_cl_val "\r\n"))
    "User-Agent: TestAgent/1.0\r\n"
    "\r\n"
    unsat_body)))

; force the inconsistency for the UNSAT instance
(assert (not (= unsat_cl_int (str.len unsat_body))))

; ========== Connect extracted Content-Length to body length depending on chosen case ==========
; When sat_case is true, the parsed content-length must match the extracted body length
; When sat_case is false, we demand the opposite, making the entire instance UNSAT for that branch.
(assert (ite sat_case
  (= cl_int (str.len body))
  (not (= cl_int (str.len body)))))

; Additionally, tie the cl_val to the chosen concrete request content-length value
(assert (= cl_val (ite sat_case sat_cl_val unsat_cl_val)))

; Choose one: set sat_case to true for SAT, false for UNSAT.
; Leaving it unconstrained lets the solver pick SAT via sat_case = true.



; [GENERATION STATUS: SUCCESS]
(assert (= rest_after_reqline "n"))
(assert (= rest_after_headers "F]GIJ[_"))
(assert (= sat_cl_int 11))
(assert (= sat_cl_val "11"))
(assert (= request "POST /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 4\r\nUser-Agent: TestAgent/1.0\r\n\r\nABCDE"))
(assert (= ua_key "User-Agent"))
(assert (= host_val "."))
(assert (= ua_line "r\n"))
(assert (= cl_int 6))
(assert (= cl_val_raw " 4"))
(assert (= request_unsat "POST /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 4\r\nUser-Agent: TestAgent/1.0\r\n\r\nABCDE"))
(assert (= body "F]GIJ[_"))
(assert (= host_val_raw " ."))
(assert (= unsat_cl_int 6))
(assert (= ua_val "4"))
(assert (= request_line "POST  HTTP/1.1"))
(assert (= host_key "Host"))
(assert (= cl_line "r"))
(assert (= cl_key "Content-Length"))
(assert (= unsat_cl_val "4"))
(assert (= sat_case false))
(assert (= cl_val "4"))
(assert (= headers_block "\")
  (define-fun sat_body () String
    "))
(assert (= ua_val_raw " 4"))
(assert (= host_line "\n"))
(assert (= unsat_body "ABCDE"))
(assert (= request_sat "POST /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 11\r\nUser-Agent: TestAgent/1.0\r\n\r\nhello=world"))
(check-sat)
(exit)
