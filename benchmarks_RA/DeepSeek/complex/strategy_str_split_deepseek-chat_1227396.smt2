; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Logic includes string splitting and integer validation for content-length
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
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const user_agent_str String)

; Declare uninterpreted functions for string split operations as per interface

; Assert that the header contains at least one newline to separate lines
(assert (str.contains header "\n"))

; Split the header by newlines to get individual lines
(assert (>= (num_splits header "\n") 2))

; Extract the first line (assumed to be the request line, e.g., "GET / HTTP/1.1")
(declare-const request_line String)
(assert (= request_line (split_at header "\n" 0)))

; Extract the second line as the Host header (example: "Host: example.com")
(assert (= host_str (split_at header "\n" 1)))

; Assert that the Host line contains a colon to separate key and value
(assert (str.contains host_str ":"))
(assert (>= (num_splits host_str ":") 2))

; Extract the value part after the colon in the Host line
(declare-const host_value String)
(assert (= host_value (split_at host_str ":" 1)))

; Assert that the host value is non-empty
(assert (> (str.len host_value) 0))

; Extract the third line as the User-Agent header (example: "User-Agent: Mozilla")
(assert (= user_agent_str (split_at header "\n" 2)))

; Assert that the User-Agent line contains a colon
(assert (str.contains user_agent_str ":"))
(assert (>= (num_splits user_agent_str ":") 2))

; Extract the value part after the colon in the User-Agent line
(declare-const user_agent_value String)
(assert (= user_agent_value (split_at user_agent_str ":" 1)))

; Assert that the user agent value is non-empty
(assert (> (str.len user_agent_value) 0))

; Extract the Content-Length line (assumed to be the fourth line)
(assert (= content_length_str (split_at header "\n" 3)))

; Assert that the Content-Length line contains a colon and the key "Content-Length"
(assert (str.contains content_length_str ":"))
(assert (>= (num_splits content_length_str ":") 2))
(assert (str.contains content_length_str "Content-Length"))

; Extract the value part after the colon in the Content-Length line
(declare-const content_length_value_str String)
(assert (= content_length_value_str (split_at content_length_str ":" 1)))

; Convert the content-length value string to an integer
(assert (= content_length_val (str.to_int content_length_value_str)))

; Validate that the content-length is a non-negative integer
(assert (>= content_length_val 0))

; Additional constraint to ensure the header ends properly (optional, for realism)
(assert (str.suffixof "\n\n" (split_rest header "\n" 4)))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
