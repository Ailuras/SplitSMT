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

; Declare string variables for HTTP request headers
(declare-const header_block String)
(declare-const content_length_header String)
(declare-const content_length_value String)
(declare-const host_header String)
(declare-const host_value String)
(declare-const user_agent_header String)
(declare-const user_agent_value String)

; Declare integer variables for validation
(declare-const content_length_int Int)
(declare-const header_count Int)

; Declare uninterpreted functions for str_split interface

; Define header block with key-value pairs separated by newlines
(assert (= header_block (str.++ "Host: example.com\n" "Content-Length: 1024\n" "User-Agent: Mozilla/5.0\n")))

; Extract Content-Length header using split operations
(assert (= content_length_header (split_at header_block "\n" 1))) ; Second header (index 1)
(assert (= content_length_value (split_at content_length_header ": " 1))) ; Value part after ": "

; Extract Host header
(assert (= host_header (split_at header_block "\n" 0))) ; First header (index 0)
(assert (= host_value (split_at host_header ": " 1))) ; Value part after ": "

; Extract User-Agent header
(assert (= user_agent_header (split_at header_block "\n" 2))) ; Third header (index 2)
(assert (= user_agent_value (split_at user_agent_header ": " 1))) ; Value part after ": "

; Validate number of headers
(assert (= header_count (num_splits header_block "\n")))
(assert (>= header_count 3)) ; At least three headers

; Convert content-length value to integer and validate
(assert (= content_length_int (str.to_int content_length_value)))
(assert (>= content_length_int 0)) ; Non-negative content length
(assert (<= content_length_int 10000)) ; Reasonable upper bound

; Additional constraints for header values
(assert (str.contains host_value ".")) ; Host must contain a dot
(assert (str.contains user_agent_value "Mozilla")) ; User-Agent must contain Mozilla

; Ensure all headers have proper key-value format
(assert (>= (num_splits host_header ": ") 2))
(assert (>= (num_splits content_length_header ": ") 2))
(assert (>= (num_splits user_agent_header ": ") 2))

; Check for no empty values
(assert (not (= host_value "")))
(assert (not (= content_length_value "")))
(assert (not (= user_agent_value "")))

; Final consistency check
(assert (distinct host_value content_length_value user_agent_value))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
