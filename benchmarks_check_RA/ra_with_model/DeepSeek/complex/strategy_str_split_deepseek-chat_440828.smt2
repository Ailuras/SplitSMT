; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
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

; Declare variables for the HTTP header string and its components
(declare-const header String)
(declare-const first_line String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)

; Declare uninterpreted functions for string split operations as per the interface

; Assert that the header contains at least two lines separated by newline delimiter "\n"
(assert (>= (num_splits header "\n") 2))

; Extract the first line (e.g., request line like "GET / HTTP/1.1") by splitting on newline
(assert (= first_line (split_at header "\n" 0)))

; Extract the second line (e.g., a header line like "Content-Length: 123") by splitting on newline
(assert (= content_length_str (split_at header "\n" 1)))

; Assert that the second line contains a colon delimiter to separate key and value
(assert (>= (num_splits content_length_str ":") 2))

; Extract the key part (e.g., "Content-Length") from the second line by splitting on colon
(assert (= key1 (split_at content_length_str ":" 0)))

; Extract the value part (e.g., "123") from the second line by splitting on colon
(assert (= value1 (split_at content_length_str ":" 1)))

; Assert that the key is exactly "Content-Length" to validate the header
(assert (= key1 "Content-Length"))

; Convert the value string to an integer for content-length validation
(assert (= content_length_val (str.to_int value1)))

; Assert that the content-length is a positive integer (e.g., greater than 0)
(assert (> content_length_val 0))

; Additional constraint: Ensure the header has at least one more key-value pair after the first two lines
(assert (>= (num_splits header "\n") 3))

; Extract the third line (e.g., "Host: example.com") by splitting on newline
(assert (= (split_at header "\n" 2) (str.++ key2 ":" value2)))

; Assert that the third line also contains a colon delimiter
(assert (>= (num_splits (split_at header "\n" 2) ":") 2))

; Extract key and value from the third line
(assert (= key2 (split_at (split_at header "\n" 2) ":" 0)))
(assert (= value2 (split_at (split_at header "\n" 2) ":" 1)))

; Assert that the key in the third line is non-empty to ensure a valid header
(assert (> (str.len key2) 0))

; Final check: Ensure the entire header string is non-empty
(assert (> (str.len header) 0))



; [GENERATION STATUS: SUCCESS]
(assert (= header "n"))
(assert (= key2 "n"))
(assert (= key1 "Content-Length"))
(assert (= value2 ""))
(assert (= content_length_val 2))
(assert (= first_line "\")
  (define-fun content_length_str () String
    "))
(assert (= value1 "2"))
(check-sat)
(exit)
