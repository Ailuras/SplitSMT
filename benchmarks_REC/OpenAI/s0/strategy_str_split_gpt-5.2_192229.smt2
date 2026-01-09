(set-logic ALL)

; Uninterpreted interface: str_split
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

; -----------------------------
; Scenario: HTTP Header Parsing
; -----------------------------

; Common delimiters
(declare-const delim_crlf String)
(declare-const delim_colon String)
(assert (= delim_crlf "\r\n"))
(assert (= delim_colon ":"))

; Whole HTTP header block (request-line + headers + blank line + optional body)
(declare-const http_blob String)

; Split request into lines
(declare-const request_line String)
(declare-const line_host String)
(declare-const line_content_length String)
(declare-const line_user_agent String)
(declare-const line_blank_or_rest String)

(assert (>= (num_splits http_blob delim_crlf) 4))
(assert (= request_line (split_at http_blob delim_crlf 0)))
(assert (= line_host (split_at http_blob delim_crlf 1)))
(assert (= line_content_length (split_at http_blob delim_crlf 2)))
(assert (= line_user_agent (split_at http_blob delim_crlf 3)))
(assert (= line_blank_or_rest (split_rest http_blob delim_crlf 4)))

; Request line basic structure: METHOD SP PATH SP HTTP/VERSION
(declare-const method String)
(declare-const path String)
(declare-const version String)
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))

; Constrain method/version to plausible forms
(assert (or (= method "GET") (= method "POST")))
(assert (str.in_re version (str.to_re "HTTP/1.1")))

; -----------------------------
; SAT parsing/validation branch
; -----------------------------

; Parse Host header: "Host: <value>"
(declare-const host_key String)
(declare-const host_value String)
(assert (>= (num_splits line_host delim_colon) 2))
(assert (= host_key (split_at line_host delim_colon 0)))
(assert (= host_value (split_rest line_host delim_colon 1)))

; Parse Content-Length header: "Content-Length: <digits>"
(declare-const cl_key String)
(declare-const cl_value_raw String)
(declare-const cl_value String)
(assert (>= (num_splits line_content_length delim_colon) 2))
(assert (= cl_key (split_at line_content_length delim_colon 0)))
(assert (= cl_value_raw (split_rest line_content_length delim_colon 1)))

; Normalize by requiring a leading space before the value and then extracting digits
; Example: cl_value_raw == " 123"
(assert (>= (str.len cl_value_raw) 2))
(assert (= (str.at cl_value_raw 0) " "))
(assert (= cl_value (str.substr cl_value_raw 1 (- (str.len cl_value_raw) 1))))

; Digit regex for Content-Length
(define-fun re_digit () RegLan (re.range "0" "9"))
(define-fun re_digits_plus () RegLan (re.++ (re.range "0" "9") (re.* (re.range "0" "9"))))
(assert (str.in_re cl_value re_digits_plus))

; Convert Content-Length string to Int via str.to_int, require it is defined (not (- 1))
(declare-const content_length Int)
(assert (= content_length (str.to_int cl_value)))
(assert (>= content_length 0))

; Parse User-Agent similarly, but allow any non-empty value after ":"
(declare-const ua_key String)
(declare-const ua_value_raw String)
(declare-const ua_value String)
(assert (>= (num_splits line_user_agent delim_colon) 2))
(assert (= ua_key (split_at line_user_agent delim_colon 0)))
(assert (= ua_value_raw (split_rest line_user_agent delim_colon 1)))
(assert (>= (str.len ua_value_raw) 2))
(assert (= (str.at ua_value_raw 0) " "))
(assert (= ua_value (str.substr ua_value_raw 1 (- (str.len ua_value_raw) 1))))
(assert (>= (str.len ua_value) 1))

; Keys match expected names
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Host value sanity: require it contains a dot and no CRLF
(assert (str.contains host_value "."))
(assert (not (str.contains host_value delim_crlf)))

; Body begins after the blank line; enforce that there is a blank line and a body segment exists
; Require the remainder to start with CRLF (i.e., empty line) then body
(declare-const rest_after_headers String)
(declare-const body String)
(assert (= rest_after_headers line_blank_or_rest))

; For simplicity, require rest_after_headers begins with "\r\n" then body
(assert (>= (str.len rest_after_headers) 2))
(assert (= (str.substr rest_after_headers 0 2) delim_crlf))
(assert (= body (str.substr rest_after_headers 2 (- (str.len rest_after_headers) 2))))

; Validate Content-Length equals actual body length (SAT instance)
(assert (= content_length (str.len body)))

; Additional plausibility: path starts with '/'
(assert (>= (str.len path) 1))
(assert (= (str.at path 0) "/"))

; -----------------------------
; UNSAT sub-instance (guarded)
; Mix in an explicit contradictory requirement to create an UNSAT branch,
; but guard it with a boolean that is asserted false for overall SAT.
; This demonstrates both SAT/UNSAT patterns in one file.
; -----------------------------

(declare-const enable_unsat_branch Bool)
(assert (= enable_unsat_branch false))

; Contradiction: if enabled, force content_length to differ from body length
(assert (=> enable_unsat_branch (not (= content_length (str.len body)))))

; Another contradiction: if enabled, require Content-Length value to be non-digits
(assert (=> enable_unsat_branch (not (str.in_re cl_value re_digits_plus))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
