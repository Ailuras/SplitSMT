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

; HTTP Header Parsing scenario: parse request headers with colon and CRLF, validate Content-Length

; --- str_split interface (uninterpreted) ---

; --- Variables ---
(declare-const X String)               ; full HTTP request headers (possibly including request-line)
(declare-const request_line String)
(declare-const headers_blob String)
(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const user_agent_line String)
(declare-const ua_key String)
(declare-const ua_value String)
(declare-const body String)
(declare-const cl_num_str String)

; Basic structure: request-line then headers then blank line then body
(assert (= request_line (split_at X "\r\n" 0)))
(assert (= headers_blob (split_rest X "\r\n" 1)))
(assert (>= (num_splits X "\r\n") 3))

; Require a blank line separator somewhere: "\r\n\r\n" must occur
(assert (str.contains X "\r\n\r\n"))

; Constrain request-line format: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re request_line (re.++ (re.union (str.to_re "GET") (str.to_re "POST") (str.to_re "HEAD"))
                                           (str.to_re " ")
                                           (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "/") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "?") (str.to_re "=") (str.to_re "&")))
                                           (str.to_re " ")
                                           (str.to_re "HTTP/1.1"))))

; Parse specific header lines by index after request-line
(assert (= host_line (split_at X "\r\n" 1)))
(assert (= user_agent_line (split_at X "\r\n" 2)))
(assert (= cl_line (split_at X "\r\n" 3)))

; Each header line is Key:Value; split on first ':' (relaxed via split_at)
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= ua_key (split_at user_agent_line ":" 0)))
(assert (= ua_value (split_rest user_agent_line ":" 1)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))

; Keys must match expected header names
(assert (= host_key "Host"))
(assert (= ua_key "User-Agent"))
(assert (= cl_key "Content-Length"))

; Whitespace after ':' allowed: optional spaces/tabs before actual value
(assert (str.in_re host_value (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\t")))
                                     (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re ".")))
                                     (re.opt (re.++ (str.to_re ":") (re.+ (re.range "0" "9")))))))

(assert (str.in_re ua_value (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\t")))
                                   (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re " ") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "/") (str.to_re "(") (str.to_re ")"))))))

; Content-Length must be digits only (allow leading whitespace)
(assert (= cl_num_str (str.replace cl_value " " "")))
(assert (str.in_re cl_num_str (re.+ (re.range "0" "9"))))

; Also ensure Content-Length line has exactly one ':' occurrence (two segments)
(assert (= (num_splits cl_line ":") 2))

; Avoid obviously malformed headers (mutated from seed: forbid some embedded Host/Subject injection patterns)
(assert (not (str.contains X "Subject:")))
(assert (not (str.contains X "\u{1b}Host:")))
(assert (not (str.contains X "Host:\n")))

; Ensure CRLF is used, no bare LF-only lines inside the first part
(assert (not (str.contains request_line "\n")))
(assert (not (str.contains request_line "\r\r")))

; Body is the substring after the blank line; relaxed via split_rest on "\r\n\r\n"
(assert (= body (split_rest X "\r\n\r\n" 1)))
(assert (>= (num_splits X "\r\n\r\n") 2))

; Validate Content-Length against body length with a bounded numeric regex for 0..9999 then relate by cases
; (we avoid direct string-to-int conversion by constraining representative lengths)
(assert (str.in_re cl_num_str (re.union
  (str.to_re "0")
  (re.++ (re.range "1" "9") (re.* (re.range "0" "9")))
)))

; Constrain body length to be consistent with a small content-length window for satisfiable instances
; Choose a concrete length by forcing cl_num_str and body length to match a specific value.
(assert (= cl_num_str "12"))
(assert (= (str.len body) 12))

; Extra: require Host value includes a dot (e.g., example.com)
(assert (str.contains host_value "."))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
