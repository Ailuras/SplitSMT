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

; Uninterpreted interface for string split operations

; -------------------------------
; Scenario: HTTP Header Parsing
; -------------------------------

; Full raw HTTP request header block (request line + headers + blank line + optional body)
(declare-const http_req String)

; Common delimiters
(declare-const DCRLF String)
(declare-const DCOLON String)

(assert (= DCRLF "\r\n"))
(assert (= DCOLON ":"))

; Request line (first line)
(declare-const req_line String)
(assert (= req_line (split_at http_req DCRLF 0)))

; Method and path parsed using spaces
(declare-const method String)
(declare-const path String)
(declare-const version String)
(assert (= method (split_at req_line " " 0)))
(assert (= path   (split_at req_line " " 1)))
(assert (= version (split_at req_line " " 2)))
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "HTTP/1." version))
(assert (str.prefixof "/" path))

; Ensure there is at least one header line and the header section terminates with an empty line
; Lines: 0=req line, 1=Host, 2=Content-Length, 3=User-Agent, 4="" (blank), 5=body (possibly empty)
(assert (>= (num_splits http_req DCRLF) 5))

(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)
(declare-const line4 String)
(declare-const body String)

(assert (= line1 (split_at http_req DCRLF 1)))
(assert (= line2 (split_at http_req DCRLF 2)))
(assert (= line3 (split_at http_req DCRLF 3)))
(assert (= line4 (split_at http_req DCRLF 4)))

(assert (= line4 ""))
(assert (= body (split_rest http_req DCRLF 5)))

; --- Parse Host header: "Host: <value>"
(declare-const host_key String)
(declare-const host_val String)
(assert (= host_key (split_at line1 DCOLON 0)))
(assert (= host_val (split_at line1 DCOLON 1)))
(assert (= host_key "Host"))
(assert (str.prefixof " " host_val))
(assert (>= (str.len host_val) 2))

; --- Parse Content-Length header: "Content-Length: <digits>"
(declare-const cl_key String)
(declare-const cl_val_raw String)
(declare-const cl_val String)
(assert (= cl_key (split_at line2 DCOLON 0)))
(assert (= cl_val_raw (split_at line2 DCOLON 1)))
(assert (= cl_key "Content-Length"))
(assert (str.prefixof " " cl_val_raw))
(assert (= cl_val (str.substr cl_val_raw 1 (- (str.len cl_val_raw) 1))))

; Content-Length must be all digits and non-empty
(assert (>= (str.len cl_val) 1))
(assert (str.in_re cl_val (re.+ (re.range "0" "9"))))

; Convert Content-Length to Int with str.to_int, constrain it to be valid
(declare-const cl_int Int)
(assert (= cl_int (str.to_int cl_val)))
(assert (>= cl_int 0))
(assert (<= cl_int 1000000))

; If POST, require a Content-Length and enforce body length equals it.
; If GET, enforce Content-Length is 0 and body is empty.
(assert (=> (= method "POST") (= (str.len body) cl_int)))
(assert (=> (= method "GET") (and (= cl_int 0) (= body ""))))

; --- Parse User-Agent header (allow any value, but validate format has a colon)
(declare-const ua_key String)
(declare-const ua_val String)
(assert (= ua_key (split_at line3 DCOLON 0)))
(assert (= ua_val (split_at line3 DCOLON 1)))
(assert (= ua_key "User-Agent"))
(assert (str.prefixof " " ua_val))

; Ensure header lines actually contain ':' by requiring at least 2 segments when split on ':'
(assert (>= (num_splits line1 DCOLON) 2))
(assert (>= (num_splits line2 DCOLON) 2))
(assert (>= (num_splits line3 DCOLON) 2))

; -------------------------------
; Additional diversity constraints (SAT-leaning core)
; -------------------------------

; Host value cannot contain CRLF
(assert (not (str.contains host_val DCRLF)))

; User-Agent value should contain at least one slash or space (typical tokens)
(assert (or (str.contains ua_val "/") (str.contains ua_val " ")))

; -------------------------------
; Embedded UNSAT instance (guarded)
; Toggle make_unsat to true to force contradiction.
; -------------------------------

(declare-const make_unsat Bool)

; Contradiction: if enabled, require method=GET but also require positive content-length and matching non-empty body.
(assert (=> make_unsat (and (= method "GET") (> cl_int 0))))
(assert (=> make_unsat (and (> (str.len body) 0) (= (str.len body) cl_int))))

; Also add an independent contradiction for demonstration: Host key must be Host and not Host.
(assert (=> make_unsat (and (= host_key "Host") (not (= host_key "Host")))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
