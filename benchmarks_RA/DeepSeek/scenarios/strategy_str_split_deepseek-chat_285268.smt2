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
; Declare variables for HTTP header parsing
(declare-fun header_string () String)
(declare-fun content_length_key () String)
(declare-fun content_length_value () String)
(declare-fun host_key () String)
(declare-fun host_value () String)
(declare-fun user_agent_key () String)
(declare-fun user_agent_value () String)
(declare-fun total_segments () Int)
; Declare functions for string split operations
; Assert that header_string is non-empty and contains newlines and colons
(assert (>= (str.len header_string) 10))
(assert (str.contains header_string "\n"))
(assert (str.contains header_string ":"))
; Split header_string by newline to get lines
(assert (= total_segments (num_splits header_string "\n")))
(assert (>= total_segments 3))
; Extract key-value pairs from specific lines using colon as delimiter
(assert (= content_length_key (split_at (split_at header_string "\n" 0) ":" 0)))
(assert (= content_length_value (split_at (split_at header_string "\n" 0) ":" 1)))
(assert (= host_key (split_at (split_at header_string "\n" 1) ":" 0)))
(assert (= host_value (split_at (split_at header_string "\n" 1) ":" 1)))
(assert (= user_agent_key (split_at (split_at header_string "\n" 2) ":" 0)))
(assert (= user_agent_value (split_at (split_at header_string "\n" 2) ":" 1)))
; Validate that keys are non-empty and specific
(assert (= content_length_key "Content-Length"))
(assert (= host_key "Host"))
(assert (= user_agent_key "User-Agent"))
; Validate content-length value is a positive integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (>= (str.to_int content_length_value) 0))
; Ensure no percent signs in any value to avoid URL encoding issues
(assert (not (str.contains content_length_value "%")))
(assert (not (str.contains host_value "%")))
(assert (not (str.contains user_agent_value "%")))
; Additional constraint: host_value must contain a dot for domain
(assert (str.contains host_value "."))
; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
