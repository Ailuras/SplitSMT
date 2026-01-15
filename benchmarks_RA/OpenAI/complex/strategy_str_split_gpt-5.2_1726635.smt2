(set-logic ALL)

; --- Uninterpreted interface ops for splitting ---
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

; --- Seed structure preserved / mutated ---
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_132387 () String)

; --- HTTP Header Parsing scenario variables ---
(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value_raw String)
(declare-const cl_value String)
(declare-const content_length Int)
(declare-const body String)

; Seed constraints (mutated: input now tied to request and further constrained)
(assert (= var_0xINPUT_132387 request))
(assert (= T_1 (= "-" var_0xINPUT_132387)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_132387)))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- Basic HTTP request structure ---
; Ensure at least request-line + headers + empty line + optional body
(assert (>= (num_splits request "\r\n") 3))
(assert (= request_line (split_at request "\r\n" 0)))
(assert (= headers_block (split_rest request "\r\n" 1)))

; request_line: "METHOD SP PATH SP HTTP/VERSION"
(assert (str.contains request_line "HTTP/"))
(assert (or (str.contains request_line "GET ") (str.contains request_line "POST ")))

; header block ends with an empty line; body starts after that
(assert (>= (num_splits headers_block "\r\n\r\n") 2))
(assert (= body (split_rest headers_block "\r\n\r\n" 1)))

; --- Extract specific headers by line position (simple model) ---
; Line 1 after request line: Host
; Line 2 after request line: Content-Length
(assert (= host_line (split_at request "\r\n" 1)))
(assert (= cl_line (split_at request "\r\n" 2)))

; Parse "Key: Value" using ':'
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value_raw (split_rest cl_line ":" 1)))

; Trim model: require a single leading space before values
(assert (= (str.at host_value 0) " "))
(assert (= (str.at cl_value_raw 0) " "))
(assert (= host_value (str.++ " " (str.substr host_value 1 (- (str.len host_value) 1)))))
(assert (= cl_value_raw (str.++ " " (str.substr cl_value_raw 1 (- (str.len cl_value_raw) 1)))))
(assert (= cl_value (str.substr cl_value_raw 1 (- (str.len cl_value_raw) 1))))

; Validate header keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value sanity
(assert (> (str.len (str.substr host_value 1 (- (str.len host_value) 1))) 0))
(assert (str.contains (str.substr host_value 1 (- (str.len host_value) 1)) "."))

; Content-Length digits only (simple numeric validation)
(assert (> (str.len cl_value) 0))
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Bind an integer approximation of content-length via constraints
(assert (>= content_length 0))
(assert (<= content_length 1000000))

; SAT branch: allow either a consistent length or inconsistent; force consistent here
; If cl_value is "0" then body must be empty; otherwise body length must be > 0
(assert (or (and (= cl_value "0") (= (str.len body) 0) (= content_length 0))
            (and (not (= cl_value "0")) (> (str.len body) 0) (> content_length 0))))

; Additional structural constraints: ensure no stray '-' or empty request
(assert (not (str.contains request "\n\n")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
