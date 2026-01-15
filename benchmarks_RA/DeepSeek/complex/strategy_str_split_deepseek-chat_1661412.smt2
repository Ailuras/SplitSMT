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
(declare-const key String)
(declare-const value String)

; Declare functions for string split operations as per the interface

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header by newlines to get the first line (e.g., request line)
(assert (= first_line (split_at header "\n" 0)))
(assert (>= (num_splits header "\n") 1))

; Assert that the first line contains a colon to indicate a key-value pair (e.g., "Host: example.com")
(assert (str.contains first_line ":"))

; Split the first line by colon to extract key and value
(assert (= key (split_at first_line ":" 0)))
(assert (= value (split_at first_line ":" 1)))
(assert (>= (num_splits first_line ":") 2))

; Ensure the key is non-empty and the value is non-empty after trimming spaces (simplified)
(assert (> (str.len key) 0))
(assert (> (str.len value) 0))

; Validate content-length: find a line that starts with "Content-Length:"
(assert (str.contains header "Content-Length:"))

; Extract the content-length line by splitting the header and checking each line (simplified using split_rest)
; Use split_rest to get the part of header after "Content-Length:" and then split by newline
(declare-const after_content_length String)
(assert (= after_content_length (split_rest header "Content-Length:" 0)))
(assert (= content_length_str (split_at after_content_length "\n" 0)))

; Convert content_length_str to an integer and assert it is positive
(assert (= content_length_val (str.to_int content_length_str)))
(assert (> content_length_val 0))

; Additional constraints to ensure diversity and complexity
; Assert that the header has at least 3 lines (including the first line and content-length line)
(assert (>= (num_splits header "\n") 3))

; Assert that the value in the first line does not contain colons (to avoid ambiguity)
(assert (not (str.contains value ":")))

; Assert that the content-length value is less than 10000 to keep it realistic
(assert (< content_length_val 10000))

; Final check for satisfiability
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
