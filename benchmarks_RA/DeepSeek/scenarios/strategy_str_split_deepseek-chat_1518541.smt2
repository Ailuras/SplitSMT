; HTTP Header Parsing with str_split operations
; Extracting values from HTTP request headers using colons and newlines
; Validating content-length and handling key-value pairs
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

; Declare string variables for HTTP headers
(declare-fun request_headers () String)
(declare-fun header_key () String)
(declare-fun header_value () String)
(declare-fun content_length_str () String)
(declare-fun content_type () String)

; Declare integer variables for validation
(declare-const content_length_val Int)
(declare-const colon_index Int)
(declare-const newline_index Int)

; Declare str_split interface functions

; Core constraints for HTTP header parsing
; Extract first header line using newline delimiter
(assert (= header_key (split_at request_headers "\n" 0)))
(assert (>= (num_splits request_headers "\n") 2))

; Split the first header line by colon to get key-value pair
(assert (= colon_index (str.indexof header_key ":" 0)))
(assert (> colon_index 0))
(assert (= header_value (str.substr header_key (+ colon_index 1) (- (str.len header_key) (+ colon_index 1)))))

; Extract content-length header using str_split
(assert (= content_length_str (split_at request_headers "Content-Length:" 1)))
(assert (>= (num_splits request_headers "Content-Length:") 2))

; Convert content-length string to integer
(assert (str.is_digit content_length_str))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (>= content_length_val 0))
(assert (<= content_length_val 10000))

; Extract content-type header
(assert (= content_type (split_at request_headers "Content-Type:" 1)))
(assert (>= (num_splits request_headers "Content-Type:") 2))

; Validate content-type values
(assert (or (= content_type "text/html")
            (= content_type "application/json")
            (= content_type "text/plain")))

; Additional constraints for header structure
(assert (str.contains request_headers "\n\n"))  ; Empty line separating headers and body
(assert (str.contains header_key ":"))
(assert (not (str.contains header_value ":")))  ; Value should not contain colon

; Ensure header key is not empty
(assert (> (str.len header_key) 0))
(assert (> (str.len header_value) 0))

; Check for specific required headers
(assert (str.contains request_headers "Host:"))
(assert (str.contains request_headers "User-Agent:"))

; Final consistency check
(assert (>= (num_splits request_headers "\n") 3))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
