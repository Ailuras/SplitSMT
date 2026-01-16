; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
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

; Declare variables for the HTTP request header string and its components
(declare-const header String)
(declare-const first_line String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_key String)
(declare-const host_val String)

; Declare uninterpreted functions for string split operations as per the interface

; Assert that the header contains at least two lines separated by newline delimiter "\n"
(assert (>= (num_splits header "\n") 2))

; Extract the first line (e.g., "GET / HTTP/1.1") by splitting header with newline delimiter at index 0
(assert (= first_line (split_at header "\n" 0)))

; Assert that the first line contains a colon for key-value parsing (e.g., in the Host header)
(assert (>= (num_splits first_line ":") 2))

; Extract the Host key (e.g., "Host") from the first line by splitting with colon delimiter at index 0
(assert (= host_key (split_at first_line ":" 0)))

; Extract the Host value (e.g., "example.com") from the first line by splitting with colon delimiter at index 1
(assert (= host_val (split_at first_line ":" 1)))

; Assert that the header contains a Content-Length line by checking for the substring "Content-Length"
(assert (str.contains header "Content-Length"))

; Extract the Content-Length line by splitting the header with newline delimiter and finding the line that contains "Content-Length"
; Use split_rest to get the rest of the header after the first line, then split it further
(declare-const rest_header String)
(assert (= rest_header (split_rest header "\n" 1)))
(assert (str.contains rest_header "Content-Length"))

; Extract the Content-Length value string by splitting the rest_header with colon delimiter
(assert (= content_length_str (split_at rest_header ":" 1)))

; Convert the Content-Length value string to an integer and assert it is a positive number
(assert (= content_length_val (str.to_int content_length_str)))
(assert (> content_length_val 0))

; Additional constraint: Ensure the Host key is exactly "Host" (case-sensitive) for validation
(assert (= host_key "Host"))

; Add a constraint to make the problem SAT by allowing flexibility in the header content
(assert (str.contains header "HTTP/1.1"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
