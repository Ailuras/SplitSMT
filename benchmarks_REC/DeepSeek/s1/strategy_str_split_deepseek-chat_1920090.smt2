; HTTP Header Parsing with str_split operations
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
; Declare string variables for HTTP request header and components
(declare-fun header () String)
(declare-fun content_length_key () String)
(declare-fun content_length_value () String)
(declare-fun host_key () String)
(declare-fun host_value () String)
(declare-fun user_agent_key () String)
(declare-fun user_agent_value () String)
(declare-fun first_line () String)
(declare-fun rest_headers () String)
; Declare integer variables for validation
(declare-fun content_length_int () Int)
(declare-fun total_length () Int)
; Declare uninterpreted functions for str_split interface
; Assert initial constraints on header structure
(assert (str.contains header "\n"))
(assert (>= (str.len header) 10))
; Split header into first line and rest using newline delimiter
(assert (= first_line (split_at header "\n" 0)))
(assert (= rest_headers (split_rest header "\n" 1)))
(assert (>= (num_splits header "\n") 2))
; Extract key-value pairs from rest_headers using colon delimiter
(assert (= content_length_key (split_at rest_headers ":" 0)))
(assert (= content_length_value (split_at rest_headers ":" 1)))
(assert (>= (num_splits rest_headers ":") 2))
; Validate content-length key and value
(assert (= content_length_key "Content-Length"))
(assert (str.is_digit content_length_value))
(assert (>= (str.len content_length_value) 1))
; Convert content_length_value to integer for arithmetic validation
(assert (= content_length_int (str.to_int content_length_value)))
(assert (>= content_length_int 0))
(assert (<= content_length_int 10000))
; Additional header fields for diversity
(assert (= host_key (split_at rest_headers "\n" 0)))
(assert (= host_value (split_at rest_headers "\n" 1)))
(assert (str.contains host_key "Host"))
(assert (>= (str.len host_value) 5))
(assert (= user_agent_key (split_at rest_headers "\n" 2)))
(assert (= user_agent_value (split_at rest_headers "\n" 3)))
(assert (str.contains user_agent_key "User-Agent"))
(assert (>= (str.len user_agent_value) 10))
; Ensure total length of header matches content-length constraint
(assert (= total_length (str.len header)))
(assert (<= content_length_int total_length))
; Add a contradictory constraint to create an UNSAT instance
(assert (> content_length_int total_length))
(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
