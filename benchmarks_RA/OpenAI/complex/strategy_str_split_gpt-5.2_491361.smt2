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

; Uninterpreted interface functions for string splitting

; Seed remnants / core structure preserved
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_18057 () String)
(assert (= T_1 (= "-" var_0xINPUT_18057)))
(assert T_1)

; Scenario: HTTP Header Parsing
(declare-const request String)
(declare-const headers String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const body String)
(declare-const content_length Int)
(declare-const actual_body_len Int)
(declare-const i Int)

; Split request into lines by newline. Line 0 is request line.
(assert (= request_line (split_at request "\n" 0)))
(assert (= headers (split_rest request "\n" 1)))
(assert (>= (num_splits request "\n") 4))

; Ensure request line looks like: "GET / HTTP/1.1"
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET"))

; Parse some header lines (assume they exist at fixed positions for this model)
(assert (= host_line (split_at request "\n" 1)))
(assert (= ua_line   (split_at request "\n" 2)))
(assert (= cl_line   (split_at request "\n" 3)))

; Each header line should contain a colon separator
(assert (str.contains host_line ":"))
(assert (str.contains ua_line ":"))
(assert (str.contains cl_line ":"))

; Split header lines by ":" into key and value segments
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (split_rest host_line ":" 1)))
(assert (= ua_key   (split_at ua_line ":" 0)))
(assert (= ua_val   (split_rest ua_line ":" 1)))
(assert (= cl_key   (split_at cl_line ":" 0)))
(assert (= cl_val   (split_rest cl_line ":" 1)))

; Validate required header keys (case-sensitive in this simplified model)
(assert (= host_key "Host"))
(assert (= ua_key "User-Agent"))
(assert (= cl_key "Content-Length"))

; Trim-like constraints via containment (no real trim function available)
(assert (not (= host_val "")))
(assert (not (= ua_val "")))
(assert (not (= cl_val "")))

; Content-Length value must be all digits (allow a leading space before digits)
; Regex: (" ")? [0-9]+
(assert (str.in_re cl_val (re.++ (re.opt (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Relate content_length to some numeric property; use a simple bounded interpretation
; (since full string-to-int is not part of the provided interface)
(assert (>= content_length 0))
(assert (<= content_length 1024))

; Define body as everything after header lines (from line 4 onwards)
(assert (= body (split_rest request "\n" 4)))
(assert (= actual_body_len (str.len body)))

; SAT instance: accept consistent length
(assert (= actual_body_len content_length))

; Add some additional structure: header section must end with an empty line at line 4
(assert (= (split_at request "\n" 4) ""))

; Ensure host value contains a dot, like a domain
(assert (str.contains host_val "."))

; Index constraints for interface natural indices
(assert (>= i 0))
(assert (< i (num_splits request "\n")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
